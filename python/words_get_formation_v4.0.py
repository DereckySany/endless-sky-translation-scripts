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
        # Conjunto para armazenar linhas já escritas no arquivo de saída
        linhas_gravadas = set()
        # Percorrer cada linha do arquivo de entrada
        for linha in f:
            # Se a linha começar com aspas duplas ou acento grave, escrever apenas o símbolo
            if linha.startswith('"') or linha.startswith('`'):
                g.write(linha[0] + "\n")
                continue
            # Separar a linha em palavras
            palavras = linha.split()
            # Contar o número de tabulações antes da primeira palavra na linha
            num_tabs = 0
            for char in linha:
                if char == "\t" or char == "#":
                    num_tabs += 1
                else:
                    break
            # Escrever a palavra e o número de tabulações no arquivo de saída, se ela ainda não tiver sido gravada
            for palavra in palavras:
                if num_tabs >= 0 and num_tabs != num_tabs_anterior:
                    if palavra.startswith('"') or palavra.startswith('`'):
                        linha_saida = f"{num_tabs}\t{palavra[0]}\n"
                    else:
                        if palavra.startswith('#'):
                            linha_saida = f"0\t{palavra}\n"
                        else:
                            linha_saida = f"{num_tabs}\t{palavra}\n"
                    if linha_saida not in linhas_gravadas:
                        g.write(linha_saida)
                        linhas_gravadas.add(linha_saida)
                    # g.write(linha_saida)
                # Armazenar o número de tabulações da palavra anterior
                num_tabs_anterior = num_tabs

# Fechar arquivos de entrada e saída
f.close()
g.close()
