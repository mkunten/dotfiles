#!/bin/bash
echo "#!/bin/bash"

## packages
echo "## packages"
# Ubuntu Japanese Team
echo "# Ubuntu Japanese Team"
sudo add-apt-repository -y ppa:japaneseteam/ppa
# golang glide
echo "# golang glide"
sudo add-apt-repository -y ppa:masterminds/glide
# install
echo "# install"
sudo apt -y update && sudo apt install -y \
  vim vim-gtk terminator git \
  eblook eb-utils eb-doc feh silversearcher-ag \
  glide plantuml

## dirs
echo "## dirs"
mkdir -p hostc tmp dev .ssh
chmod 700 ~/.ssh
echo "hostc ${HOME}/hostc vboxsf defaults,uid=${UID},gid=$(id -g)" | \
  sudo tee -a /etc/fstab
grep -r vboxsf /etc/modules* > /dev/null || echo vboxsf | \
  sudo tee -a /etc/modules-load.d/vboxsf.conf > /dev/null
sudo mount -a
rm -rf ~/Documents ~/Downloads
ln -s ~/hostc/Documents ~/
ln -s ~/hostc/Downloads ~/
ln -s ~/hostc/Dropbox ~/
ln -s ~/hostc/epwing ~/

## config
echo "## config"
# my bin
echo "# my bin"
cd $(dirname $0)
cp -rp ../bin ~/bin
sed -i.bak -e 's/^\( *\)\(.*\)\(lxsession-default terminal\)\(.*\)$/\1<!-- \2\3\4 -->\n\1\2~\/bin\/term\4/' \
  ~/.config/openbox/lubuntu-rc.xml
openbox --reconfigure

# git
echo "# git"
git config --global user.name 'mkunten'
git config --global user.email 'mkunten@users.noreply.github.com'
git config --global ghq.root '~/dev/src'

# golang tools
echo "# golang tools"
export GOPATH=~/dev
export PATH=$PATH:$HOME/bin:$GOPATH/bin
go get -u golang.org/x/tools/cmd/...
go get -u github.com/BurntSushi/toml/cmd/tomlv
#go get -u github.com/dinedal/textql/...
echo "#go get -u github.com/dinedal/textql/..."
go get -u github.com/noborus/trdsql
go get -u github.com/mattn/mkup
go get -u github.com/motemen/ghq
# peco
echo "# peco"
go get -d github.com/peco/peco
cd ${GOPATH}/src/github.com/peco/peco
glide install
go build cmd/peco/peco.go
mv peco ~/dev/bin/
# lemonade
echo "# lemonade"
go get -d github.com/pocke/lemonade
cd ${GOPATH}/src/github.com/pocke/lemonade
make install

# git repos
echo "# git repos"
ghq get --shallow git@github.com:mkunten/dotfiles.git
ghq get --shallow git@github.com:mkunten/others.git
ghq get --shallow git@bitbucket.org:mkunten/texmf.git

# anyenv
echo "# anyenv"
ghq get --shallow riywo/anyenv
ln -s ~/.anyenv ~/dev/src/github.com/riywo/anyenv
# path/init todo
echo "# path/init todo"
anyenv install ndenv
ndenv install v8.4.0
ndenv global v8.4.0

# symlink/cp
echo "# symlink/cp"
ln -s ~/dev/src/github.com/mkunten/dotfiles/vim ~/.vim
ln -s ~/dev/dev/src/github.com/mkunten/dotfiles/less ~/.less
ln -s ~/dev/dev/src/github.com/mkunten/dotfiles/lesskey ~/.lesskey
mkdir -p ~/.config/terminator
cp ~/dev/dev/src/github.com/mkunten/dotfiles/config/terminator/config \
  ~/.config/terminator/config
cp ~/dev/dev/src/github.com/mkunten/dotfiles/config/trdsql \
  ~/.config/trdsql

# .profile
echo "# .profile"
cat << 'EOS' >> ~/.profile

if [ -d "$HOME/dev" ]; then
  export GOPATH="$HOME/dev"
  export PATH="$HOME/dev/bin:$PATH"
fi

if [ -d "$HOME/.anyenv" ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
fi
EOS

# .bashrc
echo "# .bashrc"
cat << 'EOS' >> ~/.bashrc

# ghq
function gcd() {
  cd $(ghq list -p | peco --select-1 --query="$*")
}

# anyenv
if [ -f "$HOME/.anyenv/bin/anyenv" ]; then
  eval "$($HOME/.anyenv/bin/anyenv init -)"
fi

# workaround for terminator bug
# https://askubuntu.com/questions/446076/change-environment-variable-term
[[ $COLORTERM = gnome-terminal && ! $TERM = screen-256color ]] && \
  TERM=xterm-256color
EOS

## web & sql
echo "## web & sql"
sudo apt install -y apache2 php php-dev php-pear php-mbstring \
 mysql-server php-mysql postgresql php-pgsql
sudo chown -R mkunten.mkunten /var/www
#ln -s ~/git /var/www/pub
echo "#ln -s ~/git /var/www/pub"
# mysql
echo "# mysql"
sudo cat << EOM | sudo tee /etc/mysql/conf.d/utf8.cnf
[mysqld]
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_520_ci
init-connect = SET NAMES utf8mb4
[client]
default-character-set = utf8mb4
[mysql]
default-character-set = utf8mb4
[mysqldump]
default-character-set = utf8mb4
EOM
sudo systemctl restart mysql
echo mysql_secure_installation -D
mysql_secure_installation -D
# postgresql
echo "# postgresql"
sudo sed -i.bak -e 's/^\(local *all *all *\)peer$/#\0\n\1md5/' /etc/postgresql/9.5/main/pg_hba.conf
echo postgresql: createuser -sdrlP $(id -un)
sudo -u postgres -s createuser -sdrlP $(id -un)
# reload
echo "# reload"
sudo systemctl restart postgresql
sudo systemctl restart apache2
# trdsql
echo "# trdsql"
echo "postgresql: create(user|db) for noborus/trdsql"
createuser trdsql
createdb -O trdsql trdsql
psql trdsql -c "ALTER USER trdsql WITH PASSWORD 'trdsql'"

# nodejs tools
echo "# nodejs tools"
npm install -g eslint coffee-script js2coffee uglify-js pm2
ndenv rehash

# texlive
echo "# texlive"
ln -s ~/dev/src/github.com/mkunten/texmf ~/texmf
sudo apt install -y texlive-fonts-recommended texlive-lang-cjk \
  texlive-lang-indic texlive-lang-other t1utils \
  texlive-luatex texlive-xetex pkg-config
