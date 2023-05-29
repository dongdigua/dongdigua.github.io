EMACS=emacs
ORG_CONFIG_FILE=publish_config.el
TARGET=ls ../*.html* | grep -v "index\|xmr\|404.html"

# --script and --batch can't load the theme
# GUI will have a better color, but can't use in CI
EMACS_OPTS=-Q -nw --eval "(load-file \"$(ORG_CONFIG_FILE)\")" -f myweb-publish

all: html

html:
	@echo "Generating HTML..."
	@$(EMACS) $(EMACS_OPTS)
	@echo "DONE"

clean:
	- rm ~/.org-timestamps/org-pages.cache
	- $(TARGET) | xargs -I {} rm {}
	- rm ../feed.xml*
