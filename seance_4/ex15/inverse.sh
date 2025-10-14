#!/bin/sh

if [ $# -ne 1 ] && [ $# -ne 2 ]
then	
	echo "Erreur: inverse.sh nom_fichier1 [nom_fichier2]" >&2
	exit 1
fi

if [ $# -eq 2 ]
then
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

rm -f .inv1 .inv2 #je pense que c'est inutill 
