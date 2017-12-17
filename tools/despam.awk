#!/usr/bin/awk -f

NR == FNR {
    whitelist[$1] = 1
}

{
    if (whitelist[$3] == 1)
        print
}
