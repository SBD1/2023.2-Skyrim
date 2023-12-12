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


CALL concluir_missao('MIS0001', 'CHAR0001');
--CALL consumir('ITEM001', 'CHAR0001');
CALL realizar_encantamento('CHAR0001', 'ENCV001');
--select * FROM PLAY_CHARACTER;
SELECT * FROM PLAY_CHARACTER;