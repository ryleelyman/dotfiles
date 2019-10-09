apt-get install fuse libfuse2 git python3-pip ack-grep -y
wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim
chmod +x nvim
mv nvim /usr/bin
ln -srn dotfiles/.config .config
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install --user pynvim
wget -qO- "https://yihui.name/gh/tinytex/tools/install-unx.sh" | sh
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
dropboxd
