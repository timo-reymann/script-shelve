#!/bin/bash
DIR=$(dirname $0)
DIR=$(cd $DIR && cd .. && pwd)

if [ -z "$1" ]
then
    echo "Please specify the sript to execute!"
    exit 2
fi

if [[ -x "$file" ]]
then
    $DIR/$1
else
    source $DIR/$1
fi

