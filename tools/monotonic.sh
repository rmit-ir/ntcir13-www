#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NUMS=$DIR/nums
SPLIT=$DIR/split
SPLIT2=$DIR/split2
TMPRUN=$DIR/tmp.run
OUT=$DIR/pruned.run
INF=$1

if [ ! ${1:0:1} = "/" ]; then
    INF="$PWD/$1"
fi

awk '{print $1}' $INF | sort | uniq > $NUMS

mkdir -p $SPLIT $SPLIT2
cd $SPLIT
awk '{print>$1}' $INF 
cd ..

for f in `cat $NUMS`;
do
    awk -v i=10000 '{$5=i--;print}' $SPLIT/$f >> $SPLIT2/$f 
done

for f in `cat $NUMS`;
do
    awk -v i=1 '{$4=i++;print}' $SPLIT2/$f >> $TMPRUN 
done

# If a second argument is supplied to the script, assume that we are preparing
# RMIT-R4 which requires specific cutoffs for some queries. Otherwise just trim
# all queries to depth 100.
if [ -n "$2" ]; then
    # 0002 0 clueweb12-0800tw-18-09266 25 9976 RMIT-FIELDSQEa
    # 0003 0 clueweb12-0603wb-40-03660 23 9978 RMIT-FIELDSQEa
    # 0004 0 clueweb12-1610wb-58-03477 48 9953 RMIT-FIELDSQEa
    # 0011 0 clueweb12-0800wb-75-13914 83 9918 RMIT-FIELDSQEa
    # 0040 0 clueweb12-0704wb-61-09779 58 9943 RMIT-FIELDSQEa
    # 0044 0 clueweb12-0202wb-53-17197 68 9933 RMIT-FIELDSQEa
    # 0049 0 clueweb12-0300tw-86-16714 32 9969 RMIT-FIELDSQEa
    # 0052 0 clueweb12-0601wb-05-14135 72 9929 RMIT-FIELDSQEa
    # 0054 0 clueweb12-0112wb-59-19743 89 9912 RMIT-FIELDSQEa
    # 0058 0 clueweb12-0211wb-00-29977 78 9923 RMIT-FIELDSQEa
    # 0082 0 clueweb12-1315wb-52-01285 92 9909 RMIT-FIELDSQEa
    # 0092 0 clueweb12-1006wb-82-12882 30 9971 RMIT-FIELDSQEa
    # 0094 0 clueweb12-1705wb-22-20480 96 9905 RMIT-FIELDSQEa
    # 0100 0 clueweb12-1909wb-10-10532 24 9978 RMIT-FIELDSQEa
    awk '{
         if ($1 == "0002") {if($4 <= 25) { print $0 }}
    else if ($1 == "0003") {if($4 <= 23) { print $0 }}
    else if ($1 == "0004") {if($4 <= 48) { print $0 }}
    else if ($1 == "0011") {if($4 <= 83) { print $0 }}
    else if ($1 == "0040") {if($4 <= 58) { print $0 }}
    else if ($1 == "0044") {if($4 <= 68) { print $0 }}
    else if ($1 == "0049") {if($4 <= 32) { print $0 }}
    else if ($1 == "0052") {if($4 <= 72) { print $0 }}
    else if ($1 == "0054") {if($4 <= 89) { print $0 }}
    else if ($1 == "0058") {if($4 <= 78) { print $0 }}
    else if ($1 == "0082") {if($4 <= 92) { print $0 }}
    else if ($1 == "0092") {if($4 <= 30) { print $0 }}
    else if ($1 == "0094") {if($4 <= 96) { print $0 }}
    else if ($1 == "0100") {if($4 <= 24) { print $0 }}
    else if ($4 < 101) { print $0 }
    }' $TMPRUN > $OUT
else
    awk '{if ($4 < 101) print $0}' $TMPRUN > $OUT
fi

rm -fr $SPLIT $SPLIT2 $NUMS $TMPRUN
