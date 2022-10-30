EMACS=emacs
ORG_CONFIG_FILE=publish_config.el
EMACS_OPTS=--batch --eval "(load-file \"$(ORG_CONFIG_FILE)\")" -f myweb-publish
TARGET=ls ../*.html* | grep -v "index\|xmr.html"

all: html

html:
	@echo "Generating HTML..."
	@$(EMACS) $(EMACS_OPTS)
	@echo "DONE"

clean:
	rm ~/.org-timestamps/org-pages.cache
	$(TARGET) | xargs -I {} rm {}
	rm ../feed.xml*
