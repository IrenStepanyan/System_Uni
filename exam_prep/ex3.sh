#!/bin/sh

# Task 3: Write a script which reads the names of the files in the given directory, prints the number of characters on each line and prints the overall number of characters in each script.
#./Script.sh REP

#!! new ligne counts only in the total

if [ $# -ne 1 ] 
then 
	echo " Usage : $0 <repertoire> " >&2
	exit 1
fi 

if [ ! -d "$1" ]
then
	echo "Erreur: $1 n'esp pas un repertoire" >&2
	exit 2
fi 

if [ ! -r "$1" -o ! -x "$1" ]
then
	echo "ErreurL $1 n'est pas accessible " >&2
	exit 3
fi

for fichier in "$1"/*
do
	if [ -f "$fichier" -a -r "$fichier" ]
	then
		echo "Fichier: `basename "$fichier" ` "
		total_char=` wc -c < "$fichier" | tr -d ' ' `
		num_ligne=1
		
		while read ligne
		do
			nb_char=`echo "$ligne" | wc -c | tr -d ' ' `
			nb_char=`expr $nb_char - 1 `
			echo "Ligne $num_ligne : $nb_char caracteres"
			
			num_ligne=`expr $num_ligne + 1 `
		done < "$fichier"
		echo "Total : $total_char caracteres "
	fi
done

exit 0
