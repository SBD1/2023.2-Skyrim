# Criações dos Triggers

Aqui são apresentados os códigos ou scripts utilizados para a criação dos triggers para manter a integridade do jogo.

## Sumário
* [Garantir que o peso do inventário não seja excedido.](#Garantir-que-o-peso-do-inventário-não-seja-excedido.)

 * [Garantir que o nome de uma sala seja único dentro de um local](#Garantir-que-o-nome-de-uma-sala-seja-único-dentro-de-um-local)
 * [Restrição de valor mínimo para humanoide](#Restrição-de-valor-mínimo-para-humanoide)
 * [Restrição de valor mínimo para Magia](#Restrição-de-valor-mínimo-para-Magia)
 * [Restrição de valor mínimo para nível](#Restrição-de-valor-mínimo-para-nível)
 * [Restrição de valor mínimo para play_character](#Restrição-de-valor-mínimo-para-play_character)
 * [Restrição de valor mínimo para not_play_character](#Restrição-de-valor-mínimo-para-not_play_character)
 * [Restrição de valor mínimo para inventário](#Restrição-de-valor-mínimo-para-inventário)
 * [Restrição de valor mínimo para Golpes](#Restrição-de-valor-mínimo-para-Golpes)
 * [Restrição de valor mínimo para Venstimentas](#Restrição-de-valor-mínimo-para-Venstimentas)
 * [Restrição de valor mínimo para Encantamento de Vestimentas](#Restrição-de-valor-mínimo-para-Encantamento-de-Vestimentas)
 * [Restrição de valor mínimo para Consumível](#Restrição-de-valor-mínimo-para-Consumível)
 * [Restrição de valor mínimo para Arma](#Restrição-de-valor-mínimo-para-Arma)
 * [Restrição de valor mínimo para Encantamento de Arma](#Restrição-de-valor-mínimo-para-Encantamento-de-Arma)
 * [Restrição de valor mínimo para Gema](#Restrição-de-valor-mínimo-para-Gema)
 * [Restrição de valor mínimo para missão_matar_npc](#Restrição-de-valor-mínimo-para-missão_matar_npc)
 * [Restrição de valor mínimo para missão_obter_item](#Restrição-de-valor-mínimo-para-missão-obter-item)
 * [Garantir consistência quando for inserir personagem jogável](#Garantir-consistência-quando-for-inserir-personagem-jogável)
 * [Garantir consistência quando for inserir em personagem não jogável](#Garantir-consistência-quando-for-inserir-em-personagem-não-jogável)
 * [Quando deletar personagem jogável](#Quando-deletar-personagem-jogável)
 * [Quando deletar npc](#Quando-deletar-npc)






 * [ESTA_MORTO](#ESTA_MORTO)
 * [TIPO_MISSAO](#TIPO_MISSAO)
 * [MISSAO_NIVEL](#MISSAO_NIVEL)
 * [CUMPRE_MISSAO](#CUMPRE_MISSAO)
 * [DIALOGOS](#DIALOGOS)
 * [MISSAO_MATAR_NPC](#MISSAO_MATAR_NPC)
 * [TIPO_ITEM](#TIPO_ITEM)
 * [INSTANCIA_ITEM](#INSTANCIA_ITEM)
 * [TIPO_ENCANTAMENTO](#TIPO_ENCANTAMENTO)
 * [VESTIMENTA](#VESTIMENTA)
 * [ENCANTAMENTO_VESTIMENTA](#ENCANTAMENTO_VESTIMENTA)
 * [CONSUMIVEL](#CONSUMIVEL)
 * [CONSOME](#CONSOME)
 * [ARMA](#ARMA)
 * [ENCANTAMENTO_ARMA](#ENCANTAMENTO_ARMA)
 * [MISSAO_OBTER_ITEM](#MISSAO_OBTER_ITEM)
 * [GEMA](#GEMA)
 * [PROPORCIONA_ENCANTAMENTO](#PROPORCIONA_ENCANTAMENTO)
 * [APRENDER_ENCANTAMENTO](#APRENDER_ENCANTAMENTO)


## Garantir que o peso do inventário não seja excedido.
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

## Garantir que o nome de uma sala seja único dentro de um local

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

## Restrição de valor mínimo para humanoide

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

## Restrição de valor mínimo para Magia

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

## Restrição de valor mínimo para nível

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

## Restrição de valor mínimo para play_character

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

## Restrição de valor mínimo para not_play_character

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

## Restrição de valor mínimo para inventário

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

## Restrição de valor mínimo para Golpes

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

## Restrição de valor mínimo para Venstimentas

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

## Restrição de valor mínimo para Encantamento de Vestimentas

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

## Restrição de valor mínimo para Consumível

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

## Restrição de valor mínimo para Arma

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

## Restrição de valor mínimo para Encantamento de Arma

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


## Restrição de valor mínimo para Gema

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

## Restrição de valor mínimo para missão_matar_npc

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

## Restrição de valor mínimo para missão_obter_item
        
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

## Garantir consistência quando for inserir personagem jogável

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

## Garantir consistência quando for inserir em personagem não jogável
        
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

## Quando deletar personagem jogável

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
        
## Quando deletar npc

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
