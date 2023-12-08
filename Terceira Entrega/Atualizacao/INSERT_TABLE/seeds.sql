INSERT INTO TIPO_PERSONAGEM_HISTORIA (id_personagem,jogavel) VALUES('CHAR0015','TRUE');
INSERT INTO TIPO_PERSONAGEM_HISTORIA (id_personagem,jogavel) VALUES('CHAR0014','TRUE');
INSERT INTO TIPO_PERSONAGEM_HISTORIA (id_personagem,jogavel) VALUES('CHAR0013','TRUE');

INSERT INTO NIVEL (id_nivel, xp_minimo, XP_MAXIMO) VALUES ('N01', 0, 50);
INSERT INTO NIVEL (id_nivel, xp_minimo, XP_MAXIMO) VALUES ('N02', 0, 100);


INSERT INTO REGIAO (id_regiao, nome) VALUES ('REG0001', 'Vale de Whiterun');
INSERT INTO REGIAO (id_regiao, nome) VALUES ('REG0002', 'Marca Oriental');
INSERT INTO REGIAO (id_regiao, nome) VALUES ('REG0003', 'Rift');

INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC0001', 'Desfiladeiro de Dragontail', 'REG0001');
INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC0002', 'Floresta de Falkreath', 'REG0001');
INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC0003', 'Caverna da Água Clara', 'REG0001');
INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC0004', 'Fonte de Água Quente de Eldergleam', 'REG0002');
INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC0005', 'Ruínas de Bleak Falls Barrow', 'REG0002');
INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC0006', 'Cidade de Solitude', 'REG0002');
INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC0007', 'Pântano de Morthal', 'REG0003');
INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC0008', 'Aldeia de Riverwood', 'REG0003');
INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC0009', 'Fortaleza de Fort Dawnguard', 'REG0003');
INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC0010', 'Torre de Alta Hrothgar', 'REG0003');


INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM001', 'Floresta de Falkreath', 'LOC0001');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM002', 'Caverna da Água Clara', 'LOC0002');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM003', 'Fonte de Água Quente de Eldergleam', 'LOC0003');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM004', 'Ruínas de Bleak Falls Barrow', 'LOC0004');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM005', 'Salão dos Companheiros', 'LOC0005');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM006', 'Câmara do Arquimago', 'LOC0006');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM007', 'Sala dos Troféus em Vento Frio', 'LOC0007');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM008', 'Quarto do Arconte em Castelo Volkihar', 'LOC0008');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM009', 'Salão dos Segredos em Thieves Guild', 'LOC0009');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM010', 'Câmara do Jarl em Whiterun', 'LOC0010');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM011', 'Quarto do Arquimago em Colégio de Winterhold', 'LOC0001');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM012', 'Salão dos Vigilantes em Riften', 'LOC0002');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM013', 'Aposentos do Jarl em Markarth', 'LOC0003');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM014', 'Câmara dos Lordes em Castelo Volkihar', 'LOC0004');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM015', 'Torre do Guardião em Torre da Aurora', 'LOC0001');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM016', 'Câmara do Jarl em Windhelm', 'LOC0002');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM017', 'Salão dos Segredos na Thieves Guild', 'LOC0003');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM018', 'Quarto do Dragão em Falkreath', 'LOC0004');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM019', 'Sala dos Reis em Palácio Azul em Solitude', 'LOC0005');

INSERT INTO INVENTARIO (id_inventario, peso_maximo, carteira, eh_loja) VALUES ('INV0001', 50.0, 100, FALSE);
INSERT INTO INVENTARIO (id_inventario, peso_maximo, carteira, eh_loja) VALUES ('INV0002', 20.0, 50, FALSE);
INSERT INTO INVENTARIO (id_inventario, peso_maximo, carteira, eh_loja) VALUES ('INV0003', 10.0, 20, FALSE);
INSERT INTO INVENTARIO (id_inventario, peso_maximo, carteira, eh_loja) VALUES ('INV0004', 30.0, 60, FALSE);


INSERT INTO PLAY_CHARACTER (id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario) 
VALUES ('CHAR0001', 'Thrandor Silverblade', 'N01', 1, 10, 10, 10, 99, 10, 10, 'ROOM001', 'INV0001');

INSERT INTO PLAY_CHARACTER (id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario) 
VALUES ('CHAR0002', 'SeranaDarkSoul', 'N02', 1, 10, 10, 10, 99, 10, 10, 'ROOM002', 'INV0002');

INSERT INTO PLAY_CHARACTER (id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario) 
VALUES ('CHAR0003', 'Nara Nightshade', 'N01', 1, 10, 10, 10, 99, 10, 10, 'ROOM003', 'INV0003');

INSERT INTO PLAY_CHARACTER (id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario) 
VALUES ('CHAR0004', 'Lyndra Fireheart', 'N02', 1, 10, 10, 10, 99, 10, 10, 'ROOM004', 'INV0004');

INSERT INTO PLAY_CHARACTER (id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario) 
VALUES ('CHAR0005', 'Elara Moonshadow', 'N02', 1, 10, 10, 10, 99, 10, 10, 'ROOM005', 'INV0002');