#!/bin/sh

# grep -v smth -> lines that doesn't correspond to the smth
# ici j'utilise grep -v '^\.' '\.txt$' pour eviter inclusion the file qui se termine par .txt ou qui commence avec point (fichieres caches) 

txt_count=$(ls -al 2>/dev/null | grep '^-' | grep '\.txt$' | wc -l)
echo "Il y a $txt_count fichiers dont le nom se termine par .txt"

sh_count=$(ls -al 2>/dev/null | grep '^-' | grep '\.sh$' | wc -l)
echo "Il y a $sh_count fichiers dont le nom se termine par .sh"

caches_count=$(ls -al 2>/dev/null | grep '^-' | grep '^\.[^.]' | wc -l)
echo "Il y a $caches_count fichiers caches"
# [^ smth] caractere autre qu'un smth
# grep '^\.[^.]' -> les lignes qui commerencent par un point et suivi d'un cararactere autre qu'un point (.) 

autre_count=$(ls -al 2>/dev/null | grep '^-' | grep -v '\.txt$' | grep -v '\.sh$' | grep -v '^\.' | wc -l)
echo "Il y a $autre_count autres fichiers"

