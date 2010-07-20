#! /bin/sh

./build_test.sh garbage -DDEBUG -DREPORT_HEAP_GROWTH src/memory.c src/object.c src/garbage.c && echo 'garbage start:' && date && ./run_test.sh garbage && echo 'garbage end' && date

echo '\n'

./build_test.sh garbage_vs_manual  && echo 'manual start:' && date && ./run_test.sh garbage_vs_manual && echo 'manual end' && date
