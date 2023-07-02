all: org posts gmi

org:
	cd org && make

posts:
	pandoc posts.md --css=css/everforest.css -s -o posts.html

gmi:
	misc/mdlist2gmi.py > posts.gmi

clean:
	rm posts.html
	rm posts.gmi
