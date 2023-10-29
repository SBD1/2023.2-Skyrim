# Criações das tabelas

Aqui são apresentados os códigos ou scripts utilizados para a criação das 30 tabelas do modelo relacional do jogo. 

## Sumário
* [A questão das id](#A-questão-das-id)

 * [REGIAO](#REGIAO)

 * [LOCAL](#LOCAL)

 * [SALA](#SALA)

 * [VIAGEM_SALAS](#VIAGEM_SALAS)
 * [TIPO_PERSONAGEM_HISTORIA](#TIPO_PERSONAGEM_HISTORIA)
 * [VIDA_PERSONAGEM](#VIDA_PERSONAGEM)
 * [HABILIDADE_ESPECIE](#HABILIDADE_ESPECIE)
 * [ESPECIE](#ESPECIE)
 * [HUMANOIDES](#HUMANOIDE)
 * [PLAY_CHARACTER](#PLAY_CHARACTER)
 * [MAGIA](#MAGIA)
 * [MAGIA_HUMANOIDE](#MAGIA_HUMANOIDE)
 * [NOT_PLAY_CHARACTER](#NOT_PLAY_CHARACTER)
 * [INSTANCIA_NPC](#INSTANCIA_NPC)
 * [GOLPES](#GOLPES)
 * [BESTA](#BESTA)
 * [GOLPES_BESTA](#GOLPES_BESTA)
 * [HOSTILIDADE](#HOSTILIDADE)
 * [TIPO_MISSAO](#TIPO_MISSAO)
 * [CUMPRE_MISSAO](#CUMPRE_MISSAO)
 * [DIALOGOS](#DIALOGOS)
 * [INVENTARIO](#INVENTARIO)
 * [MISSAO_MATAR_NPC](#MISSAO_MATAR_NPC)
 * [TIPO_ITEM](#TIPO_ITEM)
 * [INSTANCIA_ITEM](#INSTANCIA_ITEM)
 * [VESTIMENTA](#VESTIMENTA)
 * [ENCANTAMENTO_VESTIMENTA](#ENCANTAMENTO_VESTIMENTA)
 * [ARMA](#ARMA)
 * [ENCANTAMENTO_ARMA](#ENCANTAMENTO_ARMA)
 * [MISSAO_OBTER_ITEM](#MISSAO_OBTER_ITEM)



## A questão das id:
Para a criação das ids de cada tabela, foram levados em consideração padroẽs para cada um, ou seja, cada id será avaliada por um conjunto de regras para por der cadastrada no banco.

### Regras
- **REGIAO** → “REG” + 4 Números.
  - **Exemplo**: REG0001
- **LOCAL** → “LOC” + 4 Números.
    - **Exemplo**: LOC0001
- **SALA** → “ROOM” + 3 Números.
    - **Exemplo**: ROOM001
- **HABILIDADE_ESPECIE** → “HAB” + 4 Números.
    - **Exemplo**: HAB0001
- **ESPECIE** → “ESPEC” + 2 Números.
    - **Exemplo**: ESPEC20
- **TIPO_PERSONAGEM_HISTORIA**  → “CHAR” + 4 Números.
    - **Exemplo**: CHAR2244
    - **Observação**: É mesmo para o PC, o humanoide e o NPC.
- **MAGIA** → “MAG” + 4 Números.
    - **Exemplo**: MAG8888
- **INSTANCIA_NPC** → “INPC” + 4 Números.
    - **Exemplo**: INPC1234
- **INVENTÁRIO** → “INV” + 4 Números.
    - **Exemplo**: INV0001
- **TIPO_MISSAO** → “MIS” + 4 Números.
    - **Exemplo**: MIS3332
- **DIALOGOS** → “DIA” + 4 Números.
    - **Exemplo**: DIA0000
- **TIPO_ITEM** → “ITEM” + 3 Números.
    - **Exemplo**: ITEM012
- **INSTANCIA_ITEM** → “IITEM” + 3 Números.
    - **Exemplo**: IITEM012
- **ENCANTAMENTO VESTIMENTA** → “ENCV” + 3 Números.
    - **Exemplo**: ENCV080
- **VIAGEM_SALAS** → “V” + 6 Números.
    - **Exemplo**: V001234.
 
      
## REGIAO
    CREATE TABLE REGIAO(
    id_regiao CHAR(7) PRIMARY KEY,
    nome CHAR(30) UNIQUE NOT NULL,
    CONSTRAINT verificar_id_regiao
    CHECK (id_regiao LIKE 'REG%'
  		AND CAST(SUBSTRING(id_regiao, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
    	AND LENGTH(id_regiao) = 7 )
    );


## LOCAL
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

## SALA

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

## VIAGEM_SALAS
  
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

## TIPO_PERSONAGEM_HISTORIA

      CREATE TABLE TIPO_PERSONAGEM_HISTORIA (
      id_personagem CHAR(8) PRIMARY KEY,
     jogavel BOOLEAN,
     CONSTRAINT verificar_id_personagem
     CHECK( id_personagem LIKE 'CHAR%'
        AND CAST(SUBSTRING(id_personagem, 5,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_personagem) = 8)
    );

## VIDA_PERSONAGEM

      CREATE TABLE VIDA_PERSONAGEM(
      id_personagem CHAR(8) PRIMARY KEY,
      vida_maxima INTEGER CHECK (vida_maxima >= 0 AND vida_maxima <= 100),
      mana_max INTEGER CHECK (mana_max >= 0 AND mana_max <= 100),
      stamina_max INTEGER CHECK (stamina_max >= 0 AND stamina_max <= 100),
      CONSTRAINT fk_id_id_personagem
        FOREIGN KEY (id_personagem) REFERENCES TIPO_PERSONAGEM_HISTORIA(id_personagem)
  		ON DELETE RESTRICT
  	 	ON UPDATE CASCADE 
    );
      

## HABILIDADE_ESPECIE

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
      

## ESPECIE

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

## HUMANOIDE
      CREATE TABLE HUMANOIDE (
      id_humanoide CHAR(8) PRIMARY KEY,
     eqp_bota BOOLEAN,
     eqp_luva BOOLEAN,
     eqp_calça BOOLEAN,
     eqp_colar BOOLEAN,
     eqp_peitoral BOOLEAN,
     eqp_anel BOOLEAN,
     eqp_cabeça BOOLEAN,
     mão_esq BOOLEAN,
     mão_dir BOOLEAN,
     stamina_max INTEGER CHECK (stamina_max >= 0 AND stamina_max <= 100),
     mana_max INTEGER CHECK (mana_max >= 0 AND mana_max <= 100),
     id_especie CHAR(7),
     CONSTRAINT fk_id_humanoide
        FOREIGN KEY (id_humanoide) REFERENCES TIPO_PERSONAGEM_HISTORIA(id_personagem)
    		 ON DELETE RESTRICT
  	     ON UPDATE CASCADE, 
     CONSTRAINT fk_id_especie
         FOREIGN KEY (id_especie) REFERENCES ESPECIE(id_especie)
         ON DELETE RESTRICT
  	  	ON UPDATE CASCADE 
    );

## PLAY_CHARACTER

      CREATE TABLE PLAY_CHARACTER (
      id_play_character CHAR(8) PRIMARY KEY,
      nome CHAR(20) UNIQUE NOT NULL,
      nivel INTEGER CHECK (nivel >= 1 AND nivel <= 30),
      xp INTEGER CHECK (xp >= 0 AND xp <= 100),
      vida_atual INTEGER CHECK (vida_atual >= 0 AND vida_atual <= 100),
      mana_atual INTEGER CHECK (mana_atual >= 0 AND mana_atual <= 100),
      stamina_atual INTEGER CHECK (stamina_atual >= 0 AND stamina_atual <= 100),
      id_sala CHAR(7),
      CONSTRAINT fk_id_play_character
          FOREIGN KEY (id_play_character) REFERENCES TIPO_PERSONAGEM_HISTORIA(id_personagem)
    	  	ON DELETE RESTRICT
      	 	ON UPDATE CASCADE,
     CONSTRAINT fk_id_sala
       FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
    		ON DELETE RESTRICT
    	 	ON UPDATE CASCADE 
    );


## MAGIA

    CREATE TABLE MAGIA (
     id_magia CHAR(7) PRIMARY KEY,
    elemento CHAR(20) NOT NULL,
    dano INTEGER CHECK (dano >= 0 AND dano <= 100),
    nivel INTEGER CHECK (nivel >= 0 AND nivel <= 100),
    custo_mana INTEGER CHECK (custo_mana >= 0 AND custo_mana <= 100),
  	CONSTRAINT verificar_id_habilidade
  	CHECK( id_magia LIKE 'MAG%'
       AND CAST(SUBSTRING(id_magia, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_magia) = 7)
    );

## MAGIA_HUMANOIDE
    CREATE TABLE MAGIA_HUMANOIDE (
    id_humanoide CHAR(8),
    id_magia CHAR(7),
    PRIMARY KEY (id_humanoide, id_magia),
    FOREIGN KEY (id_humanoide) REFERENCES HUMANOIDE (id_humanoide)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_magia) REFERENCES MAGIA (id_magia)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    );   

## NOT_PLAY_CHARACTER
    CREATE TABLE NOT_PLAY_CHARACTER (
    id_npc CHAR(8) PRIMARY KEY,
    nome CHAR(20) UNIQUE NOT NULL,
    nivel INTEGER CHECK (nivel BETWEEN 1 AND 30),
    xp INTEGER CHECK (xp BETWEEN 0 AND 100),
    CONSTRAINT fk_id_npc
        FOREIGN KEY (id_npc) REFERENCES TIPO_PERSONAGEM_HISTORIA (id_personagem)
  		ON DELETE RESTRICT
        ON UPDATE CASCADE
    );


## INSTANCIA_NPC
    CREATE TABLE INSTANCIA_NPC (
    id_instancia_npc CHAR(8) PRIMARY KEY,
    id_npc CHAR(8),
    vida_atual INTEGER CHECK (vida_atual BETWEEN 0 AND 100),
    mana_atual INTEGER CHECK (mana_atual BETWEEN 0 AND 100),
    stamina_atual INTEGER CHECK (stamina_atual BETWEEN 0 AND 100),
    id_sala CHAR(7),
    CONSTRAINT fk_id_npc 
  		FOREIGN KEY (id_npc) REFERENCES NOT_PLAY_CHARACTER(id_npc)
  		ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_id_sala 
  		FOREIGN KEY (id_sala) REFERENCES SALA(id_sala)
  		ON DELETE RESTRICT
        ON UPDATE CASCADE
    );
 

## GOLPES
    CREATE TABLE GOLPES (
    id_golpe CHAR(7) PRIMARY KEY,
    nome CHAR(20) NOT NULL,
    dano INTEGER CHECK (dano BETWEEN 0 AND 100),
    elemento INTEGER CHECK (elemento BETWEEN 0 AND 100),
    CHECK( id_golpe LIKE 'STRO%'
       AND CAST(SUBSTRING(id_golpe, 5,3) AS INTEGER) BETWEEN 000 AND 999
       AND LENGTH(id_golpe) = 7)
    );
      

## BESTA

    CREATE TABLE BESTA (
    id_besta CHAR(8) PRIMARY KEY,
    mod_defesa_frio INTEGER,
    mod_defesa_fogo INTEGER,
    mod_defesa_raio INTEGER,
    FOREIGN KEY (id_besta) REFERENCES TIPO_PERSONAGEM_HISTORIA (id_personagem)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    );

## GOLPES_BESTA

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

## HOSTILIDADE

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

## TIPO_MISSAO

    CREATE TABLE TIPO_MISSAO (
    id_missao CHAR(7) PRIMARY KEY,
    tipo_objetivo CHAR(40),
    obrigatoria BOOLEAN
 	CHECK( id_missao LIKE 'MIS%'
       AND CAST(SUBSTRING(id_missao, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_missao) = 7)
    ); 

## CUMPRE_MISSAO

    CREATE TABLE CUMPRE_MISSAO (
    id_missao CHAR(7),
    id_play_character CHAR(8),
    status CHAR(20),
    PRIMARY KEY (id_missao, id_play_character),
    FOREIGN KEY (id_missao) REFERENCES TIPO_MISSAO (id_missao)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_play_character) REFERENCES PLAY_CHARACTER (id_play_character)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    );

## DIALOGOS

    CREATE TABLE DIALOGOS (
    id_dialogo CHAR(7),
    id_personagem CHAR(8),
    dialogo CHAR(50),
    missao CHAR(7),
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

## INVENTARIO

    CREATE TABLE INVENTARIO (
    id_dono CHAR(8) UNIQUE NOT NULL,
    id_inventario CHAR(7) PRIMARY KEY,
    peso_maximo FLOAT,
    carteira INTEGER,
    eh_loja BOOLEAN,
   	CHECK( id_inventario LIKE 'INV%'
       AND CAST(SUBSTRING(id_inventario, 4,4) AS INTEGER) BETWEEN 0000 AND 9999
       AND LENGTH(id_inventario) = 7),
    CONSTRAINT fk_dono
        FOREIGN KEY (id_dono) REFERENCES TIPO_PERSONAGEM_HISTORIA (id_personagem)
  		ON DELETE RESTRICT
        ON UPDATE CASCADE
    );

## MISSAO_MATAR_NPC

    CREATE TABLE MISSAO_MATAR_NPC (
    id_missao CHAR(7) PRIMARY KEY,
    nome_missao CHAR(20) UNIQUE NOT NULL,
    id_pre_requisito CHAR(7),
    id_instancia_npc CHAR(8),
    vida_atual_instancia INTEGER,
    nivel INTEGER CHECK (nivel BETWEEN 0 AND 100),
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

## TIPO_ITEM

    CREATE TABLE TIPO_ITEM (
    id_item CHAR(7) PRIMARY KEY,
    tipo_item CHAR(20) NOT NULL
  	CHECK( id_item LIKE 'ITEM%'
       AND CAST(SUBSTRING(id_item, 5,3) AS INTEGER) BETWEEN 000 AND 999
       AND LENGTH(id_item) = 7)
    );
      

## INSTANCIA_ITEM

    CREATE TABLE INSTANCIA_ITEM (
    id_instancia_item CHAR(8),
    id_item CHAR(7),
    tipo_lugar CHAR(30) NOT NULL,
    id_lugar CHAR(7),
    PRIMARY KEY (id_instancia_item, id_item),
    CHECK( id_instancia_item LIKE 'IITEM%'
       AND CAST(SUBSTRING(id_instancia_item, 6,3) AS INTEGER) BETWEEN 000 AND 999
       AND LENGTH(id_instancia_item) = 7),
    CONSTRAINT fk_id_item
        FOREIGN KEY (id_item) REFERENCES TIPO_ITEM (id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_id_lugar
        FOREIGN KEY (id_lugar) REFERENCES INVENTARIO(id_inventario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    );
  

## VESTIMENTA

    CREATE TABLE VESTIMENTA (
    id_vestimenta CHAR(7),
    nome CHAR(20) NOT NULL,
    valor INTEger NOT NULL,
    peso FLOAT CHECK (peso > 0),
    tipo_vestimenta CHAR(20) NOT NULL,
    resistencia INTEGER NOT NULL,
    parte_corpo CHAR(20) NOT NULL,
    eqp_status BOOLEAN NOT NULL,
    PRIMARY KEY (id_vestimenta),
    CONSTRAINT fk_id_vestimenta
        FOREIGN KEY (id_vestimenta) REFERENCES TIPO_ITEM (id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    );
    

## ENCANTAMENTO_VESTIMENTA

    CREATE TABLE ENCANTAMENTO_VESTIMENTA (
    id_encantamento CHAR(7) PRIMARY KEY,
    id_vestimenta CHAR(7) NOT NULL,
    elemento CHAR(20) NOT NULL,
    resistencia INTEGER NOT NULL,
  	CHECK( id_encantamento LIKE 'ENCV%'
       AND CAST(SUBSTRING(id_encantamento, 5,3) AS INTEGER) BETWEEN 000 AND 999
       AND LENGTH(id_encantamento) = 7),
    CONSTRAINT fk_id_vestimenta
        FOREIGN KEY (id_vestimenta) REFERENCES VESTIMENTA (id_vestimenta)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    );
    

## CONSUMIVEL

    CREATE TABLE CONSUMIVEL (
    id_consumivel CHAR(7) PRIMARY KEY,
    nome CHAR(20) NOT NULL,
    valor INTEGER NOT NULL,
    peso FLOAT CHECK (peso > 0),
    tipo_consumivel CHAR(20),
    aumento INTEGER NOT NULL,
    CONSTRAINT fk_id_item
        FOREIGN KEY (id_consumivel) REFERENCES TIPO_ITEM (id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    );

## ARMA

    CREATE TABLE ARMA (
    id_arma CHAR(7),
    nome CHAR(20) NOT NULL,
    valor INTEGER NOT NULL,
    peso FLOAT CHECK (peso > 0),
    tipo_arma CHAR(20),
    num_mãos INTEGER CHECK (num_mãos >= 1 AND num_mãos <= 2),
    custo_stamina INTEGER CHECK (custo_stamina >= 0),
    eqp_status BOOLEAN,
    PRIMARY KEY (id_arma),
    CONSTRAINT fk_id_item
        FOREIGN KEY (id_arma) REFERENCES TIPO_ITEM (id_item)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    );

## ENCANTAMENTO_ARMA

    CREATE TABLE ENCANTAMENTO_ARMA (
    id_encantamento CHAR(8) PRIMARY KEY,
    id_arma CHAR(7),
    elemento CHAR(20) NOT NULL,
    dano INTEGER NOT NULL,
  	CHECK( id_encantamento LIKE 'ENCA%'
       AND CAST(SUBSTRING(id_encantamento, 5,3) AS INTEGER) BETWEEN 000 AND 999
       AND LENGTH(id_encantamento) = 7),
    CONSTRAINT fk_id_arma
        FOREIGN KEY (id_arma) REFERENCES ARMA (id_arma)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
    );

## MISSAO_OBTER_ITEM 

    CREATE TABLE MISSAO_OBTER_ITEM (
    id_missao CHAR(7) PRIMARY KEY,
    nome CHAR(30) NOT NULL,
    id_pre_requisito CHAR(7),
    id_instancia_item CHAR(8) NOT NULL,
    id_item CHAR(7) NOT NULL,
    id_inventario_origem CHAR(7)NOT NULL,
    id_inventario_destino CHAR(7) NOT NULL,
    FOREIGN KEY (id_missao) REFERENCES TIPO_MISSAO(id_missao),
    FOREIGN KEY (id_instancia_item, id_item) REFERENCES INSTANCIA_ITEM(id_instancia_item, id_item),
    FOREIGN KEY (id_inventario_origem) REFERENCES INVENTARIO(id_inventario),
    FOREIGN KEY (id_inventario_destino) REFERENCES INVENTARIO(id_inventario)
    );

## 5. Histórico de Versão

| Versão | Alteração | Responsável | Revisor | 
| - | - | - | - |
| 1.0 | Criaçao das tabelas | Larissa Stéfane | - |
