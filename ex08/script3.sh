#!/bin/sh

rm -rf REP 2>/dev/null
mkdir REP 2>/dev/null || exit 1 #si mkdir ne fonctionne pas


ls *.txt *.sh >REP/liste.txt 2>/dev/null #redirection erreurs di pas de fishiers

if [ ! -s REP/liste.txt ]
then
	echo "Aucun fishier .txt ou .sh" >&2
	exit 1
fi


fichier_dernier=`tail -n 1 REP/liste.txt`

if [ -f "$fichier_dernier" ]
then
  cp "$fichier_dernier" REP/ 2>/dev/null
else
	echo "Fichier $fichier_dernier est introuvable." >&2
	exit 2
fi

rm REP/liste.txt
