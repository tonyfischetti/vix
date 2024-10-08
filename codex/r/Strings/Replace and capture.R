# r, strings, replace, capture, regex, str_replace, str_replace_all, case-insensitive regex

str <- "Hello"
str_replace(str, "^(.{4}).+$", "\\1")   # "Hell"
str_replace(str, "l", "L")              # "HeLlo"
str_replace_all(str, "l", "L")          # "HeLLo"
str_replace_all(str, "(?i)L", "*")      # "He**o"
