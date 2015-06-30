#!/bin/sh

# nofile
echo "*    soft    nofile   32768" >> /etc/security/limits.conf
echo "*    hard    nofile   32768" >> /etc/security/limits.conf

# nproc
sed -i -e 's/^\(\*.*\)/#\1\n\*\tsoft\tnproc\t63228\n\*\thard\tnproc\t63228/g' /etc/security/limits.d/90-nproc.conf

# sudo
echo "gennai    ALL=(ALL)    NOPASSWD: ALL" >> /etc/sudoers
