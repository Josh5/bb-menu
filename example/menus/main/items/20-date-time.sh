#!/bin/sh
# title: Show Date & Time
# description: Display current date and time

echo
echo "📅 Current Date & Time:"
date
echo
echo "Wrote to /tmp/bb-menu-demo/last-run.log"
mkdir -p /tmp/bb-menu-demo
date >>/tmp/bb-menu-demo/last-run.log

press_any_key_to_exit
