/* Prevent multiple inclusion */
#ifndef MEMORY
#define MEMORY

#include "object.h"
#include "stdlib.h"

/* The structure of the memory sub-system. */
struct memory
{
   /* The currently active memory area */
   struct chunk * current;

   /* A currently inactive memory area */
   struct chunk * inactive;

   /* A pointer to the next piece of free space 
      in the current area */
   struct chunk * next;

   /* Size of memory */
   size_t size;
};

/* Grow the size of the available memory.  Grow at least as much as size. */
void grow(size_t size, struct memory * m);

/* Allocate a new chunk */
chunk_addr allocate(size_t size, struct memory * m);

/* Readdress the chunks in current memory
   The arguments are currently used memory, and then the memory unit */
void readdress(size_t used, struct memory * m);
#endif
