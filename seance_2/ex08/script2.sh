#!/bin/sh

if [ $# -ne 1 ]
then
	echo "Usage: $0 <repertoire>" >&2
	exit 1
fi

if [ ! -d "$1" -o ! -r "$1" -o ! -x "$1" -o ! -w "$1" ]
then
	echo "Erreur: le repertoire n'est pas accessible">&2
	exit 2
fi 

rm -f "$1"/* "$1"/.* 2>/dev/null #for hidden files as well 
# rmdir "$1" 2>/dev/null || rm -rf "$1"  #if didn't work first one => n;est pas vide
# option 2

rmdir "$1" 2>/dev/null 
if [ $? -ne 0 ]
then
    echo "Erreur: impossible de supprimer le repertoire (non vide ?)." >&2
    exit 3
fi
