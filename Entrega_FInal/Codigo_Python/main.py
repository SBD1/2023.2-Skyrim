from config import config_database,reset_database
from helper import select_player
from classes.connection import Conexao 
import os 

def menu(con: Conexao):
	print("Seja bem-vindo ao mini-jogo Skyrim")
	print("Selecione as opções: ")
	print("1 - Iniciar o jogo\n2 - Resetar o jogo\n3 - Sair\n:",end='')
	opcao = int(input())
	
	if opcao == 1:
		os.system('clear')
		player = select_player(con)
		player.show_player()
		

	elif opcao == 2:
		reset_database()
		print('Banco de dados resetado ..')
		menu(con)
	else:
		print("Até mais ..")
		exit(0)

cursor = config_database()
conexao = Conexao(cursor)
os.system('clear')
menu(conexao)


# - Cadastrar,Ver, Eliminar, personagem
# - Andar pelo mapa ( salas ou lugares)
# - A cada sala tem um inimigo aleatório
# - Quando se deparar com o inimigo, e lutar vai subtrair a vida
