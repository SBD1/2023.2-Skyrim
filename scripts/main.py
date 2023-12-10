from os import system
from config import config_database, reset_database
from helper import *
from classes.connection import Conexao
from aux import main

if __name__ == "__main__":
    cursor = config_database()
    conexao = Conexao(cursor)
    system('clear')
    main(conexao)
