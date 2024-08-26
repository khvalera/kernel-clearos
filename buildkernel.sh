#!/bin/bash

mkdir -p ${HOME}/rpmbuild/{SPECS,SOURCES}
spectool -g -A -R ${HOME}/rpmbuild/SPECS/kernel.spec

if [ -e /tmp/kernelbuild.out ] ; then
	tail -5 /tmp/kernelbuild.out
	rm -f /tmp/kernelbuild.out
fi

date
( time ( rpmbuild -ba --clean ${HOME}/rpmbuild/SPECS/kernel.spec ) ) 2>&1 | tee /tmp/kernelbuild.out
date
