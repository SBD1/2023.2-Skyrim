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


