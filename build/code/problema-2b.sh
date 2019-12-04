#!/bin/bash
cat ./../source/UFO-Nov-Dic-2014.psv |\
cut -d$'\t' -f4 |\
tail -n +2 |\
awk NF |\
grep -v 'Sphere' |\
wc -w \
> ./../results/avistamientos_no_esferoide
cat ./../results/avistamientos_no_esferoide