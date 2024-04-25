#!/usr/bin/bash
# // 2024-03-10 Sun 20:42

# This copies config files in home and other directories:
  # 1) Copies config files to $HOME
  # 2) Copies .vimrc to /root
  # 3) copies neofetch/config.conf to $HOME/.config/neofetch/


#################################################################

function _install_programs() {

    # See if programs were already installed
    RESULT=$(which pipx)

    #if [[ -n "$RESULT" ]]; then
    if [[ -z "$RESULT" ]]; then

        # Install some programs:
        echo "Installing programs ..."
        sudo apt install neofetch fzf fd-find htop python3-full zoxide pipx moreutils ufw rsyslog fail2ban nginx-full
        #--dry-run

        # Install moreutils to get the vidir program;

        # Install trash-cli through pipx
        echo "Pipx installing trash-cli to /opt/pipx and creating symlink to /usr/local/bin ..."
        sudo PIPX_HOME=/opt/pipx PIPX_BIN_DIR=/usr/local/bin pipx install trash-cli

        # Then make additional symlink from /opt/pipx to /root/.local/pipx
        echo "Making symlink from /opt/pipx to /root/.local/pipx ..."
        sudo mkdir /root/.local
        sudo ln -s /opt/pipx /root/.local/pipx

    fi
}


function _copy_to_home() {
    # Copy hidden filds to home
    cp home_dir/.* ~/
}

function _copy_to_root() {
    # Copy the .vimrc file to /root
    sudo cp home_dir/.vimrc /root/
}

function _copy_to_neofetch() {
    # if not exist, then create neofetch folder;
    # Then copy the neofetch config.conf file
    mkdir -p ~/.config/neofetch
      # This command won't overwrite or delete if the folder already exists;
    cp home_dir/neofetch/config.conf ~/.config/neofetch
}

function _doStart() {

    echo "Ctrl-c to Cancel."
    echo -n "Doing copy in 3 seconds ... "

    for (( n=1; n < 4; n++ )); do
        sleep 1
        echo -n "$n "
    done

    sleep 1

    echo
    echo "Start..."

    sleep 1

    _install_programs

    echo "Doing copies ..."
    _copy_to_home
    _copy_to_root
    _copy_to_neofetch

    echo "Sourcing ~/.bashrc ..."
    # source ~/.bashrc
    # source "$HOME/.bashrc"

    SOURCE_BASHRC="source ~/.bashrc"
    # IFS= read -rei "$SOURCE_BASHRC" -p "${PS1@P}" SOURCE_BASHRC2
    eval "$SOURCE_BASHRC"  # run command
      # Execute arguments as shell command;
      # See: help eval

    #echo "Run 'source ~/.bashrc'"
    echo "Done."

    # echo "Copied and ~/.bashrc re-sourced."
}


#####################################################################

# List files in home_dir
# echo "Files in home_dir:"
# echo $(ls -AF home_dir) | tr [:space:] '\n'
# echo

# WHO=$(whoami)
# if [[ $WHO == "h5" ]]; then
#     echo "$WHO. Wrong system."
#     exit
# fi


echo "This script will:"
RESULT=$(which pipx)
if [[ -z "$RESULT" ]]; then
    echo "▫ Install basic programs."
    echo "▫ Pipx install trash-cli and setup symlinks."
fi

echo "▫ Copy configuration files to \$HOME folder."
echo "▫ Copy vimrc to /root folder."
echo "▫ Copy neofetch/config.conf to \$HOME/.config/neofetch."
read -p "Do you want to continue? (Y/n): " CHOICE
# read -p "Setup and copy configuration files to \$HOME folder, .vimrc to /root folder, and neofetch/config.conf to \$HOME/.config/neofetch? (Y/n): " CHOICE

case "$CHOICE" in

  n|N )
      echo "Canceled."
      exit
      ;;
  y|Y|* )
      read -rp "This can't be undone. Press any key to confirm. "
        # -r : fixing backslashes
        # -p : prompt
        # https://www.shellcheck.net/wiki/SC2162
      _doStart
      ;;
esac



