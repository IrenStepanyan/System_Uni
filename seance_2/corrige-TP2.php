TP2

Exercice 8

1) script1.sh :
#! /bin/sh
mkdir "$1"
cp "$2" "$1"

2) script2.sh :
#! /bin/sh
rm "$1"/*
rmdir "$1"

3) script3.sh :
#! /bin/sh
mkdir REP
ls *.txt > REP/liste.txt
ls *.sh >> REP/liste.txt
cp `tail -n 1 REP/liste.txt` REP
rm REP/liste.txt

Exercice 9

#! /bin/sh
echo "Il y a `ls -al | grep -c '^-.*\.txt$'` fichier(s) dont le nom se termine par .txt"
echo "Il y a `ls -al | grep -c '^-.*\.sh$'` fichier(s) dont le nom se termine par .sh"
echo "Il y a `ls -al | grep -c '^-.* \.' ` fichier(s) caché(s)."
echo "Il y a `ls -al | grep -v '\.txt$' | grep -v '\.sh$' | grep -v ' \.' | grep -c '^-'` autre(s) fichier(s)."

Exercice 10

cd
cp users/linfg/linfg0/S3/liste.txt .

1) tail -n +6 liste.txt | grep 'linfg[0-9]$' | sort -k 3 | head -n 1 | cut -f1 -d' '

2) tail -n +6 liste.txt | grep 'linfg[0-9]\{3\}$' | sort -k 3 | tail -n 1 | cut -f1 -d' '

3)
#! /bin/sh
echo "Il y a `tail -n +6 liste.txt | cut -f1 -d' ' | 
              grep '.\{'$1'\}' | grep -v '.\{'$2'\}' | 
              wc -l | tr -d ' '` étudiants dont le nom comporte entre $1 et $2 lettres."

