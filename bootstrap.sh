#!/bin/bash

UPGRADE_PACKAGES=${1:-none}

if [ "$UPGRADE_PACKAGES}" != "none" ]; then
	echo "==> Updating and upgrading packages ..."

	# Add third party repositories
	add-apt-repository ppa:keithw/mosh-server -y
	apt-get update
	apt-get upgrade -y
fi

apt-get install -qq \
	git \
	mosh \
	python3-pip \
	fuse \
	libfuse2 \
	ack-grep \
	-y --no-install-recommends

git config --global user.name "Rylee Lyman"
git config --gloabl user.email "rylee.lyman@tufts.edu"

# install neovim
if ! [ -x "$(command -v nvim)" ]; then
	echo "==> Installing neovim ..."
	wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim
	chmod +x nvim
	mv nvim /usr/bin
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	pip3 install --user pynvim
fi

if ! [ -x "$(command --version ctags)" ]; then
	git clone https://github.com/universal-ctags/ctags.git
	cd ctags
	./autogen.sh
	./configure --prefix=$HOME
	make
	make install
fi

ln -srn dotfiles/.config .config

if [ ! -f "${HOME}/.TinyTex" ]; then
	echo "==> Installing TinyTex ..."
	wget -qO- "https://yihui.name/gh/tinytex/tools/install-unx.sh" | sh
fi

if [ ! -f "${HOME}/Dropbox" ]; then
	wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
	dropboxd
fi
