/* Prevent multiple inclusion */
#ifndef OBJECT
#define OBJECT

#include <stdlib.h>
#include <stdarg.h>

#include "bool.h"

/* An 8-bit word */
typedef char word;

/* Nice looking alias for a chunk */
typedef struct chunkS chunk;

/* An address of a chunk, from the perspective of the mutator. */
typedef chunk * chunk_addr;

/* A chunk of memory, requested from the memory manager */
struct chunkS
{
   /* The size of this chunk */
   size_t size;

   /* The chunk's address. */
   chunk_addr addr;

   /* Has the chunk been moved by the garbage collector? */
   bool moved;
}
achunk;

/* The return type is short */
typedef short return_type;

/* The size in memory the chunk would occupy */
size_t chunk_size(size_t size);

/* The size in memory the chunk does occupy */
size_t chsize(chunk * chnk);

/* Get a pointer to the ith position of the chunk */
word * obpointer(size_t i, chunk_addr obj);

/* Copy n bytes from obj to the ith position of the chunk */
void obwrite(word * chu, word * obj, size_t n);

#endif
