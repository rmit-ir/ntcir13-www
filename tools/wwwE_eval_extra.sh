#!/bin/bash

SPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
QRELS=$SPATH/../results/wwwE.trec.qrels

gdeval.pl -k 20 -j 4 $QRELS $1 | tail -1 > /tmp/qq.20
gdeval.pl -k 10 -j 4 $QRELS $1 | tail -1 > /tmp/qq.10
gdeval.pl -k 5 -j 4 $QRELS $1 | tail -1 > /tmp/qq.5
echo -n "ERR_5                   all     "
awk -F, '{printf "%.4f\n", $4}' /tmp/qq.5
echo -n "ERR_10                  all     "
awk -F, '{printf "%.4f\n", $4}' /tmp/qq.10
echo -n "ERR_20                  all     "
awk -F, '{printf "%.4f\n", $4}' /tmp/qq.20
echo -n "NDCG_5                  all     "
awk -F, '{printf "%.4f\n", $3}' /tmp/qq.5
echo -n "NDCG_10                 all     "
awk -F, '{printf "%.4f\n", $3}' /tmp/qq.10
echo -n "NDCG_20                 all     "
awk -F, '{printf "%.4f\n", $3}' /tmp/qq.20
rbp_eval -d 100 -WH -p 0.8,0.9,0.95 $QRELS $1 | awk '{print "rbp_" $2, "               all    ", $8 $9}'

rm -f /tmp/qq.*
