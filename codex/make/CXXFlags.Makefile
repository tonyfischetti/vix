# make, CFLAGS, CPPFLAGS, cpp flags

.DELETE_ON_ERROR:

CXX       := g++
CFLAGS    := -O2 -Wall -Wextra -I.
CXXFLAGS  := -std=c++2b -O2 -I. -Wall -Wextra -Werror -Wpedantic -Wshadow
CXXFLAGS  += -Wconversion -Wsign-conversion -Wunreachable-code
CXXFLAGS  += -Wrange-loop-construct -Wredundant-move -Wswitch
CXXFLAGS  += -Wsuggest-override -Wuninitialized -Winline -Weffc++
CXXFLAGS  += -Wmissing-braces -Wnon-virtual-dtor  -Wold-style-cast
CXXFLAGS  += -Wreturn-local-addr
