SHELL=/bin/sh

# files that need mode 644
MAN_FILE=man1/git-http.1
HTML_FILE=html/git-http.html

all:
	@echo "usage: make man"
	@echo "       make clean"
man:
	install -d -m 0755 man1
	pandoc -s \
		-w man git-http.1.md \
		-o  $(MAN_FILE)
html:
	pandoc -s -S --toc \
		-c git-http.css git-http.1.md \
		-o $(HTML_FILE)
clean:
	rm -f $(MAN_FILE)
	rm -f $(HTML_FILE)
	rmdir man1 --ignore-fail-on-non-empty

