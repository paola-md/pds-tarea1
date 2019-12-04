#!/bin/bash
curl https://www.gutenberg.org/files/35/35-0.txt | \
awk 'f;/*** START OF THIS PROJECT GUTENBERG EBOOK THE TIME MACHINE ***/{f=1}' | \
awk 'NR==1,/*** END OF THIS PROJECT GUTENBERG EBOOK THE TIME MACHINE  ***/' | \
head -n-1 | \
awk '{print tolower($0)}' | \
gawk -v RS='[^[:alpha:]]+' '{print}' | \
sort | \
uniq -c | \
sort -n -r | \
head -n 10 > ./../results/freq_palabras
cat ./../results/freq_palabras
