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

/* Test the garbage cleaner by running a program which should stay at a constant memory limit.

Fail on segfault or ever increasing memory usage.
*/

#include "object.h"
#include "memory.h"

#include <stdio.h>

#define CHUNK_SIZE 1024
#define STACK_SIZE 10000
#define ITERATIONS 5000

int main(int argc, char ** argv)
{

   /* The stack */
   chunk_addr stack[STACK_SIZE];

   /* Iterative variables */
   int i, j;

   /* The memory manager */
   memory_manager mem;

   /* Create the stack */

   /* Create a new memory manager that should not have to grow. */
   mem = new_memory_manager(STACK_SIZE * chunk_size(CHUNK_SIZE));

   /* For ever:
      Loop throught the stack.  
      Allocate a new piece of data to stack. */
   for (j = 0; j < ITERATIONS; j++)
   { 
      for (i = 0; i < STACK_SIZE; i++)
      {
         stack[i] = allocate(stack, stack + 1, CHUNK_SIZE, mem); 
      }
   }   

   /* Shutdown the memory manager. */
   shutdown_memory_manager(mem);

   return EXIT_SUCCESS;
}
