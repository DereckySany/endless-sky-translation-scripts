#!/bin/bash
clear
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 arquivo_original arquvio_traduzido"
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
echo "Iniciando..."
while IFS= read -r line1 && IFS= read -r line2 <&3; do
#     indent=$(printf '%*s' "$(($num_tabs-1))" '')
#     num_tabs=$(echo "$line1" | grep -Po "^\t*" | wc -c)
#     indent=$(printf '\t%.0s' $(seq 1 $[$num_tabs-1]))
    num_tabs=${line1//[!$'\t']}
    echo -e "${num_tabs}${line2}"
done < "$1" 3< "$2" > "${2%.*}_indented.txt"
echo "Indentation complete. Result written to ${2%.*}_indented.txt"
echo "Remove acentuation..."
removedor_acento "${2%.*}_indented.txt"
echo "All Done!"
