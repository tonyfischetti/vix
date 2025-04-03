# make, color, colored text, tput, echo, printf, silent

.PHONY: begin
begin:
	@ echo "$$(tput bold)$$(tput setaf 3)beginning$$(tput sgr0)"
	@ printf '\n'
	...
