import os
import helper
import psycopg2 as db
from dotenv import load_dotenv

def config_database():
	# Carrega o arquivo .env
	load_dotenv()
	db_host = os.getenv('DB_HOST')
	db_user = os.getenv('DB_USER')
	db_pass = os.getenv('DB_PASS')
	db_name = os.getenv('DB_NAME')
	
	try:
		helper.info('info','Conectando ao banco de dados ...') 
		ptr = db.connect(dbname=db_name,user=db_user,password=db_pass,host=db_host)
		helper.info('info','Banco de dados conectado ...') 
		return ptr.cursor()
	except :
		helper.info('e','Erro na conexão com o banco de dados. Verifique as configurações e tente novamente .')
		return None
	
