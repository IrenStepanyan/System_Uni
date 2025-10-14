#!/bin/sh

while true
do
	echo "Repertoire courant: `pwd`"
	echo "Sous-reperoires: "
	reper=`ls -d */ 2>/dev/null`
	if [ -z "$reper" ]
	then
		echo "Aucun sous-repertoires"
	else
		nmb=1
		for rep in $reper
		do
			echo "$nmb $rep"
			nmb=`expr $nmb + 1`
		done
	fi
	
	echo "Tapez le numero (0 pour rester, -1 pour monte, -2 pour quitter) :"
	read choice

	case $choice in
		0) echo "Restez dans le repertoir courant" ;;
		-1)
			cd .. 2>/dev/null
			if [ $? -ne 0 ]
			then
				echo "Deja au repertoire racine"
			fi ;;
		-2)	
			echo "Fin"
			exit 0 ;;
		*) #si il est numero valide
			if [ "$choice" -ge 1 ] && [ "$choice" -lt "$nmb" ]
			then
				choisi_rep=`echo $reper | cut -d ' ' -f $choice`
				cd "$choisi_rep" 2>/dev/null
				if [ $? -ne 0 ]
				then
					echo "Impossible de se deplacer dans ce repertoite."
				fi
			else
				echo "Choix invalide."
			fi ;;
		esac
done
	
	
