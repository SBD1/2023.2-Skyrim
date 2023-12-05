DROP TABLE IF EXISTS APRENDER_ENCANTAMENTO;
DROP TABLE IF EXISTS PROPORCIONA_ENCANTAMENTO;
DROP TABLE IF EXISTS GEMA;
DROP TABLE IF EXISTS MISSAO_OBTER_ITEM;
DROP TABLE IF EXISTS ENCANTAMENTO_ARMA;
DROP TABLE IF EXISTS ARMA;
DROP TABLE IF EXISTS CONSOME;
DROP TABLE IF EXISTS CONSUMIVEL;
DROP TABLE IF EXISTS ENCANTAMENTO_VESTIMENTA;
DROP TABLE IF EXISTS VESTIMENTA;
DROP TABLE IF EXISTS TIPO_ENCANTAMENTO;
DROP TABLE IF EXISTS INSTANCIA_ITEM;
DROP TABLE IF EXISTS TIPO_ITEM;
DROP TABLE IF EXISTS  MISSAO_MATAR_NPC;
DROP TABLE IF EXISTS DIALOGOS;
DROP TABLE IF EXISTS CUMPRE_MISSAO;
DROP TABLE IF EXISTS MISSAO_NIVEL;
DROP TABLE IF EXISTS TIPO_MISSAO;
DROP TABLE IF EXISTS ESTA_MORTO;
DROP TABLE IF EXISTS INSTANCIA_NPC;
DROP TABLE IF EXISTS NOT_PLAY_CHARACTER;
DROP TABLE IF EXISTS PLAY_CHARACTER;
DROP TABLE IF EXISTS HOSTILIDADE;
DROP TABLE IF EXISTS GOLPES_BESTA;
DROP TABLE IF EXISTS GOLPES;
DROP TABLE IF EXISTS BESTA;
DROP TABLE IF EXISTS MAGIA_HUMANOIDE;
DROP TABLE IF EXISTS MAGIA;
DROP TABLE IF EXISTS ESPECIE_HUMANOIDE;
DROP TABLE IF EXISTS HUMANOIDE;
DROP TABLE IF EXISTS ESPECIE;
DROP TABLE IF EXISTS HABILIDADE_ESPECIE;
DROP TABLE IF EXISTS FORMA;
DROP TABLE IF EXISTS NIVEL;
DROP TABLE IF EXISTS TIPO_PERSONAGEM_HISTORIA;
DROP TABLE IF EXISTS INVENTARIO;
DROP TABLE IF EXISTS VIAGEM_SALAS;
DROP TABLE IF EXISTS SALA;
DROP TABLE IF EXISTS LUGAR;
DROP TABLE IF EXISTS REGIAO;

