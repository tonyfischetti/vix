
#pragma once

#include "Animal.h"

struct Cow final : public Animal {
    Cow(std::string_view, std::string_view) noexcept;
    ~Cow() noexcept;
    const std::string& speak() const noexcept override;
    const std::string& getName() const noexcept override;

  private:
    const std::string _name;
    const std::string _says;
};
