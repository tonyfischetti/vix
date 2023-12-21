
#pragma once

#include "Animal.h"

struct Dog final : public Animal {
    Dog(std::string_view, std::string_view) noexcept;
    ~Dog() noexcept;

    Dog(const Dog& src) noexcept;
    Dog& operator=(const Dog& rhs) noexcept = delete;

    Dog(Dog&& src) noexcept;
    Dog& operator=(Dog&& rhs) noexcept = delete;

    const std::string& speak() const noexcept override;
    const std::string& getName() const noexcept override;

  private:
    const std::string _name;
    const std::string _says;
};
