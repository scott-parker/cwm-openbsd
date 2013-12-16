PREFIX?= /usr/local
BINDIR?= $(PREFIX)/bin
MANDIR?= $(PREFIX)/man

CC?= gcc
YACC?= bison -y
CFLAGS+= -O2 -Wall -D_GNU_SOURCE
LDADD+= -lXft -lXrender -lX11 -lxcb -lXau -lXdmcp -lfontconfig -lexpat \
        -lfreetype -lz -lXinerama -lXrandr -lXext

SRCS= $(shell ls *.c) y.tab.c
OBJS= $(SRCS:.c=.o)
DEPS= $(addsuffix .depend, $(OBJS))

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
