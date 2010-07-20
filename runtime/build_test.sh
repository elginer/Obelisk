#! /bin/sh

# Check for correct number of arguments
if [ $# -eq 0 ]
then
   echo "Usage:\n$0 test [extra source files]"
   exit 1
fi

# Grab the test name before shiting on to the rest of the arguments
TEST=$1
shift

# Compile test
gcc -Werror -std=c99 -pedantic -Iinclude -o test_out/$TEST tests/$TEST.c $*
