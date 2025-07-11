#------------------------------------------------------------------
### Bashrc
#------------------------------------------------------------------

  # if [ -f ~/.bash_aliases ]; then
  #     . ~/.bash_aliases
  # fi


  HISTCONTROL=ignoreboth:erasedups
  HISTSIZE=99999
  HISTFILESIZE=999999

  shopt -s histappend
  shopt -s checkwinsize
  shopt -s autocd direxpand dirspell cdspell

  bind 'set completion-ignore-case on'
  bind 'set match-hidden-files off'


  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      #alias dir='dir --color=auto'
      #alias vdir='vdir --color=auto'

      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
  fi


  export EDITOR=/usr/bin/vim.basic
  export SUDO_EDITOR=/usr/bin/vim.basic

  alias sbrc='source ~/.bashrc'
    # source .bashrc shortcut

  alias hs='. ~/.bash_hs'
  alias vif='~/.bash_vif'
  alias svif='sudo ~/.bash_vif'

  alias fgo='. ~/.bash_fgo'
  alias fgod=fgo
  alias fgof='. ~/.bash_fgo -f'

  alias bat='batcat'
  export BAT_THEME=zenburn

  alias ranger=". ranger"
  export RANGER_LOAD_DEFAULT_RC=FALSE
  export RANGER_DEVICONS_SEPARATOR='  '

  eval "$(zoxide init bash)"
    # Enable zoxide in bash

#------------------------------------------------------------------
### ls aliases
#------------------------------------------------------------------

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
  alias sll='sudo ls -alFh'
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

  alias lll='ll | grep ^l'       # begnning with l, all links;

#------------------------------------------------------------------
### Navigation + CD Shortcuts
#------------------------------------------------------------------


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



#------------------------------------------------------------------
### Trash-cli
#------------------------------------------------------------------


  # sep_graph='•  •  •  •  •  •  •  •'
  sep_graph='—————————————————————————'

  alias trasher='sudo trash-empty -f && trash-empty -f && echo trash-empty sudo+$USER. Okay.'
  alias trashe='trash-empty -f && echo trash-empty $USER. Okay.'

  alias trashlr='echo sudo trash-list: && sudo trash-list && echo $sep_graph && echo $USER trash-list: && trash-list && echo $sep_graph'
  alias trashl='echo $USER trash-list: && trash-list && echo $sep_graph'

  alias rm='trash-put'
  alias srm="sudo trash-put"

#------------------------------------------------------------------
### System command flag modifications
#------------------------------------------------------------------


  alias rmm='\rm -vi'      # bypass alias; interactive every delete;
  alias rmmm='\rm -vI'     # bypass alias; interactive once;
  alias rmdir='rmdir -v'
  alias cp='cp -v'
  alias mv='mv -vi'
  alias smv="sudo mv -vi"
  alias ln='ln -v'
  alias mkdir='mkdir -vp'
  alias chmod='chmod -v --preserve-root'
  alias chown='chown -v --preserve-root'


#------------------------------------------------------------------
### Disk Info
#------------------------------------------------------------------



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

#------------------------------------------------------------------
### Python virtual environment activate/deactivate
#------------------------------------------------------------------

  # python alias to start virtual environment
  alias vactivate=". ./.venv/bin/activate"
  alias vact=vactivate
  alias dact=deactivate
  alias dactivate=deactivate


#------------------------------------------------------------------
### Search aliases
#------------------------------------------------------------------

  # alias cgo='cd "$(dirname "$(fd | fzf)")"'
  # alias cgod='cd "$(fd -t d | fzf)"'
  alias fd='fdfind --hidden --exclude .git'



#------------------------------------------------------------------
### Ranger
#------------------------------------------------------------------

  # start ranger as a source so that when exit
  # ranger, it will exit in the selected directory;
  alias ranger=". ranger"


