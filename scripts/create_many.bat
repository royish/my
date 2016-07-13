i=0
mkdir /tmp/many_dir
while [ "$i" != 100 ]; do
let "i = i + 1"
mkdir /tmp/many_dir/a$i
j=0
while [ "$j" != 10001 ]; do
let "j = j + 1"
echo $i $j > /tmp/many_dir/a$i/a$j.jpg
done
done

