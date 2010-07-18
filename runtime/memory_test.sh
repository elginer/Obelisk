#! /bin/sh

./build_test.sh memory src/memory.c src/object.c src/pointer.c src/stack.c

./run_test.sh memory
