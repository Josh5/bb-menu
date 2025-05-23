#!/bin/sh
# title: System Info
# description: Prints OS and CPU details

echo "Kernel:"
uname -a

echo
echo "CPU Info:"
grep 'model name' /proc/cpuinfo | uniq

press_any_key_to_exit
