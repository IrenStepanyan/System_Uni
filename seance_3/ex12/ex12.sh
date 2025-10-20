#!/bin/sh

if [$# -ne 0 ]
then
	echo "Usage: $0" >&2
	exit 1
fi

> f_francais.txt 
#cree ou vider le fichier de sortie

while read ligne
do
	traduit=""
	sep=""
	for mot in $ligne
	do
		francais=`grep "^$mot " dico.txt | cut -d ' ' -f 2`
		traduit="${traduit}${sep}${francais}"
		sep=" "
	done
	echo "$traduit" >>f_francais.txt
done < f_anglais.txt

exit 0
