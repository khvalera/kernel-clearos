#!/bin/bash

# The install-pkg.sh script for installing the necessary packages for building the kernel

yum install spectool rpmbuild git-core perl-devel perl-generators gcc hmaccalc bison flex elfutils-devel zlib-devel binutils-devel \
            newt-devel perl-ExtUtils-Embed xz-devel python-devel audit-libs-devel asciidoc xmlto numactl-devel pciutils-devel \
            ncurses-devel openssl-devel pesign rpm
