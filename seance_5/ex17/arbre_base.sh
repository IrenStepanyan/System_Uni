#! /bin/sh


parcourir_arbre()
{
	for rep in "$1"/*
	do
		if [ -d "$rep" ]
		then
			nom_rep=`basename "$rep"`
			echo "$nom_rep"
			
			parcourir_arbre "$rep"
		fi
	done   
    
}    


if [ $# -ne 1 ]
then
	echo "Usage : $0 <repertoire> " >&2
	exit 1
fi

if [ ! -d "$1" ]
then
    echo "Erreur : $1 n'est pas un repertoire !" >&2
    exit 2
fi

if [ ! -r "$1" -o ! -x "$1" ]
then
    echo "Erreur : $1 n'est pas accessible !" >&2
    exit 3
fi

parcourir_arbre "$1"

exit 0
