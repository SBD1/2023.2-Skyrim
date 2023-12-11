# Criações dos Triggers

Aqui são apresentados os códigos ou scripts utilizados para a criação dos triggers para manter a integridade do jogo.

## Sumário

* [Código Completo em SQL](#Código-Completo-em-SQL)

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
 * [Trigger para verificar a total exclusividade ao inserir em HUMANOIDE](#Trigger-para-verificar-a-total-exclusividade-ao-inserir-em-HUMANOIDE)
 * [Quando deletar humanoide](#Quando-deletar-humanoide)
 * [Trigger para verificar a total exclusividade ao inserir em BESTA](#Trigger-para-verificar-a-total-exclusividade-ao-inserir-em-BESTA)
 * [Quando deletar Besta](#Quando-deletar-Besta)
 * [Atualização do xp após a conclusão de uma missão](#Atualização-do-xp-após-a-conclusão-de-uma-missão)
 * [Atualizar o nível quando o XP é alterado](#Atualizar-o-nível-quando-o-XP-é-alterado)
 * [Garantir consistência quando for inserir em MAGIA_HUMANOIDE](#Garantir-consistência-quando-for-inserir-em-MAGIA_HUMANOIDE)
 * [Atualizar MAGIA_HUMANOIDE com o aumento de nível](#Atualizar-MAGIA_HUMANOIDE-com-o-aumento-de-nível)
 * [Garantir integridade dos tipos itens:Consumível](#Garantir-integridade-dos-tipos-itens:Consumível)
 * [Garantir integridade dos tipos itens:Vestimenta](#Garantir-integridade-dos-tipos-itens:Vestimenta)
 * [Garantir integridade dos tipos itens:Arma](#Garantir-integridade-dos-tipos-itens:Arma)
 * [Garantir integridade dos tipos itens:Gema](#Garantir-integridade-dos-tipos-itens:Gema)
 * [Integridade de dados para consumiveis](#Integridade-de-dados-para-consumiveis)
 * [Trigger para quantidade máxima de consumíveis](#Trigger-para-quantidade-máxima-de-consumíveis)
 * [Zerar a quantidade de consumíveis consumidos quando passar de nivel](#Zerar-a-quantidade-de-consumíveis-consumidos-quando-passar-de-nivel)
 * [Garantir integridade em Missões de matar_npc](#Garantir-integridade-em-Missões-de-matar_npc)
 * [Garantir integridade em missões obter item](#Garantir-integridade-em-missões-obter-item)
 * [Inserir na tabela aprende_encantamento](#Inserir-na-tabela-aprende_encantamento)
 * [Integridade em encantamento total exclusivo vestimenta](#Integridade-em-encantamento-total-exclusivo-vestimenta)
 * [Integridade em encantamento total exclusivo arma](#Integridade-em-encantamento-total-exclusivo-arma)
 * [Atualizar_especie_humanoide](#Atualizar_especie_humanoide)
 * [Histórico de Versão](#Histórico-de-Versão)
   

## Código Completo em SQL

Caso deseje visualizar o código completo dos triggers e Functions clique no link: [Triggers](triggers_03_12.sql)

## Garantir que o peso do inventário não seja excedido.

**Objetivo:** Garantir que o peso máximo do inventário não seja negativo.

**Código:**

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

**Objetivo:** Garantir que o nome da sala seja único dentro de um local.

**Código:**

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

**Objetivo:** Garantir que os atributos de vida, mana e stamina de um humanoide não sejam negativos.

**Código:** 
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

**Objetivo:** Garantir que os atributos de dano, nível e custo de mana de uma magia não sejam negativos.

**Código:**

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

**Objetivo:** Garantir que os atributos de XP mínimo e máximo de um nível não sejam negativos.

**Código:**

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

**Objetivo:** Garantir que diversos atributos de um personagem jogável não sejam negativos.

**Código:**

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

**Objetivo:** Garantir que diversos atributos de um NPC não sejam negativos.

**Código:**
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

**Objetivo:** Garantir que o atributo "carteira" do inventário não seja negativo.

**Código:**

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

**Objetivo:** Garantir que diversos atributos de um golpe não sejam negativos.

**Código:**

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

**Objetivo:** Garante que os atributos de valor, peso e resistência das Vestimentas não sejam negativos.

**Código:**

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

**Objetivo:** Garante que o atributo resistência do Encantamento de Vestimenta não seja negativo.

**Código:**

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

**Objetivo:** Garante que os atributos de valor, peso e aumento dos Consumíveis não sejam negativos.

**Código:**

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

**Objetivo:** Garante que os atributos de valor, peso, número de mãos e custo de stamina das Armas não sejam negativos.

**Código:**

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

**Objetivo:** Garante que o atributo dano do Encantamento de Arma não seja negativo.

**Código:**

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

**Objetivo:** Garante que os atributos de valor, peso e potência da Gema não sejam negativos.

**Código:**

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

**Objetivo:** Garante que o atributo xp_missao da missão para matar NPC não seja negativo.

**Código:**

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

**Objetivo:** Garante que o atributo xp_missao da missão para obter item não seja negativo.

**Código:**
        
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

**Objetivo:** Impede a inserção de uma chave duplicada na tabela TIPO_PERSONAGEM_HISTORIA ao inserir um personagem jogável.

**Código:**

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

**Objetivo:** mpede a inserção de uma chave duplicada na tabela TIPO_PERSONAGEM_HISTORIA ao inserir um personagem não jogável.

**Código:**
        
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

**Objetivo:** Remove a entrada correspondente na tabela TIPO_PERSONAGEM_HISTORIA quando um personagem jogável é deletado.

**Código:**

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

**Objetivo:** Remove a entrada correspondente na tabela TIPO_PERSONAGEM_HISTORIA quando um NPC é deletado.

**Código:**

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


## Trigger para verificar a total exclusividade ao inserir em HUMANOIDE

**Objetivo:** Verifica se o personagem já possui uma forma e se a chave existe em TIPO_PERSONAGEM_HISTORIA ao inserir um Humanoide.

**Código:**

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

## Quando deletar humanoide

**Objetivo:** Remove a entrada correspondente na tabela FORMA quando um Humanoide é deletado.

**Código:**

        CREATE OR REPLACE FUNCTION excluir_forma_humanoide()
        RETURNS TRIGGER AS $excluir_forma_humanoide$
        BEGIN
            -- Exclui a tupla correspondente em FORMA
            DELETE FROM FORMA WHERE id_personagem = OLD.id_humanoide;
        
            RETURN OLD;
        END;
        $excluir_forma_humanoide$ LANGUAGE plpgsql;
        
        
        CREATE TRIGGER trigger_excluir_forma_humanoide
        AFTER DELETE ON HUMANOIDE
        FOR EACH ROW
        EXECUTE FUNCTION excluir_forma_humanoide();

## Trigger para verificar a total exclusividade ao inserir em BESTA

**Objetivo:** Verifica se o personagem não jogável já possui uma forma e se a chave existe em NOT_PLAY_CHARACTER ao inserir uma Besta.

**Código:**

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

## Quando deletar Besta

**Objetivo:** Remove a entrada correspondente na tabela FORMA quando uma Besta é deletada.

**Código:**
        CREATE OR REPLACE FUNCTION excluir_forma_besta()
        RETURNS TRIGGER AS $excluir_forma_besta$
        BEGIN
        
            DELETE FROM FORMA WHERE id_personagem = OLD.id_besta;
        
            RETURN OLD;
        END;
        $excluir_forma_besta$ LANGUAGE plpgsql;
        
        CREATE TRIGGER trigger_excluir_forma_besta
        AFTER DELETE ON BESTA
        FOR EACH ROW
        EXECUTE FUNCTION excluir_forma_besta();

## Atualização do xp após a conclusão de uma missão

**Objetivo:** Atualiza o XP do personagem jogável após a conclusão bem-sucedida de uma missão.

**Código:**
        
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

## Atualizar o nível quando o XP é alterado

**Objetivo:** Atualiza o nível do personagem jogável quando o XP é alterado.

**Código:**

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
        
        CREATE TRIGGER atualizar_nivel_trigger
        AFTER UPDATE ON PLAY_CHARACTER
        FOR EACH ROW
        WHEN (NEW.xp <> OLD.xp)  -- A trigger só será acionada se o XP for alterado
        EXECUTE FUNCTION atualizar_nivel();
        
## Garantir consistência quando for inserir em MAGIA_HUMANOIDE

**Objetivo:** Verifica se o nível é 1 e o dano é igual ao dano_inicial ao inserir em MAGIA_HUMANOIDE.

**Código**
        
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

##  Atualizar MAGIA_HUMANOIDE com o aumento de nível

**Objetivo:** Atualiza automaticamente o nível e o dano de MAGIA_HUMANOIDE quando o XP ou o nível do personagem jogável são atualizados.

**Código**

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

## Garantir integridade dos tipos itens:Consumível

**Objetivo:** Mantém a tabela TIPO_ITEM atualizada para refletir os itens do tipo Consumível.

**Código:**

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

## Garantir integridade dos tipos itens:Vestimenta

**Objetivo:** Mantém a tabela TIPO_ITEM atualizada para refletir os itens do tipo Vestimenta.


**Código:**

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

## Garantir integridade dos tipos itens:Arma

**Objetivo:** Mantém a tabela TIPO_ITEM atualizada para refletir os itens do tipo Arma.


**Código:**

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

## Garantir integridade dos tipos itens:Gema

**Objetivo:** Mantém a tabela TIPO_ITEM atualizada para refletir os itens do tipo Arma.


**Código:**

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

## Integridade de dados para consumiveis

**Objetivo:** Verifica se o tipo de consumível é válido ao inserir em CONSUMIVEL.

**Código:**

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
        
## Trigger para quantidade máxima de consumíveis

**Objetivo:** Impede que a quantidade de consumo seja maior que 3 em CONSOME.


**Código:**

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

## Zerar a quantidade de consumíveis consumidos quando passar de nivel

**Objetivo:** Zera a quantidade de consumíveis consumidos quando o personagem jogável passa de nível.

**Código:**

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

## Garantir integridade em Missões de matar_npc

**Objetivo:** Garantir que cada tipo de missão tenha uma chave única.

**Código**

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
         

## Garantir integridade em missões obter item

**Objetivo:** Garantir que cada tipo de missão tenha uma chave única.

**Código** 
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

## Inserir na tabela aprende_encantamento

**Objetivo:** Quando um novo play_character é cadastrado, automaticamente, são feitos inserts na tabela Aprender_ENCANTAMENTO, mas os seus status são sempre FALSE.

**Código**
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

## Integridade em encantamento total exclusivo vestimenta

**Objetivo:** Garantir a integridade ao inserir na tabela de encantamento de vestimenta

**Código**
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

## Integridade em encantamento total exclusivo arma

**Objetivo:** Garantir a integridade ao inserir na tabela de encantamento arma

**Código**

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

## Atualizar_especie_humanoide

**Objetivo:** Atualizar o nível da habilidade, aumentando o seu dano, de acordo com a passagem de nível do personagem.

**Código**

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
         
     
         CREATE TRIGGER atualizar_especie_humanoide_trigger
         AFTER UPDATE ON PLAY_CHARACTER
         FOR EACH ROW
         WHEN (NEW.nivel <> OLD.nivel)  -- A trigger só será acionada se o nível for alterado
         EXECUTE FUNCTION atualizar_especie_humanoide();



## Histórico de Versão


| Versão | Alteração | Responsável | Revisor | Data |
| - | - | - | - | - |
| 1.0 | Criaçao das Triggers | Larissa Stéfane | - | 26/11/2023    
| 2.0 | Adicionar mais triggers | Larissa Stéfane | - | 30/11/2023
| 3.0 | Correção do md | Larissa Stéfane | - | 02/12/2023
| 4.0 | Adicionar mais triggers | Larissa Stéfane | - | 03/12/2023
| 5.0 | Adicionar mais triggers | Larissa Stéfane | - | 04/12/2023
