#!/usr/bin/bash

# /usr/bin/env bash
# /bin/env bash
# /usr/bin/bash
# /bin/bash

# // 2024-03-10 Sun 20:42
# // 2025-06-30 Mon 22:55
  # Fix mistake paste left unremoved;
  # Fix pipx not working again;

# This copies config files in home and other directories:
  # 1) Copies config files to $HOME
  # 2) Copies .vimrc to /root
  # 3) copies neofetch/config.conf to $HOME/.config/neofetch/


#ᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳ

declare CONT=false
  # continue operation or not:

# declare PROGRAMS="bat screen ranger neofetch fzf fd-find htop python3-full zoxide pipx moreutils ufw rsyslog fail2ban nginx-full inxi"
declare PROGRAMS="bat ripgrep ncdu screen ranger neofetch \
    fzf fd-find htop python3-full zoxide python3-pip moreutils \
    ufw rsyslog fail2ban nginx-full inxi"

declare PROGRAMS_POSTFIX="mailutils postfix sasl2-bin \
    libgsasl18 libsasl2-dev libsasl2-modules"


# Can also do an array:
# declare -a PROGRAMS=(
#     bat ripgrep ncdu screen ranger
#     neofetch fzf fd-find htop
#     python3-full zoxide python3-pip
#     moreutils ufw rsyslog
#     fail2ban nginx-full inxi
# )
# echo "${PROGRAMS[*]}"
# Note: The delimiter is controlled by IFS (default: space). Change it temporarily if needed:
  # Pass as single string;
# IFS=','; echo "${PROGRAMS[*]}"; unset IFS  # Output: "bat,ripgrep,ncdu"
# sudo apt install "${PROGRAMS[@]}"  # Correctly passes each element as an argument
  # Pass individually

#ᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳᅳ

function install_programs_postfix() {

    local RESULT
    # RESULT=$(which pipx)
    RESULT=$(whereis postfix)
    # Can't use which, hash or command -v here because postfix
    # is not a command but a program!

    if [[ "$RESULT" == "postfix:" ]]; then

        read -rp "Do you want to install Postfix? (y/N): " CHOICE
        # Why -r? https://www.shellcheck.net/wiki/SC2162
        case "$CHOICE" in

          y|Y )
              sudo apt install $PROGRAMS_POSTFIX -y
              echo "Done."
              ;;
          n|N|* )
              ;;
        esac
    fi

}

function install_programs_basic() {

    # See if programs were already installed
    # local RESULT
    # RESULT=$(which pipx)
    # RESULT=$(command -v pipx)
      # Rather than 'which' command, lsp reommends:
      # command -v pipx
      # hash pipx
      # has doesn't necessarily seem to work??!
    # RESULT=''
      # Problem if adding new programs to the list; so maybe just reinstall everything; won't reinstall if already installed;

    # List of programs to install:
      # Install moreutils to get the vidir program;

    # if [[ -z "$RESULT" ]]; then


    #-------------------------------------------------------
    ## Install basic programs

    echo "Installing basic applications..."
    sudo apt install $PROGRAMS -y
      #--dr-run
      # Don't use double-quotes around $PROGRAMS; we want each string to be separate; not 1 long word;


    #-------------------------------------------------------
    ## Install pipx

    # Install pipx with pip:
    pip install pipx --break-system-packages
      # Until .bashrc is sourced or new bash is started, there is no path yet; have to use full path;
      # // 2025-06-30 : This installed pipx into ~/.local/bin/pipx, and created a symlink
       # from /usr/local/bin/pipx to ~/.local/bin/pipx
    # sudo pip install pipx --prefix=/opt --break-system-packages
      # If want to install pipx inside /opt folder; this was an attempt
       # to fix the problem; but still didn't work;

    ~/.local/bin/pipx ensurepath
      # sets the path

    echo "Done."



    #-------------------------------------------------------
    ## Install trash-cli

    # // 2025-06-30 Mon 19:41
    # Once again, something changed with pipx so that my prior setup fails!!
    # Now there's permission problems! So have to do this:
    sudo chmod 777 /opt
    sudo chmod 777 /usr/local/bin

    # Install trash-cli through pipx
    echo "Pipx installing trash-cli to /opt/pipx-install and creating symlink to /usr/local/bin..."
    # sudo PIPX_HOME=/opt/pipx-install PIPX_BIN_DIR=/usr/local/bin ~/.local/bin/pipx install trash-cli --force
      # This installs the trash-cli binaries into PIPX_HOME folder; and creates a symlink to PIPX_HOME in PIPX_BIN_DIR
    # sudo env PIPX_HOME=/opt/pipx-install PIPX_BIN_DIR=/usr/local/bin pipx install trash-cli
    PIPX_HOME=/opt/pipx-install PIPX_BIN_DIR=/usr/local/bin ~/.local/bin/pipx install trash-cli --force
      # Same as prior, but without sudo; if use sudo, seems the call to pipx fails for whatever reason;


    # Then make additional symlink from /opt/pipx to /root/.local/pipx
    # The reason for this is to enable "sudo pipx..." cp,,amd; otherwise, doesn't work;
    # echo "Making symlink from /opt/pipx to /root/.local/pipx..."
    # sudo mkdir /root/.local
    # sudo rm /root/.local/pipx
      # in case there's a pipx file there already
    # sudo ln -s ~/.local/bin/pipx /root/.local/bin/pipx
      # This not working anymore??

    echo "Making symlink from ~/.local/bin/pipx to /usr/local/bin/pipx..."
    sudo ln -s ~/.local/bin/pipx /usr/local/bin/pipx
      # could put it in /usr/local/bin, or /usr/bin; local/bin is less crowded;

    # echo "Making symlink from /opt/pipx-install/pipx to /usr/bin/pipx..."
    # sudo ln -s ~/.local/bin/pipx /usr/bin/pipx
      # Have to put here now?!!
      # Now should be able to call, "$ sudo pipx..."


    # set the permissions back to original:
    sudo chmod 755 /opt
    sudo chmod 755 /usr/local/bin

    # This is a less than ideal and very messy solution!!

    # This --global thing doesn't work! sudo still can't use it!
    # Going back to the old way of creating links manually;
    # pipx install trash-cli with --global flag;
    # The flag must be in this specific order; Without sudo;
    #echo "Pipx installing trash-cli..."
    #~/.local/bin/pipx --global install trash-cli

    echo "Done."

    # fi
}

