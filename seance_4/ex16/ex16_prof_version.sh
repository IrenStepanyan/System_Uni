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
              commande_a_relancer=`grep '^\$ ' "$chemin"/temp | tail -$nb_commandes | head -1 | cut -c3-`
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