#------------------------------------------------------------------
### Git
#------------------------------------------------------------------


  alias gs="git status"
  alias gss="git status --short"

  alias gv="git add --all && git status && echo '-- all files staged --'"
    # Also add gaa="add --all" alias in .bash_options;
    # so can do either g aa, or gaa
    #aa = add --all
    # aa = !git add --all && git status && echo '-- all files staged --'

  alias gcm="git commit --message"
    # commit + message + <message>

  alias gcmm="git commit -m wip"
    # commit with default 'wip';
    # $ git commit --allow-empty-message -m ''
      # Can also commit without message;
      # For reference here;

  alias gca="git commit --amend --no-edit"
    # commit + amend

  alias gcam="git commit --amend --message"
    # commit + amend + <message>

  alias gcvm="git commit -am"
    # commit + auto stage all + message + <message>

  alias gcva="git add --all && git commit --amend --no-edit"
    # Combine gA + gca; add all + commit amend, no edit;
    # aaca = !git add --all && git commit --amend --no-edit

  alias gcvmm="git add --all && git commit -am wip"
    # stage all + commit + message 'wip'
    # The ! denotes, run the command through the shell;
    # Do not run via normal git;
    #aacmm = !git add --all && git commit -am wip


  # Note: doing --pretty seems to put it on one line;

  # @ gl1 : log, simple colorless one line
  alias gl1="git log --oneline"
    # Will use this to print the original plain version without color
    # Will never use this!

  # Variable N
  N=10  # Number of lines to list;

  # @ gl : git log N lines
  alias gl="git --no-pager log -n ${N} --pretty=\"%C(blue)%h  %C(yellow)%as %C(brightGreen)(%cr)%x09 %C(white)%an %C(magenta)%s%C(red)%d\" && echo '[git log -n ${N}]'"

  alias glr="git --no-pager log -n ${N} --pretty=\"%C(blue)%h  %C(yellow)%as %C(brightGreen)(%cr)%x09 %C(white)%an %C(magenta)%s%C(red)%d\" --reverse && echo '[git log reverse -n ${N}]'"

  alias gll="git log --pretty=\"%C(blue)%h  %C(yellow)%as %C(yellow)%as %C(brightGreen)(%cr)%x09 %C(white)%an %C(magenta)%s%C(red)%d\""
    # List all from this branch; no line limit;

  alias gllr="git log --pretty=\"%C(blue)%h  %C(yellow)%as %C(brightGreen)(%cr)%x09 %C(white)%an %C(magenta)%s%C(red)%d\" --reverse"
    # List all from this branch, reverse; no line limit;

  alias gla="git log --pretty=\"%C(blue)%h  %C(yellow)%as %C(brightGreen)(%cr)%x09 %C(white)%an %C(magenta)%s%C(red)%d\" --all"
    # --all : list all logs from all branches; no line limit;
    # --all : Pretend as if all the refs in refs/, along with HEAD, are listed on the command line as <commit>;

  alias gldg="git log --pretty=\"%C(blue)%h  %C(yellow)%as %C(brightGreen)(%cr)%x09 %C(white)%an %C(magenta)%s%C(red)%d\" --decorate --graph"
    # git log with graph + decoration; but --decorate doesn't seem to do anything becuase probably over-decorated with --pretty, %d, and the rest of it;


  alias gldga="git log --pretty=\"%C(blue)%h  %C(yellow)%as %C(brightGreen)(%cr)%x09 %C(white)%an %C(magenta)%s%C(red)%d\" --decorate --graph --all"
    # git log (all branches) with graph + decoration; but --decorate doesn't seem to do anything??

  alias glm="git log master --pretty=\"%C(blue)%h  %C(yellow)%as %C(brightGreen)(%cr)%x09 %C(white)%an %C(magenta)%s%C(red)%d\""
    # Show logs from the POV of master HEAD; useful when you're in a prior branch;

  alias gb="git branch -v"
    # list branches

  alias gba="git branch -av"
    # list all branches, including remote;

  alias gbs="git branch -v --sort=-committerdate"
    # like gba + sort, newest first;
    # Sort :
      # -committerdate -- sorts newest first;
      # committerdate  -- sorts newest last;

  alias gbsa="git branch -av --sort=-committerdate"
    # like gbs + all branches, including remote;

  alias gch="git checkout"

  alias gst="git stash"

  alias gstl="git stash list"
    # stash list
  alias gstpu="git stash push"
    # stash stage & unstaged
  alias gstpum="git stash push -m"
    # stash with name/message <message>
  alias gstapply="git stash apply"
  alias gstpop="git stash pop"
  alias gstdrop="git stash drop"
  alias gstclear="git stash clear"
    # remove all stash

  #alias gcfl="git config --list"
    # all config settings
  #alias gcfa="git config --get-regexp ^alias"
    # config alias settings

  alias gpush="git push"
    # Not sure if just 'p' is a good idea?
  alias gpushf="git push --force"
  alias gpushfl="git push --force-with-lease"
    # Safer than --force;
    # Only pushes if remote hasn't changed since last fetch
    # If someone else pushed/commited, then push fails

  alias gpull="git pull"
  alias gpull1="git pull --depth 1 && echo 'git pull --depth 1'"
  alias gpull2="git pull --depth 2 && echo 'git pull --depth 2'"
  alias gpull3="git pull --depth 3 && echo 'git pull --depth 3'"
  alias gpull4="git pull --depth 4 && echo 'git pull --depth 4'"
  alias gpull5="git pull --depth 5 && echo 'git pull --depth 5'"

  source /usr/share/bash-completion/completions/git

