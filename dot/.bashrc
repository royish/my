# .bashrc
export HISTCONTROL=ignoredups

# aliases
alias .ba='g $HOME/.bashrc'
alias .gv='g $HOME/.gvimrc'
alias cmd='g $HOME/my/docs/commands.txt'
alias .mg='g $HOME/my/docs/magic.txt'
alias hgr='history | grep'
alias lsg='ls | grep'
alias lag='la | grep'
alias fgr='find . | /bin/grep'
#function fgr()
#{
#    find . -name "*$**"
#}
alias sgr='set | grep'
alias .bs='. $HOME/.bashrc'  
alias psg='ps aux | grep -vw grep | grep'
#alias psg='ps -eflw | grep'
alias tt='cd /tftpboot'
alias ssh='ssh -X'
alias ll='ls -l'
alias la='ls -lA'
alias s='cd ..'
alias rm='rm -i'
alias mv='mv -i'
alias gv='gview'
alias gin='gvim -c "set nomodified" -'
alias ic='sudo ifconfig'

alias G='sudo g'
alias gd='$DIFFPROG 2> /dev/null'
alias s="cd .."
alias ss="cd ../.."
alias sss="cd ../../.."
alias gvim='gvim 2> /dev/null'

alias jgrpe='jgrep'

## enable programmable completion features (you don't need to enable
## this, if it's already enabled in /etc/bash.bashrc and /etc/profile
## sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#fi
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f $HOME/my/scripts/my_bash_completion ]; then
    . $HOME/my/scripts/my_bash_completion
fi

if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# aliases

# exports
export EDITOR='gvim -f'
export DIFFPROG="gvim -df +0 -s $HOME/my/scripts/diftop.vim"
#export DIFFPROG='gvim -df +0 -geom +0+118 -s /home/shaulir/scripts/diftop.vim'
export CCACHE='/usr/local/bin/ccache'
#export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin:/home/shaulir/scripts
  #@@@:/usr/local/gvd/bin

#from root
# set PATH so it includes user's private bin if it exists
if [ -d $HOME/bin ] ; then
    PATH=$HOME/bin:/usr/local/sbin:"${PATH}"
fi

#do the same with MANPATH
if [ -d $HOME/man ]; then
    MANPATH=$HOME/man:"${MANPATH}"
fi
    
# If running interactively, then:
if [ "$PS1" ]; then

    # append to history
    shopt -s histappend

    # write history to disk on every prompt
    PROMPT_COMMAND='history -a'

    # smart 'less'
    eval `lesspipe`

    # color ls
    alias ls='ls --color=auto'

    # color grep
    alias grep='/bin/grep --color=auto'

    # color prompt
    . $HOME/.prompt
fi

alias cs='cscope -Rbq'
alias sc='cd $HOME/my/scripts'

# vim: ft=sh

# Allow X connections

ssh_client=($SSH_CLIENT)
export display_ip=${ssh_client[0]}
if [ -z "$DISPLAY" -a -n "$display_ip" ] ; then
  export DISPLAY="$display_ip:0"
fi

export HISTSIZE=100000
export HISTFILESIZE=500000

export PATH=/home/shaulir/repowrt:$PATH


export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/gopath
export PATH=$GOPATH:$GOPATH/bin:$PATH


export PATH=$PATH:/opt/tch/armeb-buildroot-linux-uclibcgnueabi/usr/bin


# GIT stuff
alias gis='git status '
alias gil='git status '
alias gia='git add '
alias gib='git branch '
alias gic='git commit'
alias gid='git difftool'
alias gio='git checkout '
alias gik='gitk --all&'
alias gix='gitx --all'

alias got='git '
alias get='git '

# Smart Home

export SMARTHOME_DIR=$HOME/work/smarthome
export ANDROID_HOME=$HOME/android-sdks
# For Release versions <= R3.5.B 
export ANDROID_NDK_ROOT=${SMARTHOME_DIR}/toolchain/android-ndk-r8e
export ANDROID_NDK_HOME=${SMARTHOME_DIR}/toolchain/android-ndk-r8e
# For Release versions > R3.5.B
export ANDROID_NDK_ROOT=${SMARTHOME_DIR}/toolchain/android-ndk
export ANDROID_NDK_HOME=${SMARTHOME_DIR}/toolchain/android-ndk
# Configura JAVA with the path where JAVA is installed (below is my configuration)
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
