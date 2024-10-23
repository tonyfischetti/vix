
PAPER_NAME     	:= paper
LATEX_TEMPLATE 	:= templates/mine.tex
FILTER   	  	:= Filter1

OPTS := markdown+yaml_metadata_block+smart
ARGS := --standalone
ARGS += --embed-resources
ARGS += --citeproc
ARGS += --number-sections
ARGS += --template $(LATEX_TEMPLATE)
# ARGS += --toc
# ARGS += --filter bin/$(FILTER)

dist/$(PAPER_NAME).pdf: $(PAPER_NAME).md metadata.yaml Makefile bin/$(FILTER) references.bib
	mkdir -p dist
	pandoc -f $(OPTS) $(ARGS) $(PAPER_NAME).md metadata.yaml -o $@ 

bin/$(FILTER): $(FILTER).hs Makefile
	mkdir -p build
	mkdir -p bin
	ghc -O -Wall $(FILTER).hs -odir build/ -hidir build/ -o $@

.PHONY: clean
clean:
	rm -rf dist
	rm -rf build
	rm -rf bin

