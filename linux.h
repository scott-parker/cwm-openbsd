size_t		 strlcpy(char *, const char *, size_t);
size_t		 strlcat(char *, const char *, size_t);
long long	 strtonum(const char *, long long, long long, const char **);
char		*fgetln(FILE *, size_t *);

#ifndef __dead
#define __dead		__attribute__((__noreturn__))
#endif

#ifndef WAIT_ANY
#define WAIT_ANY	(-1)
#endif

#ifndef TAILQ_END
#define	TAILQ_END(head)	NULL
#endif

#ifndef TAILQ_FOREACH_SAFE
#define TAILQ_FOREACH_SAFE(var, head, field, tvar)	\
	for ((var) = TAILQ_FIRST(head);			\
	    (var) != TAILQ_END(head) &&			\
	    ((tvar) = TAILQ_NEXT(var, field), 1);	\
	    (var) = (tvar))
#endif
