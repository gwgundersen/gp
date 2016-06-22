#!/usr/bin/env bash

if [ -z $2 ]; then
    regex=$1
else
    regex=$2
fi
local_exclude="./.gp_exclude"
global_exclude="$HOME/.gp_exclude_global"
file_excludes=()
dir_excludes=()
horizontal_line=""

if [ ! "$regex" ]; then
    echo "gp: Regular expression required"
    exit
fi

build_excludes()
{
    filename=$1
    if [ -e $filename ]; then
        while read -r line
        do
            if [ "${line:0:1}" == "#" ]; then
                continue
            elif [ -z "$line" ]; then
                continue
            elif [ "${line: -1}" == "/" ]; then
                dir_excludes+=(${line%/})
            else
                file_excludes+=($line)
            fi
        done < $filename
    fi
}

build_excludes $local_exclude
build_excludes $global_exclude

build_horizontal_line()
{
    lines=$(tput cols)
    for i in `seq 1 $lines`; do
        horizontal_line+="="
    done
}

if [ -z $2 ]; then
    build_horizontal_line
    echo $horizontal_line
    grep -ir --color ${dir_excludes[@]/#/--exclude-dir=} ${file_excludes[@]/#/--exclude=} $regex .
elif [ $1 == "--echo" ]; then
    echo grep -ir --color ${dir_excludes[@]/#/--exclude-dir=} ${file_excludes[@]/#/--exclude=} $regex .
elif [ $1 == "--raw" ]; then
    build_horizontal_line
    echo $horizontal_line
    grep --color ${dir_excludes[@]/#/--exclude-dir=} ${file_excludes[@]/#/--exclude=} "${@:2}"
else
    echo "gp: Incorrect arguments"
fi

