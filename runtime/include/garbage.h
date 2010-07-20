/* Prevent multiple inclusion */
#ifndef GARBAGE
#define GARBAGE

#include "memory.h"
#include "object.h"

/* Copying garbage collector. */

/* Collect garbage.
   The stack pointer is used to find chunks.  The chunks run until the stack bottom. */
void collect_garbage(stack_pointer top, stack_pointer bottom, memory_manager m);

#endif
