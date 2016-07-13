. /usr/local/bin/jtools_functions.sh
cdr build/pkg/build/disk_image/modfs_dir/lib/modules
ln -s ../../../../../../os/linux/vmlinux vmlinux
crash_analyze_k.pl < $1
