
--Atualização da mana com o uso de magia com combate:
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

        UPDATE PLAY_CHARACTER
        SET mana_atual = mana_atual - v_custo_mana
        WHERE id_play_character = p_id_play_character;


        SELECT vida_atual
        INTO v_vida_atual_npc
        FROM INSTANCIA_NPC
        WHERE id_instancia_npc = p_id_instancia_npc;

        IF v_vida_atual_npc - (v_dano_magia / ((SELECT nivel FROM NOT_PLAY_CHARACTER WHERE id_npc = (SELECT id_npc FROM INSTANCIA_NPC WHERE id_instancia_npc = p_id_instancia_npc)) + (SELECT nivel FROM INSTANCIA_NPC WHERE id_instancia_npc = p_id_instancia_npc))) <= 0 THEN

            INSERT INTO ESTA_MORTO (id_play_character, id_instancia_npc)
            VALUES (p_id_play_character, p_id_instancia_npc);

            RAISE NOTICE 'Personagem morto';
        END IF;
    ELSE
        RAISE EXCEPTION 'Mana insuficiente para lançar a magia';
    END IF;
END;
$uso_magia$ LANGUAGE plpgsql;



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
