#!/bin/sh

#Error handling is MUST 

if [ $# -ne 1 ] && [ $# -ne 2 ]
then	
	echo "Erreur: inverse.sh nom_fichier1 [nom_fichier2]" >&2
	exit 1
fi


if [ ! -f "$1" -a ! -r "$1" ]
then
	echo "Erreur: le fichier "$1" n'existe pas ou n'est pas lisibile." >&2
	exit 2
fi

if [ $# -eq 2 ]
then
	if [ ! -f "$2" -a ! -w "$2" ]
	then 
		echo "Erreur: le fichier "$2" n'existe pas ou est protege en ecriture" >&2
		exit 3
	fi
	
	cp "$1" "$2"
	./inverse.sh "$2"
	exit $?
fi

echo "Un seul parametre"
nblignes=`wc -l < "$1"`

rm -f .inv1 .inv2 #effancer .inv2 apres chaque test

while [ "$nblignes" -gt 0 ]
do
	head -n "$nblignes" "$1" >.inv1
	tail -n 1 .inv1 >> .inv2
	
	nblignes=`expr $nblignes - 1`
done

cp .inv2 "$1"

rm -f .inv1 .inv2

exit 0
