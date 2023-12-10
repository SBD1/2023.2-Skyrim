from connection import Conexao

d = ''
c = Conexao(d)
# c.insert('REGIAO',['1','2','3','4'],[5,6,7,8])
# c.select('REGIAO',['1','2','3','4'])
# c.select('REGIAO',['1','2'])
# c.select('REGIAO',['ass'])
# c.select('REGIAO',['*'])
# c.select('REGIAO',['*'],{'id':3})
# c.inner_join('pessoa','jogo','id_pessoa','id_jogo')
c.select('SALA',)
