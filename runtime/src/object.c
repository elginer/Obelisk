#include "object.h"

/* The size in memory the a chunk would occupy */
size_t chunk_size(size_t size)
{
   return sizeof(achunk) + size;
}
