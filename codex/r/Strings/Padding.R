# r, strings, padding strings, str_pad

str <- "Hello"
str_pad(str, 7)                 # "  Hello"
str_pad(str, 7, side="left")    # "  Hello"
str_pad(str, 7, side="right")   # "Hello  "
str_pad(str, 10, side="both")   # "  Hello   "
str_pad(str, 10, pad='_')       # "_____Hello"
