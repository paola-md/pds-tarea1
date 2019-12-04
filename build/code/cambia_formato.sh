#!/bin/bash
cat ./../source/UFO-Nov-Dic-2014.tsv |\
awk 'NR>1{gsub("\t","|")}1' \
> ./../source/UFO-Nov-Dic-2014.psv