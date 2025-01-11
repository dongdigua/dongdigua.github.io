all: describe org posts gmi patches get

.PHONY: org
org:
	cd org; $(MAKE)

posts:
	pandoc posts.md --css=css/everforest.css -s -o posts.html

gmi:
	misc/mdlist2gmi.py > posts.gmi

describe:
	sed -i "s/\$$v\\$$/\$$v: $$(git describe --tags HEAD)\\$$/g" index.html

patches:
	./patches/txt.sh
	./patches/color.sh

get:
	curl "https://raw.githubusercontent.com/dongdigua/configs/main/.tmux.conf" -o misc/tmux.conf
	curl "https://gist.githubusercontent.com/dongdigua/18160c0dda33ae5c322949f013443f84/raw" -o misc/pia.sh

clean:
	rm posts.html
	rm posts.gmi
