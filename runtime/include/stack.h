/* Prevent multiple inclusion */
#ifndef STACK
#define STACK

/* Stacks of lists */

#include "object.h"

/* A nice name for pointers to the data_stack */
typedef struct data_stackS * stack_pointer;

/* A nice name for a data stack */
typedef stack_pointer * data_stack;

/* A boolean */
typedef char bool;

/* A data stack.  Either it's the bottom of the stack or its not. */
struct data_stackS
{
   /* Is this the bottom of the stack? */
   bool bottom;
  
   /* Further down the stack */
   stack_pointer down;

   /* The chunks associated with this part of the stack */
   chunk_addr * vals;

   /* The number of values in the stack */
   size_t num_vals;
}
astack;

/* Create a new stack  */
data_stack new_stack();

/* Push a new layer onto the stack */
void push_new(size_t count, chunk_addr * chnks, data_stack stck);

/* Delete newest member of stack. 
   DO NOT free the array contained within.
   Fail with a fatal error if this is the bottom of the stack. */
void pop(data_stack stck);

/* Delete the stack */
void delete_stack(data_stack stck);

#endif
