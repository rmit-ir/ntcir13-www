#!/bin/bash

SPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
QRELS=$SPATH/../results/wwwE.qrels
EVALD=$SPATH/../results/reproduce/eval

mkdir -p $EVALD
cd $EVALD

cp $EVALD/../RMIT-R?.run .
cp $QRELS .
awk '{print $1}' RMIT-R1.run | sort -u > tid
NTCIRsplitqrels wwwE.qrels rel

awk '{f=$1 "/" $1 "." FILENAME ".res"; print $3>f}' RMIT-R1.run
awk '{f=$1 "/" $1 "." FILENAME ".res"; print $3>f}' RMIT-R2.run
awk '{f=$1 "/" $1 "." FILENAME ".res"; print $3>f}' RMIT-R3.run
awk '{f=$1 "/" $1 "." FILENAME ".res"; print $3>f}' RMIT-R4.run

echo RMIT-R1.run | NTCIR-eval tid rel test -cutoffs 10 -g 1:2:3:4
echo RMIT-R2.run | NTCIR-eval tid rel test -cutoffs 10 -g 1:2:3:4
echo RMIT-R3.run | NTCIR-eval tid rel test -cutoffs 10 -g 1:2:3:4
echo RMIT-R4.run | NTCIR-eval tid rel test -cutoffs 10 -g 1:2:3:4

echo "RMIT-R1.run
RMIT-R2.run
RMIT-R3.run
RMIT-R4.run" > rmit_list
# Official evaluation results
NEV2mean rmit_list tid test.nev Q@0010 MSnDCG@0010 nERR@0010

# Additional evaluation metrics (RBP, gdeval.pl)
OUT=rmit_list_eval_extra.txt
>$OUT
$SPATH/wwwE_eval_extra.sh RMIT-R1.run | awk '{print "RMIT-R1", $0}' >> $OUT
$SPATH/wwwE_eval_extra.sh RMIT-R2.run | awk '{print "RMIT-R2", $0}' >> $OUT
$SPATH/wwwE_eval_extra.sh RMIT-R3.run | awk '{print "RMIT-R3", $0}' >> $OUT
$SPATH/wwwE_eval_extra.sh RMIT-R4.run | awk '{print "RMIT-R4", $0}' >> $OUT
