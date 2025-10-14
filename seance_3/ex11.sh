#!/bin/sh

date_str=`date -R`

# separer le jour, moins, anne, et l'heure
jour_semaine=`echo "$date_str" | cut -d ',' -f 1` 
#cut -d ',' -f 1 -> cuts before , and the field 1
jour=`echo "$date_str" | cut -d ' ' -f 2`
moins=`echo "$date_str" | cut -d ' ' -f 3`
anne=`echo "$date_str" | cut -d ' ' -f 4`
heure=`echo "$date_str" | cut -d ' ' -f 5`

case $jour_semaine in
	"Mon") jour_semain_fr="Lundi" ;;
	"Tue") jour_semain_fr="Mardi" ;;
	"Wed") jour_semain_fr="Mercredi" ;;
	"Thu") jour_semain_fr="Jeudi" ;;
	"Fri") jour_semain_fr="Vendredi" ;;
	"Sat") jour_semain_fr="Samedi" ;;
	"Sun") jour_semain_fr="Dimanche" ;;
esac

case $moins in
	"Jan") moins_fr="Janvier" ;;
	"Feb") moins_fr="Fevrier" ;;
	"Mar") moins_fr="Mars" ;;	
	"Apr") moins_fr="Avril" ;;
	"May") moins_fr="Mai" ;;
	"Jun") moins_fr="Juin" ;;
	"Jul") moins_fr="Juillet" ;;
	"Aug") moins_fr="Aout" ;;
	"Sep") moins_fr="Septembre" ;;
	"Oct") moins_fr="Octobre" ;;
	"Nov") moins_fr="Novembre" ;;
	"Dec") moins_fr="Decembre" ;;
esac

echo "$jour_semain_fr $jour $moins_fr $anne $heure"

exit 0
