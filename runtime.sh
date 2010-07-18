#! /bin/sh

# Invoke gcc on the runtime, building a shared object.

gcc -std=c99 -pedantic -c -Iruntime/include runtime/src/memory.c -o runtime/memory.o
gcc -std=c99 -pedantic -c -Iruntime/include runtime/src/garbage.c -o runtime/garbage.o
gcc -std=c99 -pedantic -c -Iruntime/include runtime/src/object.c -o runtime/object.o

ar rs runtime/libobelisk.a runtime/memory.o runtime/garbage.o runtime/object.o
