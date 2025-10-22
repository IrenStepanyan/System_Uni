#!/bin/sh

while true 
do
	echo "Repertoire courant : `pwd`"
	echo "Sous-repertoire : "
	
	count=1
	trouver=false
	for rep in *
	do
		if [ -d "$rep" -a -r "$rep" -a -x "$rep" ]
		then
			echo "$count) $rep/"
			count=`expr $count + 1 `
			trouver=true
		fi
	done
	if [ "$trouver" = false ]
	then
		echo "Aucun sous-repertoire trouve"
	fi
	
	echo "Tapez le numero (0 pour rester, -1 pour monter, -2 pour quitter) :"
	read choice 
	
	case $choice in 
		0)
			echo "rester dans le repertoire courant." 
			;;
		-1)
			cd .. 2>/dev/null
			if [ $? -ne 0 ]
			then
				echo "deja repertoire recin, impossible de monter"
			fi 
			;;
		-2)
			echo "Fin"
			exit 0 
			;;
		*)
			if [ $choice -ge 1 -a $choice -lt $count ] 2>/dev/null
			then
				i=1
				for rep in *
				do
					if [ -d "$rep" -a -r "$rep" -a -x "$rep" ]
					then
						if [ $i -eq $choice ]
						then
							cd "$rep" 2>/dev/null
							if [ #? -ne 0 ]
							then
								echo "impossible de se deplacer dans $rep "
							fi
							break
						fi
						i=`expr $i + 1 `
					fi
				done
			else
				echo "Choix invalide. (hint: doit etre entre 1 et `expr $count - 1`) "
			fi 
			;;
	esac
done
 						
				 
