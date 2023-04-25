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
        mission*)
            echo "$line2"
            indentation="\t"
            ;;
        description*)
            echo -e "\t$line2"
            indentation="\t"
            ;;
        "to offer"*)
            echo -e "\t$line2"
            indentation="\t\t"
            ;;
        source*)
            echo -e "\t$line2"
            indentation="\t"
            ;;
        destination*)
            echo -e "\t$line2"
            indentation="\t\t"
            ;;
        on*)
            echo -e "\t$line2"
            indentation="\t\t"
            ;;
        conversation*)
            echo -e "\t\t$line2"
            indentation="\t\t\t"
            ;;
        goto*)
            echo -e "\t\t\t\t$line2"
            indentation="\t\t\t"
            ;;
        choice*)
            echo -e "\t\t\t$line2"
            indentation="\t\t\t\t"
            ;;
        decline*)
            echo -e "\t\t\t\t\t$line2"
            indentation="\t\t\t"
            ;;
        accept*)
            echo -e "\t\t\t\t$line2"
            indentation=""
            ;;
        *) if [[ $line2 == "" ]];then
            echo -e "$line2"
            else
            echo -e "$indentation$line2"
            fi
            ;;
    esac
done < "$1" 3< "$2" > "${2%.*}_formatado.txt"
