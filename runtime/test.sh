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

# Compile and run tests
gcc -Iinclude -o tests/$TEST tests/$TEST.c $*
./tests/$TEST
