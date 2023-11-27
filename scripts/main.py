from config import config_database 

def menu():
	print("Seja bem-vindo ao jogo Skyrim")
	print("Selecione as opções: ")
	print("1 - Iniciar o jogo\n2 - Sair\n:",end='')
	opcao = int(input())
	
	if opcao == 1:
		print("Jogando ...")
	else:
		print("Até mais ..")
		exit(0)

config_database()		
#menu()
