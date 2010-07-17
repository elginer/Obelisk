/* Prevent multiple inclusion */
#ifndef ERROR
#define ERROR

#include "stdlib.h"

/* Macro to report errors and exit. */
#define FATAL_ERROR(MSG) \
   perror("Fatal error in Obelisk runtime; " MSG );\
   exit(EXIT_FAILURE);

#endif
