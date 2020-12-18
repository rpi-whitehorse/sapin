#!/bin/bash
trap "tput reset; tput cnorm; exit" 2
clear
tput civis
lin=2
col=$(($(tput cols) / 2))
c=$((col-1))
est=$((c-2))
color=0
tput setaf 2; tput bold

# Dessine l'arbre
for ((i=1; i<20; i+=2))
{
    tput cup $lin $col
    for ((j=1; j<=i; j++))
    {
        echo -n \*
    }
    let lin++
    let col--
}

tput sgr0; tput setaf 3

# Dessine le tronc
for ((i=1; i<=3; i++))
{
    tput cup $((lin++)) $c
    echo 'mWm'
}
annee=$(date +'%Y')
let annee++
tput setaf 1; tput bold
tput cup $lin $((c - 15)); echo La MJC du cheval blanc vous souhaite
tput cup $((lin + 1)) $((c - 7)); echo Un Joyeux-Noël et nos
color=$((RANDOM %8))
tput cup $((lin + 2)) $((c - 9)); echo Meilleurs vœux pour $annee
let c++
k=1

# Mise en lumiere et animation
while true; do
    for ((i=1; i<=35; i++)) {
        # eteint les ampoules
        [ $k -gt 1 ] && {
            tput setaf 2; tput bold
            tput cup ${line[$[k-1]$i]} ${column[$[k-1]$i]}; echo \*
            unset line[$[k-1]$i]; unset column[$[k-1]$i]  # Efface la zone
        }

        li=$((RANDOM % 9 + 3))
        start=$((c-li+2))
        co=$((RANDOM % (li-2) * 2 + 1 + start))
        tput setaf $color; tput bold   # Mise en couleur aleatoire
        tput cup $li $co
        echo o
        line[$k$i]=$li
        column[$k$i]=$co
        color=$(((color+1)%8))
        # Clignotement du texte 
        sh=-5
        for l in J o y e u x - N o ë l
        do
            tput cup $((lin+1)) $((c+sh))
            echo $l
            let sh++
            sleep 0.01
        done
    }
    k=$((k % 2 + 1))
done