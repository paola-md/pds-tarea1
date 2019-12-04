#!/bin/bash
rm ./../temp/*
rm ./../results/*
echo "============PROBLEMA 1============="
./problema-1.sh
echo "============PROBLEMA 2A============="
./problema-2a.sh
echo "============PROBLEMA 2B============="
./problema-2b.sh
echo "============PROBLEMA 3=============="
./problema-3.sh
echo "============PROBLEMA 4=============="
./ufo-analysis.sh
./GraficaStats.R
