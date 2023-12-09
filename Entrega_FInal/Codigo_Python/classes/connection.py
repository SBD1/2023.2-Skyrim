class Conexao:
    def __init__(self,cursor) -> None:
        self.cursor = cursor

    def getCursor(self)->None:
        return self.cursor
    
    def setCursor(self,cursor)->None:
        self.cursor = cursor

    def insert(self,table : str,fields : list, params : list):
        n = len(fields) - 1
        q = 'INSERT INTO {} ('.format(table)
        for a in range(n):
            q += fields[a] + ', '
        q += fields[-1] + ') VALUES ('
        q += '%s,' * n
        q += '%s);'
        self.cursor.execute(q)

    
    def select(self, table: str,fields : list,whereCondition : dict = None ):
        q = 'SELECT '
        n = len(fields)
        if n > 1:
            for a in range(n-1):
                q += fields[a] + ', '
            q += fields[-1] 
        else:
            q += ' '+fields[0]+' '
        q += ' FROM {}'.format(table)
        if whereCondition :
            key = list(whereCondition.keys())[0]
            value = whereCondition[key]
            q += ' WHERE {}=\'{}\''.format(key,value)
        q += ';'
        self.cursor.execute(q)
        return self.cursor.fetchall()
    
    def inner_join(self,from_table : str, to_table : str,id_from: str, id_to : str):
        q = 'SELECT * FROM {} INNER JOIN {} ON {}.{}={}.{};'.format(from_table,to_table,from_table,id_from,to_table,id_to)
        self.cursor.execute(q)
    
    def delete(self,table: str, whereCondition: dict):
        key = list(whereCondition.keys())[0]
        value = whereCondition[key]
        q = 'DELETE FROM {} WHERE {}={};'.format(table,key,value)
        self.cursor.execute(q)
        
    def close_connection(self):
        self.getCursor().close()