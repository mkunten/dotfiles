#!/bin/bash

## file copy


## config
# .bashrc
cat << 'EOS' >> ~/.bashrc

# proxy
if [ -f "$HOME/bin/proxy-nijl.sh" ]; then
  source $HOME/bin/proxy-nijl.sh
fi
EOS
