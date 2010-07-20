/* Prevent multiple inclusion */
#ifndef MEMORY
#define MEMORY

#include "object.h"

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
   chunk_addr next;

   /* Size of memory */
   size_t size;
}
amemory_manager;

/* Nice name for the memory manager */
typedef struct memory * memory_manager;

/* The stack is a contiguous block of pointers to heap locations */
typedef chunk_addr * stack_pointer;

/* Allocate a new chunk on the heap.
   Pass the stack pointer, and a pointer to the bottom of the stack.
   They may be used in the case we readdress pointers to the heap. */  
chunk_addr allocate(stack_pointer spointer, stack_pointer sbottom, size_t size, memory_manager mem);

/* Create a new memory manager of given size */
memory_manager new_memory_manager(size_t size);

/* Shutdown the memory manager */
void shutdown_memory_manager(memory_manager mem);

/* Create a new chunk */
chunk_addr new_chunk(size_t size, memory_manager mem);

/* Move chunks to a current memory area.
   Re-address the pointers on the stack.
   Return the end of the area.  */
chunk_addr copy_stack(stack_pointer top, stack_pointer bottom, memory_area mem);

#endif
