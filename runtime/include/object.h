/* Prevent multiple inclusion */
#ifndef OBJECT
#define OBJECT

#include "stdlib.h"

/* A chunk of memory, requested from the memory manager */
struct chunk
{
   /* The size of this chunk */
   size_t size;

   /* The address of this chunk */
   struct chunk ** addr;
} achunk;

/* An address of a chunk, from the perspective of the mutator. */
typedef struct chunk ** chunk_addr;

/* The size in memory the a chunk would occupy */
size_t chunk_size(size_t size);

#endif
