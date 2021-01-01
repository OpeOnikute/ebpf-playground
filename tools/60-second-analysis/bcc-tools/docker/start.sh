#!/bin/bash

# Configure the headers
echo "Configuring headers..."
cd /usr/src/$(uname -r)

make defconfig

# && make oldconfig \

# Create module symlinks

echo 'CONFIG_BPF=y' >> .config
echo 'CONFIG_BPF_SYSCALL=y' >> .config
echo 'CONFIG_BPF_JIT=y' >> .config
echo 'CONFIG_HAVE_EBPF_JIT=y' >> .config
echo 'CONFIG_BPF_EVENTS=y' >> .config
echo 'CONFIG_FTRACE_SYSCALLS=y' >> .config
echo 'CONFIG_KALLSYMS_ALL=y' >> .config

# prepare headers
echo "Preparing headers..."
make prepare

cat .config | grep CONFIG_KALLSYMS_ALL

cd /usr/share/bcc/tools
# ./profile 1

bash