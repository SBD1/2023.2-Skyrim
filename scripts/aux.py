from config import *
from classes.connection import Conexao
from os import system
from helper import *


def main(con: Conexao):
    resposta = 0

    print(" ________________________________________________________________________")
    print(" |                                                                       |")
    print(" |                         Bem-vindo(a) ao jogo:                         |")
    print(" |      !Herdeiros da Tempestade: Em busca de Aldrich Stormwalker!       |")
    print(" |                                                                       |")
    print(" |                                                                       |")
    print(" |                                                                       |")
    print(" | Um jogo baseado no universo de Skyrim criado pelos estudantes de SBD  |")
    print(" |_______________________________________________________________________|")
    print("\n")

    print("\n \n \nAperte Enter para continuar...")

    input()

    system("clear")

    print(" ________________________________________________________________________")
    print(" |                                                                       |")
    print(" |                    Bem-vindo(a) ao mundo Lumaria!                     |")
    print(" |      !Um lugar onde lobos tentarão te atacar e dragões te matar!      |")
    print(" |           mas que a aventura, com certeza, vai te consquistar!        |")
    print(" |                                                                       |")
    print(" |_______________________________________________________________________|")

    print("\n \n \nAperte Enter para continuar...")

    input()

    system("clear")

    print("         |        Faça um escolha jovem viajante:      |")
    print("         |*********************************************|")
    print("         |                                             |")
    print("         |1) Iniciar jogo                              |")
    print("         |2) Resetar jogo                              |")
    print("         |3) Sair                                      |")
    print("         |_____________________________________________|")

    resposta = int(input())

    if resposta == 1:
        system("clear")

        print("        |       Escolha quem você vai querer ser:     |")
        print("         |*********************************************|")
        print("         |                                             |")
        print("         |1) Thaliana                                  |")
        print("         |2) Valeriun                                  |")
        print("         |3) Tyranor                                   |")
        print("         |4) Lyra                                      |")
        print("         |5) Voltar                                    |")
        print("         |_____________________________________________|")
        print("         |     Caso você deseje ver as informações:    |")
        print("         |*********************************************|")
        print("         |6) Dados de Thaliana                         |")
        print("         |7) Dados de Valeriun                         |")
        print("         |8) Dados de Tyranor                          |")
        print("         |9) Dados de Lyra                             |")
        print("         |_____________________________________________|")

        resposta = int(input())
        introducao()

    elif resposta == 2:
        reset_database()
        print("Você resetou o jogo")
        main(con)

    elif resposta == 3:

        system("clear")
        print("   ____________________________________________________________________________")
        print("   |                                                                           |")
        print("   |                        Você saiu de Lumaria!                              |")
        print("   |            *Esperamos que tenha tido uma ótima aventura*                  |")
        print("   |___________________________________________________________________________|")

        exit(0)
