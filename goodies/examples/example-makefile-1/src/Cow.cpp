
#include "Cow.h"

Cow::Cow(std::string_view name, std::string_view says) noexcept
    : _name {name},
      _says {says} {
    puts("cow contructed");
}

Cow::~Cow() noexcept {
    puts("cow de-constructed");
}

const std::string& Cow::getName() const noexcept {
    return _name;
}

const std::string& Cow::speak() const noexcept {
    return _says;
}

