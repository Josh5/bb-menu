#!/bin/sh
# title: System Info
# description: Displays detailed information about the system including kernel version, architecture, CPU model, and other useful diagnostics. This output can help users or developers understand what platform they are running on, and is particularly useful for debugging compatibility issues or logging hardware setups for embedded environments or handheld devices.

echo "Kernel:"
uname -a

echo
echo "CPU Info:"
grep 'model name' /proc/cpuinfo | uniq

press_any_key_to_exit
