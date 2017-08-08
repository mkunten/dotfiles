#!/bin/bash

WORKDIR="ricty-webdevicons"
FONTSDIR=$(pwd)/fonts/ricty-webdevicon

# fontforge
which fontforge > /dev/null
if [ $? = 1 ]; then
  sudo add-apt-repository ppa:fontforge/fontforge
  sudo apt update && sudo apt -y install fontforge
fi

mkdir -p ${WORKDIR} ${FONTSDIR}
cd ${WORKDIR}

# ricty
if [ ! -f Inconsolata-Regular.ttf ]; then
  wget https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Regular.ttf
fi
if [ ! -f Inconsolata-Bold.ttf ]; then
  wget https://github.com/google/fonts/raw/master/ofl/inconsolata/Inconsolata-Bold.ttf
fi
if [ ! -d migu-1m-20150712 ]; then
  wget -O migu-1m-20150712.zip "https://ja.osdn.net/frs/redir.php?m=jaist&f=%2Fmix-mplus-ipa%2F63545%2Fmigu-1m-20150712.zip" && unzip migu-1m-20150712.zip
fi
if [ ! -f ricty_generator.sh ]; then
  wget -q http://www.rs.tus.ac.jp/yyusa/ricty/ricty_generator.sh
fi
bash ricty_generator.sh auto

# nerd-fonts
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts
cd nerd-fonts
OPTS="-w --fontawesome --fontawesomeextension --fontlinux --octicons --powersymbols --pomicons --powerline --powerlineextra --progressbars --careful -out ${FONTSDIR}"
fontforge -script ./font-patcher ../Ricty-Regular.ttf ${OPTS}
fontforge -script ./font-patcher ../Ricty-Bold.ttf ${OPTS}
fontforge -script ./font-patcher ../RictyDiscord-Regular.ttf ${OPTS}
fontforge -script ./font-patcher ../RictyDiscord-Bold.ttf ${OPTS}

cat << EOS

all done!

to remove gabage files:
  rm -rf ${WORKDIR}
to install fonts: 

  mv fonts/ricty-webdevicon ${HOME}/.fonts/ricty-webdevicon
  fc-cache
  # fc-list | grep Ricty
EOS

