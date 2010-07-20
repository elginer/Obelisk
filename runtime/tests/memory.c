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

/* Small test for the memory manager.
   Request a large amount of memory, write to it a number of times, and then try to read it back.
   Test fails on segfault!

   NOTE: Must be build with -DNO_GARBAGE_COLLECTION */

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
      objs[i] = allocate(objs, objs + i, 20, mem);
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
   for(i = 0; i < max; i++)
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
      printf("Zone contents: %s", obpointer(0, objs[i]));
   }


}

int main(int argc, char ** argv)
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

   /* Return success. */
   return EXIT_SUCCESS;
}
