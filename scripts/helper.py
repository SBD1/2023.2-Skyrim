from os import system
from classes.connection import Conexao
from helper import *
from classes.play_character import *


def investigar_sala():
    system("clear")
    print("         |              Investigar a sala:             |")
    print("         |*********************************************|")
    print("         |                                             |")
    print("         |1) Verificar estante                         |")
    print("         |2) Verificar mesa                            |")
    print("         |3) Verificar a porta destroçada!             |")
    print("         |_____________________________________________|")


def introducao():
    escolha = 0
    tecla = ""

    input("\n \n \nAperte Enter para continuar...")

    system("clear")

    print(" ______________________________________________________________________________")
    print(" |                                                                             |")
    print(" |                Era mais um fim de tarde no vale de Whiterun                 |")
    print(" |    Após passar o dia caçando com seu melhor amigo, Ealdred Swiftblade,      |")
    print(" | Você retorna à sua casa, mas ela não é mais o refúgio seguro que conheceste |")
    print(" |   Móveis destroçados e manchas de sangue pintam um quadro aterrorizante.    |")
    print(" |                                                                             |")
    print(" |_____________________________________________________________________________|")
    print("\n")
    print("\n \n \nAperte Enter para continuar...")

    input()

    system("clear")

    print(" ______________________________________________________________________________")
    print(" |                                                                             |")
    print(" |                - Aldrich! Aldrich! Você está aí?!                           |")
    print(" |         Você grita enquanto o seu coração acelera cada vez mais!            |")
    print(" |                                                                             |")
    print(" |              Você olha em volta, mas nenhum sinal de Aldrich                |")
    print(" |_____________________________________________________________________________|")
    print("\n")
    print("\n \n \nAperte Enter para continuar...")

    input()

    system("clear")

    print(" ___________________________________________________________________________________")
    print(" |                                                                                  |")
    print(" |                      Aldrich é o seu irmão mais velho!                           |")
    print(" | Após o misterioso assassinato de seus pais, foi ele quem cuidou e protegeu você! |")
    print(" |__________________________________________________________________________________|")
    print("\n")
    print("\n \n \nAperte Enter para continuar...")

    input()

    system("clear")

    print(" ___________________________________________________________________________________")
    print(" |                                                                                  |")
    print(" |       - Ealdred Swiftblade: Precisamos descobrir o que aconteceu aqui!           |")
    print(" |__________________________________________________________________________________|")
    print("\n")
    print("\n \n \nAperte Enter para continuar...")

    input()

    investigar_sala()
    escolha = int(input("Escolha: "))

    if escolha == 1:
        system("clear")
        print(" ______________________________________________________________")
        print(" |     Você decide verificar a estante de livros quebrada.     |")
        print(" |  Entre os destroços, encontra uma carta rasgada e algumas   |")
        print(" |         pistas sobre o desaparecimento de Aldrich.          |")
        print(" |    Carta de Aldrich: 'Será que isso nos levará até ele?'    |")
        print(" |_____________________________________________________________|")

        investigar_sala()
        escolha = int(input("Escolha: "))

    elif escolha == 2:
        system("clear")
        print(" ______________________________________________________________")
        print(" |            Você decide verificar a mesa quebrada.           |")
        print(" |  Sob os destroços, encontra um livro antigo com o símbolo   |")
        print(" |           da família de lord Malachar Darkthorn             |")
        print(" |   Livro adicionado no seu inventário!                       |")
        print(" |_____________________________________________________________|")

        print("\n \n \nAperte Enter para continuar...")
        input()

        system("clear")

        print(" ___________________________________________________________________________________")
        print(" |                                                                                  |")
        print(" |       - Ealdred Swiftblade: Este é o símbolo do inimigo da sua família!          |")
        print(" |                                                                                  |")
        print(" |       - Ealdred Swiftblade: O que ele quer com Aldrich? Devemos tomar cuidado!   |")
        print(" |__________________________________________________________________________________|")
        print("\n")
        print("\n \n \nAperte Enter para continuar...")

        input()

    elif escolha == 3:
        system("clear")
        print(" ______________________________________________________________")
        print(" |        Você decide verificar a porta destroçada.            |")
        print(" |  A porta está completamente destruída, como se algo muito   |")
        print(" |              poderoso tivesse passado por ali.              |")
        print(" |_____________________________________________________________|")

        print("\n \n \nAperte Enter para continuar...")
        input()

    print(" ______________________________________________________________________________")
    print(" |                                                                             |")
    print(" |                - Ahrg! Eu vou encontrar lord Malachar Darkthorn             |")
    print(" |                     Vou confrontá-lo e fazer picadinhos dele!               |")
    print(" |_____________________________________________________________________________|")
    print("\n")
    print("\n \n \nAperte Enter para continuar...")

    input()

    system("clear")

    print(" ______________________________________________________________________________________")
    print(" |                                                                               |")
    print(" |         - Ealdred Swiftblade: Uhm, Lord Malachar Darkthorn é poderoso!        |")
    print(" |                                                                               |")
    print(" | - Ealdred Swiftblade: Você deve obter uma armadura para se proteger antes!!   |")
    print(" |_______________________________________________________________________________|")
    print("\n")
    print("\n \n \nAperte Enter para continuar...")

    print(" ______________________________________________________________________________")
    print(" |                                                                             |")
    print(" |                  Missão 1: Comprar uma armadura em uma loja!                 |")
    print(" |                     Vou confrontá-lo e fazer picadinhos dele!               |")
    print(" |_____________________________________________________________________________|")
    print("\n \n \nAperte Enter para continuar...")


def info(type_info=str, message=str):
    print("[{}] - {}".format('INFO' if type_info == 'info' else 'ERROR', message))


def obter_salas(con: Conexao) -> list:
    con = con.select('SALA', ['*'])


def play_menu(player: PlayCharacter):
    print("1 - Mudar de sala")
    print("X - Qualquer outro número para sair .")
    print(": ", end='')
    n = int(input())
    if n == 1:
        pass
    else:
        exit(0)


def select_player(con: Conexao) -> PlayCharacter:
    fields = 'id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario'
    players_list = con.select('PLAY_CHARACTER', fields.split(','))
    info('INFO', 'Selecione os jogadores:')
    c = 1
    for row in players_list:
        nome = row[1]
        print('{} - {}'.format(c, nome))
        c += 1
    print(": ", end='')
    n = int(input())

    if n < 1 or n >= c:
        info("e", 'Opção errada..')
        exit(-1)

    player = players_list[n-1]
    id_play_character = player[0]
    nome = player[1]
    nivel = player[2]
    xp = player[3]
    vida_atual = player[4]
    mana_atual = player[5]
    stamina_atual = player[6]
    vida_maxima = player[7]
    mana_max = player[8]
    stamina_max = player[9]
    id_sala = player[10]
    id_inventario = player[11]

    return PlayCharacter(con, id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario)
