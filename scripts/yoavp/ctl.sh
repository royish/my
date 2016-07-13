BASE=`ls -l | grep -v cloned | grep '\->' | head -1 | sed -e 's%.*-> \(.*/rg\.[^/]*\).*%\1%'`
if [ -z $BASE ]; then
  BASE=`pwd | sed -e 's%\(.*/rg\.[^/]*\).*%\1%'`
fi

DIR=`pwd | sed -e "s%.*rg\.[^/]*%%"`

if (( $# != 0 )); then
  SUFFIX="$1"
else
  SUFFIX=""
fi

cd $BASE$SUFFIX$DIR

