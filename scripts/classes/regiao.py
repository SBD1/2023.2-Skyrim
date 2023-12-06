class Regiao:
    table = 'regiao'
    def __init__(self,cursor,id_regiao : str,nome  : str) -> None:
        cursor.execute('INSERT INTO {}(id_regiao)')