CREATE TABLE IF NOT EXISTS  REGIAO(
  id_regiao CHAR(7) PRIMARY KEY,
  nome CHAR(30) UNIQUE NOT NULL,
  CONSTRAINT verificar_id_regiao
    CHECK (id_regiao LIKE 'REG%'
  		AND CAST(SUBSTRING(id_regiao, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
    	AND LENGTH(id_regiao) = 7 )
);

CREATE TABLE IF NOT EXISTS  LUGAR(
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
  
  
CREATE TABLE IF NOT EXISTS  SALA(
  id_sala CHAR(7) PRIMARY KEY,
  nome_sala CHAR(40) NOT NULL,
  id_local CHAR(7),
  descricao CHAR(40),
  CONSTRAINT verificar_id_sala
  	CHECK( id_sala LIKE 'ROOM%'
          AND CAST(SUBSTRING(id_sala, 5,3) AS INTEGER) BETWEEN 000 AND 999
          AND LENGTH(id_sala) = 7),
  CONSTRAINT fk_id_sala
  	FOREIGN KEY (id_local) REFERENCES LUGAR(id_local)
  	ON DELETE RESTRICT
  	ON UPDATE CASCADE
  );
  
 CREATE TABLE IF NOT EXISTS  VIAGEM_SALAS(
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

CREATE TABLE IF NOT EXISTS  INVENTARIO (
    id_inventario CHAR(7) PRIMARY KEY,
    peso_maximo FLOAT,
    carteira INTEGER,
    eh_loja BOOLEAN,
   	CHECK( id_inventario LIKE 'INV%'
       AND CAST(SUBSTRING(id_inventario, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_inventario) = 7)
);

CREATE TABLE IF NOT EXISTS  TIPO_PERSONAGEM_HISTORIA (
   id_personagem CHAR(8) PRIMARY KEY,
   jogavel BOOLEAN,
   CONSTRAINT verificar_id_personagem
   CHECK( id_personagem LIKE 'CHAR%'
       AND CAST(SUBSTRING(id_personagem, 5,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_personagem) = 8)
);


CREATE TABLE IF NOT EXISTS  NIVEL(
	id_nivel CHAR(3) PRIMARY KEY,
	xp_minimo INTEGER,
	XP_MAXIMO INTEGER
	--CONSTRAINT id_nivel
	--CHECK( id_nivel LIKE 'N'
      -- AND CAST(SUBSTRING(id_nivel, 2,2) AS INTEGER) BETWEEN 00 AND 99
       --AND LENGTH(id_nivel) = 3)
);

CREATE TABLE IF NOT EXISTS  FORMA (
	id_personagem CHAR(8) PRIMARY KEY,
	forma CHAR(10) NOT NULL CHECK (forma IN ('Humanoide', 'Besta')),
	CONSTRAINT fk_forma_personagem
    FOREIGN KEY (id_personagem) REFERENCES TIPO_PERSONAGEM_HISTORIA(id_personagem)
    ON DELETE RESTRICT
    ON UPDATE CASCADE

);

CREATE TABLE IF NOT EXISTS  HABILIDADE_ESPECIE (
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

CREATE TABLE IF NOT EXISTS  ESPECIE (
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

CREATE TABLE IF NOT EXISTS  HUMANOIDE (
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




CREATE TABLE IF NOT EXISTS  MAGIA (
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

CREATE TABLE IF NOT EXISTS  ESPECIE_HUMANOIDE (
    id_humanoide CHAR(8),
    id_habilidade CHAR(7),
	nivel INTEGER CHECK (NIVEL >= 0 AND nivel <= 100),
	dano INTEGER CHECK (dano >= 0 AND dano <= 100),
    PRIMARY KEY (id_humanoide, id_habilidade),
    FOREIGN KEY (id_humanoide) REFERENCES HUMANOIDE (id_humanoide)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_habilidade) REFERENCES HABILIDADE_ESPECIE (id_habilidade)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS  MAGIA_HUMANOIDE (
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


CREATE TABLE IF NOT EXISTS  BESTA (
    id_besta CHAR(8) PRIMARY KEY,
    mod_defesa_frio INTEGER,
    mod_defesa_fogo INTEGER,
    mod_defesa_raio INTEGER,
    FOREIGN KEY (id_besta) REFERENCES FORMA(id_personagem)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS  GOLPES (
    id_golpe CHAR(7) PRIMARY KEY,
    nome CHAR(20) NOT NULL,
    dano INTEGER CHECK (dano BETWEEN 0 AND 100),
    elemento INTEGER CHECK (elemento BETWEEN 0 AND 100),
    CHECK( id_golpe LIKE 'STRO%'
       AND CAST(SUBSTRING(id_golpe, 5,3) AS INTEGER) BETWEEN 000 AND 999
       AND LENGTH(id_golpe) = 7)
);


CREATE TABLE IF NOT EXISTS  GOLPES_BESTA (
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

CREATE TABLE IF NOT EXISTS  HOSTILIDADE (
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


CREATE TABLE IF NOT EXISTS  PLAY_CHARACTER (
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

CREATE TABLE IF NOT EXISTS  NOT_PLAY_CHARACTER (
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

CREATE TABLE IF NOT EXISTS  INSTANCIA_NPC (
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

CREATE TABLE IF NOT EXISTS  ESTA_MORTO (
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

CREATE TABLE IF NOT EXISTS  TIPO_MISSAO (
    id_missao CHAR(7) PRIMARY KEY,
    tipo_objetivo CHAR(40),
    obrigatoria BOOLEAN
 	CHECK( id_missao LIKE 'MIS%'
       AND CAST(SUBSTRING(id_missao, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_missao) = 7)
);

CREATE TABLE IF NOT EXISTS  MISSAO_NIVEL (
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


CREATE TABLE IF NOT EXISTS  CUMPRE_MISSAO (
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

CREATE TABLE IF NOT EXISTS  DIALOGOS (
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

CREATE TABLE IF NOT EXISTS  MISSAO_MATAR_NPC (
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

CREATE TABLE IF NOT EXISTS  TIPO_ITEM (
    id_item CHAR(7) PRIMARY KEY,
    tipo_item CHAR(20) NOT NULL
  	CHECK( id_item LIKE 'ITEM%'
       AND CAST(SUBSTRING(id_item, 5,3) AS INTEGER) BETWEEN 000 AND 999
       AND LENGTH(id_item) = 7)
);

CREATE TABLE IF NOT EXISTS  INSTANCIA_ITEM (
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

CREATE TABLE IF NOT EXISTS  TIPO_ENCANTAMENTO(
	id_encantamento CHAR(7) primary key,
	tipo_encatamento CHAR(30),
	CHECK( id_encantamento LIKE 'ENCV%'
       AND CAST(SUBSTRING(id_encantamento, 5,3) AS INTEGER) BETWEEN 000 AND 999
       AND LENGTH(id_encantamento) = 7)
);

CREATE TABLE IF NOT EXISTS  VESTIMENTA (
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

CREATE TABLE IF NOT EXISTS  ENCANTAMENTO_VESTIMENTA (
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

CREATE TABLE IF NOT EXISTS  CONSUMIVEL (
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

CREATE TABLE IF NOT EXISTS  CONSOME(
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


CREATE TABLE IF NOT EXISTS  ARMA (
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


CREATE TABLE IF NOT EXISTS  ENCANTAMENTO_ARMA (
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

CREATE TABLE IF NOT EXISTS  MISSAO_OBTER_ITEM (
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

CREATE TABLE IF NOT EXISTS  GEMA(
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

CREATE TABLE IF NOT EXISTS  PROPORCIONA_ENCANTAMENTO(
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

CREATE TABLE IF NOT EXISTS  APRENDER_ENCANTAMENTO(
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

-- Triggers:

-- Drop das Triggers

DROP TRIGGER IF EXISTS check_peso_maximo_insert_trigger ON INVENTARIO;
DROP TRIGGER IF EXISTS check_peso_maximo_update_trigger ON INVENTARIO;

DROP TRIGGER IF EXISTS verificar_nome_sala_unica_insert_trigger ON SALA;
DROP TRIGGER IF EXISTS verificar_nome_sala_unica_update_trigger ON SALA;

DROP TRIGGER IF EXISTS check_atributos_humanoides_trigger ON HUMANOIDE;
DROP TRIGGER IF EXISTS check_atributos_magia_trigger ON MAGIA;
DROP TRIGGER IF EXISTS check_atributos_nivel_trigger ON NIVEL;
DROP TRIGGER IF EXISTS check_atributos_personagem_trigger ON PLAY_CHARACTER;
DROP TRIGGER IF EXISTS check_atributos_npc_trigger ON NOT_PLAY_CHARACTER;
DROP TRIGGER IF EXISTS check_atributos_inventario_trigger ON INVENTARIO;
DROP TRIGGER IF EXISTS check_atributos_golpes_trigger ON GOLPES;
DROP TRIGGER IF EXISTS check_atributos_vestimenta_trigger ON VESTIMENTA;
DROP TRIGGER IF EXISTS check_atributos_encantamento_vestimenta_trigger ON ENCANTAMENTO_VESTIMENTA;
DROP TRIGGER IF EXISTS check_atributos_consumivel_trigger ON CONSUMIVEL;
DROP TRIGGER IF EXISTS check_atributos_arma_trigger ON ARMA;
DROP TRIGGER IF EXISTS check_atributos_encantamento_arma_trigger ON ENCANTAMENTO_ARMA;
DROP TRIGGER IF EXISTS check_atributos_gema_trigger ON GEMA;
DROP TRIGGER IF EXISTS check_atributos_missao_matar_npc_trigger ON MISSAO_MATAR_NPC;
DROP TRIGGER IF EXISTS check_atributos_missao_obter_item_trigger ON MISSAO_OBTER_ITEM;
DROP TRIGGER IF EXISTS trigger_inserir_tipo_personagem_play_character ON PLAY_CHARACTER;
DROP TRIGGER IF EXISTS trigger_inserir_tipo_personagem_not_play_character ON NOT_PLAY_CHARACTER;
DROP TRIGGER IF EXISTS trigger_excluir_tipo_personagem_play_character ON PLAY_CHARACTER;
DROP TRIGGER IF EXISTS trigger_excluir_tipo_personagem_not_play_character ON NOT_PLAY_CHARACTER;
DROP TRIGGER IF EXISTS trigger_total_exclusivo_humanoide ON HUMANOIDE;
DROP TRIGGER IF EXISTS trigger_excluir_forma_humanoide ON HUMANOIDE;
DROP TRIGGER IF EXISTS trigger_total_exclusivo_besta ON BESTA;
DROP TRIGGER IF EXISTS trigger_excluir_forma_besta ON BESTA;
DROP TRIGGER IF EXISTS atualizar_xp_missao_matar_npc_trigger ON CUMPRE_MISSAO;
DROP TRIGGER IF EXISTS atualizar_xp_missao_obter_item_trigger ON CUMPRE_MISSAO;
DROP TRIGGER IF EXISTS atualizar_nivel_trigger ON PLAY_CHARACTER;
DROP TRIGGER IF EXISTS trigger_verificar_insert_magia_humanoide ON MAGIA_HUMANOIDE;
DROP TRIGGER IF EXISTS atualizar_magia_humanoide_trigger ON PLAY_CHARACTER;

-- Drop das Procedures

DROP FUNCTION IF EXISTS check_peso_maximo();
DROP FUNCTION IF EXISTS verificar_nome_sala_unica();
DROP FUNCTION IF EXISTS check_atributos_humanoides();
DROP FUNCTION IF EXISTS check_atributos_magia();
DROP FUNCTION IF EXISTS check_atributos_nivel();
DROP FUNCTION IF EXISTS check_atributos_personagem();
DROP FUNCTION IF EXISTS check_atributos_npc();
DROP FUNCTION IF EXISTS check_atributos_inventario();
DROP FUNCTION IF EXISTS check_atributos_golpes();
DROP FUNCTION IF EXISTS check_atributos_vestimenta();
DROP FUNCTION IF EXISTS check_atributos_encantamento_vestimenta();
DROP FUNCTION IF EXISTS check_atributos_consumivel();
DROP FUNCTION IF EXISTS check_atributos_arma();
DROP FUNCTION IF EXISTS check_atributos_encantamento_arma();
DROP FUNCTION IF EXISTS check_atributos_gema();
DROP FUNCTION IF EXISTS check_atributos_missao_matar_npc();
DROP FUNCTION IF EXISTS check_atributos_missao_obter_item();
DROP FUNCTION IF EXISTS inserir_tipo_personagem_play_character();
DROP FUNCTION IF EXISTS inserir_tipo_personagem_not_play_character();
DROP FUNCTION IF EXISTS excluir_tipo_personagem_play_character();
DROP FUNCTION IF EXISTS excluir_tipo_personagem_not_play_character();
DROP FUNCTION IF EXISTS total_exclusivo_humanoide();
DROP FUNCTION IF EXISTS excluir_forma_humanoide();
DROP FUNCTION IF EXISTS total_exclusivo_besta();
DROP FUNCTION IF EXISTS excluir_forma_besta();
DROP FUNCTION IF EXISTS atualizar_xp_missao_matar_npc();
DROP FUNCTION IF EXISTS atualizar_xp_missao_obter_item();
DROP FUNCTION IF EXISTS concluir_missao();
DROP FUNCTION IF EXISTS atualizar_nivel();
DROP FUNCTION IF EXISTS verificar_insert_magia_humanoide();
DROP FUNCTION IF EXISTS atualizar_magia_humanoide();



-- Garantir que o peso do inventário não seja excedido.

CREATE OR REPLACE FUNCTION check_peso_maximo()
RETURNS TRIGGER AS $check_peso_maximo$
BEGIN
    IF( NEW.peso_maximo) < 0 THEN
        RAISE EXCEPTION 'O peso máximo do inventário deve ser não negativo.';
    END IF;
    RETURN NEW;
END;
$check_peso_maximo$ LANGUAGE plpgsql;

CREATE TRIGGER check_peso_maximo_insert_trigger
BEFORE INSERT ON INVENTARIO
FOR EACH ROW EXECUTE FUNCTION check_peso_maximo();

CREATE TRIGGER check_peso_maximo_update_trigger
BEFORE UPDATE ON INVENTARIO
FOR EACH ROW EXECUTE FUNCTION check_peso_maximo();


-- Garantir que o nome de uma sala seja único dentro de um local
CREATE OR REPLACE FUNCTION verificar_nome_sala_unica()
RETURNS TRIGGER AS $verificar_nome_sala_unica$
BEGIN
    IF NEW.nome_sala IS NOT NULL AND EXISTS (
        SELECT 1
        FROM SALA
        WHERE id_local = NEW.id_local
          AND nome_sala = NEW.nome_sala
          AND id_sala != NEW.id_sala
    ) THEN
        RAISE EXCEPTION 'O nome da sala deve ser único dentro do local.';
    END IF;
    RETURN NEW;
END;
$verificar_nome_sala_unica$ LANGUAGE plpgsql;

-- Trigger de verificação antes da inserção
CREATE TRIGGER verificar_nome_sala_unica_insert_trigger
BEFORE INSERT ON SALA
FOR EACH ROW EXECUTE FUNCTION verificar_nome_sala_unica();

-- Trigger de verificação antes da atualização
CREATE TRIGGER verificar_nome_sala_unica_update_trigger
BEFORE UPDATE ON SALA
FOR EACH ROW EXECUTE FUNCTION verificar_nome_sala_unica();

-- Restrição de valor mínimo para humanoide:
CREATE OR REPLACE FUNCTION check_atributos_humanoides()
RETURNS TRIGGER AS $check_atributos_humanoides$
BEGIN
    IF NEW.vida_maxima < 0 OR NEW.mana_max < 0 OR NEW.stamina_max < 0 THEN
        RAISE EXCEPTION 'Os atributos de vida, mana e stamina devem ser não negativos.';
    END IF;
    RETURN NEW;
END;
$check_atributos_humanoides$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_humanoides_trigger
BEFORE INSERT OR UPDATE ON HUMANOIDE
FOR EACH ROW EXECUTE FUNCTION check_atributos_humanoides();

-- Restrição de valor mínimo para Magia:
CREATE OR REPLACE FUNCTION check_atributos_magia()
RETURNS TRIGGER AS $check_atributos_magia$
BEGIN
    IF NEW.dano_inicial < 0 OR NEW.custo_mana < 0 THEN
        RAISE EXCEPTION 'Os atributos de dano, nível e custo de mana devem ser não negativos.';
    END IF;
    RETURN NEW;
END;
$check_atributos_magia$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_magia_trigger
BEFORE INSERT OR UPDATE ON MAGIA
FOR EACH ROW EXECUTE FUNCTION check_atributos_magia();

-- Restrição de valor mínimo para nível:
CREATE OR REPLACE FUNCTION check_atributos_nivel()
RETURNS TRIGGER AS $check_atributos_nivel$
BEGIN
    IF NEW.xp_minimo < 0 OR NEW.xp_maximo < 0 THEN
        RAISE EXCEPTION 'Os atributos de XP mínimo e máximo devem ser não negativos.';
    END IF;
    RETURN NEW;
END;
$check_atributos_nivel$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_nivel_trigger
BEFORE INSERT OR UPDATE ON NIVEL
FOR EACH ROW EXECUTE FUNCTION check_atributos_nivel();

-- Restrição de valor mínimo para play_character:
CREATE OR REPLACE FUNCTION check_atributos_personagem()
RETURNS TRIGGER AS $check_atributos_personagem$
BEGIN
    IF NEW.xp < 0 OR NEW.vida_atual < 0 OR NEW.mana_atual < 0 OR NEW.stamina_atual < 0
       OR NEW.vida_maxima < 0 OR NEW.mana_max < 0 OR NEW.stamina_max < 0 THEN
        RAISE EXCEPTION 'Os atributos de XP, vida, mana e stamina devem ser não negativos.';
    END IF;
    RETURN NEW;
END;
$check_atributos_personagem$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_personagem_trigger
BEFORE INSERT OR UPDATE ON PLAY_CHARACTER
FOR EACH ROW EXECUTE FUNCTION check_atributos_personagem();

-- Restrição de valor mínimo para not_play_character:
CREATE OR REPLACE FUNCTION check_atributos_npc()
RETURNS TRIGGER AS $check_atributos_npc$
BEGIN
    IF NEW.xp < 0 OR NEW.vida_maxima < 0 OR NEW.mana_max < 0 OR NEW.stamina_max < 0 THEN
        RAISE EXCEPTION 'Os atributos de nível, XP, vida, mana e stamina devem ser não negativos.';
    END IF;
    RETURN NEW;
END;
$check_atributos_npc$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_npc_trigger
BEFORE INSERT OR UPDATE ON NOT_PLAY_CHARACTER
FOR EACH ROW EXECUTE FUNCTION check_atributos_npc();

-- Restrição de valor mínimo para inventário:
CREATE OR REPLACE FUNCTION check_atributos_inventario()
RETURNS TRIGGER AS $check_atributos_inventario$
BEGIN
    IF NEW.carteira < 0 THEN
        RAISE EXCEPTION 'O atributo carteira deve ser não negativo.';
    END IF;
    RETURN NEW;
END;
$check_atributos_inventario$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_inventario_trigger
BEFORE INSERT OR UPDATE ON INVENTARIO
FOR EACH ROW EXECUTE FUNCTION check_atributos_inventario();

-- Restrição de valor mínimo para Golpes:

CREATE OR REPLACE FUNCTION check_atributos_golpes()
RETURNS TRIGGER AS $check_atributos_golpes$
BEGIN
    IF NEW.dano < 0 OR NEW.elemento < 0 THEN
        RAISE EXCEPTION 'Os atributos de dano e elemento devem ser não negativos.';
    END IF;
    RETURN NEW;
END;
$check_atributos_golpes$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_golpes_trigger
BEFORE INSERT OR UPDATE ON GOLPES
FOR EACH ROW EXECUTE FUNCTION check_atributos_golpes();

-- Restrição de valor mínimo para Venstimentas:

CREATE OR REPLACE FUNCTION check_atributos_vestimenta()
RETURNS TRIGGER AS $check_atributos_vestimenta$
BEGIN
    IF NEW.valor < 0 OR NEW.peso <= 0 OR NEW.resistencia < 0 THEN
        RAISE EXCEPTION 'Os atributos de valor, peso e resistência devem ser não negativos.';
    END IF;
    RETURN NEW;
END;
$check_atributos_vestimenta$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_vestimenta_trigger
BEFORE INSERT OR UPDATE ON VESTIMENTA
FOR EACH ROW EXECUTE FUNCTION check_atributos_vestimenta();

-- Restrição de valor mínimo para Encantamento de Vestimentas:
CREATE OR REPLACE FUNCTION check_atributos_encantamento_vestimenta()
RETURNS TRIGGER AS $check_atributos_encantamento_vestimenta$
BEGIN
    IF NEW.resistencia < 0 THEN
        RAISE EXCEPTION 'O atributo resistência do encantamento de vestimenta deve ser não negativo.';
    END IF;
    RETURN NEW;
END;
$check_atributos_encantamento_vestimenta$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_encantamento_vestimenta_trigger
BEFORE INSERT OR UPDATE ON ENCANTAMENTO_VESTIMENTA
FOR EACH ROW EXECUTE FUNCTION check_atributos_encantamento_vestimenta();

-- Restrição de valor mínimo para Encantamento de Consumível:
CREATE OR REPLACE FUNCTION check_atributos_consumivel()
RETURNS TRIGGER AS $check_atributos_consumivel$
BEGIN
    IF NEW.valor < 0 OR NEW.peso <= 0 OR NEW.aumento < 0 THEN
        RAISE EXCEPTION 'Os atributos de valor, peso e aumento devem ser não negativos.';
    END IF;
    RETURN NEW;
END;
$check_atributos_consumivel$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_consumivel_trigger
BEFORE INSERT OR UPDATE ON CONSUMIVEL
FOR EACH ROW EXECUTE FUNCTION check_atributos_consumivel();

-- Restrição de valor mínimo para Arma:
CREATE OR REPLACE FUNCTION check_atributos_arma()
RETURNS TRIGGER AS $check_atributos_arma$
BEGIN
    IF NEW.valor < 0 OR NEW.peso <= 0 OR NEW.num_mãos < 1 OR NEW.num_mãos > 2 OR NEW.custo_stamina < 0 THEN
        RAISE EXCEPTION 'Os atributos de valor, peso, número de mãos e custo de stamina devem ser não negativos.';
    END IF;
    RETURN NEW;
END;
$check_atributos_arma$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_arma_trigger
BEFORE INSERT OR UPDATE ON ARMA
FOR EACH ROW EXECUTE FUNCTION check_atributos_arma();

-- Restrição de valor mínimo para Encantamento de Arma:
CREATE OR REPLACE FUNCTION check_atributos_encantamento_arma()
RETURNS TRIGGER AS $check_atributos_encantamento_arma$
BEGIN
    IF NEW.dano < 0 THEN
        RAISE EXCEPTION 'O atributo dano do encantamento de arma deve ser não negativo.';
    END IF;
    RETURN NEW;
END;
$check_atributos_encantamento_arma$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_encantamento_arma_trigger
BEFORE INSERT OR UPDATE ON ENCANTAMENTO_ARMA
FOR EACH ROW EXECUTE FUNCTION check_atributos_encantamento_arma();

-- Restrição de valor mínimo para Gema:
CREATE OR REPLACE FUNCTION check_atributos_gema()
RETURNS TRIGGER AS $check_atributos_gema$
BEGIN
    IF NEW.valor < 0 OR NEW.peso <= 0 OR NEW.potencia < 0 THEN
        RAISE EXCEPTION 'Os atributos de valor, peso e potência da gema devem ser não negativos.';
    END IF;
    RETURN NEW;
END;
$check_atributos_gema$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_gema_trigger
BEFORE INSERT OR UPDATE ON GEMA
FOR EACH ROW EXECUTE FUNCTION check_atributos_gema();

-- Restrição de valor mínimo para missão_matar_npc:
CREATE OR REPLACE FUNCTION check_atributos_missao_matar_npc()
RETURNS TRIGGER AS $check_atributos_missao_matar_npc$
BEGIN
    IF NEW.xp_missao < 0 THEN
        RAISE EXCEPTION 'O atributo xp_missao da missão para matar NPC deve ser não negativo.';
    END IF;
    RETURN NEW;
END;
$check_atributos_missao_matar_npc$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_missao_matar_npc_trigger
BEFORE INSERT OR UPDATE ON MISSAO_MATAR_NPC
FOR EACH ROW EXECUTE FUNCTION check_atributos_missao_matar_npc();

-- Restrição de valor mínimo para missão_obter_item:

CREATE OR REPLACE FUNCTION check_atributos_missao_obter_item()
RETURNS TRIGGER AS $check_atributos_missao_obter_item$
BEGIN
    IF NEW.xp_missao < 0 THEN
        RAISE EXCEPTION 'O atributo xp_missao da missão para obter item deve ser não negativo.';
    END IF;
    RETURN NEW;
END;
$check_atributos_missao_obter_item$ LANGUAGE plpgsql;

CREATE TRIGGER check_atributos_missao_obter_item_trigger
BEFORE INSERT OR UPDATE ON MISSAO_OBTER_ITEM
FOR EACH ROW EXECUTE FUNCTION check_atributos_missao_obter_item();

-- Garantir consistência quando for inserir personagem jogável:
CREATE OR REPLACE FUNCTION inserir_tipo_personagem_play_character()
RETURNS TRIGGER AS $inserir_tipo_personagem_play_character$
BEGIN
    -- Verifica se a chave já existe em TIPO_PERSONAGEM_HISTORIA
    IF EXISTS (SELECT 1 FROM TIPO_PERSONAGEM_HISTORIA WHERE id_personagem = NEW.id_play_character) THEN
        RAISE EXCEPTION 'Chave duplicada na tabela TIPO_PERSONAGEM_HISTORIA.';
    END IF;

    -- Insere em TIPO_PERSONAGEM_HISTORIA para PLAY_CHARACTER
    INSERT INTO TIPO_PERSONAGEM_HISTORIA (id_personagem, jogavel)
    VALUES (NEW.id_play_character, TRUE);

    RETURN NEW;
END;
$inserir_tipo_personagem_play_character$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_inserir_tipo_personagem_play_character
BEFORE INSERT ON PLAY_CHARACTER
FOR EACH ROW
EXECUTE FUNCTION inserir_tipo_personagem_play_character();

-- Garantir consistência quando for inserir em personagem não jogáve:

CREATE OR REPLACE FUNCTION inserir_tipo_personagem_not_play_character()
RETURNS TRIGGER AS $inserir_tipo_personagem_not_play_character$
BEGIN
    -- Verifica se a chave já existe em TIPO_PERSONAGEM_HISTORIA
    IF EXISTS (SELECT 1 FROM TIPO_PERSONAGEM_HISTORIA WHERE id_personagem = NEW.id_npc) THEN
        RAISE EXCEPTION 'Chave duplicada na tabela TIPO_PERSONAGEM_HISTORIA.';
    END IF;

    -- Insere em TIPO_PERSONAGEM_HISTORIA para NOT_PLAY_CHARACTER
    INSERT INTO TIPO_PERSONAGEM_HISTORIA (id_personagem, jogavel)
    VALUES (NEW.id_npc, FALSE);

    RETURN NEW;
END;
$inserir_tipo_personagem_not_play_character$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_inserir_tipo_personagem_not_play_character
BEFORE INSERT ON NOT_PLAY_CHARACTER
FOR EACH ROW
EXECUTE FUNCTION inserir_tipo_personagem_not_play_character();

-- Quando deletar personagem jogável:

CREATE OR REPLACE FUNCTION excluir_tipo_personagem_play_character()
RETURNS TRIGGER AS $excluir_tipo_personagem_play_character$
BEGIN
    -- Exclui a tupla correspondente em TIPO_PERSONAGEM_HISTORIA
    DELETE FROM TIPO_PERSONAGEM_HISTORIA WHERE id_personagem = OLD.id_play_character;

    RETURN OLD;
END;
$excluir_tipo_personagem_play_character$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_excluir_tipo_personagem_play_character
AFTER DELETE ON PLAY_CHARACTER
FOR EACH ROW
EXECUTE FUNCTION excluir_tipo_personagem_play_character();

-- Quando deletar npc

CREATE OR REPLACE FUNCTION excluir_tipo_personagem_not_play_character()
RETURNS TRIGGER AS $excluir_tipo_personagem_not_play_character$
BEGIN
    -- Exclui a tupla correspondente em TIPO_PERSONAGEM_HISTORIA
    DELETE FROM TIPO_PERSONAGEM_HISTORIA WHERE id_personagem = OLD.id_npc;

    RETURN OLD;
END;
$excluir_tipo_personagem_not_play_character$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_excluir_tipo_personagem_not_play_character
AFTER DELETE ON NOT_PLAY_CHARACTER
FOR EACH ROW
EXECUTE FUNCTION excluir_tipo_personagem_not_play_character();

-- Trigger para verificar a total exclusividade ao inserir em HUMANOIDE
CREATE OR REPLACE FUNCTION total_exclusivo_humanoide()
RETURNS TRIGGER AS $total_exclusivo_humanoide$
BEGIN
    -- Verifica se a chave id_personagem existe em TIPO_PERSONAGEM_HISTORIA
    IF NOT EXISTS (SELECT 1 FROM TIPO_PERSONAGEM_HISTORIA WHERE id_personagem = NEW.id_humanoide) THEN
        RAISE EXCEPTION 'Chave id_personagem não existe em TIPO_PERSONAGEM_HISTORIA.';
    END IF;

    -- Verifica se a chave id_personagem não existe em FORMA
    IF EXISTS (SELECT 1 FROM FORMA WHERE id_personagem = NEW.id_humanoide) THEN
        RAISE EXCEPTION 'Cada personagem só pode assumir uma forma. Chave já cadastrada.';
    END IF;

    -- Insere em FORMA com forma igual a 'Humanoide'
    INSERT INTO FORMA (id_personagem, forma) VALUES (NEW.id_humanoide, 'Humanoide');

    RETURN NEW;
END;
$total_exclusivo_humanoide$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_total_exclusivo_humanoide
BEFORE INSERT ON HUMANOIDE
FOR EACH ROW
EXECUTE FUNCTION total_exclusivo_humanoide();

-- Quando deletar humanoide:

CREATE OR REPLACE FUNCTION excluir_forma_humanoide()
RETURNS TRIGGER AS $excluir_forma_humanoide$
BEGIN
    -- Exclui a tupla correspondente em FORMA
    DELETE FROM FORMA WHERE id_personagem = OLD.id_humanoide;

    RETURN OLD;
END;
$excluir_forma_humanoide$ LANGUAGE plpgsql;

-- Trigger para chamar a função ao excluir HUMANOIDE
CREATE TRIGGER trigger_excluir_forma_humanoide
AFTER DELETE ON HUMANOIDE
FOR EACH ROW
EXECUTE FUNCTION excluir_forma_humanoide();


-- Trigger para verificar a total exclusividade ao inserir em BESTA

CREATE OR REPLACE FUNCTION total_exclusivo_besta()
RETURNS TRIGGER AS $total_exclusivo_besta$
BEGIN
    -- Verifica se a chave id_personagem existe em NOT_PLAY_CHARACTER
    IF NOT EXISTS (SELECT 1 FROM NOT_PLAY_CHARACTER WHERE id_npc = NEW.id_besta) THEN
        RAISE EXCEPTION 'Chave id_personagem não existe em NOT_PLAY_CHARACTER.';
    END IF;

    -- Verifica se a chave id_personagem não existe em FORMA
    IF EXISTS (SELECT 1 FROM FORMA WHERE id_personagem = NEW.id_besta) THEN
        RAISE EXCEPTION 'Cada personagem só pode assumir uma forma. Chave já cadastrada.';
    END IF;

    -- Insere em FORMA com forma igual a 'Besta'
    INSERT INTO FORMA (id_personagem, forma) VALUES (NEW.id_besta, 'Besta');

    RETURN NEW;
END;
$total_exclusivo_besta$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_total_exclusivo_besta
BEFORE INSERT ON BESTA
FOR EACH ROW
EXECUTE FUNCTION total_exclusivo_besta();

-- Quando deletar besta

-- Trigger para excluir a tupla correspondente em FORMA após a exclusão de BESTA
CREATE OR REPLACE FUNCTION excluir_forma_besta()
RETURNS TRIGGER AS $excluir_forma_besta$
BEGIN
-- Exclui a tupla correspondente em FORMA
    DELETE FROM FORMA WHERE id_personagem = OLD.id_besta;

    RETURN OLD;
END;
$excluir_forma_besta$ LANGUAGE plpgsql;

-- Trigger para chamar a função ao excluir BESTA
CREATE TRIGGER trigger_excluir_forma_besta
AFTER DELETE ON BESTA
FOR EACH ROW
EXECUTE FUNCTION excluir_forma_besta();


-- Atualização do xp após a conclusão de uma missão

CREATE OR REPLACE FUNCTION atualizar_xp_missao_matar_npc()
RETURNS TRIGGER AS $atualizar_xp_missao_matar_npc$
BEGIN
    IF NEW.status = TRUE AND EXISTS (SELECT 1 FROM MISSAO_MATAR_NPC WHERE id_missao = NEW.id_missao) THEN
        UPDATE PLAY_CHARACTER
        SET xp = xp + (SELECT xp_missao FROM MISSAO_MATAR_NPC WHERE id_missao = NEW.id_missao)
        WHERE id_play_character = NEW.id_play_character;
    END IF;
    RETURN NEW;
END;
$atualizar_xp_missao_matar_npc$ LANGUAGE plpgsql;

CREATE TRIGGER atualizar_xp_missao_matar_npc_trigger
AFTER UPDATE ON CUMPRE_MISSAO
FOR EACH ROW
EXECUTE FUNCTION atualizar_xp_missao_matar_npc();


CREATE OR REPLACE FUNCTION atualizar_xp_missao_obter_item()
RETURNS TRIGGER AS $atualizar_xp_missao_obter_item$
BEGIN
    IF NEW.status = TRUE AND EXISTS (SELECT 1 FROM MISSAO_OBTER_ITEM WHERE id_missao = NEW.id_missao) THEN
        UPDATE PLAY_CHARACTER
        SET xp = xp + (SELECT xp_missao FROM MISSAO_OBTER_ITEM WHERE id_missao = NEW.id_missao)
        WHERE id_play_character = NEW.id_play_character;
    END IF;
	
    RETURN NEW;
END;
$atualizar_xp_missao_obter_item$ LANGUAGE plpgsql;

CREATE TRIGGER atualizar_xp_missao_obter_item_trigger
AFTER UPDATE ON CUMPRE_MISSAO
FOR EACH ROW
EXECUTE FUNCTION atualizar_xp_missao_obter_item();

CREATE OR REPLACE PROCEDURE concluir_missao(
    p_id_missao CHAR(7),
    p_id_play_character CHAR(8)
)
LANGUAGE plpgsql AS $concluir_missao$
BEGIN
    UPDATE CUMPRE_MISSAO
    SET status = TRUE
    WHERE id_missao = p_id_missao AND id_play_character = p_id_play_character;
END;
$concluir_missao$;

-- Trigger para atualizar o nível quando o XP é alterado

CREATE OR REPLACE FUNCTION atualizar_nivel()
RETURNS TRIGGER AS $atualizar_nivel$
BEGIN
    IF NEW.xp > (SELECT XP_MAXIMO FROM NIVEL WHERE id_nivel = NEW.nivel) THEN
        -- Aumenta o nível se o XP atual for maior que o XP máximo para o nível atual
        UPDATE PLAY_CHARACTER
        SET nivel = (SELECT id_nivel FROM NIVEL WHERE NEW.xp >= xp_minimo ORDER BY xp_minimo DESC LIMIT 1)
        WHERE id_play_character = NEW.id_play_character;
    END IF;
    RETURN NEW;
END;
$atualizar_nivel$ LANGUAGE plpgsql;

-- Trigger para chamar a função quando o XP é atualizado
CREATE TRIGGER atualizar_nivel_trigger
AFTER UPDATE ON PLAY_CHARACTER
FOR EACH ROW
WHEN (NEW.xp <> OLD.xp)  -- A trigger só será acionada se o XP for alterado
EXECUTE FUNCTION atualizar_nivel();

-- Garantir consistência quando for inserir em MAGIA_HUMANOIDE

CREATE OR REPLACE FUNCTION verificar_insert_magia_humanoide()
RETURNS TRIGGER AS $verificar_insert_magia_humanoide$
BEGIN
    -- Verifica se o nível é 1 e o dano é igual ao dano_inicial
    IF NEW.nivel <> 1 OR NEW.dano <> (SELECT dano_inicial FROM MAGIA WHERE id_magia = NEW.id_magia) THEN
        RAISE EXCEPTION 'Os valores de nivel e dano em MAGIA_HUMANOIDE devem ser 1 e igual ao dano_inicial em MAGIA.';
    END IF;
    RETURN NEW;
END;
$verificar_insert_magia_humanoide$ LANGUAGE plpgsql;

-- Trigger para chamar a função antes do INSERT em MAGIA_HUMANOIDE
CREATE TRIGGER trigger_verificar_insert_magia_humanoide
BEFORE INSERT ON MAGIA_HUMANOIDE
FOR EACH ROW
EXECUTE FUNCTION verificar_insert_magia_humanoide();


-- Trigger para atualizar nível de magia de um humanoide

CREATE OR REPLACE FUNCTION atualizar_magia_humanoide()
RETURNS TRIGGER AS $atualizar_magia_humanoide$
DECLARE
    v_id_personagem CHAR(8);
    v_novo_nivel INTEGER;
BEGIN
    -- Obtém o ID do personagem
    v_id_personagem := NEW.id_play_character;

    -- Verifica se o personagem possui uma entrada na tabela MAGIA_HUMANOIDE
    IF NOT EXISTS (SELECT 1 FROM MAGIA_HUMANOIDE WHERE id_humanoide = v_id_personagem) THEN
        RETURN NEW;
    END IF;

    -- Verifica se houve mudança de nível
    IF NEW.nivel <> OLD.nivel THEN
    

        -- Atualiza o nível na tabela MAGIA_HUMANOIDE
        UPDATE MAGIA_HUMANOIDE
        SET nivel =  nivel + 1,  -- Incrementa o nível
            dano = dano + 10      -- Aumenta o dano em 10 pontos
        WHERE id_humanoide = v_id_personagem;

        -- Adicione mais condições ou ajustes conforme necessário para outros níveis
    END IF;

    RETURN NEW;
END;
$atualizar_magia_humanoide$ LANGUAGE plpgsql;

-- Trigger para chamar a função quando o XP ou o nível são atualizados
CREATE TRIGGER atualizar_magia_humanoide_trigger
AFTER UPDATE ON PLAY_CHARACTER
FOR EACH ROW
WHEN ( NEW.nivel <> OLD.nivel)  -- A trigger só será acionada se o nível for alterado
EXECUTE FUNCTION atualizar_magia_humanoide();

-- Garantir integridade dos tipos itens: Cnsumível.

CREATE OR REPLACE FUNCTION total_exclusivo_consumivel()
RETURNS TRIGGER AS $total_exclusivo_consumivel$
BEGIN
    IF(TG_OP = 'INSERT')THEN
    	IF EXISTS (SELECT 1 FROM TIPO_ITEM WHERE id_item = NEW.id_consumivel) THEN
        	RAISE EXCEPTION 'Chave duplicada na tabela TIPO_ITEM.';
    	END IF;

    	INSERT INTO TIPO_ITEM (id_item, tipo_item)
    	VALUES (NEW.id_consumivel, 'Consumivel');
	
	END IF;
	
	IF(TG_OP = 'DELETE')THEN
		DELETE FROM TIPO_ITEM WHERE id_item = OLD.id_consumivel;
	END IF;
    RETURN NEW;
END;
$total_exclusivo_consumivel$ LANGUAGE plpgsql;

CREATE TRIGGER total_exclusivo_consumivel
BEFORE INSERT OR DELETE ON CONSUMIVEL
FOR EACH ROW
EXECUTE FUNCTION total_exclusivo_consumivel();

-- Garantir integridade dos tipos itens: Vestimenta

CREATE OR REPLACE FUNCTION total_exclusivo_vestimenta()
RETURNS TRIGGER AS $total_exclusivo_vestimenta$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        IF EXISTS (SELECT 1 FROM TIPO_ITEM WHERE id_item = NEW.id_vestimenta) THEN
            RAISE EXCEPTION 'Chave duplicada na tabela TIPO_ITEM.';
        END IF;

        INSERT INTO TIPO_ITEM (id_item, tipo_item)
        VALUES (NEW.id_vestimenta, 'Vestimenta');

    END IF;

    IF (TG_OP = 'DELETE') THEN
        DELETE FROM TIPO_ITEM WHERE id_item = OLD.id_vestimenta;
    END IF;

    RETURN NEW;
END;
$total_exclusivo_vestimenta$ LANGUAGE plpgsql;

CREATE TRIGGER total_exclusivo_vestimenta
BEFORE INSERT OR DELETE ON VESTIMENTA
FOR EACH ROW
EXECUTE FUNCTION total_exclusivo_vestimenta();

-- Garantir integridade dos tipos itens: Arma

CREATE OR REPLACE FUNCTION total_exclusivo_arma()
RETURNS TRIGGER AS $total_exclusivo_arma$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        IF EXISTS (SELECT 1 FROM TIPO_ITEM WHERE id_item = NEW.id_arma) THEN
            RAISE EXCEPTION 'Chave duplicada na tabela TIPO_ITEM.';
        END IF;

        INSERT INTO TIPO_ITEM (id_item, tipo_item)
        VALUES (NEW.id_arma, 'Arma');

    END IF;

    IF (TG_OP = 'DELETE') THEN
        DELETE FROM TIPO_ITEM WHERE id_item = OLD.id_arma;
    END IF;

    RETURN NEW;
END;
$total_exclusivo_arma$ LANGUAGE plpgsql;

CREATE TRIGGER total_exclusivo_arma
BEFORE INSERT OR DELETE ON ARMA
FOR EACH ROW
EXECUTE FUNCTION total_exclusivo_arma();

--  Garantir integridade dos tipos itens: Gema

CREATE OR REPLACE FUNCTION total_exclusivo_gema()
RETURNS TRIGGER AS $total_exclusivo_gema$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        IF EXISTS (SELECT 1 FROM TIPO_ITEM WHERE id_item = NEW.id_gema) THEN
            RAISE EXCEPTION 'Chave duplicada na tabela TIPO_ITEM.';
        END IF;

        INSERT INTO TIPO_ITEM (id_item, tipo_item)
        VALUES (NEW.id_gema, 'Gema');

    END IF;

    IF (TG_OP = 'DELETE') THEN
        DELETE FROM TIPO_ITEM WHERE id_item = OLD.id_gema;
    END IF;

    RETURN NEW;
END;
$total_exclusivo_gema$ LANGUAGE plpgsql;

CREATE TRIGGER total_exclusivo_gema
BEFORE INSERT OR DELETE ON GEMA
FOR EACH ROW
EXECUTE FUNCTION total_exclusivo_gema();

-- Integridade de dados para consumiveis:

CREATE OR REPLACE FUNCTION validar_tipo_consumivel()
RETURNS TRIGGER AS $validar_tipo_consumivel$
BEGIN
    
    IF NEW.tipo_consumivel <> 'Force' AND NEW.tipo_consumivel <> 'Heal' AND NEW.tipo_consumivel <> 'Energy' THEN
        RAISE EXCEPTION 'Tipo de consumível inválido. Use "Force" para força, "Heal" para cura e "Energy" para energia.' USING HINT = 'Valores permitidos são "Force", "Heal" e "Energy".';
    END IF;


    RETURN NEW;
END;
$validar_tipo_consumivel$ LANGUAGE plpgsql;

CREATE TRIGGER validar_tipo_consumivel_trigger
BEFORE INSERT ON CONSUMIVEL
FOR EACH ROW
EXECUTE FUNCTION validar_tipo_consumivel();


-- Relação ce consumir em determinado nível:
CREATE OR REPLACE PROCEDURE consumir(
    p_id_instancia_item CHAR(8),
    p_id_play_character CHAR(7)
)
LANGUAGE plpgsql AS $consumir$
DECLARE
    v_tipo_consumivel CHAR(20);
    v_aumento INTEGER;
BEGIN
    -- Verifica se a instância do item é consumível e obtém o tipo e o aumento
    SELECT ci.tipo_consumivel, c.aumento
    INTO v_tipo_consumivel, v_aumento
    FROM INSTANCIA_ITEM ci
    JOIN CONSUMIVEL c ON ci.id_item = c.id_consumivel
    WHERE ci.id_instancia_item = p_id_instancia_item;

    IF v_tipo_consumivel IS NULL THEN
        RAISE EXCEPTION 'O item informado não é um consumível válido!';
    END IF;

    -- Verifica se já existe uma tupla na tabela consome
    UPDATE CONSOME
    SET quantidade = quantidade + 1
    WHERE id_consumivel = p_id_instancia_item
        AND id_play_character = p_id_play_character;

    IF NOT FOUND THEN
        -- Se não existir, insere na tabela consome com quantidade 1
        INSERT INTO CONSOME (id_consumivel, id_play_character, quantidade)
        VALUES (p_id_instancia_item, p_id_play_character, 1);
    END IF;

    -- Atualiza o Play_character conforme o tipo de consumível
    UPDATE PLAY_CHARACTER
    SET vida_atual = LEAST(vida_maxima, vida_atual + CASE WHEN v_tipo_consumivel = 'Heal' THEN v_aumento ELSE 0 END),
        mana_atual = LEAST(mana_max, mana_atual + CASE WHEN v_tipo_consumivel = 'Force' THEN v_aumento ELSE 0 END),
        stamina_atual = LEAST(stamina_max, stamina_atual + CASE WHEN v_tipo_consumivel = 'Energy' THEN v_aumento ELSE 0 END)
    WHERE id_play_character = p_id_play_character;

END;
$consumir$;

-- Trigger para quantidade máxima:
CREATE OR REPLACE FUNCTION check_quantidade_limite()
RETURNS TRIGGER AS $check_quantidade_limite$
BEGIN
    -- Verifica se a quantidade é menor ou igual a 3
    IF NEW.quantidade > 3 THEN
        RAISE EXCEPTION 'A quantidade de consumo deve ser no máximo 3.';
    END IF;

    RETURN NEW;
END;
$check_quantidade_limite$ LANGUAGE plpgsql;

CREATE TRIGGER check_quantidade_limite_trigger
BEFORE INSERT OR UPDATE ON CONSOME
FOR EACH ROW
EXECUTE FUNCTION check_quantidade_limite();

-- Trigger zerar a quantidade quando passar de nivel
CREATE OR REPLACE FUNCTION zerar_quantidade_nivel()
RETURNS TRIGGER AS $zerar_quantidade_nivel$
BEGIN
    -- Zera a quantidade quando o Play_character passa de nível
    UPDATE CONSOME
    SET quantidade = 0
    WHERE id_play_character = NEW.id_play_character;

    RETURN NEW;
END;
$zerar_quantidade_nivel$ LANGUAGE plpgsql;

-- Trigger para executar quando o nível do Play_character é atualizado
CREATE TRIGGER zerar_quantidade_nivel_trigger
AFTER UPDATE OF nivel ON PLAY_CHARACTER
FOR EACH ROW
EXECUTE FUNCTION zerar_quantidade_nivel();



--Atualização da mana com o uso de magia com combate:
-- Atualização da mana com o uso de magia com combate:
CREATE OR REPLACE PROCEDURE uso_magia(
    p_id_play_character CHAR(8),
    p_id_magia CHAR(7),
    p_id_instancia_npc CHAR(8))
AS $uso_magia$
DECLARE
    v_custo_mana INTEGER;
    v_dano_magia INTEGER;
    v_vida_atual_npc FLOAT;
BEGIN
    -- Verificar se o play_character pode fazer a magia correspondente
    IF NOT EXISTS (
        SELECT 1
        FROM MAGIA_HUMANOIDE mh
        WHERE mh.id_humanoide = p_id_play_character
          AND mh.id_magia = p_id_magia
    ) THEN
        RAISE EXCEPTION 'Play_character não pode fazer a magia correspondente';
    END IF;

    -- Obter custo_mana e dano_magia da tabela MAGIA_HUMANOIDE
    SELECT mh.dano, m.custo_mana
    INTO v_dano_magia, v_custo_mana
    FROM MAGIA_HUMANOIDE mh
    JOIN MAGIA m ON mh.id_magia = m.id_magia
    WHERE mh.id_humanoide = p_id_play_character
      AND mh.id_magia = p_id_magia;

    -- Verificar se o play_character tem mana suficiente
    IF (SELECT mana_atual FROM PLAY_CHARACTER WHERE id_play_character = p_id_play_character) >= v_custo_mana THEN
        -- Atualizar mana do play_character
        UPDATE PLAY_CHARACTER
        SET mana_atual = mana_atual - v_custo_mana
        WHERE id_play_character = p_id_play_character;

        -- Calcular dano no NPC
        SELECT vida_atual
        INTO v_vida_atual_npc
        FROM INSTANCIA_NPC
        WHERE id_instancia_npc = p_id_instancia_npc;

        -- Calcular dano no NPC considerando a fórmula fornecida
        v_vida_atual_npc := v_vida_atual_npc - (v_dano_magia / ((SELECT nivel FROM NOT_PLAY_CHARACTER WHERE id_npc = (SELECT id_npc FROM INSTANCIA_NPC WHERE id_instancia_npc = p_id_instancia_npc)) + (SELECT nivel FROM INSTANCIA_NPC WHERE id_instancia_npc = p_id_instancia_npc)));

        -- Atualizar a vida do NPC
        UPDATE INSTANCIA_NPC
        SET vida_atual = v_vida_atual_npc
        WHERE id_instancia_npc = p_id_instancia_npc;

        -- Verificar se o NPC está morto e inserir em ESTA_MORTO
        IF v_vida_atual_npc <= 0 THEN
            INSERT INTO ESTA_MORTO (id_play_character, id_instancia_npc)
            VALUES (p_id_play_character, p_id_instancia_npc);

            RAISE NOTICE 'Personagem morto';
        END IF;

        -- Aqui você pode adicionar mais lógica, se necessário, para outras ações.
    ELSE
        RAISE EXCEPTION 'Mana insuficiente para lançar a magia';
    END IF;
END;
$uso_magia$ LANGUAGE plpgsql;



--- Garantir integridade em Missões de matar_npc
CREATE OR REPLACE FUNCTION inserir_missao_matar_npc()
    RETURNS TRIGGER AS $inserir_missao_matar_npc$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            -- Verifica se a chave já existe em TIPO_MISSAO
            IF EXISTS (SELECT 1 FROM MISSAO_OBTER_ITEM WHERE id_missao = NEW.id_missao) THEN
                RAISE EXCEPTION 'Já foi cadastrada uma chave identica em MISSAO_OBTER_ITEM';
            END IF;
			
			
        END IF;

        IF TG_OP = 'DELETE' THEN
            DELETE FROM TIPO_MISSAO WHERE id_MISSAO = OLD.id_missao;
        END IF;

        RETURN NEW;
    END;
    $inserir_missao_matar_npc$ LANGUAGE plpgsql;

CREATE TRIGGER inserir_missao_matar_npc
    BEFORE INSERT OR DELETE ON MISSAO_MATAR_NPC
    FOR EACH ROW
    EXECUTE FUNCTION inserir_missao_matar_npc();

--- Garantir integridade em missãos obter item:

CREATE OR REPLACE FUNCTION inserir_missao_obter_item()
    RETURNS TRIGGER AS $inserir_missao_obter_item$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            -- Verifica se a chave já existe em TIPO_MISSAO
            IF EXISTS (SELECT 1 FROM MISSAO_MATAR_NPC WHERE id_missao = NEW.id_missao) THEN
                RAISE EXCEPTION 'Já foi cadastrada uma chave identica em MISSAO_MATAR_NPC';
            END IF;
			
			
        END IF;

        IF TG_OP = 'DELETE' THEN
            DELETE FROM TIPO_MISSAO WHERE id_MISSAO = OLD.id_missao;
        END IF;

        RETURN NEW;
    END;
    $inserir_missao_obter_item$ LANGUAGE plpgsql;

CREATE TRIGGER inserir_missao_obter_item
    BEFORE INSERT OR DELETE ON MISSAO_OBTER_ITEM
    FOR EACH ROW
    EXECUTE FUNCTION inserir_missao_obter_item();

--- Garantir integridade quando for realizar um encantamento:
CREATE OR REPLACE PROCEDURE realizar_encantamento(
    p_id_play_character CHAR(8),
    p_id_encantamento CHAR(7)
)
LANGUAGE plpgsql AS $realizar_encantamento$
DECLARE
    v_id_inventario CHAR(7);
	v_id_gema CHAR(7);
    v_qtd_gemas INTEGER;
    v_gema_valida BOOLEAN;
BEGIN
    -- Obtém o id_inventario do Play Character
    SELECT id_inventario
    INTO v_id_inventario
    FROM PLAY_CHARACTER
    WHERE id_play_character = p_id_play_character;
	
	-- Verificar a gema do encantamento
	SELECT id_gema
    INTO v_id_gema
    FROM PROPORCIONA_ENCANTAMENTO
    WHERE id_encantamento = p_id_encantamento;

    -- Verifica quantas gemas do encantamento o Play Character possui no inventário
    SELECT COUNT(*)
    INTO v_qtd_gemas
    FROM INSTANCIA_ITEM i
    JOIN GEMA ON i.id_item = GEMA.id_gema
    WHERE i.local_inventario = v_id_inventario
      AND GEMA.id_gema = v_id_gema;

    -- Se o Play Character possui mais de uma gema, verifica se alguma é válida
    IF v_qtd_gemas > 0 THEN
        -- Verifica se pelo menos uma gema é válida para o encantamento
        SELECT EXISTS (
            SELECT 1
            FROM PROPORCIONA_ENCANTAMENTO pe
            WHERE pe.id_gema = v_id_gema
        )
        INTO v_gema_valida;

        IF NOT v_gema_valida THEN
            RAISE EXCEPTION 'Nenhuma gema válida para o encantamento encontrada no inventário.';
        END IF;

        -- Verifica se o Play Character pode realizar o encantamento (status = TRUE)
        IF NOT EXISTS (
            SELECT 1
            FROM APRENDER_ENCANTAMENTO
            WHERE id_play_character = p_id_play_character
              AND id_encantamento = p_id_encantamento
              AND status = TRUE
        ) THEN
            RAISE EXCEPTION 'Play Character não sabe o encantamento.';
        END IF;

        -- Lógica para realizar o encantamento
        -- Adicione aqui o código para aplicar o encantamento


    ELSE
        RAISE EXCEPTION 'Play Character não possui a gema necessária para o encantamento no inventário.';
    END IF;

END;
$realizar_encantamento$;

--- Inserir na tabela aprende_encantamento

CREATE OR REPLACE FUNCTION inserir_aprendizado_encantamentos()
RETURNS TRIGGER AS $inserir_aprendizado_encantamentos$
BEGIN
    -- Inserir aprendizado para todos os tipos de encantamento com status FALSE
    INSERT INTO APRENDER_ENCANTAMENTO (id_encantamento, id_play_character, status)
    SELECT id_encantamento, NEW.id_play_character, FALSE
    FROM TIPO_ENCANTAMENTO;

    RETURN NEW;
END;
$inserir_aprendizado_encantamentos$ LANGUAGE plpgsql;

CREATE TRIGGER inserir_aprendizado_encantamentos
AFTER INSERT ON PLAY_CHARACTER
FOR EACH ROW
EXECUTE FUNCTION inserir_aprendizado_encantamentos();

-- Integridade em encantamento total exclusivo vestimenta
CREATE OR REPLACE FUNCTION total_exclusivo_encantamento_vestimenta()
RETURNS TRIGGER AS $total_exclusivo_encantamento_vestimenta$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        IF EXISTS (SELECT 1 FROM TIPO_ENCANTAMENTO WHERE id_encantamento = NEW.id_encantamento) THEN
            RAISE EXCEPTION 'Chave duplicada na tabela TIPO_ENCANTAMENTO.';
        END IF;

        INSERT INTO TIPO_ENCANTAMENTO (id_encantamento, tipo_encatamento)
        VALUES (NEW.id_encantamento, 'Encantamento de Vestimenta');

    END IF;

    IF (TG_OP = 'DELETE') THEN
        DELETE FROM TIPO_ENCANTAMENTO WHERE id_encantamento = OLD.id_encantamento;
    END IF;

    RETURN NEW;
END;
$total_exclusivo_encantamento_vestimenta$ LANGUAGE plpgsql;

CREATE TRIGGER total_exclusivo_encantamento_vestimenta
BEFORE INSERT OR DELETE ON ENCANTAMENTO_VESTIMENTA
FOR EACH ROW
EXECUTE FUNCTION total_exclusivo_encantamento_vestimenta();

-- Integridade em encantamento total exclusivo arma

CREATE OR REPLACE FUNCTION total_exclusivo_encantamento_arma()
RETURNS TRIGGER AS $total_exclusivo_encantamento_arma$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        IF EXISTS (SELECT 1 FROM TIPO_ENCANTAMENTO WHERE id_encantamento = NEW.id_encantamento) THEN
            RAISE EXCEPTION 'Chave duplicada na tabela TIPO_ENCANTAMENTO.';
        END IF;

        INSERT INTO TIPO_ENCANTAMENTO (id_encantamento, tipo_encatamento)
        VALUES (NEW.id_encantamento, 'Encantamento de Arma');

    END IF;

    IF (TG_OP = 'DELETE') THEN
        DELETE FROM TIPO_ENCANTAMENTO WHERE id_encantamento = OLD.id_encantamento;
    END IF;

    RETURN NEW;
END;
$total_exclusivo_encantamento_arma$ LANGUAGE plpgsql;

CREATE TRIGGER total_exclusivo_encantamento_arma
BEFORE INSERT OR DELETE ON ENCANTAMENTO_ARMA
FOR EACH ROW
EXECUTE FUNCTION total_exclusivo_encantamento_arma();


-- Procede para o uso da habilidade

CREATE OR REPLACE PROCEDURE uso_habilidade(
    p_id_play_character CHAR(8),
    p_id_habilidade CHAR(7),
    p_id_instancia_npc CHAR(8))
AS $uso_habilidade$
DECLARE
    v_custo_stamina INTEGER;
    v_dano_habilidade INTEGER;
    v_vida_atual_npc FLOAT;
BEGIN
    -- Verificar se a habilidade pertence à espécie do personagem
    IF NOT EXISTS (
        SELECT 1
        FROM ESPECIE_HUMANOIDE eh
        WHERE eh.id_humanoide = p_id_play_character
          AND eh.id_habilidade = p_id_habilidade
    ) THEN
        RAISE EXCEPTION 'Esta habilidade não pertence à especie do personagem citado';
    END IF;

    -- Obter custo_stamina e dano_habilidade da tabela ESPECIE_HUMANOIDE
    SELECT eh.dano, h.custo_stamina
    INTO v_dano_habilidade, v_custo_stamina
    FROM ESPECIE_HUMANOIDE eh
    JOIN HABILIDADE_ESPECIE h ON eh.id_habilidade = h.id_habilidade
    WHERE eh.id_humanoide = p_id_play_character
      AND eh.id_habilidade = p_id_habilidade;

    -- Verificar se o play_character tem stamina suficiente
    IF (SELECT stamina_atual FROM PLAY_CHARACTER WHERE id_play_character = p_id_play_character) >= v_custo_stamina THEN
        -- Atualizar stamina do play_character
        UPDATE PLAY_CHARACTER
        SET stamina_atual = stamina_atual - v_custo_stamina
        WHERE id_play_character = p_id_play_character;

        -- Calcular dano na NPC
        SELECT vida_atual
        INTO v_vida_atual_npc
        FROM INSTANCIA_NPC
        WHERE id_instancia_npc = p_id_instancia_npc;

        -- Calcular dano na NPC considerando a fórmula fornecida
        v_vida_atual_npc := v_vida_atual_npc - (v_dano_habilidade / ((SELECT nivel FROM NOT_PLAY_CHARACTER WHERE id_npc = (SELECT id_npc FROM INSTANCIA_NPC WHERE id_instancia_npc = p_id_instancia_npc)) + (SELECT nivel FROM INSTANCIA_NPC WHERE id_instancia_npc = p_id_instancia_npc)));

        -- Atualizar a vida do NPC
        UPDATE INSTANCIA_NPC
        SET vida_atual = v_vida_atual_npc
        WHERE id_instancia_npc = p_id_instancia_npc;

        -- Verificar se o NPC está morto e inserir em ESTA_MORTO
        IF v_vida_atual_npc <= 0 THEN
            INSERT INTO ESTA_MORTO (id_play_character, id_instancia_npc)
            VALUES (p_id_play_character, p_id_instancia_npc);

            RAISE NOTICE 'Personagem morto';
        END IF;

        -- Adicionar mais lógica, se necessário, para outras ações.
    ELSE
        RAISE EXCEPTION 'Stamina insuficiente para usar a habilidade';
    END IF;
END;
$uso_habilidade$ LANGUAGE plpgsql;

-- Atualizar o nível da habilidade de acordo com a passagem de nível do personagem

CREATE OR REPLACE FUNCTION atualizar_especie_humanoide()
RETURNS TRIGGER AS $atualizar_especie_humanoide$
DECLARE
    v_id_personagem CHAR(8);
    v_novo_nivel INTEGER;
BEGIN
    -- Obtém o ID do personagem
    v_id_personagem := NEW.id_play_character;

    -- Verifica se o personagem possui uma entrada na tabela ESPECIE_HUMANOIDE
    IF NOT EXISTS (SELECT 1 FROM ESPECIE_HUMANOIDE WHERE id_humanoide = v_id_personagem) THEN
        RETURN NEW;
    END IF;

    -- Verifica se houve mudança de nível
    IF NEW.nivel <> OLD.nivel THEN
        -- Atualiza o nível na tabela ESPECIE_HUMANOIDE
        UPDATE ESPECIE_HUMANOIDE
        SET nivel = nivel + 1,  -- Incrementa o nível
            dano = dano + 10      -- Aumenta o dano em 10 pontos (ajuste conforme necessário)
        WHERE id_humanoide = v_id_personagem;

    END IF;

    RETURN NEW;
END;
$atualizar_especie_humanoide$ LANGUAGE plpgsql;

-- Trigger para chamar a função quando o XP ou o nível são atualizados
CREATE TRIGGER atualizar_especie_humanoide_trigger
AFTER UPDATE ON PLAY_CHARACTER
FOR EACH ROW
WHEN (NEW.nivel <> OLD.nivel)  -- A trigger só será acionada se o nível for alterado
EXECUTE FUNCTION atualizar_especie_humanoide();

----------------------------------------------------------------------------------------

drop procedure if exists PILHAR_ITEM;
create procedure PILHAR_ITEM(DESTINO_INV CHAR(7), ITEM_PILHADO CHAR(8)) AS $$
DECLARE
	ITEM CHAR(7);
    CONTAGEM INTEGER;
    ID_NOVO CHAR(30);
BEGIN
	ID_NOVO := 'IITEM';
	SELECT ID_ITEM INTO ITEM FROM INSTANCIA_ITEM WHERE ID_INSTANCIA = ITEM_PILHADO;
    SELECT COUNT(*) INTO CONTAGEM FROM INSTANCIA_ITEM;
	ID_NOVO := ID_NOVO || CAST(CONTAGEM AS CHAR(3));
        insert into INSTANCIA_ITEM (ID_INSTANCIA_ITEM, ID_ITEM, LOCAL_INVENTARIO, EQP_STATUS) 
        	VALUES (ID_NOVO, ITEM, DESTINO_INV, 0);
END;
$$ lANGUAGE plpgsql;

--- DAR_DANO_ARMA
drop procedure if exists dar_dano_arma;
CREATE PROCEDURE DAR_DANO_ARMA(NPC CHAR(8), ARMA CHAR(7)) AS $$
DECLARE 
	DANO_ARMA INTEGER;
BEGIN
	SELECT DANO INTO DANO_ARMA FROM ARMA WHERE ID_ARMA = ARMA;
    UPDATE INSTANCIA_NPC SET VIDA_ATUAL = VIDA_ATUAL - DANO_ARMA WHERE ID_INSTANCIA_NPC = NPC;
END;
$$ LANGUAGE PLPGSQL;


--- DEIXA_MORTO

DROP PROCEDURE IF EXISTS DEIXA_MORTO;
CREATE PROCEDURE DEIXA_MORTO(NPC CHAR(8), PC CHAR(8)) AS $$
BEGIN
	IF (SELECT VIDA_ATUAL FROM INSTANCIA_NPC WHERE ID_INSTANCIA_NPC = NPC) > 0
	THEN RAISE EXCEPTION 'AINDA NÃO MORREU';
    	
    INSERT INTO ESTA_MORTO VALUES(PC, NPC);
	END IF;
END;
$$ LANGUAGE PLPGSQL;




-- Integridade em encantamento vestimenta.

-- TESTE:

INSERT INTO REGIAO (id_regiao, nome)
VALUES ('REG0001', 'Região de Exemplo');

-- Inserção de Local
INSERT INTO LUGAR (id_local, nome_local, id_regiao)
VALUES ('LOC0001', 'Local de Exemplo', 'REG0001');

-- Inserção de Sala
INSERT INTO SALA (id_sala, nome_sala, id_local)
VALUES ('ROOM001', 'Sala de Exemplo', 'LOC0001');

-- Inserção de Tipo de Personagem História


INSERT INTO INVENTARIO (id_inventario, peso_maximo, carteira, eh_loja)
VALUES ('INV0001', 50.0, 100, FALSE);
INSERT INTO INVENTARIO (id_inventario, peso_maximo, carteira, eh_loja)
VALUES ('INV0002', 50.0, 100, FALSE);


INSERT INTO VESTIMENTA (id_vestimenta, nome, valor, peso, tipo_vestimenta, resistencia, parte_corpo)
VALUES ('ITEM003', 'Vestimento de Aventura', 50, 5.0, 'Robe', 10, 'Torso');

INSERT INTO ENCANTAMENTO_VESTIMENTA (id_encantamento, id_vestimenta, elemento, resistencia)
VALUES ('ENCV001', 'ITEM003', 'Fogo', 5);


-- Inserção na tabela nivel
INSERT INTO NIVEL (id_nivel, xp_minimo, XP_MAXIMO)
VALUES ('N01', 0, 50);

INSERT INTO NIVEL (id_nivel, xp_minimo, XP_MAXIMO)
VALUES ('N02', 50, 70);

INSERT INTO PLAY_CHARACTER (id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario)
VALUES ('CHAR0001', 'Personagem', 'N01', 1, 10, 10, 10, 99, 10, 10, 'ROOM001', 'INV0001');

INSERT INTO NOT_PLAY_CHARACTER (id_npc, nome, nivel, xp, vida_maxima, mana_max, stamina_max)
VALUES ('CHAR0002', 'PersonagemN', 1, 50, 100, 99, 99);

INSERT INTO INSTANCIA_NPC (id_instancia_npc, id_npc, nivel, vida_atual, mana_atual, stamina_atual, id_sala, id_inventario)
VALUES ('INPC0001', 'CHAR0002', 2, 20, 10, 10, 'ROOM001', 'INV0002');

INSERT INTO TIPO_MISSAO (id_missao, tipo_objetivo, obrigatoria)
VALUES ('MIS0001', 'Objetivo de Exemplo', TRUE);

INSERT INTO MISSAO_MATAR_NPC (id_missao, xp_missao, nome_missao, id_pre_requisito, id_instancia_npc, tipo_npc)
VALUES ('MIS0001', 60, 'Missão de Matar NPC', NULL, 'INPC0001', 'CHAR0002');


INSERT INTO MAGIA (id_magia, nome, elemento, dano_inicial, custo_mana)
VALUES ('MAG0001', 'Magia de Fogo', 'Fogo', 60, 8);



-- Inserir na tabela HABILIDADE_ESPECIE
INSERT INTO HABILIDADE_ESPECIE (id_habilidade, nome, mod_vida, mod_stamina, mod_mana, mod_defesa_frio, mod_defesa_fogo, mod_defesa_eletr)
VALUES ('HAB0001', 'Habilidade Teste', 10, 20, 30, 40, 50, 60);

-- Inserir na tabela ESPECIE
INSERT INTO ESPECIE (id_especie, nome, id_habilidade)
VALUES ('ESPEC01', 'Especie Teste', 'HAB0001');

-- Inserir na tabela HUMANOIDE
INSERT INTO HUMANOIDE (id_humanoide, eqp_bota, eqp_luva, eqp_calça, eqp_colar, eqp_peitoral, eqp_anel, eqp_cabeça, mao_esq, mao_dir, id_especie, vida_maxima, mana_max, stamina_max)
VALUES ('CHAR0001', TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, 'ESPEC01', 100, 100, 100);

INSERT INTO CONSUMIVEL (id_consumivel, nome, valor, peso, tipo_consumivel, aumento)
VALUES ( 'ITEM001', 'Bebida de fogo', 12, 22.2, 'Heal', 10);

INSERT INTO GEMA (id_gema, nome, valor, peso, potencia)
VALUES ('ITEM002', 'Gema de Cristal', 34, 2.5, 8);

INSERT INTO INSTANCIA_ITEM (id_instancia_item, id_item, tipo_local, local_inventario, local_sala, eqp_status)
VALUES ('IITEM002', 'ITEM002', 'Inventário', 'INV0001', NULL , FALSE);

INSERT INTO INSTANCIA_ITEM (id_instancia_item, id_item, tipo_local, local_inventario, local_sala, eqp_status)
VALUES ('IITEM001', 'ITEM001', 'Sala', NULL, 'ROOM001', FALSE);

INSERT INTO MAGIA_HUMANOIDE (id_humanoide, id_magia, nivel, dano)
VALUES ('CHAR0001', 'MAG0001', 1, 60);


INSERT INTO MISSAO_NIVEL (ID_MISSAO, ID_NIVEL)
Values ('MIS0001', 'N01');

INSERT INTO CUMPRE_MISSAO (id_missao, id_play_character, status)
VALUES ('MIS0001', 'CHAR0001', FALSE);

INSERT INTO PROPORCIONA_ENCANTAMENTO(id_gema, id_encantamento)
VALUES ('ITEM002','ENCV001');

UPDATE APRENDER_ENCANTAMENTO 
SET status = TRUE
WHERE id_encantamento = 'ENCV001' AND id_play_character = 'CHAR0001';
--select * from cumpre_missao;

-- Atualização do nível

-- Trigger para atualizar o nível quando o XP é alterad


--CALL concluir_missao('MIS0001', 'CHAR0001');
--CALL consumir('ITEM001', 'CHAR0001');
CALL realizar_encantamento('CHAR0001', 'ENCV001');
--select * FROM PLAY_CHARACTER;
SELECT * FROM PLAY_CHARACTER;