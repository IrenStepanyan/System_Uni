TP 1

Exercice 1

1) ls users/linfg/linfg0/S4/*.txt
2) echo Le renard dit \"Oh, Monsieur du Corbeau\"
   echo J\’ai gagne \$100 a l\’Alcazar
   echo Commentaire : \\\* Initialisation \*\\

Exercice 2

1) cd
   pwd
2) mkdir -p REP/SOUSREP
3) cp users/linfg/linfg0/S4/liste.txt REP/SOUSREP
4) cd REP/SOUSREP
   ls
5) mv liste.txt ..
6) cd
   rmdir REP/SOUSREP
   rm REP/liste.txt
   rmdir REP

Exercice 3

1) cd
   cp users/linfg/linfg0/S4/liste.txt .
2) more liste.txt
3) ls -l
4) chmod u-w liste.txt
5) ls -l
6) La sauvegarde est impossible.
7) chmod u+w liste.txt
8) Cette fois-ci, la sauvegarde est possible.   

Exercice 4

1) tail -n -5 liste.txt
   Cette commande affiche les 5 dernières lignes du fichier liste.txt.
   Cette commande est équivalente à : tail -n 5 liste.txt
2) tail -n +5 liste.txt
   Cette commande affiche les lignes du fichier liste.txt, à partir de la ligne numéro 5.
3) head -5 liste.txt
   Cette commande affiche les 5 premières lignes du fichier liste.txt.
  Cette commande est équivalente à : head -n 5 liste.txt
4) head liste.txt
   Cette commande affiche les 10 premières lignes du fichier liste.txt.

Exercice 5

1) tail -n +6 liste.txt | sort -k 3
   Le numéro 2 sera affiché après le numéro 10 (parce que le tri porte sur le premier caractère), ce qui n’est pas très satisfaisant. Pour pallier ce défaut, on peut utiliser la séquence suivante :
tail -n +6 liste.txt | grep 'linfg[0-9]$' | sort -k 3 > temp
tail -n +6 liste.txt | grep 'linfg[0-9]\{2\}$' | sort -k 3 >> temp
tail -n +6 liste.txt | grep 'linfg[0-9]\{3\}$' | sort -k 3 >> temp
cat temp
rm temp

2) tail -n +6 liste.txt | sort -k 2

Exercice 6

1) grep ' LAURENT ' liste.txt 
2) tail -n +5 liste.txt | grep -v 'linfg[0-9]\{3\}$'
3) grep 'linfg.*1' liste.txt

Exercice 7

1) echo Est-ce que j\’arrive > tdm01.txt
   echo a rediriger la >> tdm01.txt
   echo sortie standard \? >> tdm01.txt
2) cat liste.txt
   Cette commande affiche le contenu du fichier liste.txt.
   cat liste.txt > liste2.txt
   Cette commande recopie le fichier liste.txt dans le fichier liste2.txt.
   rm liste2.txt
   Cette commande supprime le fichier liste2.txt.
   cat liste.txt | tail -5
   Cette commande affiche les 5 dernières lignes du fichier liste.txt.
   Cette commande est équivalente à : cat liste.txt | tail -n 5
3) head -n 10 liste.txt | tail -n +5
   Le même résultat peut être obtenu avec : 
tail -n +5 liste.txt | head -n 6

