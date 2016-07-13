# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export JPKG_AUTO_UPDATE_RND_TOOLS=1

# aliases
alias cs='cscope -Rbq'
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -a'
alias s='cd ..'
alias rm='rm -i'
alias mv='mv -i'
alias psg='ps -eflw | grep'
alias gv='gview'
alias gin='gvim -c "set nomodified" -'
alias ic='rt ifconfig'
alias vc='rt vconfig'
alias rut='rt route'
alias modprobe='rt modprobe'
alias rmmod='rt rmmod'
alias gw='rt route del default 2> /dev/null; rt route del default 2> /dev/null; rt route add default gw'
alias arp='rt arp'
alias bc='rt brctl'
alias pump='rt pump --no-dns'
alias pumpg='rt pump --no-dns --no-gateway'
alias tree='tree -I CVS'
alias h='history -c'
# winter
alias date='date; hdate -sh; ddate'
# summer
# alias date='date; hdate -shz 3; ddate'
alias rev='review edit'
alias revs='review data'
alias rst='reset; stty intr ^c'
alias clst=~/scripts/cvslastchange
alias cst='cvs stat'
alias clog='cvslog -N'
alias win='rdesktop -K -g 1016x600 -u radius osi'
alias puta='rdesktop -K -g 1016x600 -u administrator '
alias xt='xterm -geometry 98x40-0+224 -sb -rightbar -bg lightgrey -sl 20000 -si -sk &'
  # @@@ -xrm <sth with the font>
alias vg='valgrind --leak-check=full'
alias rice='rt nice --15'
alias fni='find . -xdev | crep -i '
alias musk='ssh eitan@eitan "DISPLAY=:0.0 amarok --next"'
alias mup='ssh eitan@eitan "DISPLAY=:0.0 amarok --play-pause"'

#alias st='snmpset -r 0 -Os -v 2c -c private 192.168.0.1'
#alias std='snmpset -r 0 -Os -v 2c -c private 192.168.100.1'
#alias str='snmpset -r 0 -Os -v 2c -c private 192.168.1.1'
#alias sw='snmpwalk -r 0 -Os -v 2c -c public 192.168.0.1'
#alias swd='snmpwalk -r 0 -Os -v 2c -c public 192.168.100.1'
#alias swr='snmpwalk -r 0 -Os -v 2c -c public 192.168.1.1'
#alias stbl='. stbl.sh'

#-alias kx='rt killall -9 xmms'
alias ks='killall ssh'

alias jgrep=jgr

alias dc=cd
alias ckae=cake
alias caek=cake
alias G='rt gvim'
alias ss="cd ../.."
alias sss="cd ../../.."
alias Cd="cd -P"
alias CD="cd -P"
alias Pwd="pwd -P"
alias PWD="pwd -P"

# dirs
alias pkg='cdr pkg'
alias cmn='cdr pkg/main'
alias inc='cdr pkg/include'
alias br='cdr pkg/bridge'
alias ucd='cdr pkg/ucd-snmp'
alias mib='cdr pkg/ucd-snmp/agent/mibgroup'
alias net='cdr os/linux-2.6/net'
alias lin='cdr os/linux-2.6/include/linux'
alias kos='cdr pkg/kos'
alias bld='cdr pkg/build'
alias utl='cdr pkg/util'
alias mgt='cdr pkg/mgt/lib'
alias mgd='cdr pkg/mgt/dev'
alias fw='cdr pkg/firewall'
alias fwk='cdr pkg/firewall/kernel'
alias alg='cdr pkg/firewall/kernel/alg'
alias fwc='cdr pkg/firewall/config'
alias fwp='cdr pkg/firewall/proxy'
alias fww='cdr pkg/firewall/wbm'
alias fwm='cdr pkg/firewall/main'
alias frs='cdr pkg/freeswan'
alias ips='cdr pkg/freeswan/klips/net/ipsec'
alias ipr='cdr pkg/iproute2'
alias qs='cdr pkg/qos'
alias qsm='cdr pkg/qos/main'
alias qsw='cdr pkg/qos/wbm'
alias qsg='cdr pkg/qos/mgt'
alias wbm='cdr pkg/web_mng/cgi'
alias wbl='cdr pkg/web_mng/lib'
alias int='cdr vendor/intel/ixp425'
alias doc='cdr pkg/doc/design'
alias cfg='cdr pkg/doc/configuration_guide'
alias lic='cdr pkg/license'
alias jpk='cdr pkg/jpkg'
alias vip='cdr pkg/voip'
alias av='cdr pkg/antivirus'
alias avl='cdr pkg/antivirus/lan'
alias avm='cdr pkg/antivirus/main'
alias avn='cdr pkg/antivirus/nac'
alias pav='cd ~/project/tools/rg/av'
alias bcm='cdr vendor/broadcom/bcm963xx'
alias ctr='. ctr.sh'
alias cbl='. cbl.sh'
alias ctl='. ctl.sh'
alias clx='. clx.sh'
alias gd='$DIFFPROGBG'

# files
#@@@alias gprj='gvim ~/project/rg/project/yoavp.txt +99999'
#@@@alias prj="co_diff_ci.sh ~/project/rg/project/yoavp.txt +99999"
alias hw="co_diff_ci.sh ~/project/db/hardware.csv +/yoavp"
alias book="co_diff_ci.sh ~/project/db/books.csv +/yoavp"
alias jbd='g ~/project/tools/jboard/boards.csv +/^\\\([^,]*,\\\)\\\{7\\\},'

# exports
export JPKG_AUTO_UPDATE_RND_TOOLS=1
export EDITOR='gvim -f'
export BROWSER=firefox
export DIFFPROG='gvim -df +0 -geom +0+118 -s /home/yoavp/scripts/diftop.vim'
export DIFFPROGBG='gvim -d +0 -geom +0+118 -s /home/yoavp/scripts/diftop.vim'
export CCACHE='/usr/local/bin/ccache'
export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin:/home/yoavp/scripts
  #@@@:/usr/local/gvd/bin
export PROJECT_PATH=~/project

# auto completion
#@@@. mib_names.sh
complete -W "stop start restart" jnetwork
alias bd=jboard
complete -W "connect disconnect status status-full power-reset list wan" jboard
complete -W "connect disconnect status status-full power-reset list wan" bd
complete -W "up grep purge lastchange" jcvs
complete -o filenames -F _command rt
complete -W "show addbr addif stp delbr delif" bc
complete -W "`\ls -d ~/rg.* | sed -e 's%.*/rg\.\([^/]*\).*%\1%'`" ctr
#complete -o filenames -F _make cake
#complete -W "config clean distclean CONFIG_RG_ DIST=UML run_tests BUILD=b LIC=~/rg.40/pkg/license/licenses/license.lic" cake make
. ~/scripts/make_completion

# gdb
#alias dmn='jgvd main_task 2> /dev/null &'
alias drg='jgvd openrg 2> /dev/null &'
alias dlx='jgvd vmlinux 2> /dev/null &'


# The following line was automatically added by Jungo tools installation
# process
. /etc/profile_jungo_tools
