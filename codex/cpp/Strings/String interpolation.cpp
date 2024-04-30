#include <fmt/core.h>   -lfmt
std::string str {"Hello"};
fmt::format("{0}, World", str)  // "Hello, World"

// or

std::stringstream ss {};
ss << str << ", World";
ss.str()            // "Hello, World"