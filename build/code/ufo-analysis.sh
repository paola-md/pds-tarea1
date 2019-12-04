#! /bin/bash

BASE_URL="http://www.nuforc.org/webreports/ndxe"

function concat_data(){
	tail -n +16 |\
	head -n -2 \
	>> ./../temp/extracted
}

function extract_table() {
    sed -n '/<TABLE .*>/,/<\/TABLE>/p' | \
	sed  's/<[^>]*>\n//g'  |\
	sed -e 's/<[^>]*>//g' |\
	concat_data
}
function load_data() {
	touch ./../temp/extracted
    for url in "${BASE_URL}"{2019}{01..02}".html"
    do
        echo ${url}
        curl -k ${url}  | extract_table 
    done
}

function clean_data(){
	COUNTER=1
	echo "|Date / Time|City|State|Shape|Duration|Summary|Posted||||" > ./../temp/textfile
	touch ./../temp/auxili
	
	while read -r line
	do
		if [ $COUNTER -le 10 ]
		then
		echo "$line" >>  ./../temp/auxili
		let COUNTER+=1
		else
		cat ./../temp/auxili |\
		awk '{print tolower($0)}' |\
		tr -d '\r' |\
		tr '\n'	'|' \
		>> ./../temp/textfile
		echo $'\n' >> ./../temp/textfile
		rm ./../temp/auxili
		touch ./../temp/auxili
		let COUNTER=1
		fi
	done < ./../temp/extracted; 
	
	cat ./../temp/textfile |\
	awk NF |\
	cut -d"|" -f2-8 \
	> ./../temp/cleaned
}

function format_stats(){
	awk NF |\
	sort | \
	uniq -c |\
	sort
}
function calculate_stats(){
	# Estado 
	cat ./../temp/cleaned |\
	cut -d$'|' -f3 |\
	format_stats \
	> ./../results/stats_edo
	
	# Forma
	cat ./../temp/cleaned |\
	cut -d$'|' -f4 |\
	format_stats \
	> ./../results/stats_forma
	
	#Año, mes y hora (separar)
	#Año
	cat ./../temp/cleaned |\
	cut -d$'|' -f1|\
	cut -d' ' -f1 |\
	cut -d'/' -f3 |\
	format_stats \
	> ./../results/stats_anyo
	
	# Mes
	cat ./../temp/cleaned |\
	cut -d$'|' -f1|\
	cut -d' ' -f1 |\
	cut -d'/' -f1 |\
	format_stats \
	> ./../results/stats_mes
	
	#Hora
	cat ./../temp/cleaned |\
	cut -d$'|' -f1 |\
	awk -F' ' '{print $2}' |\
	cut -d':' -f1 |\
	format_stats \
	> ./../results/stats_hora
	
	#Color
	echo "count color" > ./../results/stats_color
	cat ./../temp/cleaned |\
	awk '{print $6}' |\
	egrep -x "reddish|colored|multicolored|red|orange|yellow|green|blue|purple|brown|magenta|tan|cyan|olive|maroon|navy|aquamarine|turquoise|silver|lime|teal|indigo|violet|pink|black|white|grey|gray" | \
	format_stats \
	>> ./../results/stats_color
	
}

load_data
clean_data
calculate_stats

