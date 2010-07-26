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

#include "object.h"
#include "memory.h"
#include "pointer.h"
#include "bool.h"

#ifndef NO_GARBAGE_COLLECTION
   #include "garbage.h"
#endif

#ifdef REPORT_HEAP_GROWTH
   #include <stdio.h>
#endif   

#include <stdlib.h>
#include <string.h>

/* Move chunks to a current memory area.  Re-address the pointers on the stack.  */
chunk_addr copy_stack(stack_pointer top, stack_pointer bottom, memory_area mem)
{
   /* The current chunk */
   chunk_addr chnk;

   /* A stack pointer to work with */
   stack_pointer working_top;

   /* The size of the current chunk */
   size_t size;

   /* Set each chunk addr on the stack to not be moved. */
   for(working_top = top; working_top < bottom; working_top++)
   {
      /* Get the chunk */
      chnk = *working_top;

      /* If the chnk is not 0 then proceed with this iteration. */
      if (chnk == 0)
      {
         /* Skip the next */
         working_top++;
         continue;
      }

      /* Set the chunk to not be moved. */
      chnk->moved = FALSE;
   }

   /* Move the chunk addr addressed by each point on the stack. */
   for(working_top = top; working_top < bottom; working_top++)
   {
      /* Get the chunk */
      chnk = *working_top;

      /* If the chnk is not 0 then proceed with this iteration. */
      if (chnk == 0)
      {
         /* Skip the next. */
         working_top++;
         continue;
      }

      /* The size of the current chunk */
      size = chsize(chnk);

      /* If the chunk has not been moved. */
      if (!chnk->moved)
      {
         /* Copy the chunk to the new memory region. */
         memcpy(mem, chnk, size);
 
         /* Re-address the chunk */
         chnk->addr = (chunk_addr) mem;

         /* The chunk has now been moved */
         chnk->moved = TRUE;
      }

      /* Re-address the pointer on the stack */
      *working_top = chnk->addr;

      /* Move the memory region along. */
      mem += size;
   }

   return (chunk_addr) mem;
}

/* Create a new chunk */
chunk_addr new_chunk(size_t size, memory_manager mem)
{
   /* The pointer to the address of the new chunk */
   chunk_addr chunk;

   /* The new chunk is at the next available space */
   chunk = mem->next;

   /* Initialize the chunk */
   chunk->size = size;
   chunk->moved = FALSE;
   chunk->addr = chunk;

   /* Set the next chunk pointer to be after the address of chnk chunk */
   mem->next = (chunk_addr) (((word *) mem->next) + chunk_size(size));

   /* Return the address */
   return chunk;
}

/* The extra space required to make a new chunk of the given size */
int space_required(size_t size, memory_manager mem)
{

   return (int) (((word *) mem->next + chunk_size(size)) - (mem->current + mem->size));

}

/* Grow memory.  Double in size, or increase by at least as much space as 'at_least'.
   Rewrite the location of pointers on the stack.
   Return the location of the new memory pointer.  */
void grow(stack_pointer top, stack_pointer bottom, size_t at_least, memory_manager mem)
{
   /* The size of currently used memory */
   size_t used;

   /* Temporary swapover region */
   memory_area temp_memory;

   /* Find the size of currently used memory */
   used = (size_t) ((word *) mem->next - mem->current);

   /* Report heap growth */
   #ifdef REPORT_HEAP_GROWTH
      fprintf(stderr, "Current heap size: %zu.  Heap must grow by at least: %zu\n\n", mem->size, at_least);
   #endif

   /* If doubling the memory isn't enough then the new size is the old_size + at_least */
   if (mem->size > at_least)
   {
      mem->size = mem->size * 2;
   }
   else
   {
      mem->size = mem->size + at_least;
   }

   /* Resize the inactive memory area */
   resize_pointer(mem->size, mem->inactive);

   /* Steps to resize the current memory region */

   /* First create a temporary region */
   new_pointer(mem->size, temp_memory)

   /* Copy every item on the stack into the new memory.  Update the stack locations. */
   mem->next = copy_stack(top, bottom, temp_memory);

   /* Free the current region. */
   free(mem->current);

   /* Replace the current with the temporary */
   mem->current = temp_memory;

   /* Set the address of the next chunk */
   mem->next = (chunk *) ((size_t) mem->current + used);

}

/* Allocate a new chunk on the heap.
   Pass the stack pointer, and a pointer to the bottom of the stack.
   They may be used in the case we need to garbage collect. */  
chunk_addr allocate(stack_pointer top, stack_pointer bottom, size_t size, memory_manager mem)
{
   /* The space we need to grow by */
   int required;

   /* Find the space required */
   required = space_required(size, mem);

   /* If there is not enough free space for the new chunk */
   if (required > 0)
   {
         /* Check if we're running the garbage collector. */
      #ifndef NO_GARBAGE_COLLECTION
      
         /* Collect garbage */
         collect_garbage(top, bottom, mem);      

         /* Find the space we need now */
         required = space_required(size, mem);

         /* Check if there's enough space now! */
         if (required > 0)
         {
            /* If there's still not enough space, grow the memory manager */
            grow(top, bottom, required, mem);
         }

      #else
    
         /* Grow the memory manager */
         grow(top, bottom, required, mem);
         
      #endif
   }

   /* Return the new chunk */
   return new_chunk(size, mem);
}

/* Create a new memory manager of given size */
memory_manager new_memory_manager(size_t size)
{
   /* The new memory manager */
   memory_manager mem;

   /* Create the new memory manager */
   new_pointer(sizeof(amemory_manager), mem)

   /* Initialize the memory manager */
   new_pointer(size, mem->current)
   new_pointer(size, mem->inactive)
   mem->next = (chunk *) mem->current;
   mem->size = size;

   /* Return the memory manager */
   return mem;
}

/* Shutdown the memory manager */
void shutdown_memory_manager(memory_manager mem)
{
   /* Free the memory areas */
   free(mem->current);

   free(mem->inactive);

   /* Free the memory manager */
   free(mem);
}
