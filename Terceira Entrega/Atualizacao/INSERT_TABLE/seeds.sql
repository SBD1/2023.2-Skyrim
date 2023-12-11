
INSERT INTO REGIAO (id_regiao, nome) VALUES ('REG0001', 'Vale de Whiterun');

INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC1000', 'Casa 1', 'REG0001');
INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC2000', 'Casa 2', 'REG0001');
INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC3000', 'Casa 3', 'REG0001');
INSERT INTO LUGAR (id_local, nome_local, id_regiao) VALUES ('LOC4000', 'Casa 4', 'REG0001');

INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM100', 'Sala_Principal', 'LOC1000');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM200', 'Sala_Principal', 'LOC2000');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM300', 'Sala_Principal', 'LOC3000');
INSERT INTO SALA (id_sala, nome_sala, id_local) VALUES ('ROOM400', 'Sala_Principal', 'LOC4000');

INSERT INTO INVENTARIO (id_inventario, peso_maximo, carteira, eh_loja) VALUES ('INV0001', 25.0, 100, FALSE);
INSERT INTO INVENTARIO (id_inventario, peso_maximo, carteira, eh_loja) VALUES ('INV0002', 27.0, 100, FALSE);
INSERT INTO INVENTARIO (id_inventario, peso_maximo, carteira, eh_loja) VALUES ('INV0003', 22.0, 100, FALSE);
INSERT INTO INVENTARIO (id_inventario, peso_maximo, carteira, eh_loja) VALUES ('INV0004', 19.0, 100, FALSE);

INSERT INTO NIVEL (id_nivel, xp_minimo, XP_MAXIMO) VALUES ('N01', 0, 50);
INSERT INTO NIVEL (id_nivel, xp_minimo, XP_MAXIMO) VALUES ('N02', 0, 100);

INSERT INTO PLAY_CHARACTER (id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario) 
VALUES ('CHAR0001', 'Thaliana', 'N01', 1, 100, 100, 60, 70, 100, 100, 'ROOM100', 'INV0001');

INSERT INTO PLAY_CHARACTER (id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario) 
VALUES ('CHAR0002', 'Valeriun', 'N01', 1, 100, 100, 45, 75, 100, 100, 'ROOM200', 'INV0002');

INSERT INTO PLAY_CHARACTER (id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario) 
VALUES ('CHAR0003', 'Tyranor', 'N01', 1, 100, 100, 60, 70, 100, 100, 'ROOM200', 'INV0003');

INSERT INTO PLAY_CHARACTER (id_play_character, nome, nivel, xp, vida_atual, mana_atual, stamina_atual, vida_maxima, mana_max, stamina_max, id_sala, id_inventario) 
VALUES ('CHAR0004', 'Lyra', 'N01', 1, 100, 100, 65, 65, 100, 100, 'ROOM200', 'INV0004');

-- missão 2:
INSERT INTO REGIAO (id_regiao, nome)
VALUES ('REG0002', 'Winterhold');
INSERT INTO LUGAR (id_local, nome_local, id_regiao)
VALUES ('LOC0005', 'Winterhold_city', 'REG0002');
INSERT INTO LUGAR (id_local, nome_local, id_regiao)
VALUES ('LOC0006', 'Winterhold_mages_college', 'REG0002');
INSERT INTO SALA (id_sala, nome_sala, id_local)
VALUES ('ROOM005', 'Malacar_casa', 'LOC0005');
INSERT INTO SALA (id_sala, nome_sala, id_local)
VALUES ('ROOM006', 'Pátio colégio de magia', 'LOC0006');
VALUES ('ROOM007', 'loja colégio de magia', 'LOC0006');

INSERT INTO INVENTARIO (id_inventario, peso_maximo, carteira, eh_loja)
VALUES ('INV0005', 19.0, 100, FALSE);
INSERT INTO INVENTARIO (id_inventario, peso_maximo, carteira, eh_loja)
VALUES ('INV0006', 19.0, 100, FALSE);
INSERT INTO INVENTARIO (id_inventario, peso_maximo, carteira, eh_loja)
VALUES ('INV0007', 19.0, 100, TRUE);
