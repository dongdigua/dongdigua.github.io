EMACS=emacs
ORG_CONFIG_FILE=publish_config.el
EMACS_OPTS=--batch --eval "(load-file \"$(ORG_CONFIG_FILE)\")" -f myweb-publish

all: html

html:
	@echo "Generating HTML..."
	@$(EMACS) $(EMACS_OPTS)
	@echo "HTML generation done"

clean:
	rm ./../org_html/*.html
	rm ~/.org-timestamps/org-pages.cache
