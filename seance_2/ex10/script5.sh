#!/bin/sh

if [ $# -ne 2 ]
then 
	echo "Usage: $0 <numbre1> <numbre2>" >&2
	exit 1
fi

if [ $1 -ge $2 ]
then 
	echo "Usage: $1 doit etre moins que $2" >&2
	exit 2
fi

echo "Nombre d'etudiant dont le nom comporte entre $1 et $2: ` tail -n +6 liste.txt | cut -f1 -d' ' | grep '.\{'$1'\}' | grep -v '.\{'$2'\}' | wc -l | tr -d ' ' ` "

exit 0


#Q1: 
# tail -n +6 liste.txt | grep 'linfg[0-9]$' | sort -k 3 | head -n 1 | cut -f1 -d' '
# commancer avec le ligne 6 (parce que les lignes 1-5 sont inutile (headers)
# sort -k 3 -> le linfg.. est le 3eme column (sorts)
# head -n 1 -> prend le premiere ligne 
# cut -f1 -d ' ' -> deletes les espaces inutile

#Q2: 
# tail -n +6 liste.txt | grep 'linfg[0-9]\{3\}$' | sort -k 3 | tail -n 1 | cut -f1 -d' '
# comme il y a 3 chiffre apres linfg 
# tail -n 1 -> le dernier ligne 
   
