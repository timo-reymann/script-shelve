#!/usr/bin/env bash

dir=$(dirname $(readlink $(which script-shelve)))
dir=$(cd $dir && pwd)

_script-shelve_completion() {
    COMPREPLY=($(cd $dir && compgen -W "$(find . -type f  -not -path '*/\.*' -name "*.sh" | sed 's/.\///')" -- "${COMP_WORDS[1]}"))
}

complete -F _script-shelve_completion script-shelve
