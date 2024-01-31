###_____ Bashrc _______________________________________________________

  # if [ -f ~/.bash_aliases ]; then
  #     . ~/.bash_aliases
  # fi



  HISTCONTROL=ignoreboth:erasedups
  HISTSIZE=99999
  HISTFILESIZE=999999
  shopt -s histappend
  shopt -s checkwinsize

  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      #alias dir='dir --color=auto'
      #alias vdir='vdir --color=auto'

      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
  fi

  shopt -s autocd direxpand dirspell cdspell

  export EDITOR=/usr/bin/vim.basic

  alias hs='. ~/.bash_hs'

###_____ ls aliases ___________________________________________________


  ## Basic ls aliases

  # basic listing, but ignore AppImage, snap folders
  alias l='ls -CF -I AppImage -I snap'
    # -F : classify listings
    # -C : List by column
    # --group-directories-first : to group directories first;
    # -I, --ignore=PATTERN : do not list implied entries matching shell PATTERN
      # ignore certain folders: AppImage, snap


  # List long, all; include hidden files
  alias ll='ls -alFh'
  alias la='ls -AF'
    # -a : all (include hidden files)
    # -l : long listing format
    # -h : human readable number format
    # -A : list all, but exclude . and ..
    # --group-directories-first : to group directories first;


  ## Sorting aliases
  # Using Ranger keybindings
  
  # By default, sorting is alphabetial;

  # Sort alphabetical; alphabetical order;
  alias lln='echo Default is alphabetical. Do ll.'
  alias lan='echo Default is alphabetical. Do la.'
  # If attempt to do alphabetical, just remind that default is alphabetical;

  # reverse alphbetical; include -r switch
  alias llN='ls -alFhr'
  alias laN='ls -AFr'

  
  

  # Sort by modification time; -t switch
  alias llm='ls -alFht'
  alias lam='ls -AFt'
  # reverse modification time; include -r switch
  alias llM='ls -alFhtr'
  alias laM='ls -AFtr'

  # Sort by size; -S switch
  alias lls='ls -alFhS'
  alias las='ls -AFS'
  # reverse size; include -r switch
  alias llS='ls -alFhSr'
  alias laS='ls -AFSr'

  # Long; sort by extension; -X switch
  alias lle='ls -alFhX'
  alias lae='ls -AFX'
  # reverse extension; include -r switch
  alias llE='ls -alFhXr'
  alias laE='ls -AFXr'


  # sorting options:
  # Sort by time type:
    # modify time: default; -t
    # access time : -u
    # creation time : -c
  # sort none : -U
  # sort size : -S
  # sort version : -v
  # sort extension : -X
  # sort reverse : -r


  ## Specialized Listing Commands 

  # List hidden files only:
  # This command is intended to list just hidden files
  # However, when using .* or even * command, the ls command lists content
  # of subdirectories as well, which don't want; so include -d flag
  # in order to exclude directories;
  alias lh='ls -d .*'
    # -d: list directories only, not content; exclude inside dir listing;
    #--group-directories-first : to group directories first;
    # When .* is included (to show hidden files as well), for whatever reason, lists inside folders by default;
    # Another way is this; not sure which is better or what use cases:
    # $ ls -a | grep "^\."
    # This also includes directories; There are ways to check for directories as well using -p, etc;

  # List hidden only in long listing format:
  alias llh='ls -dlh .*'
    # -l : long listing format


  # List directories only; alphabetical:
  alias ld='ls -d */'
  alias lld='ls -lAF | grep "^d"'

  # List directories reverse
  alias lD='ls -dr */'
  alias llD='ls -lAFr | grep "^d"'

###_____ Navigation + CD Shortcuts ____________________________________


  # cd shortcuts
  #alias cd..='cd .. && ls -CF --group-directories-first'
  #alias ..='cd .. && ls -CF --group-directories-first'
  #alias ...='cd ../.. && ls -CF --group-directories-first'
  #alias ....='cd ../../.. && ls -CF --group-directories-first'
  #alias .....='cd ../../../.. && ls -CF --group-directories-first'
  #alias ......='cd ../../../../.. && ls -CF --group-directories-first'
  alias c='cd'
  alias c..='cd .. && l'
  alias cd..='cd .. && l'
  alias ..='cd .. && l'
  alias ...='cd ../.. && l'
  alias ....='cd ../../.. && l'
  alias .....='cd ../../../.. && l'
  alias ......='cd ../../../../.. && l'


  # alias shortcuts to go home, back
  alias home='cd ~ && echo cd ~'
  alias back='cd - && echo cd -'
  #alias h='~'
    # Not sure this is very useful; have to use $h if want to use as part of directory path

  # 'exit' alias; typing exit is too long
  alias qq='exit'

  # tmux kill session and exit terminal
  alias qqq='tmux kill-session'

  
  # For other custom aliases, see .bash_aliases

  alias rmdir='rmdir -v'
  alias cp='cp -v'
  alias mv='mv -vi'
  alias ln='ln -v'
  alias mkdir='mkdir -vp'
  alias chmod='chmod -v --preserve-root'
  alias chown='chown -v --preserve-root'

###_____ Disk Info ____________________________________________________



  # Note:
    # the 'd' suffix stands for 'disk'; so if I want disks only, excluding snaps/loops;
    # The 'l' suffix stands for 'long' format; more info;

  # Disk info alias, but exclude snaps, loops, tempfs, devtmpfs
  alias dfd='df -h --exclude-type=squashfs --exclude-type=tmpfs --exclude-type=devtmpfs --output=source,fstype,size,used,avail,pcent,target'
    # -h : human readable
    # -x, --exclude-type : this excludes the /dev/loop;snap file types
    #--output : this gives me columns I want;

  # alias lsblkd='lsblk -p | grep "/dev/sd.*"'
    # List block devices, excluding loops/snaps
    # But below is more efficient...
  alias lsblkd='lsblk -pe7 --output +LABEL'
    # -p : print full device paths
    # -e, --exclude list :
      # Exclude  the  devices  specified  by the comma-separated list of major device numbers.
      # 7 = loop/snap devices; excluding snaps
    # -o, --output : specify extra output columns
    # LABEL : added label for partition names;

  # This excludes nothing, but gives more info about everything
  alias lsblkl='lsblk -po +LABEL,fstype,fssize,fsused,fsuse%,UUID'
    # -f : info about filesystems; but moot if I denote my own -o output
    # -p : print full device paths
    # -o, --output : Specify which output columns to print.

  # This excludes loops/snaps, and gives more info about everything
  alias lsblkdl='lsblk -pe7 --output +LABEL,fstype,fssize,fsused,fsuse%,UUID'
    # -e, --exclude list :
      # Exclude  the  devices  specified  by the comma-separated list of major device numbers.
      # 7 = loop/snap devices; excluding snaps

  # This was the old way we excluded snaps/loops
  #alias lsblkld='lsblk -po +LABEL,UUID,fstype,fssize,fsused,fsuse% | grep "/dev/sd.*"'

###_____ Python virtual environment activate/deactivate _______________

  # python alias to start virtual environment
  alias vactivate=". ./.venv/bin/activate"
  alias veactivate=vactivate

###______ Search aliases ______________________________________________

  alias fdgo='cd "$(dirname "$(fd | fzf)")"'
  alias fdgod='cd "$(fd -t d | fzf)"'
  alias fd='fdfind --hidden'

###_____ Ranger _______________________________________________________

  # start ranger as a source so that when exit
  # ranger, it will exit in the selected directory;
  alias ranger=". ranger"


