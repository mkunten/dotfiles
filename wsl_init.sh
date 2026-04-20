#!/bin/bash
set -eu

#
echo "# prepare dirs"
mkdir -p ~/.local/bin ~/.config/bash/conf.d ~/dev/src
ln -s /mnt/c/Documents ~/
ln -s /mnt/c/Downloads ~/

#
echo "# setup git"
git config --global author.name mkunten
git config --global author.email mkunten@users.noreply.github.com
git config --global init.defaultBranch main
git config --global ghq.root ~/dev/src

echo "# prepare repositories"
sudo install -dm 755 /etc/apt/keyrings
curl -fSs https://mise.jdx.dev/gpg-key.pub | sudo tee /etc/apt/keyrings/mise-archive-keyring.asc 1> /dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.asc] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
# # for 26.04+
# sudo add-apt-repository -y ppa:jdxcode/mise
# sudo apt update -y
# sudo apt install -y mise

#
echo "# update/install packages"
sudo add-apt-repository -y ppa:jdxcode/mise
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential \ # required to build python
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
  libsqlite3-dev libncurses-dev tk-dev \
  libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
  screen zip mise # utils

#
echo "# setup gh/go/ghq/peco"
gh auth login
go install golang.org/x/tools/cmd/...@latest

cat << 'EOS' >> ~/.bashrc

# load .config/bash/conf.d/*.bash
if [ -d "$HOME/.config/bash/conf.d" ]; then
  for f in "$HOME/.config/bash/conf.d"/*.bash; do
    [ -r "$f" ] && . "$f"
  done
  unset f
fi
EOS

# dotfiles
repo=github.com/mkunten/dotfiles
gh repo clone $repo ~/dev/src/$repo
cd ~/dev/src/$repo
cp -r bin/* ~/bin/
for file in $(ls -1 dots); do
  echo cp -r $file ~/.$file
done

#
echo "# setup other tools via mise"
mise install

#
echo "misc"
sudo update-alternatives --set editor /usr/bin/vim.basic
cat << 'EOS' >> ~/.bashrc

echo "run 'exec $SHELL -l'"
exit 0
