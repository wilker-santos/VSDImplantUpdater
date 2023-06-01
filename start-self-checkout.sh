#!/bin/bash
export DISPLAY=:0.0
setsid /home/linx/self-checkout/start.sh >/dev/null 2>&1 &
exit
