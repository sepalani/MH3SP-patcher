#! /usr/bin/env bash
# This script is a derivative work based on Wiimmfi Patcher and WIT
# Copyright 2022 MH3SP Patcher Project
# SPDX-License-Identifier: GPL-2.0-or-later

export MH_PATCHER_NAME="MH3SP Patcher v2022-12"
export MH_PATCHER_HEADER="**  $MH_PATCHER_NAME  based on  **"

export PATCHER_NAME="Wiimmfi Patcher v7.5"
export DATE=2021-03-13
export COPYRIGHT="(c) wiimm (at) wiimm.de -- $DATE"
export PATCHER_HEADER="** $PATCHER_NAME - $DATE  **"

export DESTDIR="./mh3sp-images"
export WORKDIR="./patch-dir"
export LOGDIR="./_log"

export LC_ALL=C

export COL_ERROR="\033[41;37;1m"
export COL_HEAD="\033[44;37;1m"
export COL_INFO="\033[42;37;1m"
export COL0="\033[0m"

script="${0##*/}"

#
#------------------------------------------------------------------------------
# print title

function print_title
{
    local h1=${#MH_PATCHER_HEADER}
    local h2=${#PATCHER_HEADER}
    local title_length=$(($h1 > $h2 ? $h1 : $h2))
    local stars="************************************************"
    printf -v stars "${COL_HEAD}%.*s${COL0}" ${title_length} "$stars$stars"
    printf "\n${stars}\n"
    printf "${COL_HEAD}${MH_PATCHER_HEADER}${COL0}\n"
    printf "${COL_HEAD}${PATCHER_HEADER}${COL0}\n"
    printf "${stars}\n\n"
}

((PRINT_TITLE>0)) && print_title

#
#------------------------------------------------------------------------------
# system and bin path

#--- BASEDIR

if [[ ${BASH_SOURCE:0:1} == / ]]
then
    BASEDIR="${BASH_SOURCE%/*}"
    [[ $BASEDIR = "" ]] && BASEDIR=/
else
    BASEDIR="$PWD/$BASH_SOURCE"
    BASEDIR="${BASEDIR%/*}"
fi
export BASEDIR


#--- predefine BINDIR & PATH for Cygwin

export ORIGPATH="$PATH"
export BINDIR="$BASEDIR/cygwin"
[[ -d $BINDIR ]] && export PATH="$BINDIR:$ORIGPATH"


#--- find system

export SYSTEM="$( uname -s | tr '[A-Z]' '[a-z]' )"
export MACHINE="$( uname -m | tr '[A-Z]' '[a-z]' )"
export HOST

case "$SYSTEM-$MACHINE" in
    darwin-*)		HOST=mac ;;
    linux-x86_64)	HOST=linux64 ;;
    linux-*)		HOST=linux32 ;;
    cygwin*-x86_64)	HOST=cygwin64 ;;
    cygwin*)		HOST=cygwin32 ;;
    *)			HOST=- ;;
esac


#--- setup BINDIR and PATH

BINDIR="$BASEDIR/$HOST"
((VERBOSE>0)) && echo "BINDIR      = $BINDIR"
if [[ -d $BINDIR ]]
then
    chmod u+x "$BINDIR"/* 2>/dev/null || true
    export PATH="$BINDIR:$ORIGPATH"
fi

export WIT="$BINDIR/wit"

#
#------------------------------------------------------------------------------
# check existence of tools

needed_tools="awk bash chmod cp mkdir mv rm sed sort tr uname uniq which wit"

err=

for tool in $needed_tools
do
    if ! which $tool >/dev/null 2>&1
    then
    err+=" $tool"
    fi
done

if [[ $err != "" ]]
then
    printf "\n\033[31;1m!!! Missing tools:$err => abort!\033[0m\n\n" >&2
    printf "\033[36mPATH:\n   " >&2
    sed 's/:/\n   /g' <<< "$PATH" >&2
    printf "\033[0m\n" >&2
    exit 1
fi

printf '\e[0;30;47m HOST: %s \e[m\n' "$HOST"
