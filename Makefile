DEMO_FOLDER = ./demo

.PHONY: all
all: help

.PHONY: help
help: ## List all available commands
	@grep -E '(^[a-zA-Z_-]+(\.[a-zA-Z_-]+)?:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' \
		| sed -e 's/\[32m##/[33m/' \
		| sort

## Run BZT unit tests
.PHONY: test
test:
	zig build test

## Execute our Demo application using the local version of BZT
.PHONY: demo.run
demo.run:
	(cd $(DEMO_FOLDER) ; zig build run)