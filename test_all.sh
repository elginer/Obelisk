#! /bin/sh

# Run all tests
./test.sh lex && ./test.sh parse && ./test.sh scope && ./test.sh type
