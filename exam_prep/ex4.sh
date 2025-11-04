#!/bin/sh

# Task 4: Write a script which traverses through all directories of the given directory
# ./Script.sh\ufffdREP

traverser_rep()
{
	if [ -d "$1" ] #pour ne pas afficher les fichier 
	then
		echo "$1"
	fi
	
	for i in "$1"/*
	do
		if [ -d "$1" ]
		then
			traverser_rep "$i"
		fi
	done
}

if [ $# -ne 1 ]
then
	echo "Usage: $0 <repertoire>" >&2
	exit 1
fi

if [ ! -d "$1" ]
then 
	echo "Erreur: $1 n'est pas un repertoire !" >&2
	exit 2
fi

if [ ! -r "$1" -o ! -x "$1" ]
then
	echo "Erreur: $1 n'est pas accessible" >&2
	exit 3
fi

traverser_rep "$1"

exit 0
