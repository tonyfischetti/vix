str <- "Hello"
str_detect(str, "Hel{2}")     # TRUE
str_detect(str, "hel{2}")     # FALSE
str_detect(str, "(?i)hel{2}") # TRUE