TP 4

Exercice 14

#! /bin/sh
while [ $# -ne 0 ]
do
    if test -f "$1" -a -r "$1"
    then
        cat "$1"
    else
        echo "$1 inaccessible" >&2
    fi
    shift
done
exit 0

Remarque
En utilisant une boucle for, cet exercice devient encore plus simple :

#! /bin/sh
for fich
do
    if test -f "$fich" -a -r "$fich"
    then
        cat "$fich"
    else
        echo "$fich inaccessible" >&2
    fi
done


Exercice 15

#! /bin/sh
if [ $# -ne 1 -a $# -ne 2 ]
then
    echo "Usage : $0 nom_fichier1 [nom_fichier2]" >&2
    exit 1
fi
#**********************************#
# Si le nombre de paramètres est 2 #
#**********************************#
if [ $# -eq 2 ]
then
    #*********************************************#
    # Recopie du premier paramètre dans le second #
    #*********************************************#
    cp "$1" "$2"
    #***********************************#
    # Appel récursif, avec un paramètre #
    #***********************************#
    "$0" "$2"
#**********************************#
# Si le nombre de paramètres est 1 #
#**********************************#
else
    echo "Un seul paramètre"
    #****************************************#
    # Nombre de lignes du fichier à inverser #
    #****************************************#
    nblignes=`cat "$1" | wc -l | tr -s ' ' | cut -f2 -d' '`
    #*******************************************#
    # Suppression du fichier .inv2, s'il existe #
    #*******************************************#
    if [ -f .inv2 ]
    then
        rm .inv2
    fi
    #***********************************************#
    # Affichage d'une seule ligne à chaque parcours #
    #***********************************************#
    while test $nblignes -gt 0
    do
        head -$nblignes "$1" > .inv1
        tail -1 .inv1 >> .inv2
        nblignes=`expr $nblignes - 1`
    done
    #***********************************************#
    # Recopie du fichier résultat dans le paramètre #
    #***********************************************#
    cp .inv2 "$1"
    #*******************************************#
    # Suppression des deux fichiers temporaires #
    #*******************************************#
    rm .inv1 .inv2
fi
exit 0


Exercice 16

#! /bin/sh
affichage_menu()
{
    echo "\nVous pouvez taper une commande Unix, ou bien :"
    echo "\tfin, si vous souhaitez quitter l'application"
    echo "\trelancer n si vous souhaitez relancer les n dernieres commandes"
    echo "Votre choix : \c"
}
lire()
{
    affichage_menu
    read commande parametres
    until test $commande    # Boucle exécutée tant que condition fausse
    do
        echo "\nSuivez les instructions, SVP !\n" >&2
        affichage_menu
        read commande parametres
    done
}
nombre()
{
    expr $1 + 0 > /dev/null 2> /dev/null
    if [ $? -lt 2 ]
    then
        return 0
    else
        return 1
    fi
}
relancer_n()
{
    if nombre $1
    then
        if echo "\c" > "$chemin"/temp2 2> /dev/null
        then
           nb_total_commandes=`grep -c '^\$ ' "$chemin"/temp`
           if [ $1 -gt $nb_total_commandes ]
           then
              nb_commandes=$nb_total_commandes
           else
              nb_commandes=$1
           fi
           while [ $nb_commandes -gt 0 ]
           do
              commande_a_relancer=`grep '^\$ ' "$chemin"/temp | tail -$nb_commandes
	                                                          | head -1 | cut -c3-`
              echo "\$ $commande_a_relancer" | tee -a $chemin/temp2
              eval "$commande_a_relancer" > "$chemin"/temp3
              cat "$chemin"/temp3 | tee -a "$chemin"/temp2
              nb_commandes=`expr $nb_commandes - 1`
           done
           cat "$chemin"/temp2 >> "$chemin"/temp
           rm "$chemin"/temp2
           return 0
        else
           echo "Le fichier temp2 n'a pas pu être créé." >&2
           return 2
        fi
    else
        echo "\nSuivez les instructions, SVP !\n"
        return 1
    fi
}
chemin=`pwd`
if echo "\c" > "$chemin"/temp 2> /dev/null
then
    lire
    until [ "$commande" = fin ]
    do
        if [ "$commande" = relancer ]
        then
            relancer_n $parametres
            if [ $? -eq 2 ]
            then
                exit 2
            fi
        else
            echo "\$ $commande $parametres" >> $chemin/temp
            eval "$commande" $parametres > "$chemin"/temp3
            cat "$chemin"/temp3 | tee -a "$chemin"/temp
        fi
        lire
    done
    rm "$chemin"/temp "$chemin"/temp3
    exit 0
else
    echo "Le fichier temp n'a pas pu être créé." >&2
    exit 1
fi


Remarques

	1) Dans la fonction relancer_n, il faut prendre garde à ne pas écrire tout de suite
	les commandes relancées dans le fichier temp. En effet, si par exemple on relance
	les deux dernières commandes, à savoir pwd et echo bonjour, et si on écrit
	$ echo bonjour dans le fichier temp juste après avoir relancé cette commande,
	alors on relancera ensuite à nouveau, à tort, la commande echo bonjour, qui sera la
	dernière commande Unix figurant dans le fichier temp.
	C'est pour cette raison qu'on utilise un autre fichier temp2.
	
	2) La commande :
		eval "$commande" $parametre
	n'est pas équivalente à la commande :
		"$commande" $parametre
	car, si l'utilisateur avait tapé une commande Unix comportant
	des métacaractères, avec cette dernière syntaxe, ils ne seraient pas réévalués.
	Par exemple, la commande echo * afficherait, à tort, le caractère *
	
	3) La séquence :
		eval "$commande" $parametres > "$chemin"/temp3
		cat "$chemin"/temp3 | tee -a "$chemin"/temp
	n'est pas équivalente à la commande :
		eval "$commande" $parametres | tee -a "$chemin"/temp
	car dans cette deuxième syntaxe, la commande est interprétée par un sous-shell.
	Pour la même raison, la séquence :
		eval "$commande_a_relancer" > "$chemin"/temp3
		cat "$chemin"/temp3 | tee -a "$chemin"/temp2
	n'est pas équivalente à la commande :
		eval "$commande_a_relancer" | tee -a "$chemin"/temp2
	C'est pour cette raison qu'on utilise le fichier temporaire temp3.
