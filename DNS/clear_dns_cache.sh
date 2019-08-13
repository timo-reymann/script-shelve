#!/bin/bash

#
# Script for flushing dns cache on linux without restarting
#
sudo /etc/init.d/nscd restart
sudo nscd --invalidate=hosts
