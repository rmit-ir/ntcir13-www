#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NUMS=$DIR/nums
SPLIT=$DIR/split
INF=$1

if [ ! ${1:0:1} = "/" ]; then
    INF="$PWD/$1"
fi

awk '{print $1}' $INF | sort | uniq > $NUMS

mkdir -p $SPLIT
cd $SPLIT
awk '{print>$1}' $INF 
cd ..

for f in `cat $NUMS`;
do
    sort -k1n -k5rn $SPLIT/$f
done

rm -fr $SPLIT $NUMS
