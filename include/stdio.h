#include_next <stdio.h>

#ifndef CWM_COMPAT_STDIO_H
#define CWM_COMPAT_STDIO_H

#if defined(__linux__)
char	*fgetln(FILE *, size_t *);
#endif

#endif
