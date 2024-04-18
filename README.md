### serv_config

-------------

## Server config files

$ git clone https://github.com/hug5/serv_config.git  
$ cd serv_config

### Run script to copy files:

Automation script will copy all files in serv_config/home_folder to your ~/ home folder and .vimrc to your /root folder.

$ ./run_home_copy.sh  

### Then source your .bashrc:

$ source ~/.bashrc

-------------

### File Contents:

Files copied to your home folder:
```
.vimrc  
.gitconfig  
.bash_hs  
.bash_aliases  
```
Files copied to your /root folder:
```
.vimrc  
```

.../<git_project>
    
Manually copy as needed:
```
.config
```
