#!/bin/sh
# title: Disk Usage
# description: Show usage of /tmp

echo
echo "🗃️ Disk usage of /tmp:"
du -sh /tmp 2>/dev/null
echo

press_any_key_to_exit
