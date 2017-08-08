#!/bin/bash

## environment
LANG=C xdg-user-dirs-gtk-update

## packages
sudo apt update && sudo apt -y upgrade && sudo apt install -y \
  dkms build-essential
sudo reboot
