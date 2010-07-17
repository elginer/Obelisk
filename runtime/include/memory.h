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
}
amemory_manager;

typedef struct memory * memory_manager;

/* Grow the size of the available memory.  Grow at least as much as size. */
void grow(size_t size, memory_manager m);

/* Allocate a new chunk */
chunk_addr allocate(size_t size, memory_manager m);

/* Readdress the chunks in current memory
   The arguments are currently used memory, and then the memory unit */
void readdress(size_t used, memory_manager m);

/* Create a new memory manager of given size */
memory_manager new_memory_manager(size_t size);

/* Shutdown the memory manager */
void shutdown_memory_manager(memory_manager mem);

/* Macro to loop through chunks.  The current chunk is called 'this' and has type 'struct chunk *'.  It is expected that you declare 'this' before using this macro'.  It is expected that the memory_manager be called 'mem' in this scope. */
#define CHUNK_LOOP(ACT) \
      for(this = mem->current; this <= mem->next; this += chunk_size(this->size)) \
   { \
   ACT \
   }

#endif
