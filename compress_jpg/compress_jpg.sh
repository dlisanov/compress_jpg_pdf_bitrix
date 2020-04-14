#!/bin/bash
puth="/var/www/kuzgadm4/data/www/gorodkuzneck.ru"
prefix="_"
expansions=("*.jpg" "*.JPG" ".jpeg")
for expansion in ${expansions[@]}; do
    find $puth -name $expansion -size +5M > files.txt
    while read file
    do
        if grep -q "$file" "compress_files.txt";
        then
            echo "File previously compressed - $file"
        else
            newfile="$file""$prefix"
            convert "$file" -quality 65 "$newfile"
            if [ -f "$newfile" ];
            then
                rm "$file"
                mv "$newfile" "$file"
                echo "$file" >> compress_files.txt
                echo "File compressed - $file"
            fi
        fi
    done < files.txt
done
