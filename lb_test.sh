#!/usr/bin/bash

succes_count_hello=0
not_found_count_hello=0
post_count=0
put_count=0

loop_request=`shuf -i 200-2000 -n 1`


for (( c=0; c<=$loop_request; c++ ))
do
    if (( RANDOM % 2 )); 
    then 
        curl -s http://localhost/hello > /dev/null 
        (( succes_count_hello=$succes_count_hello+1 ))
    else 
        curl -s http://localhost/hello/notfound > /dev/null 
        (( not_found_count_hello=$not_found_count_hello+1 ))  
    fi

    if (( RANDOM % 2 )); 
    then 
        curl -X POST -s http://localhost/hello > /dev/null 
        (( post_count=$post_count+1 ))
    else 
        curl -X PUT -s http://localhost/hello > /dev/null 
        (( put_count=$put_count+1 ))  
    fi
    clear
    ((nb_request=$loop_request * 2))
    (( get_count=$succes_count_hello+$not_found_count_hello ))
    echo "
    TOTAL REQUEST OBJECTIF: $nb_request

    HELLO 200: $succes_count_hello
    HELLO 404: $not_found_count_hello

    GET: $get_count
    POST: $post_count
    PUT: $put_count
    "
done

