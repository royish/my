
u=upgrade_db
debug=""

print_for_bug()
{
	local desc=""
	local priority=""
	local comment=""
	local invested=""
	local is_debug=""

	bug=$1

	shift

	if [ "$1" = "debug" ]; then
	    is_debug=yes;
	    shift;
	fi

	if [ "$1" = "priority" ]; then
	    priority=$2;
	    shift;
	    shift;
	fi

	if [ "$1" = "desc" ]; then
	    desc=$2;
	    shift;
	    shift;
	fi
	
	if [ "$1" = "invested" ]; then
	    invested="$2";
	    shift;
	    shift;
	fi

	if [ "$1" = "comment" ]; then
	    comment=$2;
	    shift;
	    shift;
	fi


        [ -z "$desc" ] && desc=`echo select short_desc from bugs_rg.bugs where bug_id=$bug | mysql -h mysql -u upgr_db_read -pjnjnuh  | tail -n 1`

	l=`$u bugs_rg get_issue_work_stats -b $bug`

	[ -z "$invested" ] && invested=`echo $l | cut -d";" -f 6`
	d=`echo $l | cut -d";" -f 7`

	# Remaining 
	r0=`echo "$d" | cut -d"," -f 2`
	r1=`echo "$d" | cut -d"," -f 4`
	r2=`echo "$d" | cut -d"," -f 6`
	r3=`echo "$d" | cut -d"," -f 8`
	r4=`echo "$d" | cut -d"," -f 10`
	r5=`echo "$d" | cut -d"," -f 12`

	# Edur
	e0=`echo "$d" | cut -d"," -f 1`
	e1=`echo "$d" | cut -d"," -f 3`
	e2=`echo "$d" | cut -d"," -f 5`
	e3=`echo "$d" | cut -d"," -f 7`
	e4=`echo "$d" | cut -d"," -f 9`
	e5=`echo "$d" | cut -d"," -f 11`

        if [ -n "" ]; then
		echo $desc

		echo r0=$r0
		echo r1=$r1
		echo r2=$r2
		echo r3=$r3
		echo r4=$r4
		echo r5=$r5

		echo e0=$e0
		echo e1=$e1
		echo e2=$e2
		echo e3=$e3
		echo e4=$e4
		echo e5=$e5
	fi

	if [ -z "$priority" ]; then 
	    e=`echo $e1+$e2 | bc`
	    rem=`echo "$r1+$r2" | bc`
	elif [ "p1" == "$priority" ]; then 
	    e=$e1
	    rem=$r1
	elif [ "p2" == "$priority" ]; then 
	    e=$e2
	    rem=$r2
	else
	    echo "error. priority: $priority"
	    exit
	fi

	debug_str="priority=$priority e=$e rem=$rem"

	if [ "`echo $e | bc -l`" == "0" ]; then
	    percent_done="N/A";
	else
	    percent_done=`echo "100-((100*($rem))/($e))" | bc`;
	fi    
	[ -z "$is_debug" ] && debug_str=""

        echo B$bug,$desc,$rem,$percent_done,$invested,$comment$debug_str
}


