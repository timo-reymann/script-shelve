#!/bin/bash

#
# Script for cleaning all unused images
#

docker rmi $(docker images -q)
