#! /bin/sh

./build_test.sh memory -DNO_GARBAGE_COLLECTION -DDEBUG -DREPORT_HEAP_GROWTH src/memory.c src/object.c && ./run_test.sh memory
