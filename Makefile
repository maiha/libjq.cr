SHELL = /bin/bash
.SHELLFLAGS = -o pipefail -c

all: build

build:
	shards build

clean:
	rm -rf bin tests

######################################################################
### test

# WARNING: 1.6 is slow. (https://github.com/stedolan/jq/issues/2069)
TEST_JQ_BRANCH=jq-1.6

tests/jq.test:
	curl --create-dirs -o "$@.tmp" https://raw.githubusercontent.com/stedolan/jq/$(TEST_JQ_BRANCH)/tests/jq.test
	mv "$@.tmp" "$@"

test: tests/jq.test
	crystal spec -v

######################################################################
### CI

.PHONY : ci
ci: check_version_mismatch test

.PHONY : check_version_mismatch
check_version_mismatch: shard.yml README.md
	diff -w -c <(grep '    version:' README.md) <(grep ^version: shard.yml)
