#!/bin/bash
set -euo pipefail

repo=github.com/mkunten/dotfiles

echo "# prepare dirs"
mkdir -p ~/.local/bin ~/dev/src
ln -s /mnt/c/Documents ~/
ln -s /mnt/c/Downloads ~/

echo "# update/install packages"
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential \
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
  libsqlite3-dev libncurses-dev tk-dev \
  libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
  zip

echo "# setup mise"
curl https://mise.run | sh
eval "$(~/.local/bin/mise activate bash)"

echo "# setup dotfiles"
mkdir -p ~/dev/src/$repo
git clone https://$repo.git ~/dev/src/$repo
cd ~/dev/src/$repo/dots
for item in *; do
  if [ -d "$item" ]; then
    echo merge directory: $item
    mkdir -p "$HOME/.$item"
    rsync -a "$item/" "$HOME/.$item/"
  else
    echo copy file: $item
    cp -r "$item" "$HOME/.$item"
  fi
done
cd ~

echo "# install tools"
mise install go@latest node@latest
hash -r
mise install
$(mise which go) install golang.org/x/tools/cmd/...@latest

echo "# install windows tools"
if command -v winget.exe &> /dev/null; then
  if ! command -v win32yank.exe &> /dev/null; then
    echo "win32yank.exe not found. Installing via winget..."
    winget.exe install --id equalsraf.win32yank --silent
  else
    echo "win32yank.exe is already installed."
  fi

else
  echo "Warning: winget.exe is not accessible from WSL."
fi

echo "misc"
sudo update-alternatives --set editor /usr/bin/vim.basic

cat << 'EOS' >> ~/.bashrc

# load .config/bash/conf.d/*.bash
if [ -d "$HOME/.config/bash/conf.d" ]; then
  for f in "$HOME/.config/bash/conf.d"/*.bash; do
      [ -r "$f" ] && . "$f"
  done
  unset f
fi
EOS

echo "# gh auth"
$(mise which gh) auth login

echo "run 'exec $SHELL -l'"
exit 0
