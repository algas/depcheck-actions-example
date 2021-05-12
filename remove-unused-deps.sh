#!/usr/bin/env bash
FILE_PATH=$1
DIR=$(dirname $FILE_PATH)
DEPS=`printf ",.\\\\\"%s\\\\\"" $(npx depcheck "$DIR" --json --skip-missing | jq -r '.dependencies[]')` 
tmpfile=$(mktemp)
jq "del(.dependencies|.dummy$DEPS)" <"$FILE_PATH" >"$tmpfile"
cp "$tmpfile" $FILE_PATH
rm "$tmpfile"
