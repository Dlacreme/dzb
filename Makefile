
.PHONY: all
all: help

.PHONY: help
help: ## List all available commands
	@grep -E '(^[a-zA-Z_-]+(\.[a-zA-Z_-]+)?:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' \
		| sed -e 's/\[32m##/[33m/' \
		| sort

.PHONY: run # Starts dzb
run:
	zig build run

.PHONY: test ## Run dzb unit tests
test:
	zig build test
