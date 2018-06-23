#!/bin/bash

cd `dirname $0`
CONF_DIR=$(pwd)

install_links () {
    ln -sf $CONF_DIR/.xaliases $HOME/
    ln -sf $CONF_DIR/.xinitrc $HOME/
    ln -sf $CONF_DIR/.xprofile $HOME/
    ln -sf $CONF_DIR/.Xresources $HOME/
    ln -sf $CONF_DIR/.xserverrc $HOME/
    
    ln -sf $CONF_DIR/.conkyrc $HOME/
    ln -sf $CONF_DIR/.gtkrc-2.0 $HOME/

    ln -sf $CONF_DIR/x $HOME/
    mkdir -p $HOME/scripts/
    ln -sf $CONF_DIR/x/x-desktop.sh $HOME/scripts/
    
    mkdir -p $HOME/.config/
    ln -sf $CONF_DIR/.config/dunst $HOME/.config/
    ln -sf $CONF_DIR/.config/gtk-3.0 $HOME/.config/
    ln -sf $CONF_DIR/.config/i3 $HOME/.config/
    ln -sf $CONF_DIR/.config/i3status $HOME/.config
    ln -sf $CONF_DIR/.config/termite $HOME/.config
}

# Make links in our home directory
echo Creating symbolic links in the home directory
install_links

# Make links in root home directory
echo Now creating symbolic links in the /root directory
read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
INSTALL_LINKS_FUNC=$(declare -f install_links)
sudo bash -c "CONF_DIR=$CONF_DIR;$INSTALL_LINKS_FUNC; install_links"
