TP 5

Exercice 17

#! /bin/sh
#******************************#
# Mauvais nombre de paramètres #
#******************************#
if [ $# -ne 1 ]
then
    echo "Usage : $0 nom_répertoire" >&2
    exit 1
fi
#*****************************************#
# Le paramètre n'est pas du type souhaité #
#*****************************************#
if [ ! -d "$1" -o ! -r "$1" -o ! -x "$1" ]
then
    echo "Le répertoire $1 n'existe pas ou est protégé !" >&2
    exit 2
fi
#**********************************************#
# Pour chaque répertoire de $1, appel récursif #
#**********************************************#
for fich in "$1"/*
do
    if [ -d "$fich" ]
    then
        #***********************#
        # Affichage d'une ligne #
        #***********************#
        basename "$fich"
        #*************************************************#
        # Si le répertoire est accessible, appel récursif #
        #*************************************************#
        if [ -r "$fich" -a -x "$fich" ]
        then
            "$0" "$fich"
        fi
    fi
done
exit 0


Exercice 18

#! /bin/sh
#******************#
# Mauvaise syntaxe #
#******************#
if [ $# -eq 0 -o $# -gt 2 ]
then
    echo "Usage : $0 nom_répertoire" >&2
    exit 1
fi
#**************************************************#
# Au premier appel, affichage du nom du répertoire #
#**************************************************#
if [ $# -eq 1 ]
then
    if [ ! -d "$1" -o ! -r "$1" -o ! -x "$1" ]
    then
        echo "Le répertoire $1 n'existe pas ou est protégé !" >&2
        exit 2
    fi
    echo $1
fi
#************************************************************#
# Calcul préalable du nombre de répertoires du répertoire $1 #
#************************************************************#
nbrep=0
for fich in "$1"/*
do
    if [ -d "$fich" ]
    then
        nbrep=`expr $nbrep + 1`
    fi
done
#**********************************************#
# Pour chaque répertoire de $1, appel récursif #
#**********************************************#
for fich in "$1"/*
do
    if [ -d "$fich" ]
    then
        #***********************#
        # Affichage d'une ligne #
        #***********************#
        echo "$2+- `basename $fich`"

        #*************************************************#
        # Si le répertoire est accessible en modes r et x #
        #*************************************************#
        if [ -r "$fich" -a -x "$fich" ]
        then
            #**************************************#
            # Si on affiche le dernier d'une série #
            #**************************************#
            if [ $nbrep -eq 1 ]
            then
                #************************************************#
                # Appel récursif, avec un espace à la place du | #
                #************************************************#
                "$0" "$fich" "$2   "
            #*******#
            # Sinon #
            #*******#
            else
                #******************************************#
                # Appel récursif, avec un | supplémentaire #
                #******************************************#
                "$0" "$fich" "$2|  "
            fi
        fi
        nbrep=`expr $nbrep - 1`
    fi
done
exit 0
