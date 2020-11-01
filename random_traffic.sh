#!/usr/bin/bash

succes_count_hello=0
post_count=0
put_count=0
not_allowed=0
loop_request=`shuf -i 100-500 -n 1`


for (( c=0; c<=$loop_request; c++ ))
do
    if (( RANDOM % 2 )); 
    then 
        curl -s http://localhost/ > /dev/null 
        (( succes_count_hello=$succes_count_hello+1 ))
    fi

    if (( RANDOM % 2 )); 
    then 
        curl -X POST -s http://localhost/ > /dev/null 
        (( post_count=$post_count+1 ))
    else 
        curl -X PUT -s http://localhost/ > /dev/null 
        (( put_count=$put_count+1 ))  
    fi
    clear
    ((nb_request=$succes_count_hello + $post_count + $put_count ))
    (( get_count=$succes_count_hello))
    (( not_allowed=$post_count+$put_count))

    echo "
    SERVICE HELLO WORLD :
        total: $nb_request

        200: $succes_count_hello
        405: $not_allowed

        GET: $get_count
        POST: $post_count
        PUT: $put_count
    "
done

loop_request=`shuf -i 100-500 -n 1`
new_user=0
get_user=0


for (( c=0; c<=$loop_request; c++ ))
do
    if (( RANDOM % 13 ));
    then
        curl -s -X GET localhost/get_users > /dev/null
        (( get_user=$get_user + 1 ))
    else
        for name in $(curl -s "http://names.drycodes.com/1?nameOptions=boy_names" | jq -r ".[]" ); 
        do 
            curl -s -X POST localhost/put_name/$name > /dev/null
            (( new_user=$new_user + 1 ))
        done
    fi

    (( total_user=$new_user + $get_user))
    clear
    echo "
    SERVICE USER: 

        total: $total_user

        get : $get_user
        new user: $new_user
    "
done 

clear

((get_user=$get_user+1))
((total_user=$get_user+$new_user))

echo "

    SERVICE HELLO WORLD :
        total: $nb_request

        200: $succes_count_hello
        405: $not_allowed

        GET: $get_count
        POST: $post_count
        PUT: $put_count

    SERVICE USER: 

        total: $total_user

        get : $get_user
        new user: $new_user
"

echo " 

Liste des utilisateur :

"
curl -s -X GET localhost/get_users | jq .users