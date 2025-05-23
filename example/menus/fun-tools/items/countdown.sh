#!/bin/sh
# title: Countdown
# description: Countdown from 5 using echo and sleep

echo
for i in 5 4 3 2 1; do
    echo "$i..."
    sleep 1
done
echo "🚀 Blast off!"

press_any_key_to_exit
