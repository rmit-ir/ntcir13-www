#!/bin/awk -f

NR == FNR {
    A[$1] = $2 
    next
}

{
    B = 0.25*A[$3]+$5
    $5 = B
    print
}
