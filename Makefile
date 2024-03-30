all: describe org posts gmi

.PHONY: org
org:
	cd org; $(MAKE)

posts:
	pandoc posts.md --css=css/everforest.css -s -o posts.html

gmi:
	misc/mdlist2gmi.py > posts.gmi

describe:
	sed -i "s/\$$v\\$$/\$$v: $$(git describe --tags HEAD)\\$$/g" index.html

clean:
	rm posts.html
	rm posts.gmi
