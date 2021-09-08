#!/bin/bash

#
# This script kills all currently detached screens for the current user
#
screen -ls | grep Detached | cut -d. -f1 | awk '{print $1}' | xargs kill
