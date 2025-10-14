#!/bin/sh

while [ $# -gt 0 ]
do
	if [ -r "$1" ] && [ -f "$1" ]
	then
		echo "Contenue de: $1"
		cat "$1"
	else
		echo "$1 inaccessible" 
	fi
	
	shift #passer un parametre suivant
done

exit 0
