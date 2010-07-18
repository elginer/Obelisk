/* Prevent multiple inclusion */
#ifndef OBJECT
#define OBJECT

#include <stdlib.h>
#include <stdarg.h>

/* An 8-bit word */
typedef char word;

/* Nice looking alias for a chunk */
typedef struct chunkS chunk;

/* An address of a chunk, from the perspective of the mutator. */
typedef chunk ** chunk_addr;

/* A chunk of memory, requested from the memory manager */
struct chunkS
{
   /* The size of this chunk */
   size_t size;

   /* The address of this chunk */
   chunk_addr addr;
}
achunk;

/* The return type is short */
typedef short return_type;

/* Trampolining, for tail calls, is one return value */
#define RETURN_TRAMPOLIE 0
/* A chunk is another return value */
#define RETURN_CHUNK 1

/* Nicer looking names for our structures */
typedef struct function_pointerS function_pointer;
typedef struct trampolineS trampoline;
typedef struct return_valS return_val;
typedef union returnedU returned;

/* The closure environment is a list of chunk_addresses */
typedef chunk_addr * closure_environment;

/* A pointer to an obelisk function */
struct function_pointerS
{
   /* The function pointer points to an obelisk function */
   void (*function)(return_val * continuation, va_list args);

   /* The closure environment associated with the function */
   closure_environment closure;
   
}
afunction_pointer;

/* A trampoline */
struct trampolineS
{
   /* A trampoline has a function pointer */
   function_pointer function;

   /* A trampoline also has a list of arguments for the function */
   va_list args;
}
atrampoline;


/* A union of possible return values */
union returnedU
{
   /* The function could return a function pointer to be trampolined! */
   trampoline tail_call;

   /* The function could return a chunk */
   chunk_addr zone;
}
areturned;

/*  Return values of Obelisk functions. */
struct return_valS
{
   /* The type of the return val */
   return_type type;
   /* The return value */
   returned value;
}
areturn_val;

/* The size in memory the a chunk would occupy */
size_t chunk_size(size_t size);

/* Get a pointer to the ith position of the chunk */
word * obpointer(size_t i, chunk_addr obj);

/* Copy n bytes from obj to the ith position of the chunk */
void obwrite(word * chu, word * obj, size_t n);

#endif
