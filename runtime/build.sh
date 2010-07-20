#! /bin/sh

# Invoke gcc on the runtime, building a shared object.

gcc -Werror -std=c99 -pedantic -c -Iinclude src/memory.c -o memory.o
gcc -std=c99 -pedantic -c -Iinclude src/garbage.c -o garbage.o
gcc -Werror -std=c99 -pedantic -c -Iinclude src/object.c -o object.o

ar rs libobelisk.a memory.o object.o
