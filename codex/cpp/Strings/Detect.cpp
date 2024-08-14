// cpp, strings, regex, match, detect, re2, case-insensitive regex

#include <re2/re2.h>   // compile with -lre2

std::string str {"Hello"};

RE2::PartialMatch(str, "ll");       // 1
RE2::PartialMatch(str, "LL");       // 0
RE2::PartialMatch(str, "(?i)LL");   // 1
