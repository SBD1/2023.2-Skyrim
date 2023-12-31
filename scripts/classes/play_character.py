from os import  system
from classes.connection import Conexao
class PlayCharacter:
    def __init__(self,
                 conexao : Conexao,
                 id_play_character: str, nome: str, nivel: str, xp: int, 
                 vida_atual: int, mana_atual: int, stamina_atual: int, 
                 vida_maxima: int, mana_max: int, stamina_max: int, 
                 id_sala: str, id_inventario: str) -> None:
        self._conexao = conexao
        self._id_play_character = id_play_character
        self._nome = nome
        self._nivel = nivel
        self._xp = xp
        self._vida_atual = vida_atual
        self._mana_atual = mana_atual
        self._stamina_atual = stamina_atual
        self._vida_maxima = vida_maxima
        self._mana_max = mana_max
        self._stamina_max = stamina_max
        self._id_sala = id_sala
        self._id_inventario = id_inventario

    def get_id_play_character(self) -> str:
        return self._id_play_character
    
    def get_connection(self) -> Conexao:
        return self._conexao

    def get_nome(self) -> str:
        return self._nome

    def get_nivel(self) -> str:
        return self._nivel

    def get_xp(self) -> int:
        return self._xp

    def get_vida_atual(self) -> int:
        return self._vida_atual

    def get_mana_atual(self) -> int:
        return self._mana_atual

    def get_stamina_atual(self) -> int:
        return self._stamina_atual

    def get_vida_maxima(self) -> int:
        return self._vida_maxima

    def get_mana_max(self) -> int:
        return self._mana_max

    def get_stamina_max(self) -> int:
        return self._stamina_max

    def get_id_sala(self) -> str:
        return self._id_sala

    def get_id_inventario(self) -> str:
        return self._id_inventario

    def set_id_play_character(self, id_play_character: str) -> None:
        self._id_play_character = id_play_character

    def set_nome(self, nome: str) -> None:
        self._nome = nome

    def set_nivel(self, nivel: str) -> None:
        self._nivel = nivel

    def set_xp(self, xp: int) -> None:
        self._xp = xp

    def set_vida_atual(self, vida_atual: int) -> None:
        self._vida_atual = vida_atual

    def set_mana_atual(self, mana_atual: int) -> None:
        self._mana_atual = mana_atual

    def set_stamina_atual(self, stamina_atual: int) -> None:
        self._stamina_atual = stamina_atual

    def set_vida_maxima(self, vida_maxima: int) -> None:
        self._vida_maxima = vida_maxima

    def set_mana_max(self, mana_max: int) -> None:
        self._mana_max = mana_max

    def set_stamina_max(self, stamina_max: int) -> None:
        self._stamina_max = stamina_max

    def set_id_sala(self, id_sala: str) -> None:
        self._id_sala = id_sala

    def set_id_inventario(self, id_inventario: str) -> None:
        self._id_inventario = id_inventario
    
    def mostrar_sala(self):
        return self.get_connection().select('SALA',['nome_sala','id_local'],{'id_sala' : self.get_id_sala()})[0]
    
    def mostrar_local(self,id_local : str):
        return self.get_connection().select('LUGAR',['nome_local','id_regiao'],{'id_local' : id_local})
    
    def mostrar_regiao(self,id_regiao : str):
        return self.get_connection().select('REGIAO',['nome'],{'id_regiao' : id_regiao})[0][0]
    
    def mostrar_inventario(self):
        return self.get_connection().select('INVENTARIO',['peso_maximo','carteira'],{'id_inventario' : self.get_id_inventario()})[0]

    def show_player(self) -> None:
        system('clear')
        print(f"Informações sobre o Player Character:")
        print(f"================================")
        print(f"ID: {self._id_play_character}")
        print(f"Nome: {self._nome}")
        print(f"Nível: {self._nivel}")
        print(f"XP: {self._xp}")
        print(f"Vida Atual/Maxima: {self._vida_atual}/{self._vida_maxima}")
        print(f"Mana Atual/Max: {self._mana_atual}/{self._mana_max}")
        print(f"Stamina Atual/Max: {self._stamina_atual}/{self._stamina_max}",end='\n\n')
        print(f"Informações sobre a localização:")
        print(f"================================")
        sala = self.mostrar_sala()
        print(f"Nome da Sala: {sala[0]}")
        local = self.mostrar_local(sala[1])[0]
        print(f"Nome do local: {local[0]}")
        print(f"Nome da região: {self.mostrar_regiao(local[1])}")
        print(f"================================",end='\n\n')
        print(f"Informações sobre o inventário:")
        print(f"================================")
        print(f"Peso máximo: {self.mostrar_inventario()[0]}")
        print(f"Carteira: {self.mostrar_inventario()[1]}")
        print(f"================================")

    
