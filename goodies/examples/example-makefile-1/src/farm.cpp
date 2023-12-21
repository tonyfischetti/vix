

#include <vector>
#include <memory>
#include <string>
#include <optional>

#include <fmt/core.h>
#include <systemd/sd-journal.h>

#include "rang.hpp"

#include "common.h"
#include "Dog.h"
#include "Cow.h"


static std::vector<std::unique_ptr<Animal>> animals;
static std::vector<Dog> animals2;
static std::vector<Dog> animals3;
static std::vector<std::unique_ptr<Animal>> animals4;


// will use copy constructor
void add_dog(const std::string name, const std::string itsays) {
    Dog dog{name, itsays};
    animals2.push_back(dog);
}

// will use move constructor
void add_dog2(const std::string name, const std::string itsays) {
    Dog dog{name, itsays};
    animals3.push_back(std::move(dog));
}

// templated add function
template <typename T>
void add_animal(const std::string name, const std::string itsays) {
    std::unique_ptr<T> up { make_unique<T>(name, itsays) };
    animals4.push_back(std::move(up));
}

std::optional<std::string> get_says_by_name(std::string_view aname) {
    for (const auto& animal : animals4) {
        if (animal->getName() == aname)
            return animal->speak();
    }
    return std::nullopt;
}

using found_pair = std::pair<bool, std::string>;

found_pair get_says_by_name2(std::string_view aname) {
    for (const auto& animal : animals4) {
        if (animal->getName() == aname)
            return std::make_pair<bool, std::string>(true,
                    std::string{animal->speak()});
    }
    return std::make_pair<bool, std::string>(false, "nothing");
}

bool says_bow_wow_p(std::unique_ptr<Animal>& canimal) {
    if (canimal->speak() == "bow wow")
        return true;
    return false;
}


int main() {

    using namespace rang;

    puts("\nFIRST");

    animals.push_back(make_unique<Dog>("Bandit", dog_says));
    animals.push_back(make_unique<Cow>("Bella", cow_says));

    puts("IN FIRST VECTOR");
    for(const auto& animal : animals) {
        std::cout << "My name is " << fgB::cyan << animal->getName() <<
                     style::reset << ", and I say " << fgB::green <<
                     animal->speak() << style::reset << std::endl;
    }

    animals.clear();
    // decontructs objects

    puts("\nSECOND");
    add_dog("Rover", dog_says);

    puts("IN SECOND VECTOR");
    for(const auto& dog : animals2) {
        std::cout << "My name is " << fgB::cyan << dog.getName() <<
                     style::reset << ", and I say " << fgB::green <<
                     dog.speak() << style::reset << std::endl;
    }
    
    animals2.clear();

    puts("\nTHIRD");
    add_dog2("Fido", dog_says);

    puts("IN THIRD VECTOR");
    for(const auto& dog : animals3) {
        std::cout << "My name is " << fgB::cyan << dog.getName() <<
                     style::reset << ", and I say " << fgB::green <<
                     dog.speak() << style::reset << std::endl;
    }

    animals3.clear();



    puts("\nFOURTH");
    add_animal<Cow>("Wanda", cow_says);
    add_animal<Dog>("Beethoven", dog_says);

    puts("IN FOURTH VECTOR");
    for(const auto& animal : animals4) {
        std::cout << "My name is " << fgB::cyan << animal->getName() <<
                     style::reset << ", and I say " << fgB::green <<
                     animal->speak() << style::reset << std::endl;
    }

    // std::cout << "\nFound Beethoven? " << find_animal("Beethoven") << "\n";
    std::cout << "\nBeethoven says: " <<
                  get_says_by_name("Beethoven").value_or("UNKNOWN");
    std::cout << "\nBessie says: " <<
                  get_says_by_name("Bessie").value_or("UNKNOWN") << "\n";

    const auto [found_p, it_says] = get_says_by_name2("Wanda");
    if (found_p)
        std::cout << "Wanda says: " << it_says << "\n";

    if (const auto [found_p2, it_says2] = get_says_by_name2("Pete"); found_p2)
        std::cout << "Pete says: " << it_says2 << "\n";


    std::cout << count_if(animals4.begin(), animals4.end(),
                         says_bow_wow_p) << " animal(s) says 'bow wow'\n";


    std::cout << std::endl;
    animals4.clear();


    #ifdef SAYBYE
    fmt::print("\nBye!\n");
    #endif

    sd_journal_print(LOG_NOTICE, "farm finished running");

    return 0;
}

