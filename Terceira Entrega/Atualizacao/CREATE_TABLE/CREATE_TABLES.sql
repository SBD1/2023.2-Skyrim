DROP TABLE APRENDER_ENCANTAMENTO;
DROP TABLE PROPORCIONA_ENCANTAMENTO;
DROP TABLE GEMA;
DROP TABLE MISSAO_OBTER_ITEM;
DROP TABLE ENCANTAMENTO_ARMA;
DROP TABLE ARMA;
DROP TABLE CONSOME;
DROP TABLE CONSUMIVEL;
DROP TABLE ENCANTAMENTO_VESTIMENTA;
DROP TABLE VESTIMENTA;
DROP TABLE TIPO_ENCANTAMENTO;
DROP TABLE INSTANCIA_ITEM;
DROP TABLE TIPO_ITEM;
DROP TABLE  MISSAO_MATAR_NPC;
DROP TABLE DIALOGOS;
DROP TABLE CUMPRE_MISSAO;
DROP TABLE MISSAO_NIVEL;
DROP TABLE TIPO_MISSAO;
DROP TABLE ESTA_MORTO;
DROP TABLE INSTANCIA_NPC;
DROP TABLE NOT_PLAY_CHARACTER;
DROP TABLE PLAY_CHARACTER;
DROP TABLE HOSTILIDADE;
DROP TABLE GOLPES_BESTA;
DROP TABLE GOLPES;
DROP TABLE BESTA;
DROP TABLE MAGIA_HUMANOIDE;
DROP TABLE MAGIA;
DROP TABLE HUMANOIDE;
DROP TABLE ESPECIE;
DROP TABLE HABILIDADE_ESPECIE;
DROP TABLE FORMA;
DROP TABLE NIVEL;
DROP TABLE TIPO_PERSONAGEM_HISTORIA;
DROP TABLE INVENTARIO;
DROP TABLE VIAGEM_SALAS;
DROP TABLE SALA;
DROP TABLE LOCAL;
DROP TABLE REGIAO;

