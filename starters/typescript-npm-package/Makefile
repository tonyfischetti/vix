
.PHONY: default
default: check bundle

.PHONY: clean
clean:
	rm -rf index.js index.d.ts build/ dist/

.PHONY: start
start: clean
	npm run start:dev

.PHONY: build
build: clean
	npm run build

.PHONY: bundle
bundle: build
	npm run bundle

.PHONY: test
test: build
	npm run test

.PHONY: check
check: bundle test
	npm run check-exports

.PHONY: publish
publish: check
	npm publish
