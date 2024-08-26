# kernel-clearos 4.19.94
Kernel version with ClearOS changes applied

The install-pkg.sh script for installing the necessary packages for building the kernel.

The buildkernel.sh script is designed to perform kernel assembly.

Based on the src file from centos.org: https://buildlogs.centos.org/c7-kernels.x86_64/kernel/20190218180909/4.14.94-200.el7.x86_64/kernel-4.14.94-200.el7.src.rpm

# Changes:

IMQ patch applied: https://github.com/imq/linuximq

Enabling CONFIG_IGBVF. This is a support module for Intel(R) 82576 Virtual Function Ethernet network cards.

