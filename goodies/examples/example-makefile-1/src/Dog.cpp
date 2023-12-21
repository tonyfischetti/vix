
#include "Dog.h"

Dog::Dog(std::string_view name, std::string_view says) noexcept
    : _name {name},
      _says {says} {
    puts("dog constructed");
}

Dog::~Dog() noexcept {
    puts("dog de-constructed");
}

Dog::Dog(const Dog& src) noexcept
    : _name {src._name},
      _says {src._says} {
    puts("dog copy-constructed");
}

Dog::Dog(Dog&& src) noexcept
    : _name {std::move(src._name)},
      _says {std::move(src._says)} {
    puts("dog move-constructed");
}

const std::string& Dog::getName() const noexcept {
    return _name;
}

const std::string& Dog::speak() const noexcept {
    return _says;
}

