#!/bin/bash

#
# Script for fixing freezed cinnamon
#
export DISPLAY=:0
cinnamon-screensaver-command -e
killall -9 cinnamon
cinnamon-screensaver </dev/null &>/dev/null &
