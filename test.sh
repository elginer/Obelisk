#! /bin/sh

# Run tests
./dist/build/lex/lex && ./dist/build/parse/parse && ./dist/build/scope/scope
