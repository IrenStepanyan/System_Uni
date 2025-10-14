#!/bin/sh


echo "Il y a `ls -al | grep -c '^-.*\.txt$' ` fichier(s) dont le nom se termine par .txt"
echo "Il y a  `ls -al | grep -c '^-.*\.sh$' ` fichier(s) dont le nom se termine par .sh"
echo "Il y a `ls -al | grep -c '^-.*\.' ` fichier(s) cache(s)"
echo "Il y a `ls -al | grep -v '\.txt$' | grep -v '\.sh$' | grep -v '\.' | grep -c '^-' ` autre(s) fichier(s)." 

