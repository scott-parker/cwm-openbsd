CFLAGS+=	-O2 -Wall -D_GNU_SOURCE
LDADD+=		-lXft -lXrender -lX11 -lxcb -lXau -lXdmcp \
		-lfontconfig -lexpat -lfreetype -lz \
		-lXinerama -lXrandr -lXext

PREFIX?=	/usr/local
BINDIR?=	$(PREFIX)/bin
MANDIR?=	$(PREFIX)/man

SRCS=	$(shell ls *.c)
SRCS+=	y.tab.c
OBJS=	$(SRCS:.c=.o)
DEPS=	$(addsuffix .depend, $(OBJS))

CC?=	gcc
YACC?=	bison -y

all: y.tab.c cwm

y.tab.c:
	@echo "Generating $@"
	$(YACC) parse.y

cwm: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $+ $(LDADD)

%.o: %.c
	@echo "Generating $@.depend"
	@$(CC) -MM $(CPPFLAGS) $(CFLAGS) $< | \
	sed 's,^.*\.o[ :]*,$@ $@.depend : ,g' > $@.depend
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<

install: all
	install -m 755 -d $(DESTDIR)$(BINDIR)
	install -m 755 -d $(DESTDIR)$(MANDIR)/man1
	install -m 755 -d $(DESTDIR)$(MANDIR)/man5
	install -m 755 cwm $(DESTDIR)$(BINDIR)
	install -m 644 cwm.1 $(DESTDIR)$(MANDIR)/man1/cwm.1
	install -m 644 cwmrc.5 $(DESTDIR)$(MANDIR)/man5/cwmrc.5

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/cwm
	rm -f $(DESTDIR)$(MANDIR)/man1/cwm.1
	rm -f $(DESTDIR)$(MANDIR)/man5/cwmrc.5

clean:
	rm -f cwm $(OBJS) $(DEPS)
	rm -f y.tab.c

-include $(DEPS)

.PHONY: all install clean
