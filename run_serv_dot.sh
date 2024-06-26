#!/usr/bin/bash

# /usr/bin/env bash
# /bin/env bash
# /usr/bin/bash
# /bin/bash

# // 2024-03-10 Sun 20:42

# This copies config files in home and other directories:
  # 1) Copies config files to $HOME
  # 2) Copies .vimrc to /root
  # 3) copies neofetch/config.conf to $HOME/.config/neofetch/


#------------------------------------------


CONT=
  # continue operation or not:

PROGRAMS="bat screen ranger neofetch fzf fd-find htop python3-full zoxide pipx moreutils ufw rsyslog fail2ban nginx-full inxi"

PROGRAMS_POSTFIX="mailutils postfix sasl2-bin libgsasl18 libsasl2-dev libsasl2-modules"



#------------------------------------------
function _install_programs_postfix() {

    local RESULT
    # RESULT=$(which pipx)
    RESULT=$(whereis postfix)
    # Can't use which, hash or command -v here because postfix
    # is not a command but a program!

    if [[ -z "$RESULT" ]]; then

        read -rp "Do you want to install Postfix? (Y/n): " CHOICE
        # Why -r? https://www.shellcheck.net/wiki/SC2162
        case "$CHOICE" in

          n|N )
              ;;
          y|Y|* )
              sudo apt install $PROGRAMS_POSTFIX -y
              echo "Done."
              ;;
        esac

    fi

}

function _install_programs_basic() {

    # See if programs were already installed
    local RESULT
    # RESULT=$(which pipx)
    # RESULT=$(command -v pipx)
      # Rather than 'which' command, lsp reommends:
      # command -v pipx
      # hash pipx
      # has doesn't necessarily seem to work??!
    RESULT=''
      # Problem if adding new programs to the list; so maybe just reinstall everything; won't reinstall if already installed;

    # List of programs to install:
      # Install moreutils to get the vidir program;

    #if [[ -n "$RESULT" ]]; then
    if [[ -z "$RESULT" ]]; then

        echo "Installing basic applications..."
        sudo apt install $PROGRAMS -y
          #--dr-run
          # Don't use double-quotes around $PROGRAMS; we want each string to be separate; not 1 long word;
        echo "Done."

        # Install trash-cli through pipx
        echo "Pipx installing trash-cli to /opt/pipx and creating symlink to /usr/local/bin..."
        sudo PIPX_HOME=/opt/pipx PIPX_BIN_DIR=/usr/local/bin pipx install trash-cli

        # Then make additional symlink from /opt/pipx to /root/.local/pipx
        echo "Making symlink from /opt/pipx to /root/.local/pipx..."
        sudo mkdir /root/.local
        sudo rm /root/.local/pipx
        sudo ln -s /opt/pipx /root/.local/pipx

        echo "Done."

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
    cp home_dir/neofetch/* ~/.config/neofetch
}

function _copy_to_ranger() {
    mkdir -p ~/.config/ranger
      # This command won't overwrite or delete if the folder already exists;
    cp home_dir/ranger/* ~/.config/ranger

    # delete existing, if any; clone devicons
    rm -rf ~/.config/ranger/plugins
    git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons

}


function _doStart() {

    echo "Ctrl-c to Cancel."
    echo -n "Doing copy in 3 seconds... "

    for (( n=1; n < 4; n++ )); do
        echo -n "$n "
        sleep 1
    done

    echo
    echo "Start..."

    # sleep 1

    _install_programs_basic
    _install_programs_postfix

    echo "Making config copies..."
    _copy_to_home
    _copy_to_root
    _copy_to_neofetch
    _copy_to_ranger

    echo "Sourcing ~/.bashrc..."
    # source ~/.bashrc
    # source "$HOME/.bashrc"

    # SOURCE_BASHRC="source $HOME/.bashrc"
    # IFS= read -rei "$SOURCE_BASHRC" -p "${PS1@P}" SOURCE_BASHRC2
    # eval "$SOURCE_BASHRC"  # run command
      # Execute arguments as shell command;
      # See: help eval

    #echo "Run 'source ~/.bashrc'"

    source ~/.bashrc
    echo "Done."

    # echo "Copied and ~/.bashrc re-sourced."
}

function _doCheck() {

    if [ -z "$PS1" ]; then
       echo "This script should be sourced."
       exit
    fi


    echo "This script will:"

    RESULT=$(which pipx)
    if [[ -z "$RESULT" ]]; then
        echo "□ Install basic programs: $PROGRAMS"
        echo "□ Install trash-cli with pipx and setup symlinks."
    fi
    echo "□ Copy configuration files to \$HOME directory."
    echo "□ Copy vimrc to /root directory."
    echo "□ Copy neofetch/config.conf to \$HOME/.config/neofetch."
    echo "□ Copy ranger conf files to \$HOME/.config/ranger."
    read -p "Do you want to continue? (Y/n): " CHOICE

    ###
      # read -p "Setup and copy configuration files to \$HOME folder, .vimrc to /root folder, and neofetch/config.conf to \$HOME/.config/neofetch? (Y/n): " CHOICE

    case "$CHOICE" in

      n|N )
          echo "Canceled."
          CONT=false
          ;;
      y|Y|* )
          read -rp "This can't be undone. Press any key to confirm. "
          CONT=true
            # -r : fixing backslashes
            # -p : prompt
            # https://www.shellcheck.net/wiki/SC2162
          ;;
    esac
}


#------------------------------------------


_doCheck

if $CONT; then
    _doStart
fi



#------------------------------------------
