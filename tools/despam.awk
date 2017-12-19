#!/usr/bin/awk -f

NR == FNR {
    whitelist[$1] = 1
    next
}

{
    if (whitelist[$3] == 1)
        print
}
