#include "object.h"
#include "memory.h"
#include "stack.h"
#include "pointer.h"

/* Create a new chunk */
chunk_addr new_chunk(size_t size, memory_manager mem)
{
   /* The address of the chunk we are going to return! */
   chunk_addr zone;

   /* Request a pointer from the operating system */
   zone = (chunk_addr) new_pointer(sizeof(zone));

   /* Write the address of the new chunk to chnk pointer */
   *zone = mem->next;

   /* Initialize the chunk */
   mem->next->size = size;
   mem->next->addr = zone;

   /* Set the next chunk pointer to be after the address of chnk chunk */
   mem->next = (chunk *) ((word *) mem->next + chunk_size(size));



   /* Return the address */
   return zone;
}

/* The space required to make a new chunk of the given size */
int space_required(size_t size, memory_manager mem)
{

/*   printf("The difference between the current and next memory positions: %d\n", (word *) mem->next - (word *) mem->current);
   printf("The real size we have to allocate: %u\n", chunk_size(size)); */
   return (size_t) (((word *) mem->next + chunk_size(size)) - (word *) mem->current);

}

/* Allocate a new chunk */
chunk_addr allocate(size_t size, memory_manager mem)
{
   /* The space we need to grow by */
   int required;

/*   printf("\n\nMutator asked us to allocate space of %u\n", size); */

   /* Find the space required */
   required = space_required(size, mem) - mem->size;

/*   printf("Space required: %d\n", required); */

   /* If there is not enough free space for the new chunk */
   if (required > 0)
   {
      grow(required, mem);
   }

   /* Return the new chunk */
   return new_chunk(size, mem);
}

/* Grow memory.  Double in size, or increase by at least as much space as 'at_least'. */
void grow(size_t at_least, memory_manager mem)
{
   /* The size of currently used memory */
   size_t used;

   /* Find the size of currently used memory */
   used = (size_t) ((word *) mem->next - (word *) mem->current);

/*
   printf("The size now: %u\n", mem->size);
   printf("We need to grow at least: %d\n", at_least);
   printf("We are using: %d\n", used);
   printf("END REPORT\n\n"); */

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
   mem->inactive = resize_pointer(mem->size, mem->inactive);

   /* Resize the current memory region */
   mem->current = resize_pointer(mem->size, mem->current);

   /* Set the address of the next chunk */
   mem->next = (chunk *) ((size_t) mem->current + used);

   /* readdress the chunks in the current memory region */
   readdress(used, mem);
}

/* Readdress the chunks in current memory
   The arguments are currently used memory, and then the memory unit */
void readdress(size_t used, memory_manager mem)
{
   /* Pointer to the chunk we're working on */
   chunk * chnk;
 
   /* Loop through all the current chunks, updating their addresses */  
   CHUNK_LOOP(
         /* Set the address of the chunk to its own address */
      *(chnk->addr) = chnk;
   )
}

/* Create a new memory manager of given size */
memory_manager new_memory_manager(size_t size)
{
   /* The new memory manager */
   memory_manager mem;

   /* Create the new memory manager */
   mem = (memory_manager) new_pointer(sizeof(amemory_manager));

   /* Initialize the memory manager */
   mem->current = (memory_area) new_pointer(size);
   mem->inactive = (memory_area) new_pointer(size);
   mem->next = (chunk *) mem->current;
   mem->size = size;
   mem->stack = new_stack();

   /* Return the memory manager */
   return mem;
}

/* Grow the stack, adding space for 'count' chunks */
void grow_stack(size_t count, chunk_addr * chnks, memory_manager mem)
{
   push_new(count, chnks, mem->stack);
}

/* Shrink the stack */
void shrink_stack(memory_manager mem)
{
   pop(mem->stack);
}


/* Shutdown the memory manager */
void shutdown_memory_manager(memory_manager mem)
{
   /* The current chunk */
   chunk * chnk;

   /* Free the address of every chunk */
   CHUNK_LOOP(
      free(chnk->addr);
   )

   /* Free the memory areas */
   free(mem->current);
   free(mem->inactive);

   /* Delete the stack */
   delete_stack(mem->stack);

   /* Free the memory manager */
   free(mem);
}
