#!/bin/bash
cat ./../source/UFO-Nov-Dic-2014.psv |\
cut -d$'|' -f3 |\
tail -n +2 |\
awk NF |\
sort | \
uniq -c | \
sort -n -r \
> ./../results/avistamientos_edo
cat ./../results/avistamientos_edo
