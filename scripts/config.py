import os
import helper
import psycopg2 as db
from dotenv import load_dotenv

def connect_db():
	load_dotenv()
	db_host = os.getenv('DB_HOST')
	db_user = os.getenv('DB_USER')
	db_pass = os.getenv('DB_PASS')
	db_name = os.getenv('DB_NAME')

	try:
		helper.info('info','Conectando ao banco de dados ...') 
		cursor = db.connect(dbname=db_name,user=db_user,password=db_pass,host=db_host).cursor()
		helper.info('info','Banco de dados conectado ...')
		return cursor
	
	except db.Error as e:
		helper.info('e','Erro na conexão com o banco de dados. Verifique as configurações e tente novamente .')
		helper.info('e',e)
		exit(-1)

def config_database():
	try:
		cursor = connect_db()
		cursor.execute("SELECT EXISTS (SELECT FROM information_schema.tables WHERE  table_schema = 'public' AND table_name = 'play_character');")
		if cursor.fetchone()[0] == False:
			try:
				helper.info('info','Executar as migrations ...')
				sql = open('../Terceira Entrega/Atualizacao/CREATE_TABLE/Codigo_completo.sql').read()
				cursor.execute(sql)
				helper.info('info','Executar os seeds ...')
				sql = open('../Terceira Entrega/Atualizacao/INSERT_TABLE/seeds.sql').read()
				cursor.execute(sql)
				return cursor
		
			except FileNotFoundError as e:
				helper.info('e',e)
				exit(e.errno)
	except db.Error as e:
		helper.info('e','Erro na conexão com o banco de dados. Verifique as configurações e tente novamente .')
		helper.info('e',e)
		exit(-1)

def reset_database():
	load_dotenv()
	db_host = os.getenv('DB_HOST')
	db_user = os.getenv('DB_USER')
	db_pass = os.getenv('DB_PASS')
	db_name = os.getenv('DB_NAME')
	
	try:
		helper.info('info','Conectando ao banco de dados ...') 
		cursor = db.connect(dbname=db_name,user=db_user,password=db_pass,host=db_host).cursor()
		helper.info('info','Banco de dados conectado ...')
		
		try:
			helper.info('info','Executar as migrations ...')
			sql = open('../Terceira Entrega/Atualizacao/CREATE_TABLE/Codigo_completo.sql').read()
			cursor.execute(sql)
			helper.info('info','Executar os seeds ...')
			sql = open('../Terceira Entrega/Atualizacao/INSERT_TABLE/seeds.sql').read()
			cursor.execute(sql)
			return cursor
		
		except FileNotFoundError as e:
			helper.info('e',e)
			exit(e.errno)
	
	except db.Error as e:
		helper.info('e','Erro na conexão com o banco de dados. Verifique as configurações e tente novamente .')
		helper.info('e',e)
		exit(-1)
