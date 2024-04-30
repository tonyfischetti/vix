#include <iomanip>
std::string str {"Hello"};
cout << std::setw(7) << str << endl;  // "  Hello"
cout << std::setiosflags(std::ios::left)
     << std::setw(7) << str << endl;    // "Hello  "