#------------------------------------------------------------------
### Useful Remote Server Aliasses
#------------------------------------------------------------------

  function _mail-help() {
cat << EOF
$ mail-h
  # This help

## sendmail command:

$ sendmail -f <return_address> <to_recipient>
> To: alias<to_recipient>
> CC: alias<cc_email>
> BCC: alias<bcc_email>
> From: alias<sender_email>
> Subject: Subject Line
> This is the body of the message
> .

## mail/mailx command:

$ mailx <recipient_email> -r <return_address>
 # Include recipient directly;

$ mailx -r <return_address>
  # mail will ask for the recipient address

# ctrl-d to send mail and exit;
EOF
  }

  function _postfix-help() {
cat << EOF
$ postfix-h
  # This help
$ sudo postconf
  # postfix configuration

## Postfix aliases:

 prl: postfix reload
 prs: postfix restart
pchk: postfix check
  ps: systemctl status postfix
 ps@: systemctl status postfix@-


## Postfix hash commands:

$ sudo postmap -F hash:tls_server_sni_maps
  # Only this file should use this syntax
$ sudo postmap hash:smtpd_sender_login_maps
  # All other files use this syntax
$ postmap-hash
  # alias to hash ALL files + reload postfix


## sasl password commands:

$ sudo saslpasswd2 -c -u <domain> <username>
  # Create User
$ sudo saslpasswd2 -u <domain> <username>
  # Update password
$ sudo saslpasswd2 -d <username>@<domain>
  # Delete user; syntax is different from others!!
$ sudo sasldblistusers2
  # List users


## Mail queue aliases:

$ mailq: display the mail queue

# Various mail queue flush commands
mailq-f1: sudo postsuper -r ALL
mailq-f2: sudo postqueue -f
mailq-f3: sudo postfix flush
mailq-f4: mailq -q

# Delete mail queue
mailq-dd: mail delete ALL deferred
mailq-da: mail delete ALL
EOF
  }

  # Display help for keyboard shorts/aliases; use s-h;
  function _show_shell_help() {
cat << EOF
 s-h: This help

  sv: sudo vim

  ss: sudo systemctl [command] [service]
ssrl: sudo systemctl reload [service]
ssrs: sudo systemctl restart [service]
 sss: sudo systemctl status [service]

 tail-syslog: sudo tail -fn100 /var/log/syslog
tail-journal: sudo journalctl -f
   tail-mail: sudo tail -fn100 /var/log/mail.log

    tail-emp: sudo tail -fn100 /var/log/uwsgi/emperor.log
  tail-uwsgi: tail -fn100 etc/log/uwsgi.log  (local)
  tail-debug: tail -fn100 etc/log/debug.log  (local)

      j: jobs
 jkilla: kill all jobs
      f: fg
   f1-N: fg 1... fg N

    urs: uwsgi restart
    url: uwsgi touch file
     us: uwsgi status

    nrl: nginx reload
    nrs: nginx restart
     ns: nginx status
     nt: nginx test configuration

    frl: php8.2 reload
    frs: php8.2 restart
     fs: php8.2 status
EOF
  }

  # show this help
  alias s-h=_show_shell_help
  alias postfix-h=_postfix-help
  alias mail-h=_mail-help

  # sudoedit alias; should start vim in safe sudo mode;
  # alias sv="sudoedit"  # Don't like that it doesn't save until exit;
  alias sv="sudo vim"

  # systemctl aliases
  alias ss="sudo systemctl"
  alias ssrl="sudo systemctl reload"
  alias ssrs="sudo systemctl restart"
  alias sss="sudo systemctl status"

  alias tail-syslog="sudo tail -fn100 /var/log/syslog"
  alias tail-mail="sudo tail -fn100 /var/log/mail.log"
  alias tail-journal="sudo journalctl -f"
  alias tail-emp="sudo tail -fn100 /var/log/uwsgi/emperor.log"
  alias tail-uwsgi="tail -fn100 etc/log/uwsgi.log"
  alias tail-debug="tail -fn100 etc/log/debug.log"


  # Jobs aliases
  alias j="jobs -l"
  # alias jkill='kill $(jobs -p) &>/dev/null; f1 &>/dev/null; f2 &>/dev/null; f3 &>/dev/null; f4 &>/dev/null; f5 &>/dev/null; f6 &>/dev/null; f7 &>/dev/null; f8 &>/dev/null'
  alias jkilla='kill $(jobs -p); sleep 1; f1;f2;f3;f4;f5;f6;f7;f8'
    # This kills all active jobs
    # -p : list jobs and its process IDs
  alias f="fg"
  alias f1="fg 1"
  alias f2="fg 2"
  alias f3="fg 3"
  alias f4="fg 4"
  alias f5="fg 5"
  alias f6="fg 6"
  alias f7="fg 7"
  alias f8="fg 8"

  # uWSGI + nginx aliases
  alias urs="echo 'uWSGI restarting...' && sudo systemctl restart uwsgi-emperor && echo 'uWSGI restart done.' && sleep 1.5s && sudo systemctl status uwsgi-emperor"
  # Note: There is no "systemctl reload uwsgi-emperor"; have to restart;

  # Want to make the uswgi reload file independent of projects;
  # touching shouldn't reload all projects;
  # Then in vassals file, set:
  # touch-reload = /srv/http/ww2.inkonpages/reload-uwsgi
  # function uwsgi_reload() {
  #     local dir1
  #     local dir2
  #     local path1
  #     local path2
  #     dir1=$(echo "$(pwd)" | cut -f 2 -d '/')
  #     dir2=$(echo "$(pwd)" | cut -f 3 -d '/')
  #     if [[ $dir1 != "srv" || $dir2 != "http" ]]; then
  #         echo "Should run command in a project folder: /srv/http/project/"
  #     else
  #         echo 'touch-reload: Reload uwsgi-emperor server for this vassal.'
  #         path1=$(echo "$(pwd)" | cut -f 1,2,3,4 -d '/')
  #         # path2=${path1}'/reload-uwsgi'
  #         path2=${path1}'/uwsgi-reload'
  #         touch $path2
  #         echo '♛ uwsgi-emperor server reloaded.'
  #     fi
  # }
    # I don't think there's a need to check the full path; just check local folder;
    # If the file exists, then do it; if not, then error;

  function uwsgi_reload(){
      if [ -f ./uwsgi-reload ]; then
          echo 'Do touch-reload...'
          touch "uwsgi-reload"
          echo '♛ uwsgi-emperor reloaded.'
      else
        echo "uwsgi-reload not found."
      fi
  }

  function uwsgi_workers_reload(){
      if [ -f ./uwsgi-workers-reload ]; then
          echo 'Do touch-workers-reload...'
          touch "uwsgi-workers-reload"
          echo '♛ uwsgi-emperor workers reloaded.'
      else
        echo "uwsgi-workers-reload not found."
      fi
  }


  alias url=uwsgi_reload
    # Do: touch-reload
  alias uwrl=uwsgi_workers_reload
    # Do: touch-workers-reload

  # Rename the old command; keep for now;
  # alias url2="echo 'touch uWSGI reload file' && sudo touch /etc/uwsgi-emperor/reload && echo 'uWSGI reload touched.'"

  alias us='sudo systemctl status uwsgi-emperor'

  # nginx
  alias nrl="sudo systemctl reload nginx && echo 'nginx reloaded'"
  alias nrs="sudo systemctl restart nginx && echo 'nginx restarted'"
  alias ns="sudo systemctl status nginx"
  alias nt="sudo nginx -t"

  # php8.2-fpm
  alias frl="sudo systemctl reload php8.2-fpm && echo 'php8.2-fpm reloaded'"
  alias frs="sudo systemctl restart php8.2-fpm && echo 'php8.2-fpm restarted'"
  alias fs="sudo systemctl status php8.2-fpm"

  # postfix
  alias prl="sudo postfix reload"
  alias prs="sudo systemctl restart postfix"
  alias pchk="sudo postfix check"
  alias ps="sudo systemctl status postfix"
  alias ps@="sudo systemctl status postfix@-"

  alias postmap-hash="sudo postmap hash:recipient_canonical_maps sender_canonical_maps sender_dep_relay_maps smtpd_sender_login_maps smtp_sasl_passwd_maps virtual_alias_domains virtual_alias_maps && sudo postmap -F hash:tls_server_sni_maps && echo 'postmap hash done' && sudo postfix reload"

  # postfix mail queue commands:
  # mailq
    # View the mail queue

  alias mailq-f1="sudo postsuper -r ALL"
  alias mailq-f2="sudo postqueue -f"
  alias mailq-f3="sudo postfix flush"
  alias mailq-f4="mailq -q"
    # Requeue all messages or flush the queue

  alias mailq-dd="sudo postsuper -d ALL deferred"
    # Delete all deferred; Probably want to try this first

  alias mailq-da="sudo postsuper -d ALL"
    # Delete all
    # Do this if you really want to get rid of all queus; but danger is that it will remove all incoming as well;