function copy_to_home() {
    # Copy hidden filds to home
    cp home_dir/.* ~/
}

function copy_to_root() {
    # Copy the .vimrc file to /root
    sudo cp home_dir/.vimrc /root/
}

function copy_to_neofetch() {
    # if not exist, then create neofetch folder;
    # Then copy the neofetch config.conf file
    mkdir -p ~/.config/neofetch
      # This command won't overwrite or delete if the folder already exists;
    cp home_dir/neofetch/* ~/.config/neofetch
}

function copy_to_ranger() {
    mkdir -p ~/.config/ranger
      # This command won't overwrite or delete if the folder already exists;
    cp home_dir/ranger/* ~/.config/ranger

    # delete existing, if any; clone devicons
    rm -rf ~/.config/ranger/plugins
    git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons

}


function doStart() {

    echo "Ctrl-c to Cancel."
    echo -n "Doing copy in 3 seconds... "

    for (( n=1; n < 4; n++ )); do
        echo -n "$n "
        sleep 1
    done

    echo
    echo "Start..."

    # sleep 1

    install_programs_basic
    install_programs_postfix


    echo "Making config copies..."
    copy_to_home
    copy_to_root
    copy_to_neofetch
    copy_to_ranger

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

function doCheck() {

    if [ -z "$PS1" ]; then
       echo "This script should be sourced."
       exit
    fi


    echo "This script will:"

    # To keep it simple, just going to issue command to install all programs; if already installed, then apt should skip it;
    echo "∘ Install basic programs: $PROGRAMS"
    echo "∘ Install trash-cli with pipx and setup symlinks."
    echo "∘ Copy configuration files to \$HOME directory."
    echo "∘ Copy vimrc to /root directory."
    echo "∘ Copy neofetch/config.conf to \$HOME/.config/neofetch."
    echo "∘ Copy ranger conf files to \$HOME/.config/ranger."
    echo "∘ You will also be prompted later about installing Postfix."
    read -p "Do you want to continue? (Y/n): " CHOICE

    case "$CHOICE" in

      n|N )
          echo "Canceled."
          CONT=false
          ;;
      y|Y|* )
          read -rp "Press any key to confirm. "
          CONT=true
            # -r : fixing backslashes
            # -p : prompt
            # https://www.shellcheck.net/wiki/SC2162
          ;;
    esac
}


#------------------------------------------


doCheck

if $CONT; then
    doStart
fi


#------------------------------------------
