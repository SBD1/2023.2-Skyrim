class PlayCharacter:
    def __init__(self,
                 id_play_character: str, nome: str, nivel: str, xp: int, 
                 vida_atual: int, mana_atual: int, stamina_atual: int, 
                 vida_maxima: int, mana_max: int, stamina_max: int, 
                 id_sala: str, id_inventario: str) -> None:
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

    # Getters
    def get_id_play_character(self) -> str:
        return self._id_play_character

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

    # Setters
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

    def showPlayer(self) -> None:
        print(f"ID: {self._id_play_character}")
        print(f"Nome: {self._nome}")
        print(f"Nível: {self._nivel}")
        print(f"XP: {self._xp}")
        print(f"Vida Atual/Maxima: {self._vida_atual}/{self._vida_maxima}")
        print(f"Mana Atual/Max: {self._mana_atual}/{self._mana_max}")
        print(f"Stamina Atual/Max: {self._stamina_atual}/{self._stamina_max}")
        print(f"ID Sala: {self._id_sala}")
        print(f"ID Inventario: {self._id_inventario}")
