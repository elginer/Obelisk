/* Prevent multiple inclusion */
#ifndef MEMORY
#define MEMORY

#include "object.h"
#include "stack.h" 

/* A memory area */
typedef word * memory_area;

/* The structure of the memory sub-system. */
struct memory
{
   /* The currently active memory area */
   memory_area current;

   /* A currently inactive memory area */
   memory_area inactive;

   /* A pointer to the next piece of free space 
      in the current area */
   chunk * next;

   /* A data stack from which the garbage collector can find the root set. */
   data_stack stack;

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

/* Grow the stack, adding space for 'count' chunks */
void grow_stack(size_t count, chunk_addr * chnks, memory_manager mem);

/* Shrink the stack */
void shrink_stack(memory_manager mem);

/* Macro to loop through chunks.  The current chunk is called 'chnk' and has type 'chunk *'.  It is expected that you declare 'chnk' before using chnk macro'.  It is expected that the memory_manager be called 'mem' in chnk scope. */
#define CHUNK_LOOP(ACT) \
      for (chnk = (chunk *) mem->current; \
          chnk < mem->next; \
          chnk = (chunk *) ((word *) chnk + chunk_size(chnk->size))) \
   { \
   ACT \
   }

#endif
