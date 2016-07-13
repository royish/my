
function do_jcmd()
{
    echo "jcmd $1 \"rt jrelay /dev/ttyS1 $2 $3\""
    jcmd $1 "rt jrelay /dev/ttyS1 $2 $3"
    if [ "$3" = "on" ] ; then
        sleep 40
	rt ping -f -c 100 madam5 || echo "FAILED PING"
    fi
    sleep 1
}

function madam1()
{
    echo "MADAM1 $1"
    do_jcmd madam1 ri1 $1
    do_jcmd madam1 ri4 $1
    do_jcmd madam1 ri5 $1
    do_jcmd madam1 rj1 $1
    do_jcmd madam1 rj4 $1
    do_jcmd madam1 rj5 $1
    do_jcmd madam1 rj6 $1
}

function madam2()
{
    echo "MADAM2 $1"
    do_jcmd madam2 ra1 $1
    do_jcmd madam2 ra2 $1
    do_jcmd madam2 ra3 $1
    do_jcmd madam2 ra7 $1
    do_jcmd madam2 ra8 $1
    do_jcmd madam2 rb1 $1
    do_jcmd madam2 rb3 $1
    do_jcmd madam2 rb7 $1
    do_jcmd madam2 rc4 $1
    do_jcmd madam2 rc6 $1
    do_jcmd madam2 rc7 $1
}

function madam4()
{
    echo "MADAM4 $1"
#do_jcmd madam4 ra4 $1
    do_jcmd madam4 rb4 $1
    do_jcmd madam4 rb6 $1
    do_jcmd madam4 rb7 $1
    do_jcmd madam4 rc2 $1
    do_jcmd madam4 rc5 $1
    do_jcmd madam4 rc6 $1
    do_jcmd madam4 rd1 $1
}

function madam5()
{
    echo "MADAM5 $1"
    do_jcmd madam5 ra1 $1
    do_jcmd madam5 ra5 $1
    do_jcmd madam5 ra7 $1
    do_jcmd madam5 rb4 $1
    do_jcmd madam5 rb5 $1
    do_jcmd madam5 rb6 $1
    do_jcmd madam5 rb7 $1
    do_jcmd madam5 rb8 $1
    do_jcmd madam5 rc1 $1
    do_jcmd madam5 rc3 $1
    do_jcmd madam5 rd1 $1
}

function madam6()
{
    echo "MADAM6 $1"
    do_jcmd madam6 ra2 $1
    do_jcmd madam6 ra5 $1
    do_jcmd madam6 rb2 $1
    do_jcmd madam6 rb3 $1
    do_jcmd madam6 rb8 $1
    do_jcmd madam6 rc2 $1
    do_jcmd madam6 rc5 $1
    do_jcmd madam6 rc8 $1
    do_jcmd madam6 rd1 $1
}


madam4 $1
madam6 $1
madam5 $1
madam1 $1
madam2 $1

