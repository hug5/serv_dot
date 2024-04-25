#!/usr/bin/bash
# // 2024-03-10 Sun 20:42

# This copies config files in home and other directories:
  # 1) Copies config files to $HOME
  # 2) Copies .vimrc to /root
  # 3) copies neofetch/config.conf to $HOME/.config/neofetch/


#################################################################


function copy_to_home() {
    # Copy hidden filds to home
    cp home_folder/.* ~/
}

function copy_to_root() {
    # Copy the .vimrc file to /root
    sudo cp home_folder/.vimrc /root/
}

function copy_to_neofetch() {
    # if not exist, then create neofetch folder;
    # Then copy the neofetch config.conf file
    mkdir -p ~/.config/neofetch
      # This command won't overwrite or delete if the folder already exists;
    cp home_folder/neofetch/config.conf ~/.config/neofetch
}

function doCopy() {

    echo "Ctrl-c to Cancel."
    echo -n "Doing copy in 3 seconds... "

    for (( n=1; n < 4; n++ )); do
        sleep 1
        echo -n "$n "
    done

    sleep 1

    echo
    echo "Start..."

    sleep 1

    copy_to_home
    copy_to_root
    copy_to_neofetch

    source ~/.bashrc

    #echo "Run 'source ~/.bashrc'"
    echo "Copied and ~/.bashrc re-sourced."
}


#################################################################

# List files in home_folder
echo "home_folder:"
echo $(ls -AF home_folder) | tr [:space:] '\n'
echo
# Get confirmation
read -p "Copy configuration files to \$HOME folder, and .vimrc to /root folder, and neofetch/config.conf to \$HOME/.config/neofetch? (Y/n): " CHOICE

case "$CHOICE" in

  n|N )
      echo "Canceled."
      ;;
  y|Y|* )
      read -p "This can't be undone. Press any key to confirm: "
      doCopy
      ;;
esac