CREATE TABLE REGIAO(
  id_regiao CHAR(7) PRIMARY KEY,
  nome CHAR(30) UNIQUE NOT NULL,
  CONSTRAINT verificar_id_regiao
    CHECK (id_regiao LIKE 'REG%'
  		AND CAST(SUBSTRING(id_regiao, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
    	AND LENGTH(id_regiao) = 7 )
);

CREATE TABLE LOCAL(
  id_local CHAR(7) PRIMARY KEY,
  nome_local CHAR(30) UNIQUE NOT NULL,
  id_regiao CHAR(7),
  CONSTRAINT verificar_id_local
  	CHECK( id_local LIKE 'LOC%'
          AND CAST(SUBSTRING(id_local, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
          AND LENGTH(id_local) = 7),
  CONSTRAINT fk_id_local
  	FOREIGN KEY (id_regiao) REFERENCES REGIAO(id_regiao)
  	ON DELETE RESTRICT
  	ON UPDATE CASCADE
  );
  
  
CREATE TABLE SALA(
  id_sala CHAR(7) PRIMARY KEY,
  nome_sala CHAR(40) NOT NULL,
  id_local CHAR(7),
  CONSTRAINT verificar_id_sala
  	CHECK( id_sala LIKE 'ROOM%'
          AND CAST(SUBSTRING(id_sala, 5,3) AS INTEGER) BETWEEN 000 AND 999
          AND LENGTH(id_sala) = 7),
  CONSTRAINT fk_id_sala
  	FOREIGN KEY (id_local) REFERENCES LOCAL(id_local)
  	ON DELETE RESTRICT
  	ON UPDATE CASCADE
  );
  
 CREATE TABLE VIAGEM_SALAS(
   id_viagem CHAR(7) PRIMARY KEY,
   sala_origem CHAR(7) ,
   sala_destino CHAR(7),
   CHECK( id_viagem LIKE 'V%'
          AND CAST(SUBSTRING(id_viagem, 2,6) AS INTEGER) BETWEEN 000000 AND 999999
          AND LENGTH(id_viagem) = 7),
   CONSTRAINT fk_sala_origem
    FOREIGN KEY (sala_origem) REFERENCES SALA(id_sala)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
   CONSTRAINT fk_sala_destino
    FOREIGN KEY (sala_destino) REFERENCES SALA(id_sala)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE INVENTARIO (
    id_inventario CHAR(7) PRIMARY KEY,
    peso_maximo FLOAT,
    carteira INTEGER,
    eh_loja BOOLEAN,
   	CHECK( id_inventario LIKE 'INV%'
       AND CAST(SUBSTRING(id_inventario, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_inventario) = 7)
);

CREATE TABLE TIPO_PERSONAGEM_HISTORIA (
   id_personagem CHAR(8) PRIMARY KEY,
   jogavel BOOLEAN,
   CONSTRAINT verificar_id_personagem
   CHECK( id_personagem LIKE 'CHAR%'
       AND CAST(SUBSTRING(id_personagem, 5,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_personagem) = 8)
);


CREATE TABLE NIVEL(
	id_nivel CHAR(3) PRIMARY KEY,
	xp_minimo INTEGER,
	XP_MAXIMO INTEGER
	--CONSTRAINT id_nivel
	--CHECK( id_nivel LIKE 'N'
      -- AND CAST(SUBSTRING(id_nivel, 2,2) AS INTEGER) BETWEEN 00 AND 99
       --AND LENGTH(id_nivel) = 3)
);

CREATE TABLE FORMA (
	id_personagem CHAR(8) PRIMARY KEY,
	forma CHAR(10) NOT NULL CHECK (forma IN ('Humanoide', 'Besta')),
	CONSTRAINT fk_forma_personagem
    FOREIGN KEY (id_personagem) REFERENCES TIPO_PERSONAGEM_HISTORIA(id_personagem)
    ON DELETE RESTRICT
    ON UPDATE CASCADE

);

CREATE TABLE HABILIDADE_ESPECIE (
   id_habilidade CHAR(7) PRIMARY KEY,
   nome CHAR(20) UNIQUE NOT NULL,
   mod_vida INTEGER CHECK (mod_vida >= 0 AND mod_vida <= 100),
   mod_stamina INTEGER CHECK (mod_stamina >= 0 AND mod_stamina <= 100),
   mod_mana INTEGER CHECK (mod_mana >= 0 AND mod_mana <= 100),
   mod_defesa_frio INTEGER CHECK (mod_defesa_frio >= 0 AND mod_defesa_frio <= 100),
   mod_defesa_fogo INTEGER CHECK (mod_defesa_fogo >= 0 AND mod_defesa_fogo <= 100),
   mod_defesa_eletr INTEGER CHECK (mod_defesa_eletr >= 0 AND mod_defesa_eletr <= 100),
   CONSTRAINT verificar_id_habilidade
  	CHECK( id_habilidade LIKE 'HAB%'
       AND CAST(SUBSTRING(id_habilidade, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_habilidade) = 7)
);

CREATE TABLE ESPECIE (
   id_especie CHAR(7) PRIMARY KEY,
   nome CHAR(20) UNIQUE NOT NULL,
   id_habilidade CHAR(7),
   CONSTRAINT verificar_id_especie
    CHECK ( id_especie LIKE 'ESPEC%'
      AND CAST(SUBSTRING(id_especie, 6,2) AS INTEGER) BETWEEN 00 AND 99
      AND LENGTH(id_especie) = 7),
   CONSTRAINT fk_id_habilidade
     FOREIGN KEY (id_habilidade) REFERENCES HABILIDADE_ESPECIE(id_habilidade)
  	 ON DELETE RESTRICT
  	 ON UPDATE CASCADE 
);

CREATE TABLE HUMANOIDE (
    id_humanoide CHAR(8) PRIMARY KEY,
    eqp_bota BOOLEAN,
    eqp_luva BOOLEAN,
    eqp_calça BOOLEAN,
    eqp_colar BOOLEAN,
    eqp_peitoral BOOLEAN,
    eqp_anel BOOLEAN,
    eqp_cabeça BOOLEAN,
    mao_esq BOOLEAN,
    mao_dir BOOLEAN,
    id_especie CHAR(7),
	vida_maxima INTEGER CHECK (vida_maxima >= 0 AND vida_maxima <= 100),
  	mana_max INTEGER CHECK (mana_max >= 0 AND mana_max <= 100),
  	stamina_max INTEGER CHECK (stamina_max >= 0 AND stamina_max <= 100),
    CONSTRAINT fk_id_humanoide
        FOREIGN KEY (id_humanoide) REFERENCES FORMA(id_personagem)
  		ON DELETE RESTRICT
  	    ON UPDATE CASCADE, 
    CONSTRAINT fk_id_especie
        FOREIGN KEY (id_especie) REFERENCES ESPECIE(id_especie)
        ON DELETE RESTRICT
  	 	ON UPDATE CASCADE 
);

CREATE TABLE MAGIA (
    id_magia CHAR(7) PRIMARY KEY,
  	nome CHAR(20) UNIQUE NOT NULL,
    elemento CHAR(20) NOT NULL,
    dano_inicial INTEGER CHECK (dano_inicial >= 0 AND dano_inicial <= 100),
    custo_mana INTEGER CHECK (custo_mana >= 0 AND custo_mana <= 100),
  	CONSTRAINT verificar_id_habilidade
  	CHECK( id_magia LIKE 'MAG%'
       AND CAST(SUBSTRING(id_magia, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_magia) = 7)
	
);


CREATE TABLE MAGIA_HUMANOIDE (
    id_humanoide CHAR(8),
    id_magia CHAR(7),
	nivel INTEGER CHECK (NIVEL >= 0 AND nivel <= 100),
	dano INTEGER CHECK (dano >= 0 AND dano <= 100),
    PRIMARY KEY (id_humanoide, id_magia),
    FOREIGN KEY (id_humanoide) REFERENCES HUMANOIDE (id_humanoide)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_magia) REFERENCES MAGIA (id_magia)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


CREATE TABLE BESTA (
    id_besta CHAR(8) PRIMARY KEY,
    mod_defesa_frio INTEGER,
    mod_defesa_fogo INTEGER,
    mod_defesa_raio INTEGER,
    FOREIGN KEY (id_besta) REFERENCES FORMA(id_personagem)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE GOLPES (
    id_golpe CHAR(7) PRIMARY KEY,
    nome CHAR(20) NOT NULL,
    dano INTEGER CHECK (dano BETWEEN 0 AND 100),
    elemento INTEGER CHECK (elemento BETWEEN 0 AND 100),
    CHECK( id_golpe LIKE 'STRO%'
       AND CAST(SUBSTRING(id_golpe, 5,3) AS INTEGER) BETWEEN 000 AND 999
       AND LENGTH(id_golpe) = 7)
);


CREATE TABLE GOLPES_BESTA (
    id_golpe CHAR(7),
    id_besta CHAR(8),
    PRIMARY KEY (id_golpe, id_besta),
    FOREIGN KEY (id_golpe) REFERENCES GOLPES (id_golpe)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_besta) REFERENCES BESTA (id_besta)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE HOSTILIDADE (
    id_personagem1 CHAR(8),
    id_personagem2 CHAR(8),
    Hostil BOOLEAN,
    PRIMARY KEY (id_personagem1, id_personagem2),
    FOREIGN KEY (id_personagem1) REFERENCES TIPO_PERSONAGEM_HISTORIA (id_personagem)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_personagem2) REFERENCES TIPO_PERSONAGEM_HISTORIA (id_personagem)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


CREATE TABLE PLAY_CHARACTER (
    id_play_character CHAR(8) PRIMARY KEY,
    nome CHAR(20) UNIQUE NOT NULL,
    nivel CHAR(3),
    xp INTEGER CHECK (xp >= 0 AND xp <= 100),
    vida_atual INTEGER CHECK (vida_atual >= 0 AND vida_atual <= 100),
    mana_atual INTEGER CHECK (mana_atual >= 0 AND mana_atual <= 100),
    stamina_atual INTEGER CHECK (stamina_atual >= 0 AND stamina_atual <= 100),
	vida_maxima INTEGER CHECK (vida_maxima >= 0 AND vida_maxima <= 100),
  	mana_max INTEGER CHECK (mana_max >= 0 AND mana_max <= 100),
  	stamina_max INTEGER CHECK (stamina_max >= 0 AND stamina_max <= 100),
    id_sala CHAR(7),
	id_inventario CHAR(7) NOT NULL,
    CONSTRAINT fk_id_play_character
        FOREIGN KEY (id_play_character) REFERENCES TIPO_PERSONAGEM_HISTORIA(id_personagem)
  		ON DELETE RESTRICT
  	 	ON UPDATE CASCADE,
	CONSTRAINT fk_nivel
        FOREIGN KEY (nivel) REFERENCES NIVEL(id_nivel)
  		ON DELETE RESTRICT
  	 	ON UPDATE CASCADE,
    CONSTRAINT fk_id_sala
        FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
  		ON DELETE RESTRICT
  	 	ON UPDATE CASCADE,
	CONSTRAINT fk_id_inventario_pc
  		FOREIGN KEY (id_inventario) REFERENCES INVENTARIO(id_inventario)
  		ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE NOT_PLAY_CHARACTER (
	id_npc CHAR(8) PRIMARY KEY,
	nome CHAR(20) UNIQUE NOT NULL,
	nivel FLOAT CHECK (nivel BETWEEN 1 AND 30),
	xp INTEGER CHECK (xp BETWEEN 0 AND 100),
	vida_maxima FLOAT CHECK (vida_maxima >= 0 AND vida_maxima <= 100),
  	mana_max INTEGER CHECK (mana_max >= 0 AND mana_max <= 100),
  	stamina_max INTEGER CHECK (stamina_max >= 0 AND stamina_max <= 100),
	CONSTRAINT fk_id_npc
    	FOREIGN KEY (id_npc) REFERENCES TIPO_PERSONAGEM_HISTORIA (id_personagem)
		ON DELETE RESTRICT
    	ON UPDATE CASCADE
);

CREATE TABLE INSTANCIA_NPC (
    id_instancia_npc CHAR(8),
    id_npc CHAR(8),
	nivel FLOAT CHECK (nivel BETWEEN 1 AND 30),
    vida_atual FLOAT CHECK (vida_atual BETWEEN 0 AND 100),
    mana_atual INTEGER CHECK (mana_atual BETWEEN 0 AND 100),
    stamina_atual INTEGER CHECK (stamina_atual BETWEEN 0 AND 100),
    id_sala CHAR(7),
	id_inventario CHAR(7),
	PRIMARY KEY (id_instancia_npc),
    CONSTRAINT fk_id_npc 
  		FOREIGN KEY (id_npc) REFERENCES NOT_PLAY_CHARACTER(id_npc)
  		ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_id_sala 
  		FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
  		ON DELETE RESTRICT
        ON UPDATE CASCADE,
	CONSTRAINT fk_id_inventario
  		FOREIGN KEY (id_inventario) REFERENCES INVENTARIO(id_inventario)
  		ON DELETE RESTRICT
        ON UPDATE CASCADE,
   CONSTRAINT verificar_id_instancia_npc
   CHECK( id_instancia_npc LIKE 'INPC%'
       AND CAST(SUBSTRING(id_instancia_npc, 5,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_instancia_npc) = 8)
);

CREATE TABLE ESTA_MORTO (
    id_play_character CHAR(8),
    id_instancia_npc CHAR(8),
    PRIMARY KEY (id_play_character, id_instancia_npc),
    FOREIGN KEY (id_play_character) REFERENCES PLAY_CHARACTER (id_play_character)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_instancia_npc) REFERENCES INSTANCIA_NPC(id_instancia_npc)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE TIPO_MISSAO (
    id_missao CHAR(7) PRIMARY KEY,
    tipo_objetivo CHAR(40),
    obrigatoria BOOLEAN
 	CHECK( id_missao LIKE 'MIS%'
       AND CAST(SUBSTRING(id_missao, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_missao) = 7)
);

CREATE TABLE MISSAO_NIVEL (
    id_missao CHAR(7),
    id_nivel CHAR(7),
    status BOOLEAN,
    PRIMARY KEY (id_missao, id_nivel),
    FOREIGN KEY (id_missao) REFERENCES TIPO_MISSAO (id_missao)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_nivel) REFERENCES NIVEL(id_nivel)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


CREATE TABLE CUMPRE_MISSAO (
    id_missao CHAR(7),
    id_play_character CHAR(8),
    status BOOLEAN,
    PRIMARY KEY (id_missao, id_play_character),
    FOREIGN KEY (id_missao) REFERENCES TIPO_MISSAO (id_missao)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_play_character) REFERENCES PLAY_CHARACTER (id_play_character)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE DIALOGOS (
    id_dialogo CHAR(7),
    id_personagem CHAR(8)NOT NULL,
    dialogo CHAR(80)NOT NULL,
    missao CHAR(7)NOT NULL,
    PRIMARY KEY (id_dialogo, id_personagem),
    CHECK( id_dialogo LIKE 'DIA%'
       AND CAST(SUBSTRING(id_dialogo, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_dialogo) = 7),
    FOREIGN KEY (id_personagem) REFERENCES TIPO_PERSONAGEM_HISTORIA (id_personagem)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (missao) REFERENCES TIPO_MISSAO (id_missao)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE MISSAO_MATAR_NPC (
    id_missao CHAR(7) PRIMARY KEY,
	xp_missao INTEGER,
    nome_missao CHAR(30) UNIQUE NOT NULL,
    id_pre_requisito CHAR(7),
    id_instancia_npc CHAR(8),
	tipo_npc CHAR(8),
    CONSTRAINT fk_id_missao
        FOREIGN KEY (id_missao) REFERENCES TIPO_MISSAO (id_missao)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_id_pre_requisito
        FOREIGN KEY (id_pre_requisito) REFERENCES TIPO_MISSAO (id_missao)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_id_instancia_npc
        FOREIGN KEY (id_instancia_npc) REFERENCES INSTANCIA_NPC (id_instancia_npc)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
  	
);

CREATE TABLE TIPO_ITEM (
    id_item CHAR(7) PRIMARY KEY,
    tipo_item CHAR(20) NOT NULL
  	CHECK( id_item LIKE 'ITEM%'
       AND CAST(SUBSTRING(id_item, 5,3) AS INTEGER) BETWEEN 000 AND 999
       AND LENGTH(id_item) = 7)
);

CREATE TABLE INSTANCIA_ITEM (
    id_instancia_item CHAR(8),
    id_item CHAR(7),
	tipo_local CHAR(30) NOT NULL,
    local_inventario CHAR(7) DEFAULT NULL,
	local_sala CHAR(7) DEFAULT NULL,
	eqp_status BOOLEAN NOT NULL,
    PRIMARY KEY (id_instancia_item),
    CHECK( id_instancia_item LIKE 'IITEM%'
       AND CAST(SUBSTRING(id_instancia_item, 6,3) AS INTEGER) BETWEEN 000 AND 999
       AND LENGTH(id_instancia_item) = 8),
    CONSTRAINT fk_id_item_instancia
        FOREIGN KEY (id_item) REFERENCES TIPO_ITEM (id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_id_lugar_inventario
        FOREIGN KEY (local_inventario) REFERENCES INVENTARIO(id_inventario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
	CONSTRAINT fk_id_lugar_sala
        FOREIGN KEY (local_sala) REFERENCES SALA(id_sala)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE TIPO_ENCANTAMENTO(
	id_encantamento CHAR(7) primary key,
	tipo_encatamento CHAR(30),
	CHECK( id_encantamento LIKE 'ENCV%'
       AND CAST(SUBSTRING(id_encantamento, 5,3) AS INTEGER) BETWEEN 000 AND 999
       AND LENGTH(id_encantamento) = 7)
);

CREATE TABLE VESTIMENTA (
    id_vestimenta CHAR(7),
    nome CHAR(30) NOT NULL,
    valor INTEGER NOT NULL,
    peso FLOAT CHECK (peso > 0),
    tipo_vestimenta CHAR(20) NOT NULL,
    resistencia INTEGER NOT NULL,
    parte_corpo CHAR(20) NOT NULL,
    PRIMARY KEY (id_vestimenta),
    CONSTRAINT fk_id_vestimenta
        FOREIGN KEY (id_vestimenta) REFERENCES TIPO_ITEM (id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE ENCANTAMENTO_VESTIMENTA (
    id_encantamento CHAR(7) PRIMARY KEY,
    id_vestimenta CHAR(7) NOT NULL,
    elemento CHAR(20) NOT NULL,
    resistencia INTEGER NOT NULL,
  	CONSTRAINT fk_id_encantamento
        FOREIGN KEY (id_encantamento) REFERENCES TIPO_ENCANTAMENTO(id_encantamento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_id_vestimenta
        FOREIGN KEY (id_vestimenta) REFERENCES VESTIMENTA (id_vestimenta)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE CONSUMIVEL (
    id_consumivel CHAR(7) PRIMARY KEY,
    nome CHAR(30) NOT NULL,
    valor INTEGER NOT NULL,
    peso FLOAT CHECK (peso > 0),
    tipo_consumivel CHAR(20),
    aumento INTEGER NOT NULL,
    CONSTRAINT fk_id_item
        FOREIGN KEY (id_consumivel) REFERENCES TIPO_ITEM (id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE CONSOME(
	id_consumivel CHAR(7),
	id_play_character CHAR(8),
	Quantidade INTEGER,
	PRIMARY KEY (id_consumivel, id_play_character),
	CONSTRAINT fk_id_consumivel
        FOREIGN KEY (id_consumivel) REFERENCES CONSUMIVEL (id_consumivel)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
	CONSTRAINT fk_id_pc
        FOREIGN KEY (id_play_character) REFERENCES PLAY_CHARACTER(id_play_character)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


CREATE TABLE ARMA (
    id_arma CHAR(7),
    nome CHAR(30) NOT NULL,
    valor INTEGER NOT NULL,
    peso FLOAT CHECK (peso > 0),
    tipo_arma CHAR(20),
    num_mãos INTEGER CHECK (num_mãos >= 1 AND num_mãos <= 2),
    custo_stamina INTEGER CHECK (custo_stamina >= 0),
    PRIMARY KEY (id_arma),
    CONSTRAINT fk_id_item
        FOREIGN KEY (id_arma) REFERENCES TIPO_ITEM (id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


CREATE TABLE ENCANTAMENTO_ARMA (
    id_encantamento CHAR(7) PRIMARY KEY,
    id_arma CHAR(7),
    elemento CHAR(20) NOT NULL,
    dano INTEGER NOT NULL,
  	CONSTRAINT fk_id_encantamento
        FOREIGN KEY (id_encantamento) REFERENCES TIPO_ENCANTAMENTO(id_encantamento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_id_arma
        FOREIGN KEY (id_arma) REFERENCES ARMA (id_arma)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE MISSAO_OBTER_ITEM (
	id_missao CHAR(7) PRIMARY KEY,
	xp_missao INTEGER,
	nome CHAR(30) NOT NULL,
	id_pre_requisito CHAR(7),
	id_instancia_item CHAR(8) NOT NULL,
	id_item CHAR(7) NOT NULL,
	CONSTRAINT fk_id_missao
        FOREIGN KEY (id_missao) REFERENCES TIPO_MISSAO (id_missao)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
	 CONSTRAINT fk_id_pre_requisito
        FOREIGN KEY (id_pre_requisito) REFERENCES TIPO_MISSAO (id_missao)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
	 CONSTRAINT fk_id_instancia_item
        FOREIGN KEY (id_instancia_item) REFERENCES INSTANCIA_ITEM (id_instancia_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE GEMA(
	id_gema CHAR(7) PRIMARY KEY,
	nome CHAR(30) NOT NULL,
    valor INTEGER NOT NULL,
    peso FLOAT CHECK (peso > 0),
	potencia INTEGER NOT NULL,
	CONSTRAINT fk_id_item
        FOREIGN KEY (id_gema) REFERENCES TIPO_ITEM (id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

);

CREATE TABLE PROPORCIONA_ENCANTAMENTO(
	id_gema CHAR(7),
	id_encantamento char(7),
	PRIMARY KEY( id_gema, id_encantamento),
	CONSTRAINT fk_id_gema
        FOREIGN KEY (id_gema) REFERENCES GEMA (id_gema)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
	CONSTRAINT fk_id_encantamento
        FOREIGN KEY (id_encantamento) REFERENCES TIPO_ENCANTAMENTO(id_encantamento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE APRENDER_ENCANTAMENTO(
	id_encantamento CHAR(7),
	id_play_character CHAR(8),
	status BOOLEAN,
	primary key(id_encantamento,id_play_character),
	CONSTRAINT fk_id_encantamento
        FOREIGN KEY (id_encantamento) REFERENCES TIPO_ENCANTAMENTO(id_encantamento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
	CONSTRAINT fk_id_pc
        FOREIGN KEY (id_play_character) REFERENCES PLAY_CHARACTER(id_play_character)
        ON DELETE RESTRICT
        ON UPDATE CASCADE

);