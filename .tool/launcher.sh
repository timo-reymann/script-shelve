#!/bin/bash
DIR=$(dirname $(readlink $0))
DIR=$(cd $DIR && cd .. && pwd)

if [ -z "$1" ]
then
    echo "Please specify the sript to execute!"
    exit 2
fi

source $DIR/$1
