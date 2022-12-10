#! /usr/bin/env bash
# This script is a derivative work based on Wiimmfi Patcher and WIT
# Copyright 2022 MH3SP Patcher Project
# SPDX-License-Identifier: GPL-2.0-or-later

#----- setup

PRINT_TITLE=2
. ./bin/setup.sh

#----- for each source image

"$WIT" --allow-nkit filelist | tr -d '\r' | while read src
do
    [[ -f $src ]] || continue
    mkdir -p "$LOGDIR"
    chmod 777 "$LOGDIR" 2>/dev/null
    log="$LOGDIR/${src##*/}.txt"
    ana="$LOGDIR/${src##*/}.ana"

    (
    dest="$DESTDIR/${src##*/}"
    if [[ -a $dest ]]
    then
        printf '%b Already exists: %s %b\n' "$COL_ERROR" "$dest" "$COL0"
        exit 1
    fi

    res_file=
    res_file_type=
    "$WIT" analyze --bash "$src" -d "$ana" --var res_
    . "$ana"

    if [[ ! $res_file || ! $res_file_type || $res_file_type = OTHER ]]
    then
        printf '%b Not a Wii image: %s %b\n' "$COL_ERROR" "$src" "$COL0"
        exit 1
    fi

    if [[ $res_file_type =~ ^NK ]]
    then
        printf '%b NKIT images not supported: %s %b\n' "$COL_ERROR" "$src" "$COL0"
        exit 1
    fi

    if [[ $res_dol_avail = 0 ]]
    then
        printf '%b Invalid Wii image: %s %b\n' "$COL_ERROR" "$src" "$COL0"
        exit 1
    fi

    config_path="config/${res_id6}.xml"
    if [[ ! -f "$config_path" ]]
    then
        printf '%b Unsupported game: %s %b\n' "$COL_ERROR" "$res_id6" "$COL0"
        exit 1
    fi


    #--- patch image

    mkdir -p "$DESTDIR" 
    chmod 777 "$DESTDIR" 2>/dev/null

    rm -rf "$WORKDIR"
    "$WIT" extract -vv -1p "$src" --links --DEST="$WORKDIR" --psel data
    if [ $? -ne 0 ]
    then
        printf '%b Failed to extract game: %s %b\n' "$COL_ERROR" "$src" "$COL0"
        exit 1
    fi

    "$WIT" dolpatch "${WORKDIR}/sys/main.dol" xml="$config_path"
    if [ $? -ne 0 ]
    then
        printf '%b Failed to patch game: %s %b\n' "$COL_ERROR" "$src" "$COL0"
        exit 1
    fi

    src_name="${src##*/}"
    "$WIT" copy -vv --links "$WORKDIR" --DEST="$DESTDIR/${src_name%.*}.iso"
    if [ $? -ne 0 ]
    then
        printf '%b Failed to repack game: %s %b\n' "$COL_ERROR" "$src" "$COL0"
        exit 1
    fi

    ) 2>&1 | tee "$log"
done
