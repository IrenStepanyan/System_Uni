#!/bin/sh 

#task 2: Write a script, which renames the files by adding chosen extension to their previous name.
# ./Script.sh extension file1  [files]

if [ $# -lt 2 ]
then
	echo "Usage: $0 <extension> <file1> [files]"
	exit 1
fi

EXT="$1"
shift #making all the parameters files 

for fichier 
do
	if [ -f "$fichier" ]
	then 
		dir=`dirname "$fichier" `
		base=`basename "$fichier" `
		#nom=`echo "$base" | cut -f1 -d '.' `
		#nom=`echo "$base" | sed 's/\.[^.]*$//'`
		nom=`echo "$base" | awk -F. '{print $1}'`
		mv "$fichier" "$dir/$nom.$EXT"
	else
		echo " $fichier n'est pas un fichier" >&2 
	fi
done
