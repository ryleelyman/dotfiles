#!/bin/bash

UPGRADE_PACKAGES=${1:-none}

if [ "$UPGRADE_PACKAGES}" != "none" ]; then
	echo "==> Updating and upgrading packages ..."

	# Add third party repositories
	add-apt-repository ppa:keithw/mosh-server -y
	apt-get update
	apt-get upgrade -y
	apt-get install -qq \
		git \
		mosh \
		python3-pip \
		fuse \
		libfuse2 \
		ack-grep \
		-y --no-install-recommends
fi

# install neovim
if ! [ -x "$(command -v nvim)" ]; then
	echo "==> Installing neovim ..."
	wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim
	chmod +x nvim
	mv nvim /usr/bin
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	pip3 install setuptools
	pip3 install wheel
	pip3 install --user pynvim
fi

if ! [ -f "${HOME}/.TinyTex" ]; then
	echo "==> Installing TinyTex ..."
	wget -qO- "https://yihui.name/gh/tinytex/tools/install-unx.sh" | sh
	export PATH=$PATH:root/bin
	tlmgr install pgf cleveref mathtools xcolor tikz-cd epstopdf-pkg enumitem
	tlmgr install transparent pdfpages import rsfs jknapltx pdflscape biblatex
	tlmgr path add
	fmtutil-sys -all
fi

if ! [ -f "${HOME}/Dropbox" ]; then
	cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
	.dropbox-dist/dropboxd
fi
