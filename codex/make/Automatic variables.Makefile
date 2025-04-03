# make, automatic variables, $@

# $< 	name of the first prerequisite
# $@ 	name of the target
# $*    stem with which an implicit rule matches
# $^ 	name of all prerequisites

bin/dvd: src/dvd.c
	gcc -O2 $< -o $@
