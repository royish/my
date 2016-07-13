for fn in $@ ; do pngquant -ordered 255 $fn; done
for fn in `ls *-or8.png` ; do mogrify -depth 8 $fn; done
for fn in `ls *-or8.png` ; do pngcrush $fn `echo $fn | sed "s/-or8//"` && rm $fn; done
