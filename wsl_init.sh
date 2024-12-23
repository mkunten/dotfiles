#!/bin/bash
set -eu

#
echo "# prepare dirs"
mkdir -p ~/bin ~/dev/src
ln -s /mnt/c/Documents ~/
ln -s /mnt/c/Downloads ~/

#
echo "# setup git"
git config --global author.name mkunten
git config --global author.email mkunten@users.noreply.github.com
git config --global init.defaultBranch main
git config --global ghq.root ~/dev/src

#
echo "# update/install packages"
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential \ # required to build python
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
  libsqlite3-dev libncurses-dev tk-dev \
  libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
  gh jq screen zip # utils

#
echo "# setup asdf"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.15.0
cat << 'EOS' >> ~/.bashrc

# asdf
if [ -d ~/.asdf ]; then
  . ~/.asdf/asdf.sh
  . ~/.asdf/completions/asdf.bash
fi
EOS
. ~/.asdf/asdf.sh

asdf_list="golang nodejs python"
for lang in $asdf_list; do
  echo "## asdf: $lang"
  asdf plugin add $lang
  asdf install $lang latest
  asdf global $lang latest
done

#
echo "# setup gh/go/ghq/peco"
gh auth login
go install golang.org/x/tools/cmd/...@latest
go install github.com/x-motemen/ghq@latest
go install github.com/peco/peco/cmd/peco@latest
asdf reshim golang

cat << 'EOS' >> ~/.bashrc

# gcd
function gcd() {
  cd $(git config --global ghq.root)/$(ghq list | peco --query="$*")
}
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
echo "misc"
sudo update-alternatives --set editor /usr/bin/vim.basic
cat << 'EOS' >> ~/.bashrc

# open
function open() {
  cmd.exe /c start $(wslpath -w $1)
}
EOS

echo "run 'exec $SHELL -l'"
exit 0
