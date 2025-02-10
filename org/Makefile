EMACS=emacs
ORG_CONFIG_FILE=publish_config.el
TARGET=ls ../*.html* | grep -v "index\|xmr\|404.html"

EMACS_OPTS=--script $(ORG_CONFIG_FILE) -f myweb-publish

all: html size co2 keyword

html:
	@echo "Generating HTML..."
	@$(EMACS) $(EMACS_OPTS)
	@echo "DONE"

clean:
	- rm ~/.org-timestamps/org-pages.cache
	- $(TARGET) | xargs -I {} rm {}
	- rm ../feed.xml*

size:
	$(TARGET) | xargs -I {} sh -c 'sed -i "s/PAGE_SIZE/$$(du -h --apparent-size {} | cut -f1)/g" {}'

co2:
	$(TARGET) | xargs -I {} node ../misc/co2.js {}

keyword:
	$(TARGET) | xargs -I {} python3 ../misc/rcs_kw.py {}
