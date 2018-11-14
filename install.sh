#!/bin/bash

cd `dirname $0`
CONF_DIR=$PWD

install_tree()
{
    cp -asfT $CONF_DIR/tree $HOME
}

install_special_conky()
{
    cp -f $CONF_DIR/special/conky/.conkyrc $HOME/
    chmod 644 $HOME/.conkyrc
    sed -i "s/NETWORK_INTERFACE/$(grep 'Interface=' /etc/netctl/network | cut -d'=' -f2)/g" $HOME/.conkyrc
}

install_special_xdesktop()
{
    ln -sf $CONF_DIR/tree/bin/x/x-desktop.sh $HOME/bin/
}

case $1 in
    tree)
        echo "Installing tree only..."
        install_tree
        echo "Done!"
        ;;

    conky)
        echo "Installing conky config only..."
        install_special_conky
        echo "Done!"
        ;;

    xdesktop)
        echo "Installing x-desktop.sh only..."
        install_special_xdesktop
        echo "Done!"
        ;;

    "")
        echo "Installing everything..."
        install_tree
        install_special_conky
        install_special_xdesktop
        echo "Done!"
        ;;

    *)
        echo "Error: invalid argument."
esac

