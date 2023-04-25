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
        ship*)
            echo "$line2"
            indentation="\t"
            ;;
        attributes*)
            echo "\t$line2"
            indentation="\t\t"
            ;;
        licenses*)
            echo -e "\t\t$line2"
            indentation="\t\t\t"
            ;;
        \"cost*)
            echo -e "\t\t$line2"
            indentation="\t\t"
            ;;
        weapon*)
            echo -e "\t\t$line2"
            indentation="\t\t\t"
            ;;
        outfits*)
            echo -e "\t$line2"
            indentation="\t\t"
            ;;
        engine*)
            echo -e "\t$line2"
            indentation="\t"
            ;;
        *)
            echo -e "$indentation$line2"
            ;;
    esac
done < "$1" 3< "$2" > "${2%.*}_formatado.txt"
# Remove os acentos do arquivo
sed -i 's/\\t/\t/g' "${2%.*}_formatado.txt"
