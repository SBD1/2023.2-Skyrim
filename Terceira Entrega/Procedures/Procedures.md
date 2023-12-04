# Procedures
Aqui estão os procedures desenvolvidos para o funcionamento do jogo

## Sumário

* [Código Completo em SQL](#Código-Completo-em-SQL)
* [Atualização da mana com o uso de magia com combate](Atualização-da-mana-com-o-uso-de-magia-com-combate)
* [Atualizações quando concluir missão](Atualizações-quando-concluirmissão)
* [Relação de consumir em determinado nível](Relação-de-consumir-em-determinado-nível)
* [Realizar Encantamento](Realizar-Encantamento)
* [Histórico de Versão](#Histórico-de-Versão)

## Código Completo em SQL

Caso deseje visualizar o código completo dos Procedures clique no link: [Procedure](procedures.sql)

## Atualização da mana com o uso de magia com combate

**Objetivo:** Atualizar a mana do personagem e a vida do NPC após o uso de uma magia durante um combate.

**Funcionamento:**
 - Verifica se o personagem pode usar a magia correspondente.
    
 - Obtém informações sobre a magia, incluindo custo de mana e dano.

 - Verifica se o personagem tem mana suficiente para lançar a magia.
 - Atualiza a mana do personagem e calcula o dano na vida do NPC.
 - Se o NPC fica sem vida, registra que ele está morto.

**Código**

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
        
## Atualizações quando concluir missão

**Objetivo:** Marcar uma missão como concluída para um determinado personagem jogável.

**Funcionamento:**

 - Atualiza a tabela CUMPRE_MISSAO marcando a missão como concluída para o personagem jogável.

**Código**

          
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

## Relação de consumir em determinado nível

**Objetivo:** Atualizar o estado do personagem após consumir um item consumível

**Funcionamento**
 - Verifica se a instância do item é um consumível e obtém informações sobre o tipo e o aumento.
 - Atualiza a tabela CONSOME para registrar o consumo do item.
 - Atualiza as estatísticas do personagem com base no tipo de consumível.

**Código**

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

## Realizar Encantamento

**Objetivo:** Garantir que todos os pré-requisitos para fazer um certo encantamento estão feitos.

**Funcionamento**
 - Verificar qual é a gema necessária para realizar o encantamento.
 - Verificar se o PC possui uma das instâncias que foram geradas a partir da gema do encantamento.
 - Verificar se o PC sabe o encantamento. Se não souber, não pode realizá-lo.

**Código**

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


## Histórico de Versão


| Versão | Alteração | Responsável | Revisor | Data |
| - | - | - | - | - |
| 1.0 | Criação dos procedures | Larissa Stéfane | - | 01/12/2023    
| 2.0 | Criação dos procedures | Leonardo Machado | - | 01/12/2023
| 3.0 | Criação do md | Larissa Stéfane | - | 02/12/2023
| 4.0 | Adicionar mais procedures | Larissa Stéfane | - | 03/12/2023