from classes.connection import Conexao
from helper import *
from classes.play_character import *

def info(type_info= str, message=str):
	print("[{}] - {}".format('INFO' if type_info == 'info' else 'ERROR',message))

def select_player(con: Conexao):
	fields = 'id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario'
	players_list = con.select('PLAY_CHARACTER',fields.split(','))
	info('INFO','Selecione os jogadores:')
	c = 1
	for row in players_list:
		nome = row[1]
		print('{} - {}'.format(c,nome))
		c += 1
	print(": ",end='')
	n = int(input())

	if n < 1 or n >= c:
		info("e",'Opção errada..')
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
	
	player = PlayCharacter(con,id_play_character,nome,nivel,xp,vida_atual,mana_atual,stamina_atual,vida_maxima,mana_max,stamina_max,id_sala,id_inventario)
	player.show_player()
	return player
