#!/bin/bash
# Description: Tests generated JSON files against schemas
# Prerequisites: install 'ajv-cli' and 'ajv-formats':$  npm install -g ajv-cli ajv-formats

set -e

ajv test -s ./schemas/schema.json -r "./schemas/*.json" -d "examples/valid/*.json" -c ajv-formats --valid
ajv test -s ./schemas/schema.json -r "./schemas/*.json" -d "examples/invalid/*.json" -c ajv-formats --invalid


if [ $? -eq 0 ]
then
	echo -e "All tests \033[0;32mPASSED\033[0m\n"
fi