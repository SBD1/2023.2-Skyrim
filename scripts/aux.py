from config import *
from classes.connection import Conexao
from os import system
from helper import *


def missao(con: Conexao, player: PlayCharacter) -> bool:
    print(" ______________________________________________________________________________")
    print(" |                                                                             |")
    print(" |           Missão 1: Selecione o tipo de armadura que deseja                 |")
    vestimentas = con.select('VESTIMENTA', ['*'])
    count = 1
    l = []
    for vestimenta in vestimentas:
        id_vestimenta, nome, valor, peso, tipo_vestimenta, resistencia, parte_corpo = vestimenta
        l.append(nome)
        print(f'\t{count} - {nome}')
        count += 1
    print(" |_____________________________________________________________________________|")
    print("\n \n \n:")
    resposta = int(input())

    if l[resposta - 1].strip() == 'Armadura Prateada':
        con.concluir_missao('MIS0001', player.get_id_play_character())
        return True
    return False


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
        fields = 'id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario'
        database_players = con.select('PLAY_CHARACTER', fields.split(','))

        players = []
        print(database_players)

        for player in database_players:
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

            players.append(PlayCharacter(con, id_play_character, nome, nivel, xp, vida_atual,
                           mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario))

        count = 1
        system("clear")

        print("        |       Escolha quem você vai querer ser:     |")
        print("         |*********************************************|")
        print("         |                                             |")
        for player in players:
            print(
                f"         |{count}) {player.get_nome()}                      ")
            count += 1
        print("         |5) Voltar                                    |")
        print("         |_____________________________________________|")
        print("         |     Caso você deseje ver as informações:    |")
        print("         |*********************************************|")
        count += 1
        for player in players:
            print(
                f"         |{count}) {player.get_nome()}                      |")
            count += 1

        print("         |_____________________________________________|")

        resposta = int(input())
        num_players = len(players)

        if resposta > num_players and resposta > (num_players + 5) or resposta < 0:
            info('e', 'Personagem inválido')
            exit(0)

        if resposta < num_players:
            player = players[resposta-1]
            introducao(player)

            con.insert('CUMPRE_MISSAO',
                       'id_missao,id_play_character'.split(','), ['MIS0001', player.get_id_play_character()])
            if missao(con, player):
                print(
                    " ______________________________________________________________________________")
                print(
                    " |                                                                             |")
                print(
                    " |                  Missão 1: COMPLETA!                                        |")
                print(
                    " |_____________________________________________________________________________|")
            else:
                print(
                    " ______________________________________________________________________________")
                print(
                    " |                                                                             |")
                print(
                    " |                     FALHOU A MISSÃO!                                        |")
                print(
                    " |_____________________________________________________________________________|")
            print("\n \n \nAperte Enter para voltar ao menu...")
            input()
            system('clear')
            main(con)
        elif resposta <= (num_players + 5):
            player = players[resposta-1-5]
            player.show_player()
            info('info', 'Pressione qualquer tecla para voltar ao menu principal')
            input()
            main(con)

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
