// cpp, strings, raw strings, regex, replace, capture, re2, case-insensitive regex

#include <re2/re2.h>   // compile with -lre2

string str {"Hello"};

// these mutate str

RE2::Replace(&str, "l", "L");                               // HeLlo
RE2::GlobalReplace(&str, "l", "L");                         // HeLLo
RE2::GlobalReplace(&str, "(?i)L", "*");                     // He**o
RE2::Replace(&str, "^(.{4}).+$", "pp: \\1");                // Hell
RE2::Replace(&str, R"((.{4}).+$)" , R"(pp: \1)");           // Hell
RE2::Replace(&str, R"(^(.+?)(ll)(.+)$)" , R"(pp: \1**\3)"); // He**o
