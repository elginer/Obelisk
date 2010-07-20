/* Compare how fast Obelisk's memory manager is versus C's manual allocation and deallocation. */

#include <stdlib.h>

#define CHUNK_SIZE 1024
#define STACK_SIZE 10000
#define ITERATIONS 5000


/* Basically the same as the garbage test, but with only c. */
int main(int argc, char ** argv)
{
   char * stack[STACK_SIZE];

   char * blob;

   int i, j;

   for(j = 0; j < ITERATIONS; j++)
   {
      for (i = 0; i < STACK_SIZE; i++)
      {
         blob = malloc(CHUNK_SIZE);
         if (blob == NULL)
         {
            exit(EXIT_FAILURE);
         }
         stack[i] = blob; 
         free(blob);
      }
   }
   
}
