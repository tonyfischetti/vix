# r, strings, str_split, string split, case-insensitive regex

str <- "Hello"
str_split(str, "l+") %>% unlist       # "He" "o"
str_split(str, "(?i)L+") %>% unlist   # "He" "o"
