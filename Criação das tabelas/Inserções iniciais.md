# INSERÇÕES INICIAIS

Aqui são apresentados os códigos ou scripts utilizados para a inserção das tabelas, locais, salas e viagem_salas

## Sumário

 * [REGIAO](#REGIAO)

 * [LOCAL](#LOCAL)

 * [SALA](#SALA)

 * [VIAGEM_SALAS](#VIAGEM_SALAS)


## REGIÃO
     
      INSERT INTO REGIAO (id_regiao, nome)
      VALUES
      ('REG0001', 'Whiterun Hold'),
      ('REG0002', 'Falkreath Forest'),
      ('REG0003', 'Riften Marshlands'),
      ('REG0004', 'Solitude Shores'),
      ('REG0005', 'Dragonsreach Plateau');

## LOCAL

    INSERT INTO LOCAL (id_local, nome_local, id_regiao)
    VALUES
    ('LOC0001', 'Whiterun', 'REG0001'),
    ('LOC0002', 'Riverwood', 'REG0001'),
    ('LOC0003', 'Whitewatch Tower', 'REG0001'),
    ('LOC0004', 'Redoran Retreat', 'REG0001'),
    ('LOC0005', 'Halted Stream Camp', 'REG0001'),
    ('LOC0006', 'Rorikstead', 'REG0001'),
    ('LOC0007', 'Loreius Farm', 'REG0001'),
    ('LOC0008', 'Sleeping Tree Camp', 'REG0001');


    INSERT INTO LOCAL (id_local, nome_local, id_regiao)
    VALUES
    ('LOC0009', 'Nix Forest', 'REG0002'),
    ('LOC0010', 'Hauntalia', 'REG0002'),
    ('LOC0011', 'Emberhold', 'REG0002'),
    ('LOC0012', 'HavenSand', 'REG0002'),
    ('LOC0013', 'Shifting Moon', 'REG0002'),
    ('LOC0014', 'Leolei', 'REG0002'),
    ('LOC0015', 'Bugass', 'REG0002'),
    ('LOC0016', 'Runight', 'REG0002');


    INSERT INTO LOCAL (id_local, nome_local, id_regiao)
    VALUES
    ('LOC0017', 'Riften', 'REG0003'),
    ('LOC0018', 'Ivarstead', 'REG0003'),
    ('LOC0019', 'Misty Mountains', 'REG0003'),
    ('LOC0020', 'Whitespring', 'REG0003'),
    ('LOC0021', 'Goldenglow Estate', 'REG0003'),
    ('LOC0022', 'Ragged Flagon', 'REG0003'),
    ('LOC0023', 'Shor,s Stone', 'REG0003'),
    ('LOC0024', 'Raven Rock', 'REG0003');


    INSERT INTO LOCAL (id_local, nome_local, id_regiao)
    VALUES
    ('LOC0025', 'Solitude', 'REG0004'),
    ('LOC0026', 'Haafingar', 'REG0004'),
    ('LOC0027', 'Dainty Sload', 'REG0004'),
    ('LOC0028', 'Northwatch Keep', 'REG0004'),
    ('LOC0029', 'Hjaalmarch', 'REG0004'),
    ('LOC0030', 'Pinefrost Tower', 'REG0004'),
    ('LOC0031', 'Broken Oar Grotto', 'REG0004'),
    ('LOC0032', 'East Empire Company Warehouse', 'REG0004');


    INSERT INTO LOCAL (id_local, nome_local, id_regiao)
    VALUES
    ('LOC0033', 'Dragonsreach', 'REG0005'),
    ('LOC0034', 'High Hrothgar', 'REG0005'),
    ('LOC0035', 'Bleak Falls Barrow', 'REG0005'),
    ('LOC0036', 'Dragonsreach Balcony', 'REG0005'),
    ('LOC0037', 'Whiterun Watchtower', 'REG0005'),
    ('LOC0038', 'Throat of the World', 'REG0005'),
    ('LOC0039', 'Skyborn Altar', 'REG0005'),
    ('LOC0040', 'Mirmulnir,s Roost', 'REG0005');


## SALAS

    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM001', 'Dragonreach Hall', 'LOC0001'),
    ('ROOM002', 'Warmaiden s Smithy', 'LOC0001'),
    ('ROOM003', 'Jorrvaskr Mead Hall', 'LOC0001'),
    ('ROOM004', 'Temple of Kynareth', 'LOC0001');


    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM005', 'Riverwood Inn', 'LOC0002'),
    ('ROOM006', 'Riverwood Trader', 'LOC0002'),
    ('ROOM007', 'Alvor House', 'LOC0002'),
    ('ROOM008', 'Gerdur House', 'LOC0002');

    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM009', 'Whitewatch Tower Top', 'LOC0003'),
    ('ROOM010', 'Whitewatch Tower Base', 'LOC0003'),
    ('ROOM011', 'Whitewatch Guard Barracks', 'LOC0003'),
    ('ROOM012', 'Whitewatch Stables', 'LOC0003');
    

    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM013', 'Redoran Retreat Main Hall', 'LOC0004'),
    ('ROOM014', 'Redoran Retreat Bedroom', 'LOC0004'),
    ('ROOM015', 'Redoran Retreat Cavern', 'LOC0004'),
    ('ROOM016', 'Redoran Retreat Secret Passage', 'LOC0004');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM017', 'Halted Stream Camp Cavern', 'LOC0005'),
    ('ROOM018', 'Halted Stream Camp Longhouse', 'LOC0005'),
    ('ROOM019', 'Halted Stream Camp Watchtower', 'LOC0005'),
    ('ROOM020', 'Halted Stream Camp Cave', 'LOC0005');


    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM021', 'Rorikstead Inn', 'LOC0006'),
    ('ROOM022', 'Rorikstead Blacksmith', 'LOC0006'),
    ('ROOM023', 'Lemkil House', 'LOC0006'),
    ('ROOM024', 'Froki Shack', 'LOC0006');


    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM025', 'Loreius Farmhouse', 'LOC0007'),
    ('ROOM026', 'Loreius Farm Barn', 'LOC0007'),
    ('ROOM027', 'Loreius Farm Field', 'LOC0007'),
    ('ROOM028', 'Loreius Farm Stable', 'LOC0007');
    

    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM029', 'Sleeping Tree Camp Chief Tent', 'LOC0008'),
    ('ROOM030', 'Sleeping Tree Camp Hunter Tent', 'LOC0008'),
    ('ROOM031', 'Sleeping Tree Camp Shaman Tent', 'LOC0008'),
    ('ROOM032', 'Sleeping Tree Camp Firepit', 'LOC0008');
  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM033', 'Nix Forest Grove', 'LOC0009'),
    ('ROOM034', 'Hauntalia Clearing', 'LOC0009'),
    ('ROOM035', 'Emberhold Glade', 'LOC0009'),
    ('ROOM036', 'HavenSand Retreat', 'LOC0009');


    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM037', 'Hauntalia Altar', 'LOC0010'),
    ('ROOM038', 'Emberhold Lodge', 'LOC0010'),
    ('ROOM039', 'HavenSand Cliff', 'LOC0010'),
    ('ROOM040', 'Shifting Moon Valley', 'LOC0010');
    
  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM041', 'Emberhold Cave', 'LOC0011'),
    ('ROOM042', 'HavenSand Oasis', 'LOC0011'),
    ('ROOM043', 'Shifting Moon Hollow', 'LOC0011'),
    ('ROOM044', 'Leolei Grove', 'LOC0011');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM045', 'HavenSand Hideout', 'LOC0012'),
    ('ROOM046', 'Shifting Moon Ruins', 'LOC0012'),
    ('ROOM047', 'Leolei Cavern', 'LOC0012'),
    ('ROOM048', 'Bugass Lair', 'LOC0012');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM049', 'Shifting Moon Cave', 'LOC0013'),
    ('ROOM050', 'Leolei Retreat', 'LOC0013'),
    ('ROOM051', 'Bugass Nest', 'LOC0013'),
    ('ROOM052', 'Runight Grove', 'LOC0013');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM053', 'Leolei Altar', 'LOC0014'),
    ('ROOM054', 'Bugass Glade', 'LOC0014'),
    ('ROOM055', 'Runight Clearing', 'LOC0014'),
    ('ROOM056', 'Riften', 'LOC0014');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM057', 'Bugass Canyon', 'LOC0015'),
    ('ROOM058', 'Runight Waterfall', 'LOC0015'),
    ('ROOM059', 'Riverbed Cave', 'LOC0015'),
    ('ROOM060', 'Forest Hollow', 'LOC0015');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM061', 'Runight Altar', 'LOC0016'),
    ('ROOM062', 'Mossy Glen', 'LOC0016'),
    ('ROOM063', 'Thicket Haven', 'LOC0016'),
    ('ROOM064', 'Raven Rock Overlook', 'LOC0016');


    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM065', 'Riften Market', 'LOC0017'),
    ('ROOM066', 'Ivarstead Inn', 'LOC0017'),
    ('ROOM067', 'Misty Mountains Cave', 'LOC0017'),
    ('ROOM068', 'Whitespring Lodge', 'LOC0017');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM069', 'Ivarstead Bridge', 'LOC0018'),
    ('ROOM070', 'Misty Mountains Pass', 'LOC0018'),
    ('ROOM071', 'Whitespring Falls', 'LOC0018'),
    ('ROOM072', 'Goldenglow Cellar', 'LOC0018');


    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM077', 'Whitespring Mansion', 'LOC0020'),
    ('ROOM078', 'Frozen Lake Cottage', 'LOC0020'),
    ('ROOM079', 'Goldenglow Manor', 'LOC0020'),
    ('ROOM080', 'Snowy Woods Cabin', 'LOC0020');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM081', 'Goldenglow Warehouse', 'LOC0021'),
    ('ROOM082', 'Secret Tunnels', 'LOC0021'),
    ('ROOM083', 'Goldenglow Cave', 'LOC0021'),
    ('ROOM084', 'Luxury Villa', 'LOC0021');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM085', 'Thieves Guild Hideout', 'LOC0022'),
    ('ROOM086', 'Black-Briar Meadery', 'LOC0022'),
    ('ROOM087', 'Cistern Entrance', 'LOC0022'),
    ('ROOM088', 'The Ratway', 'LOC0022');


    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM089', 'Shors House', 'LOC0023'),
    ('ROOM090', 'Stone Quarry', 'LOC0023'),
    ('ROOM091', 'Miners Shack', 'LOC0023'),
    ('ROOM092', 'Entrance Mine', 'LOC0023');
    
  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM093', 'Raven Rock Inn', 'LOC0024'),
    ('ROOM094', 'Frostmoon Crag', 'LOC0024'),
    ('ROOM095', 'Bloodskal Barrow', 'LOC0024'),
    ('ROOM096', 'Ash Spawn Lair', 'LOC0024');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM097', 'Blue Palace', 'LOC0025'),
    ('ROOM098', 'Proudspire Manor', 'LOC0025'),
    ('ROOM099', 'The Winking Skeever', 'LOC0025'),
    ('ROOM100', 'Solitude Sawmill', 'LOC0025');
    
  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM101', 'Castle Volkihar', 'LOC0026'),
    ('ROOM102', 'Cave of the Abused', 'LOC0026'),
    ('ROOM103', 'Broken Oar Grotto', 'LOC0026'),
    ('ROOM104', 'Dragon Bridge Lumber Camp', 'LOC0026');


    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM105', 'Dainty Sload', 'LOC0027'),
    ('ROOM106', 'Pirate Cove', 'LOC0027'),
    ('ROOM107', 'Abandoned Cabin', 'LOC0027'),
    ('ROOM108', 'Lost Prospect Mine', 'LOC0027');


    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM109', 'Northwatch Keep', 'LOC0028'),
    ('ROOM110', 'Prisoner Cells', 'LOC0028'),
    ('ROOM111', 'Northwatch Keep Balcony', 'LOC0028'),
    ('ROOM112', 'Prisoner Quarters', 'LOC0028');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM113', 'Hjaalmarch Stormcloak Camp', 'LOC0029'),
    ('ROOM114', 'Hjaalmarch Imperial Camp', 'LOC0029'),
    ('ROOM115', 'Sightless Pit', 'LOC0029'),
    ('ROOM116', 'Old Hroldan Inn', 'LOC0029');


  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM117', 'Pinefrost Tower', 'LOC0030'),
    ('ROOM118', 'Bards Leap Summit', 'LOC0030'),
    ('ROOM119', 'Fort Hraggstad', 'LOC0030'),
    ('ROOM120', 'Ustengrav', 'LOC0030');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM121', 'Broken Oar Grotto', 'LOC0031'),
    ('ROOM122', 'Bonechill Passage', 'LOC0031'),
    ('ROOM123', 'Hall of Rumination', 'LOC0031'),
    ('ROOM124', 'Dormant Centurion', 'LOC0031');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM125', 'East Empire Company Warehouse', 'LOC0032'),
    ('ROOM126', 'Fort Frostmoth', 'LOC0032'),
    ('ROOM127', 'Jolgeirr Barrow', 'LOC0032'),
    ('ROOM128', 'Dwarven Ship', 'LOC0032');
    
  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM129', 'Dragonsreach Great Porch', 'LOC0033'),
    ('ROOM130', 'Dragonsreach Jarl,s Quarters', 'LOC0033'),
    ('ROOM131', 'Dragonsreach Dungeon', 'LOC0033'),
    ('ROOM132', 'Dragonsreach Main Hall', 'LOC0033');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM133', 'High Hrothgar Courtyard', 'LOC0034'),
    ('ROOM134', 'High Hrothgar Hall of Valor', 'LOC0034'),
    ('ROOM135', 'High Hrothgar Inner Sanctum', 'LOC0034'),
    ('ROOM136', 'High Hrothgar Pilgrim,s Trench', 'LOC0034');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM137', 'Bleak Falls Barrow Main Chamber', 'LOC0035'),
    ('ROOM138', 'Bleak Falls Barrow Sanctum', 'LOC0035'),
    ('ROOM139', 'Bleak Falls Barrow Catacombs', 'LOC0035'),
    ('ROOM140', 'Bleak Falls Barrow Puzzle Room', 'LOC0035');

    
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM141', 'Dragonsreach Balcony Overlook', 'LOC0036'),
    ('ROOM142', 'Dragonsreach Balcony', 'LOC0036'),
    ('ROOM143', 'Whiterun Overlook', 'LOC0036'),
    ('ROOM144', 'Balcony Gardens', 'LOC0036');

  
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM145', 'Whiterun Watchtower Interior', 'LOC0037'),
    ('ROOM146', 'Watchtower Balcony', 'LOC0037'),
    ('ROOM147', 'Watchtower Storeroom', 'LOC0037'),
    ('ROOM148', 'Watchtower Garrison', 'LOC0037');


     INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM149', 'Throat of the World Summit', 'LOC0038'),
    ('ROOM150', 'Paarthurnax,s Perch', 'LOC0038'),
    ('ROOM151', 'Clear Skies Peak', 'LOC0038'),
    ('ROOM152', 'Highwind Summit', 'LOC0038');
  
 
    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM153', 'Skyborn Altar Peak', 'LOC0039'),
    ('ROOM154', 'Ancient Sacrificial Chamber', 'LOC0039'),
    ('ROOM155', 'Altar of the Dragon', 'LOC0039'),
    ('ROOM156', 'Alduin,s Portal', 'LOC0039');


    INSERT INTO SALA (id_sala, nome_sala, id_local)
    VALUES
    ('ROOM157', 'Mirmulnir,s Roost Cliffs', 'LOC0040'),
    ('ROOM158', 'Roost Cavern', 'LOC0040'),
    ('ROOM159', 'Dragon Roost Perch', 'LOC0040'),
    ('ROOM160', 'Shriekwind Bastion', 'LOC0040');

## VIAGEM_SALA
      (
    INSERT INTO VIAGEM_SALAS (id_viagem, sala_origem, sala_destino)
    VALUES
    ('V000001', 'ROOM001', 'ROOM002'),
    ('V000002', 'ROOM001', 'ROOM003'),
    ('V000003', 'ROOM001', 'ROOM004'),
    ('V000004', 'ROOM002', 'ROOM003'),
    ('V000005', 'ROOM002', 'ROOM004'),
    ('V000006', 'ROOM003', 'ROOM004'),
    ('V000007', 'ROOM002', 'ROOM005'),
    ('V000008', 'ROOM006', 'ROOM009'),
    ('V000009', 'ROOM005', 'ROOM006'),
    ('V000010', 'ROOM005', 'ROOM007'),
    ('V000011', 'ROOM005', 'ROOM008'),
    ('V000012', 'ROOM006', 'ROOM005'),
    ( 'V000013', 'ROOM006', 'ROOM007'),
    ('V000014', 'ROOM006', 'ROOM008'),
    ('V000015', 'ROOM007', 'ROOM005'),
    ('V000016', 'ROOM007', 'ROOM006'),
    ('V000017', 'ROOM007', 'ROOM008'),
    ('V000018', 'ROOM008', 'ROOM005'),
    ('V000019', 'ROOM008', 'ROOM006'),
    ('V000020', 'ROOM008', 'ROOM007'),
    ('V000021', 'ROOM009', 'ROOM010'),
    ('V000022', 'ROOM010', 'ROOM009'),
    ('V000023', 'ROOM010', 'ROOM011'),
    ('V000024', 'ROOM011', 'ROOM010'),
    ('V000025', 'ROOM011', 'ROOM012'),
    ('V000026', 'ROOM012', 'ROOM011'),
    ('V000027', 'ROOM013', 'ROOM014'),
    ('V000028', 'ROOM014', 'ROOM013'),
    ('V000029', 'ROOM014', 'ROOM015'),
    ( 'V000030', 'ROOM015', 'ROOM014'),
    ('V000031', 'ROOM015', 'ROOM016'),
    ('V000032', 'ROOM016', 'ROOM015'),
    ('V000033', 'ROOM015', 'ROOM017'),
    ('V000034', 'ROOM016', 'ROOM017'),
    ('V000035', 'ROOM017', 'ROOM018'),
    ('V000036', 'ROOM018', 'ROOM017'),
    ('V000037', 'ROOM018', 'ROOM019'),
    ('V000038', 'ROOM019', 'ROOM018'),
    ('V000039', 'ROOM019', 'ROOM020'),
    ('V000040', 'ROOM020', 'ROOM019'),
    ('V000041', 'ROOM018', 'ROOM023'),
    ('V000042', 'ROOM020', 'ROOM021'),
    ('V000043', 'ROOM021', 'ROOM022'),
    ('V000044', 'ROOM022', 'ROOM021'),
    ('V000045', 'ROOM022', 'ROOM023'),
    ('V000046', 'ROOM023', 'ROOM022'),
    ('V000047', 'ROOM023', 'ROOM024'),
    ('V000048', 'ROOM024', 'ROOM023'),
    ('V000049', 'ROOM022', 'ROOM027'),
    ('V000050', 'ROOM032', 'ROOM026'),
    ('V000051', 'ROOM024', 'ROOM025'),
    ('V000052', 'ROOM025', 'ROOM026'),
    ('V000053', 'ROOM026', 'ROOM025'),
    ('V000054', 'ROOM026', 'ROOM027'),
    ('V000055', 'ROOM027', 'ROOM026'),
    ('V000056', 'ROOM027', 'ROOM028'),
    ('V000057', 'ROOM028', 'ROOM027'),
    ('V000058', 'ROOM028', 'ROOM029'),
    ('V000059', 'ROOM027', 'ROOM029'),
    ('V000060', 'ROOM029', 'ROOM038'),
    ('V000061', 'ROOM030', 'ROOM037'),
    ('V000062', 'ROOM031', 'ROOM040'),
    ('V000063', 'ROOM032', 'ROOM033'),
    ('V000064', 'ROOM029', 'ROOM030'),
    ('V000065', 'ROOM030', 'ROOM029'),
    ('V000066', 'ROOM030', 'ROOM031'),
    ('V000067', 'ROOM031', 'ROOM030'),
    ('V000068', 'ROOM032', 'ROOM031'),
    ('V000069', 'ROOM032', 'ROOM030'),
    ('V000070', 'ROOM033', 'ROOM034'),
    ('V000071', 'ROOM034', 'ROOM033'),
    ('V000072', 'ROOM034', 'ROOM035'),
    ('V000073', 'ROOM035', 'ROOM034'),
    ('V000074', 'ROOM036', 'ROOM035'),
    ('V000075', 'ROOM036', 'ROOM033'),
    ('V000076', 'ROOM037', 'ROOM038'),
    ('V000077', 'ROOM038', 'ROOM037'),
    ('V000078', 'ROOM038', 'ROOM039'),
    ('V000079', 'ROOM039', 'ROOM038'),
    ('V000080', 'ROOM040', 'ROOM037'),
    ('V000081', 'ROOM040', 'ROOM039'),
    ('V000082', 'ROOM041', 'ROOM042'),
    ('V000083', 'ROOM042', 'ROOM041'),
    ('V000084', 'ROOM042', 'ROOM043'),
    ('V000085', 'ROOM043', 'ROOM042'),
    ('V000086', 'ROOM044', 'ROOM041'),
    ('V000087', 'ROOM044', 'ROOM043'),
    ('V000088', 'ROOM045', 'ROOM046'),
    ('V000089', 'ROOM046', 'ROOM047'),
    ('V000090', 'ROOM047', 'ROOM048'),
    ('V000091', 'ROOM049', 'ROOM050'),
    ('V000092', 'ROOM050', 'ROOM051'),
    ('V000093', 'ROOM051', 'ROOM052'),
    ('V000094', 'ROOM053', 'ROOM054'),
    ('V000095', 'ROOM054', 'ROOM055'),
    ('V000096', 'ROOM055', 'ROOM056'),
    ('V000097', 'ROOM057', 'ROOM058'),
    ( 'V000098', 'ROOM058', 'ROOM059'),
    ('V000099', 'ROOM059', 'ROOM060'),
    ('V000100', 'ROOM061', 'ROOM062'),
    ('V000101', 'ROOM062', 'ROOM063'),
    ('V000102', 'ROOM063', 'ROOM064'),
    ('V000103', 'ROOM065', 'ROOM066'),
    ( 'V000104', 'ROOM066', 'ROOM067'),
    ('V000105', 'ROOM067', 'ROOM068'),
    ('V000106', 'ROOM069', 'ROOM070'),
    ('V000107', 'ROOM070', 'ROOM071'),
    ('V000108', 'ROOM071', 'ROOM072'),
    ('V000109', 'ROOM077', 'ROOM078'),
    ('V000110', 'ROOM078', 'ROOM079'),
    ('V000111', 'ROOM079', 'ROOM080'),
    ('V000112', 'ROOM081', 'ROOM082'),
    ('V000113', 'ROOM082', 'ROOM083'),
    ('V000114', 'ROOM083', 'ROOM084'),
    ('V000115', 'ROOM085', 'ROOM086'),
    ('V000116', 'ROOM086', 'ROOM087'),
    ('V000117', 'ROOM087', 'ROOM088'),
    ('V000118', 'ROOM089', 'ROOM090'),
    ('V000119', 'ROOM090', 'ROOM091'),
    ('V000120', 'ROOM091', 'ROOM092'),
    ('V000121', 'ROOM093', 'ROOM094'),
    ('V000122', 'ROOM094', 'ROOM095'),
    ('V000123', 'ROOM095', 'ROOM096'),
    ('V000124', 'ROOM097', 'ROOM098'),
    ('V000125', 'ROOM098', 'ROOM099'),
    ( 'V000126', 'ROOM099', 'ROOM100'),
    ('V000127', 'ROOM101', 'ROOM102'),
    ('V000128', 'ROOM102', 'ROOM103'),
    ('V000129', 'ROOM103', 'ROOM104'),
    ('V000130', 'ROOM105', 'ROOM106'),
    ('V000131', 'ROOM106', 'ROOM107'),
    ('V000132', 'ROOM107', 'ROOM108'),
    ('V000133', 'ROOM109', 'ROOM110'),
    ('V000134', 'ROOM110', 'ROOM111'),
    ('V000135', 'ROOM111', 'ROOM112'),
    ( 'V000136', 'ROOM113', 'ROOM114'),
    ('V000137', 'ROOM114', 'ROOM115'),
    ('V000138', 'ROOM115', 'ROOM116'),
    ('V000139', 'ROOM117', 'ROOM118'),
    ('V000140', 'ROOM118', 'ROOM119'),
    ('V000141', 'ROOM119', 'ROOM120'),
    ('V000142', 'ROOM064', 'ROOM065'),
    ('V000143', 'ROOM065', 'ROOM045'),
    ('V000144', 'ROOM046', 'ROOM057'),
    ('V000145', 'ROOM060', 'ROOM066'),
    ('V000146', 'ROOM068', 'ROOM077'),
    ('V000147', 'ROOM071', 'ROOM079'),
    ('V000148', 'ROOM084', 'ROOM085'),
    ('V000149', 'ROOM104', 'ROOM105'),
    ('V000150', 'ROOM120', 'ROOM064'),
    ('V000151', 'ROOM121', 'ROOM122'),
    ( 'V000152', 'ROOM121', 'ROOM123'),
    ('V000153', 'ROOM122', 'ROOM121'),
    ('V000154', 'ROOM122', 'ROOM123'),
    ('V000155', 'ROOM122', 'ROOM124'),
    ('V000156', 'ROOM123', 'ROOM121'),
    ('V000157', 'ROOM123', 'ROOM122'),
    ('V000158', 'ROOM123', 'ROOM124'),
    ('V000159', 'ROOM124', 'ROOM122'),
    ('V000160', 'ROOM124', 'ROOM123'),
    ('V000161', 'ROOM125', 'ROOM126'),
    ('V000162', 'ROOM125', 'ROOM127'),
    ('V000163', 'ROOM126', 'ROOM125'),
    ('V000164', 'ROOM126', 'ROOM127'),
    ('V000165', 'ROOM126', 'ROOM128'),
    ('V000166', 'ROOM127', 'ROOM125'),
    ('V000167', 'ROOM127', 'ROOM126'),
    ('V000168', 'ROOM127', 'ROOM128'),
    ('V000169', 'ROOM128', 'ROOM126'),
    ('V000170', 'ROOM128', 'ROOM127'),
    ('V000171', 'ROOM129', 'ROOM130'),
    ('V000172', 'ROOM129', 'ROOM131'),
    ('V000173', 'ROOM130', 'ROOM129'),
    ('V000174', 'ROOM130', 'ROOM131'),
    ('V000175', 'ROOM130', 'ROOM132'),
    ('V000176', 'ROOM131', 'ROOM129'),
    ('V000177', 'ROOM131', 'ROOM130'),
    ('V000178', 'ROOM131', 'ROOM132'),
    ('V000179', 'ROOM132', 'ROOM130'),
    ('V000180', 'ROOM132', 'ROOM131'),
    ('V000181', 'ROOM133', 'ROOM134'),
    ('V000182', 'ROOM133', 'ROOM135'),
    ('V000183', 'ROOM134', 'ROOM133'),
    ('V000184', 'ROOM134', 'ROOM135'),
    ('V000185', 'ROOM134', 'ROOM136'),
    ('V000186', 'ROOM135', 'ROOM133'),
    ('V000187', 'ROOM135', 'ROOM134'),
    ('V000188', 'ROOM135', 'ROOM136'),
    ('V000189', 'ROOM136', 'ROOM134'),
    ('V000190', 'ROOM136', 'ROOM135'),
    ('V000191', 'ROOM137', 'ROOM138'),
    ('V000192', 'ROOM137', 'ROOM139'),
    ('V000193', 'ROOM138', 'ROOM137'),
    ('V000194', 'ROOM138', 'ROOM139'),
    ('V000195', 'ROOM138', 'ROOM140'),
    ('V000196', 'ROOM139', 'ROOM137'),
    ('V000197', 'ROOM139', 'ROOM138'),
    ('V000198', 'ROOM139', 'ROOM140'),
    ('V000199', 'ROOM140', 'ROOM138'),
    ( 'V000200', 'ROOM140', 'ROOM139'),
    ('V000201', 'ROOM140', 'ROOM138'),
    ( 'V000202', 'ROOM140', 'ROOM139'),
    ('V000203', 'ROOM141', 'ROOM142'),
    ('V000204', 'ROOM141', 'ROOM143'),
    ('V000205', 'ROOM142', 'ROOM141'),
    ('V000206', 'ROOM142', 'ROOM143'),
    ('V000207', 'ROOM142', 'ROOM144'),
    ('V000208', 'ROOM143', 'ROOM141'),
    ('V000209', 'ROOM143', 'ROOM142'),
    ('V000210', 'ROOM143', 'ROOM144'),
    ('V000211', 'ROOM144', 'ROOM142'),
    ('V000212', 'ROOM144', 'ROOM143'),
    ('V000213', 'ROOM145', 'ROOM146'),
    ('V000214', 'ROOM145', 'ROOM147'),
    ('V000215', 'ROOM146', 'ROOM145'),
    ('V000216', 'ROOM146', 'ROOM147'),
    ('V000217', 'ROOM146', 'ROOM148'),
    ('V000218', 'ROOM147', 'ROOM145'),
    ('V000219', 'ROOM147', 'ROOM146'),
    ('V000220', 'ROOM147', 'ROOM148'),
    ('V000221', 'ROOM148', 'ROOM146'),
    ('V000222', 'ROOM148', 'ROOM147'),
    ('V000223', 'ROOM149', 'ROOM150'),
    ('V000224', 'ROOM149', 'ROOM151'),
    ('V000225', 'ROOM150', 'ROOM149'),
    ('V000226', 'ROOM150', 'ROOM151'),
    ('V000227', 'ROOM150', 'ROOM152'),
    ('V000228', 'ROOM151', 'ROOM149'),
    ('V000229', 'ROOM151', 'ROOM150'),
    ('V000230', 'ROOM151', 'ROOM152'),
    ('V000231', 'ROOM152', 'ROOM150'),
    ('V000232', 'ROOM152', 'ROOM151'),
    ('V000233', 'ROOM153', 'ROOM154'),
    ('V000234', 'ROOM153', 'ROOM155'),
    ('V000235', 'ROOM154', 'ROOM153'),
    ('V000236', 'ROOM154', 'ROOM155'),
    ('V000237', 'ROOM154', 'ROOM156'),
    ('V000238', 'ROOM155', 'ROOM153'),
    ('V000239', 'ROOM155', 'ROOM154'),
    ('V000240', 'ROOM155', 'ROOM156'),
    ('V000241', 'ROOM156', 'ROOM154'),
    ('V000242', 'ROOM156', 'ROOM155'),
    ('V000243', 'ROOM157', 'ROOM158'),
    ('V000244', 'ROOM157', 'ROOM159'),
    ('V000245', 'ROOM158', 'ROOM157'),
    ('V000246', 'ROOM158', 'ROOM159'),
    ('V000247', 'ROOM158', 'ROOM160'),
    ('V000248', 'ROOM159', 'ROOM157'),
    ('V000249', 'ROOM159', 'ROOM158'),
    ('V000250', 'ROOM159', 'ROOM160'),
    ('V000251', 'ROOM160', 'ROOM159');
  
     




    
