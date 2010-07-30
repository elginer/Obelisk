#! /bin/sh

# Check for correct number of arguments
if [ $# -eq 0 ]
then
   echo "Usage:\n$0 test"
   exit 1
fi

# Run tests
runghc tests/$1.hs
