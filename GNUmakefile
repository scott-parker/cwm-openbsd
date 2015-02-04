PREFIX?=	/usr/local
BINDIR?=	$(PREFIX)/bin
MANDIR?=	$(PREFIX)/man

CC?=		gcc
YACC?=		bison -y
X11BASE?=	/usr

UNAME:=		$(shell sh -c 'uname 2> /dev/null || echo undefined')

CFLAGS+=	-Iinclude -I$(X11BASE)/include/freetype2

LDADD+=		-lXft -lXrender -lX11 -lxcb -lXau -lXdmcp -lfontconfig \
		-lexpat -lfreetype -lz -lXinerama -lXrandr -lXext

SRCS=		calmwm.c client.c conf.c group.c kbfunc.c menu.c mousefunc.c \
		screen.c search.c util.c xevents.c xutil.c xmalloc.c y.tab.c

ifeq ($(UNAME), Linux)
CFLAGS+=	-D_GNU_SOURCE
SRCS+=		compat/fgetln.c compat/strlcat.c compat/strlcpy.c \
		compat/strtonum.c
endif

OBJS=		$(SRCS:.c=.o)

all: y.tab.c cwm

y.tab.c:
	$(YACC) parse.y

cwm: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $+ $(LDADD)

%.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<

install: all
	install -m 755 -d $(DESTDIR)$(BINDIR)
	install -m 755 -d $(DESTDIR)$(MANDIR)/man1
	install -m 755 -d $(DESTDIR)$(MANDIR)/man5
	install -m 755 cwm $(DESTDIR)$(BINDIR)
	install -m 644 cwm.1 $(DESTDIR)$(MANDIR)/man1
	install -m 644 cwmrc.5 $(DESTDIR)$(MANDIR)/man5

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/cwm
	rm -f $(DESTDIR)$(MANDIR)/man1/cwm.1
	rm -f $(DESTDIR)$(MANDIR)/man5/cwmrc.5

clean:
	rm -f y.tab.c cwm $(OBJS)

.PHONY: all install clean
