#!/bin/sh

PACKAGE=dnsmasq

pushd .

make package/$PACKAGE/{clean,prepare} V=s QUILT=1
cd build_dir/target-*/$PACKAGE-*
cd `find . | grep patches$`/..
quilt push -a
quilt series 



# quilt new 340-tch-publish-requested-options.patch



quilt edit src/rfc2131.c
quilt edit src/helper.c



quilt diff
quilt refresh


popd

make package/$PACKAGE/update V=s

make package/$PACKAGE/{clean,compile} package/index V=s




