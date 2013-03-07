#! /usr/bin/make -f
SHELL=/bin/sh

DESTDIR?=/usr/local
prefix?=${DESTDIR}

# files that need mode 755
EXEC_FILES=git-http

# files that need mode 644
MAN_FILE=man1/git-http.1

all:
	@echo "usage: make install     -> installs git-http only"
	@echo "       make install-man -> installs man pages only"
	@echo "       make install-all -> installs git-http and man pages"
	@echo "       make uninstall"
	@echo "       make uninstall-man"
	@echo "       make uninstall-all"
	@echo "       make clean"

install:
	install -d -m 0755 $(prefix)/bin
	install -m 0755 $(EXEC_FILES) $(prefix)/bin

install-man:
	install -d -m 0755 $(prefix)/man
	cd man && \
	make man && \
	install -d -m 0755 $(prefix)/man/man1 && \
	install -m 0644 $(MAN_FILE) $(prefix)/man/man1 && \
	mandb $(prefix)/man/man1

install-all: install install-man

uninstall:
	test -d $(prefix)/bin && \
	cd $(prefix)/bin && \
	rm -f $(EXEC_FILES)

uninstall-man:
	test -d $(prefix)/man && \
	cd $(prefix)/man && \
	rm -f $(MAN_FILE)
	mandb -f $(prefix)/man/$(MAN_FILE)
	rmdir --ignore-fail-on-non-empty $(prefix)/man/man1

uninstall-all: uninstall uninstall-man

clean:
	cd man && make clean

