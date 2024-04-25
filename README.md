### serv_config

----------------------------------------------

## Server config files

$ git clone https://github.com/hug5/serv_config.git  
$ cd serv_config

### Run script to copy files:

Automation script will:  
▫ Install basic programs.  
▫ Pipx install trash-cli and setup symlinks.  
▫ Copy configuration files to \$HOME directory.  
▫ Copy vimrc to /root directory.  
▫ Copy neofetch/config.conf to \$HOME/.config/neofetch.  


$ ./run_serv_config.sh

----------------------------------------------

### File Contents:

Files copied to your home directory:
```
.vimrc  
.gitconfig  
.bash_hs  
.bash_aliases  
```
Files copied to your /root directory:
```
.vimrc  
```

.../<git_project>
    
Manually copy as needed:
```
.config
```
