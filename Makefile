all: org posts gmi

org:
	cd org && make

posts:
	pandoc posts.md --css=css/everforest.css -s -o posts.html

gmi:
	misc/mdlist2gmi.py > posts.gmi

describe:
	git describe --tags HEAD
	sed -i "s/\$$v\\$$/\$$v: $$(git describe --tags HEAD)\\$$/g" index.html

clean:
	rm posts.html
	rm posts.gmi
