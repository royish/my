export PATH=$PATH:~/git/repowrt:~/scripts
. ~/git/repowrt/extras/repowrt_completion.sh
[ -z "$GVIM_PATH" ] && export GVIM_PATH=`which gvim 2>/dev/null`

#http://askubuntu.com/questions/10481/how-do-i-enable-or-disable-the-global-application-menu/133005#133005
export UBUNTU_MENUPROXY=

function jgrep()
{
    "grep" -H -R -n --color=auto "$@" *
}

set_func_opt()
{
    func_opt=("$@")
    func_opt_stdin=0
    func_opt_fg=0
    local i j

    # handle jumping to a specific line: g <filename>:<line>:<junk>
    # A quick hack for gvim_func_fg: it adds '-f' option, and it is used
    # in editor.sh...:
    j=0 # the position of the filename. if -f is used, then should be 1
    if [ ${#func_opt[@]} = 2 -a "${func_opt[0]}" = "-f" ] ; then
        j=1
    fi
    if [ ${#func_opt[@]} = $((j+1)) ] &&
        [ "${func_opt[j]/*:}" != "${func_opt[j]}" ]
    then
	local file=${func_opt[j]/:*} # extract <filename>
	local lineno=${func_opt[j]/$file:}; # extract <line>:<junk>
	local lineno=${lineno/:*}; # extract <line>
	func_opt=("$file" "+$lineno")
	if [ $j = 2 ] ; then
            func_opt=("-f" "${func_opt[@]}")
	fi
    fi

    # check if '-' option is given for stdin
    i=0
    while [ ! -z "${func_opt[i]}" ] ; do 
	if [ "${func_opt[i]}" = "-" ] ; then
            func_opt_stdin=1
	elif [ "${func_opt[i]}" = "-f" ] ; then
	    func_opt_fg=1
	fi
	i=$((i+1))
    done
}

gvim_func()
{
    # parse the options for gvim line jump
    set_func_opt "$@"
    # for Linux - run GVIM with no changes
    $GVIM_PATH "${func_opt[@]}"
}

g()
{
    gvim_func "$@"
}

if [ -n "$DESKTOP_SESSION" ];then 
    # No point to start gnome-keyring-daemon if ssh-agent is not up 
    if [ -n "$SSH_AGENT_PID" ];then 
        eval $(gnome-keyring-daemon --start) 
        export SSH_AUTH_SOCK
	export GPG_AGENT_INFO
        export GNOME_KEYRING_CONTROL
    fi
fi