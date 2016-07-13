#!/bin/sh
for arg in "$@" ; do
  if [ $arg == "-r" ]; then
    REVERT="r"
  fi
  if [ ${arg:0:1} == "R" ]; then
    REV=$arg
  fi
  if [ ${arg:0:6} == "branch" ]; then
    BRANCH=$arg
  fi
  if [ $arg == "1" ]; then
    BRANCH=$arg
  fi
  if [ ${arg:0:1} == "B" ]; then
    bugs="$arg "
  fi
done

command="review diff -j "
title=`$command $REV | grep TITLE | sed -e "s/# TITLE: //"`
bugs+=`$command $REV | grep "# BUGS: " | sed -e "s/# BUGS: //"`

if [ $REVERT ]; then
  script=$REV\_revert.sh
  arg+="-r "
else
  script=$REV.sh
fi

for arg in "$@" ; do
  if [ ${arg:0:1} != "R" ] && [ ${arg:0:1} != "B" ]; then
    args+="$arg "
  fi
done
args+="$REV"
command+=$args

clean_exit()
{
  printf "Exiting...\n"
  printf "For deleteion of modified files, copy this:\n"
  printf "=============\n"
  printf "rm -f \`cat $REV.list\`\n"
  printf "up \`cat $REV.list\`\n\n"
  exit -1
}

printf "$command > $script\n"
$command > $script
#review diff -j$REVERT $1 $2 $3 $4 > $1.sh
#review diff -r $1 $2 $3 $4 > $1.sh
chmod +x $script
#cat $script | grep cvs | cut -f 8 -d ' ' > $REV.list
cat $script | grep cvs | grep -v mkdir | cut -f 9 -d ' ' > $REV.list
printf "\n=============\n\n"
cat $script
printf "\n=============\n\n"
printf "Should I Patch? [y(es)/branch.../s(kip)/N(o)] "
read cont
case "$cont" in
  'y')
    printf "\n=============\n\n"
    ./$script
    ;&
  's')
    printf "\n=============\n\ncvs -qn up \`cat $REV.list\` > $REV.up\n"
    cvs -qn up `cat $REV.list` > $REV.up
    printf "cat $REV.up | grep ^[MRAC] | \
      cut -f 2 -d ' ' > $REV""_inserted.list\n"
    cat $REV.up | grep "^[MRAC]" | cut -f 2 -d " " > $REV\_inserted.list
    printf "cat $REV""_inserted.list\n\n"
    cat $REV\_inserted.list
    printf "\n=============\n\n"
    CONFLICT=`cvs -qn up \`cat $REV.list\` | grep "^C "`
    if [ -n "$CONFLICT" ]; then
      printf "you have conflicts, fix and come back...\n\n"
      review edit $REV &
      g $REV.up
      clean_exit
    fi
    printf "command for diff of diffs:\n"
    printf "rd $args\n\n"
    printf "Wanna see diff of diffs? [y(es) / s(kip) / N(o) ] "
    read cont
    case "$cont" in
      'y')
        printf "\n=============\n"
        rd $args
	;&
      's')
        printf "\n=============\n"
	printf "Which review to commit to? [NEW/n(o)/r (original review - $REV)] "
        read cont
	case "$cont" in
	  'y'|"")
	    COMMIT_REVIEW="new"
	    ;;
	  'r')
	    COMMIT_REVIEW=$REV
	    ;;
	  'n')
	    printf "Bad review!\n"
	    ;&
	  *)
	    clean_exit
	    ;;
	esac
        TAG=`cvs stat Makefile | grep Tag | sed -e 's/\t1/dev ()/' | \
          sed -e 's/(none)/dev ()/' | \
          sed -e 's/ *Sticky Tag:*\t[^b(]\(.*\) (.*/\1/'`
	if [ -z $BRANCH ]; then
	  BRANCH=`cat $script | grep COMMITS | head -n 1 | \
	    sed -e 's/.*COMMITS: \(.*\) #.*/\1/'`
	fi
	if [ $BRANCH == "1" ]; then
	  BRANCH="branch dev"
	fi
        if [ $REVERT ]; then
	  ACTION="Reverted $REV ($BRANCH) on"
        else
	  ACTION="Merged $REV ($BRANCH) to"
        fi
        msg="$bugs $ACTION $TAG ($title)"
        printf "\n=============\n"
        printf "command I'm going to commit with:\n"
        printf "rev ci -m \"$msg\" $COMMIT_REVIEW \`cat $REV""_inserted.list\`\n\n"
        printf "Copying this for review title to the clipboard:\n"
        printf "$bugs $ACTION $TAG ($title)\n\n"
        echo "$bugs $ACTION $TAG ($title)" | xclip
        printf "\n=============\n"
	printf "Should I Commit? [y(es)/N(o)] "
        read cont
        if [ $cont == "y" ]; then
          review ci -m "$msg" $COMMIT_REVIEW `cat $REV\_inserted.list`
          printf "\n=============\n"
        fi
	;;
      *)
	clean_exit
	;;
    esac
    ;;
  branch*)
    $0 $@ -b $cont
    ;;
  '1')
    $0 $@ -b 1
    ;;
  *)
    printf "not patching...\n"
    exit -1
    ;;
esac
