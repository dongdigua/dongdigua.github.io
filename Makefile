all: describe org patches get

.PHONY: org
org:
	$(MAKE) -C org

describe:
	sed -i "s/\$$v\\$$/\$$v: $$(git describe --tags HEAD)\\$$/g" index.html

.PHONY: patches
patches:
	./patches/txt.sh
	./patches/color.sh
	./patches/postamble.sh

get:
	curl "https://raw.githubusercontent.com/dongdigua/configs/main/.tmux.conf" -o misc/tmux.conf
	curl "https://gist.githubusercontent.com/dongdigua/18160c0dda33ae5c322949f013443f84/raw" -o misc/pia.sh
	curl -O "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
	curl -O "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md.minisig"
