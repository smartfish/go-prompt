NAME := prompt

.DEFAULT_GOAL := help

.PHONY: setup
setup:  ## Setup for required tools.
	go get github.com/golang/lint/golint
	go get golang.org/x/tools/cmd/goimports
	go get golang.org/x/tools/cmd/stringer
	go get github.com/pkg/term
	glide install

.PHONY: fmt
fmt: ## Formatting source codes.
	@goimports -w $$(glide nv -x)

.PHONY: lint
lint: ## Run golint and go vet.
	@golint $$(glide novendor)
	@go vet $$(glide novendor)

.PHONY: test
test:  ## Run the tests.
	@go test $$(glide novendor)

.PHONY: help
help: ## Show help text
	@echo "Commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'
