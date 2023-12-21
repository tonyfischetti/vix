
#pragma once 

#include <string>

struct Animal {
    Animal() noexcept {};
    virtual ~Animal() noexcept {};

    virtual const std::string& speak()   const noexcept = 0;
    virtual const std::string& getName() const noexcept = 0;
};
