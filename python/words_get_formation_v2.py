import sys
import os

# Obter o nome do arquivo de entrada a partir dos argumentos da linha de comando
if len(sys.argv) != 2:
    print("Uso: python script.py arquivo_entrada")
    sys.exit(1)

arquivo_entrada = sys.argv[1]

# Obter o nome do arquivo de saída
nome_arquivo, extensao_arquivo = os.path.splitext(arquivo_entrada)
arquivo_saida = nome_arquivo + "_words.txt"

# Abrir arquivo de entrada para leitura
with open(arquivo_entrada, "r") as f:
    # Abrir arquivo de saída para escrita
    with open(arquivo_saida, "w") as g:
        # Variável para armazenar o número de tabulações da palavra anterior
        num_tabs_anterior = -1
        # Percorrer cada linha do arquivo de entrada
        for linha in f:
            # Separar a linha em palavras
            palavras = linha.split()
            # Contar o número de tabulações antes da primeira palavra na linha
            num_tabs = 0
            for char in linha:
                if char == "\t":
                    num_tabs += 1
                else:
                    break
            # Escrever a palavra e o número de tabulações no arquivo de saída
            for palavra in palavras:
                if num_tabs > 0 and num_tabs != num_tabs_anterior:
                    g.write(f"{num_tabs}\t{palavra}\n")
                # Armazenar o número de tabulações da palavra anterior
                num_tabs_anterior = num_tabs

# Fechar arquivos de entrada e saída
f.close()
g.close()
