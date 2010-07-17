#include "object.h"
#include "memory.h"
#include "error.h"

#include "stdlib.h"

/* Resize a memory area */
void * resize_pointer(size_t size, void * old)
{
   /* Our new pointer */
   void * new;
   
   /* Try to resize the pointer */
   new = realloc(old, size);

   if (new == NULL)
   {
      FATAL_ERROR("Ran out of memory!");
   }

   return new;
}

/* Request a new pointer from the operating system */
void * new_pointer(size_t size)
{
   /* Our new pointer */
   void * ptr;

   /* Try to create a new pointer */
   ptr = malloc(size);

   /* If the pointer is NULL, raise an error and abort execution! */
   if (ptr == NULL)
   {
      FATAL_ERROR("Ran out of memory!");
   }
   
   return ptr;
}

/* Create a new chunk */
chunk_addr new_chunk(size_t size, struct memory * mem)
{
   /* The address of the chunk we are going to return! */
   chunk_addr zone;

   /* Request a pointer from the operating system */
   zone = (chunk_addr) new_pointer(sizeof(zone));

   /* Write the address of the new chunk to this pointer */
   *zone = mem->next;

   /* Initialize the chunk */
   mem->next->size = size;
   mem->next->addr = zone;

   /* Set the next chunk pointer to be after the address of this chunk */
   mem->next = mem->next + size;

   /* Return the address */
   return zone;
}

/* Is there enough space to make a new chunk of the given size? */
int enough_space(size_t size, struct memory * mem)
{
   return ((int) mem->next + chunk_size(size)) - (int) mem->current < (int) mem->size;
}

/* Allocate a new chunk */
chunk_addr allocate(size_t size, struct memory * mem)
{
   /* If there is not enough free space for the new chunk */
   if (! enough_space(size, mem))
   {
      grow(size, mem);
   }

   /* Return the new chunk */
   return new_chunk(size, mem);
}

/* Grow memory.  Double in size, or increase by at least as much space as 'at_least'. */
void grow(size_t at_least, struct memory * mem)
{
   /* The size of currently used memory */
   size_t used;

   /* The new memory area */
   struct chunk * new_memory;

   /* The miniumum size we need to grow by */
   at_least = chunk_size(at_least);

   /* Find the size of currently used memory */
   used = (size_t) mem->next - (size_t) mem->current;

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
   mem->next = (struct chunk *) ((size_t) mem->current + used);

   /* readdress the chunks in the current memory region */
   readdress(used, mem);
}

/* Readdress the chunks in current memory
   The arguments are currently used memory, and then the memory unit */
void readdress(size_t used, struct memory * mem)
{
   /* Pointer to the chunk we're working on */
   struct chunk * this;
   
   /* Loop through all the current chunks, updating their addresses */
   for(this = mem->current; this <= mem->next; this += chunk_size(this->size))
   {
      /* Set the address of the chunk to its own address */
      *(this->addr) = this;
   }
}
