#!/bin/bash
simbols='+-/*!&$#?=@<>'
numbers='1234567890'
alphabet_low='abcdefghijklnopqrstuvwxyz'
alphabet_high='ABCDEFGHIJKLMNOPQRSTUVWXYZ'


function get_pswd  {
    questions=('верхний регистр' 'нижний регистр' 'цифры' 'символы')
    parts=("$alphabet_high" "$alphabet_low" "$numbers" "$simbols")
    answers=()
    k=0
    for ((i=0;i<=3;i++));
    do  
        read -p "хотите добавить ${questions[$i]} в пароль?(можно ответить да/нет/yes/no)" answer
        if [[ "$answer" == "y" ]] || [[ "$answer" == "да" ]] || [[ "$answer" == "yes" ]] || [[ "$answer" == "д" ]] 
        then
        k=$(( 1 + $k ))
        answers+=(1)
        else
        answers+=(0)
        fi
    done
    
    while [[ $len -le $k ]]
    do
    read -p "ввведите число символов в пароле= " len 
    done 
    
    let "parts_length = $len / $k"
    last_part_length=$(( $len % $k ))
    password=''
    for ((i=0;i<=3;i++));
    do
        if [[ ${answers[$i]} == 1 ]]
        then
        
        part_of_oswd=$( gen_part_of_pswd $parts_length ${parts[$i]} )
        # echo "${parts[$i]}"
        password+="$part_of_oswd"
        fi
    done
    part_of_oswd=$( gen_part_of_pswd $last_part_length $numbers )
    password+="$part_of_oswd"
    echo "$password"

    }

function gen_part_of_pswd () {
    part=''
    l="$2"
    for ((i=1;i<=$1;i++));
    do  
        rand=$(( RANDOM % ${#l} ))
        part+="${l:rand:1}"
    done
    echo "$part"
}


function backup {
    cp -b -r $1  $2
    }

# function start_docker {
#     a=`sudo docker ps -a` 
#     echo "$a" > docker_containers.txt
#     awk '{print $14}' docker_containers.txt > docker_manes.txt
#     while IFS= read -r line; do
#         sudo docker start "$line"
#         done
# }

function magic_network {
    /dev/null > out
    /dev/null > out2
    ip_add=`hostname -I | awk -F. '{print $1."."$2."."$3."."}'`
    sudo nmap -sS -O -p- "$ip_add"0/24 | grep "report for" >> out
    etad=`date`
    awk 'BEGIN {print $etad} {print $5,$6}' out >> out2
    echo "$etad" >> out2
}


function main {
    echo "help me//"
    echo "Будем генерировать пароли)("

    result=$( get_pswd )
    echo "$result"


    # magic_network
    # echo "Если в файлах out2 и out1 ничего нет, значит у вас что-то не то с сетью"
    }

main