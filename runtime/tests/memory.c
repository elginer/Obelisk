/* Small test for the memory manager.
   Request a large amount of memory, write to it a number of times, and then try to read it back.
   Test fails on segfault! */

#define DEBUG

#include "memory.h"
#include "object.h"

#include <stdio.h>

/* The number of reads and writes we are going to do. */
#define ITERATIONS 5000 

/* Request a number of chunks */
void request_test(size_t max, chunk_addr objs[], memory_manager mem)
{
   /* Iterating variable */
   size_t i;

   /* Allocate a number of chunks */
   for(i = 0; i < max; i++)
   {
      /* get a chunk from the memory manager */
      objs[i] = allocate(20, mem);
   }

}

/* Write to the chunks */
void write_test(size_t max, chunk_addr objs[])
{
   /* The data we are going to write */
   word * data;

   /* An iterating variable */
   size_t i;

   /* Initialize the data */
   data = "Comfortably numb?!\n";

   /* Write to each chunk */
   for(i=0; i < max; i++)
   {
      /* Write to the chunk */
      obwrite(obpointer(0, objs[i]), data, 20);
   }

}

/* Print the contents of each chunk */
void read_test(size_t max, chunk_addr objs[])
{
   /* An iterating variable */
   size_t i;

   /* Print out each zone */
   for(i = 0; i < max; i++)
   {  /* Print the contents of the zone */
 //     printf("Zone contents: %s", obpointer(0, objs[i]));
   }


}

int main(int argc, int argv)
{

   /* The memory manager */
   memory_manager mem;

   /* A list of chunks */
   chunk_addr objs[ITERATIONS];

   /* Initialize the memory manager */
   mem = new_memory_manager(5); /*ITERATIONS * (chunk_size(20))); */

   /* Request chunks from the memory manager */
   request_test(ITERATIONS, objs, mem);

   /* Write to the memory manager */
   write_test(ITERATIONS, objs);

   /* Read from the memory manager */
   read_test(ITERATIONS, objs);

   /* Shutdown the memory_manager */
   shutdown_memory_manager(mem);
}
