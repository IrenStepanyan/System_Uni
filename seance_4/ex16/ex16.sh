#! /bin/sh

# Fonction d'affichage du menu
affichage_menu()
{
    echo ""
    echo "Vous pouvez taper une commande Unix, ou bien :"
    echo "fin si vous souhaitez quitter l'application"
    echo "relancer n si vous souhaitez relancer les n dernieres commandes"
    echo "Votre choix : \c"
}


relancer_n()
{
    n=$1
    
    if [ ! -f temp ]
    then
        echo "Aucune commande n'a encore ete executee !" >&2
        return
    fi
    
    nb_commandes=`grep "^\$ " temp | wc -l`
    
    if [ $n -gt $nb_commandes ]
    then
        echo "Il n'y a que $nb_commandes commande(s) dans l'historique !" >&2
        return
    fi
    
    grep "^\$ " temp | tail -n $n > temp_commandes
    
    while read ligne_commande
    do
        commande=`echo "$ligne_commande" | cut -c3-`
        
        echo "$ $commande" | tee -a temp
        eval "$commande" | tee -a temp
        
    done < temp_commandes
    
    rm -f temp_commandes
}

cat /dev/null > temp

choix=""

until [ "$choix" = "fin" ]
do
    affichage_menu
    
    read choix
    
    if [ "$choix" = "fin" ]
    then
        echo "" #pour ne pas utiliser exit 0 
    elif [ "$choix" ]
    then
        premier_mot=`echo $choix | cut -f1 -d' '`
        
        if [ "$premier_mot" = "relancer" ]
        then
            deuxieme_mot=`echo $choix | cut -f2 -d' '`
            
            test_nombre=`expr "$deuxieme_mot" + 0 2> /dev/null` #pour verifier si le deuxieme_mot et une nombre 
            
            if [ $? -eq 0 -a "$deuxieme_mot" -gt 0 ]
            then
                relancer_n $deuxieme_mot
            else
                echo "Usage : relancer n (ou n est un entier positif)" >&2
            fi
        else
            echo "$ $choix" | tee -a temp
            eval "$choix" | tee -a temp
        fi
    fi
done

rm -f temp

exit 0
