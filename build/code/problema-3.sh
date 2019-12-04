#!/bin/bash
cat ./../source/UFO-Nov-Dic-2014.psv |\
cut -d$'|' -f5 |\
tail -n +2 |\
awk NF |\
awk '{print tolower($0)}'|\
tr '~' ' ' \
> ./../temp/info
IFS=$'\n' 
awk '/minute/{ print $0 }' ./../temp/info |\
grep -o -E '[0-9]+' |\
sed -e 's/^0\+//' |\
awk 'BEGIN{FS=OFS="\n"}{print $0*60}' \
> ./../temp/minutes
awk '/second/{ print $0 }' ./../temp/info |\
grep -o -E '[0-9]+' |\
sed -e 's/^0\+//' \
> ./../temp/seconds
awk '/hour/{ print $0 }' ./../temp/info |\
grep -o -E '[0-9]+' |\
sed -e 's/^0\+//' |\
awk 'BEGIN{FS=OFS="\n"}{print $0*360}' \
 > ./../temp/hour
 cat ./../temp/minutes \
 ./../temp/seconds \
 ./../temp/hour >> ./../temp/all_seconds
mean=`awk '{ total += $0; count++ } END { print total/count }' ./../temp/all_seconds`
min=`awk 'BEGIN{a=1000}{if ($0<0+a) a=$0} END{print a}' ./../temp/all_seconds`
max=`awk 'BEGIN{a=   0}{if ($0>0+a) a=$0} END{print a}' ./../temp/all_seconds`
echo "Media: " $mean "segundos" > ./../results/tiempos_duracion
echo  "Minimo:  " $min "segundo" >> ./../results/tiempos_duracion
echo "Maximo: " $max "segundos" >> ./../results/tiempos_duracion
echo "Media: " $mean "segundos" 
echo  "Minimo:  " $min "segundo" 
echo "Maximo: " $max "segundos" 