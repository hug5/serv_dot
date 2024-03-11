#!/usr/bin/bash
# // 2024-03-10 Sun 20:42

# This copies config files in home_folder to ~/ and copies .vimrc to /root

############################################


function doCopy() {

    echo "Ctrl-c to cancel."
    echo -n "Doing copy in 3 seconds... "
    for (( n=1; n < 4; n++ )); do
        sleep 1
        echo -n "$n "
    done
    sleep 1
    echo
    echo "Start..."
    sleep 1
    # cp -r home_folder/. ~/tmp/home_folder/
    cp -r home_folder/. ~/
    # sudo cp home_folder/.bash_aliases /tmp/home_folder
    sudo cp home_folder/.vimrc /root/
    echo "Copied."
    echo "Run 'source ~/.bashrc'"
}


############################################

# List files in home_folder
echo "home_folder:"
echo $(ls -AF home_folder) | tr [:space:] '\n'
echo
# Get confirmation
read -p "Copy configuration files to ~/ home folder and .vimrc to /root folder? (y/n): " CHOICE

case "$CHOICE" in

  y|Y )
      read -p "THIS CANNOT BE UNDONE!! Press key to continue: "
      doCopy
      ;;
  n|N|* )
      echo "Canceled."
      ;;
esac



