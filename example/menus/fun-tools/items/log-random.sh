#!/bin/sh
# title: Log Random Numbers
# description: Append a random number to a file in /tmp

RAND=$(echo $RANDOM)
mkdir -p /tmp/bb-menu-demo
echo "🎲 $RAND" >>/tmp/bb-menu-demo/random.log
echo
echo "Appended $RAND to /tmp/bb-menu-demo/random.log"
echo

press_any_key_to_exit
