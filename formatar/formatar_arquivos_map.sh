#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 file1 file2"
    exit 1
fi

if [[ ! -f $1 ]]; then
    echo "File not found: $1"
    exit 1
fi

if [[ ! -f $2 ]]; then
    echo "File not found: $2"
    exit 1
fi

while read -r line1 && read -r line2 <&3; do
    case "$line1" in
        planet*)
            echo "$line2"
            indentation="\t"
            ;;
        tribute*)
            echo "\t$line2"
            indentation="\t\t"
            ;;
        *) if [[ $line2 == "" ]];then
            echo -e "$line2"
            else
            echo -e "$indentation$line2"
            fi
            ;;
    esac
done < "$1" 3< "$2" > "${2%.*}_formatado.txt"
# Remove os acentos do arquivo
sed -i 's/\\t/\t/g' "${2%.*}_formatado.txt"
