// cpp, strings, padding strings, iomanip, setw, setiosflags

#include <iomanip>
#include <iostream>

std::string str {"Hello"};

std::cout << std::setw(7) << str << std::endl;  // "  Hello"
std::cout << std::setiosflags(std::ios::left)
     << std::setw(7) << str << std::endl;       // "Hello  "
