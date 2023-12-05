-- Atualização da mana com o uso de magia com combate
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

        IF v_vida_atual_npc - (v_dano_magia / ((SELECT nivel FROM NOT_PLAY_CHARACTER WHERE id_npc = (SELECT id_npc FROM INSTANCIA_NPC WHERE id_instancia_npc = p_id_instancia_npc)) + (SELECT nivel FROM INSTANCIA_NPC WHERE id_instancia_npc = p_id_instancia_npc))) <= 0 THEN
            -- NPC morto, inserir em ESTA_MORTO
            INSERT INTO ESTA_MORTO (id_play_character, id_instancia_npc)
            VALUES (p_id_play_character, p_id_instancia_npc);

            RAISE NOTICE 'Personagem morto';
        END IF;

        -- Aqui você pode adicionar mais lógica, se necessário, para atualizar a vida do NPC ou realizar outras ações.
    ELSE
        RAISE EXCEPTION 'Mana insuficiente para lançar a magia';
    END IF;
END;
$uso_magia$ LANGUAGE plpgsql;

-- Atualizações quando concluir missão


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


---------------------------------------------------------------------------------------

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

