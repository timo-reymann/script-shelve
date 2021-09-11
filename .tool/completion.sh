#!/usr/bin/env bash

_script-shelve_completion() {
    dir=$(dirname $(readlink $(which script-shelve)))
    dir=$(cd $dir && pwd)
    COMPREPLY=($(cd $dir && cd .. && compgen -W "$(find . -type f  -not -path '*/\.*' | sed 's/.\///')" -- "${COMP_WORDS[1]}"))
}

complete -F _script-shelve_completion script-shelve
