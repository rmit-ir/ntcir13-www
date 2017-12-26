#!/bin/bash 

SPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PPATH="$SPATH/../results/reproduce"

if [ ! -f "$SPATH/local.sh" ]; then
    echo "Config required. Create the file tools/local.sh and set the variable"
    echo "\`INDEX\` to the path of your ClueWeb12B Indri index. For example:"
    echo ""
    echo "echo \"INDEX='indri-indexes/ClueWeb12B'\" > $SPATH/local.sh"
    echo ""
    exit 1
fi

if [ $# -ne 1 ]; then
	echo "usage: $0 <indri-bin>"
	exit 1
fi

xz -dk $SPATH/spam.white.70.xz $SPATH/pagerank.prior.xz

source $SPATH/local.sh
INDRI_ARGS="-threads=48 -stemmer.name=krovetz -count=10000 -trecFormat=1"

# RMIT-1 SDM Fields
$1 -index=$INDEX $INDRI_ARGS -fbDocs=10 -fbTerms=50 -fbOrigWeight=0.6 \
    -rule=method:dirichlet,mu:2000,operator:term \
    -rule=method:dirichlet,mu:2000,operator:window \
    "$PPATH/sdmf.param" > "$PPATH/sdmf-qe.run"
# Spam was not filtered for this run
$SPATH/monotonic.sh "$PPATH/sdmf-qe.run"
mv "$SPATH/pruned.run" "$PPATH/RMIT-R1.run"

# RMIT-2 (RMIT-1, PageRank)
$SPATH/pagerank.awk $SPATH/pagerank.prior $PPATH/sdmf-qe.run > $PPATH/sdmf-qe-pr.run
$SPATH/despam.awk \
    $SPATH/spam.white.70 \
    "$PPATH/sdmf-qe-pr.run" > "$PPATH/sdmf-qe-pr-nospam.run"
# Requires sort from PageRank rescoring
$SPATH/sort.sh "$PPATH/sdmf-qe-pr-nospam.run" > $PPATH/sdmf-qe-pr-nospam-sort.run
$SPATH/monotonic.sh "$PPATH/sdmf-qe-pr-nospam-sort.run"
mv "$SPATH/pruned.run" "$PPATH/RMIT-R2.run"

# RMIT-3 FDM
$1 -index=$INDEX $INDRI_ARGS -fbDocs=20 -fbTerms=10 -fbOrigWeight=0.8 \
    -rule=method:dirichlet,mu:2000,operator:term \
    -rule=method:dirichlet,mu:2000,operator:window \
    "$PPATH/www17-fdm.param" > "$PPATH/www17-fdm-qe.run"
$SPATH/despam.awk \
    $SPATH/spam.white.70 \
    "$PPATH/www17-fdm-qe.run" > "$PPATH/www17-fdm-qe-nospam.run"
$SPATH/monotonic.sh "$PPATH/www17-fdm-qe-nospam.run"
mv "$SPATH/pruned.run" "$PPATH/RMIT-R3.run"

# RMIT-4 NGram Fields
$1 -index=$INDEX $INDRI_ARGS -fbDocs=10 -fbTerms=50 -fbOrigWeight=0.6 \
    -rule=method:dirichlet,mu:2000,operator:term \
    -rule=method:dirichlet,mu:2000,operator:window \
    "$PPATH/www17-fields.param" > "$PPATH/www17-fields-qe.run"
$SPATH/despam.awk \
    $SPATH/spam.white.70 \
    "$PPATH/www17-fields-qe.run" > "$PPATH/www17-fields-qe-nospam.run"
$SPATH/monotonic.sh "$PPATH/www17-fields-qe-nospam.run" "R4"
mv "$SPATH/pruned.run" "$PPATH/RMIT-R4.run"
