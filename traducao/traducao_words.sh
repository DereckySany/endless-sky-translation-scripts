#!/bin/bash

# Verifica se foi fornecido um arquivo como argumento
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 arquivo"
    exit 1
fi

# Verifica se o arquivo de saída já existe
if [[ "$1" == *"_novo.txt" ]]; then
    novo_arquivo="$1"
else
    novo_arquivo="${1%.*}_novo.txt"
fi

# Percorre as linhas do arquivo de entrada
while read line
do
    if echo "$line" | grep -q '^`'; then
        # Extrai o texto entre as aspas
        text=$(echo "$line" | awk -F'`' '{ for (i=2; i<=NF; i+=2) print $i }')
        # Procura pelo texto entre aspas invertidas e o remove temporariamente
        #code=$(echo "$text" | awk -F'`' '{ for (i=2; i<=NF; i+=2) print $i }')
        #text=$(echo "$text" | awk -F'`' '{ for (i=1; i<=NF; i+=2) print $i }' ORS="")
        # Traduz o texto
        translated=$(trans -b -s en -t pt -no-ansi "$text")
        # Re-adiciona o texto entre aspas invertidas
        #translated=$(echo "$translated" | awk -v var="$code" '{gsub("{code}", var)}1')
        # Substitui o texto original pelo texto traduzido
        #line=$(echo "$line" | sed "s/\`\(.*\)\`/\"$translated\"/")
        line=$(echo "$line" | sed "s/\`\(.*\)\`/\`$translated\`/")
    fi
    if echo "$line" | grep -q '^"'; then
        # Extrai o texto entre as aspas
        text=$(echo "$line" | awk -F'"' '{ for (i=2; i<=NF; i+=2) print $i }')
        # Procura pelo texto entre aspas invertidas e o remove temporariamente
        #code=$(echo "$text" | awk -F'`' '{ for (i=2; i<=NF; i+=2) print $i }')
        #text=$(echo "$text" | awk -F'`' '{ for (i=1; i<=NF; i+=2) print $i }' ORS="")
        # Traduz o texto
        translated=$(trans -b -s en -t pt -no-ansi "$text")
        # Re-adiciona o texto entre aspas invertidas
        #translated=$(echo "$translated" | awk -v var="$code" '{gsub("{code}", var)}1')
        # Substitui o texto original pelo texto traduzido
        #line=$(echo "$line" | sed "s/\`\(.*\)\`/\"$translated\"/")
        line=$(echo "$line" | sed "s/\"\(.*\)\"/\"$translated\"/")
    fi
    # Salva a linha no arquivo de saída
    echo "$line" >> "$novo_arquivo"
done < "$1"

