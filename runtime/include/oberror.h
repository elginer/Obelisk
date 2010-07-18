/* Prevent multiple inclusion */
#ifndef ERROR
#define ERROR

#include <error.h>
#include <stdlib.h>

/* Macro to report errors and exit. */
#define FATAL_ERROR(MSG) \
   error(EXIT_FAILURE, 0 ,"Fatal error in Obelisk runtime; " MSG );\

#endif
