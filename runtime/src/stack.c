/*

Copyright 2010 John Morrice

This source file is part of The Obelisk Programming Language and is distributed under the terms of the GNU General Public License

This file is part of The Obelisk Programming Language.

    The Obelisk Programming Language is free software: you can 
    redistribute it and/or modify it under the terms of the GNU 
    General Public License as published by the Free Software Foundation, 
    either version 3 of the License, or any later version.

    The Obelisk Programming Language is distributed in the hope that it 
    will be useful, but WITHOUT ANY WARRANTY; without even the implied 
    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
    See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with The Obelisk Programming Language.  
    If not, see <http://www.gnu.org/licenses/>

*/

/* A data stack */

#include "stack.h"
#include "object.h"
#include "pointer.h"
#include "oberror.h"

#include <stdlib.h>

/* Create a new stack  */
data_stack new_stack()
{
   /* Our new stack */
   data_stack stck;

   /* The new top of the stack */
   struct data_stackS top;

   /* A pointer to the top of the stack */
   stack_pointer top_pointer; 

   /* Create a pointer for the stack */
   stck = new_pointer(sizeof(stack_pointer)); 

   /* Initialize the stack */
   top.bottom = 1;
   top.down = NULL;
   top.vals = NULL;
   top.num_vals = 0;

   /* Create a new pointer for the top of the stack */
   top_pointer = new_pointer(sizeof(top));

   /* Write to the new pointer */
   *top_pointer = top;

   /* Write the new top to the stack */
   *stck = top_pointer;

   /* Return the stack */
   return stck;   
}

/* Push a new layer onto the stack */
void push_new(size_t count, chunk_addr * chnks, data_stack stck)
{
   /* The new top of the stack */
   struct data_stackS top;

   /* A pointer to the top of the stack */
   stack_pointer top_pointer; 
 
   /* Initialize the stack */
   top.bottom = 0;
   top.down = *stck;
   top.vals = chnks;
   top.num_vals = count;

   /* Create a new pointer for the top of the stack */
   top_pointer = new_pointer(sizeof(top));

   /* Write to the new pointer */
   *top_pointer = top;

   /* Write the new top to the stack */
   *stck = top_pointer;
}

/* Delete newest member of stack. 
   DO NOT free the array contained within. 
   Fail with a fatal error if this is the bottom of the stack. */
void pop(data_stack stck)
{
   /* The old top */   
   stack_pointer old_top;

   /* Save a reference to the old top */
   old_top = *stck;

   /* Check if this is the bottom of the stack */
   if(old_top->bottom)
   {
      FATAL_ERROR("Tried to pop bottom of data stack.")
   }
   
   /* Set the data stack to point down one level. */
   *stck = old_top->down;

   /* Free the old top */
   free(old_top);
}

/* Delete the stack */
void delete_stack(data_stack stck)
{
   /* Pointer to stack top */
   stack_pointer top;   

   /* Free each unit of the stack */
   for(top = *stck; !(top->bottom);)
   {
      pop(stck);
      top = *stck;
   }

   /* Free the bottom of the stack */
   free(*stck);

   /* Free the stack */
   free(stck);
}
