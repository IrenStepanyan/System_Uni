#!/bin/sh

if [ $# -ne 2 ]
then 
    echo "Usage: $0 <repertoire> <fichier>" >&2
    exit 1
fi 

if [ -d "$1" ]
then
    echo "Le repertoite '$1' existe deja." >&2
    exit 2
fi

if [ ! -f "$2" ]
then
    echo "Le fichier '$2' n'existe pas." >&2
    exit 3
fi


mkdir "$1"
cp "$2" "$1/"
