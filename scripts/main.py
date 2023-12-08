from config import config_database,reset_database
import os 

def menu():
	print("Seja bem-vindo ao mini-jogo Skyrim")
	print("Selecione as opções: ")
	print("1 - Iniciar o jogo\n2 - Resetar o jogo\n3 - Sair\n:",end='')
	opcao = int(input())
	
	if opcao == 1:
		print("Jogando ...")
	elif opcao == 2:
		reset_database()
		print('Banco de dados resetado ..')
		menu()
	else:
		print("Até mais ..")
		exit(0)

config_database()
#os.system('clear')
menu()
