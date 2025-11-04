#!/bin/sh

if [ $# -eq 0 -o $# -gt 2 ] 
then
	echo "Usage : $0 <Rep> " >&2
	exit 1 
fi 


if [ $# -eq 1 ]
then
	if [ ! -d "$1" -o ! -r "$1" -o ! -x "$1" ]
	then
		echo "Le repertoire $1 n'existe pas ou est protege" >&2
		exit 2
	fi
	echo $1
fi

nbrep=0
for fich in "$1"/*
do
	if [ -d "$fich" ]
	then
		nbrep=`expr $nbrep + 1 `
	fi
done

#echo "$nbrep"

if [ "$nbrep" -ne 0 ]
then

	for fich in "$1"/*
	do
		if [ -d "$fich" ] 
		then 
			echo "$2+- `basename $fich `"
		
			if [ -r "$fich" -a -x "$fich" ]
			then
				if [ $nbrep -eq 1 ]
				then 
					"$0" "$fich" "$2 "
				else
					"$0" "$fich" "$2| "
				fi
			fi
			nbrep=`expr $nbrep - 1 `
		fi
	done
else
	echo "\c"
fi


exit 0
