
.DELETE_ON_ERROR:

.PHONY: install
install:
	@ mkdir -p build
	@ mkdir -p bin
	npm ci
