#!/bin/bash
set -e

DIR=$(dirname $(readlink $0))
DIR=$(cd $DIR && cd .. && pwd)

if [[ -z "$1" ]]
then
    echo "$(tput setaf 1)❌ Please specify the sript to execute $(tput sgr0)"
    exit 2
fi

script="$DIR/$1"

if [[ ! -f "$script" ]]
then
    echo "$(tput setaf 1)❌ Script ${1} not found$(tput sgr0)"
    exit 2
fi

echo -e "\n$(tput setaf 2)🏃 ${1}...\n$(tput sgr0)"

if [[ -x "$script" ]]
then
    $script ${@:2}
else
    source $script
fi

