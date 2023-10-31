### Tabelas e Dependências Funcionais

1. **REGIAO (id_regiao, nome_regiao)**
   - {id_regiao} -> {nome_regiao}

2. **LOCAL (id_local, nome_local, id_região)**
   - {id_local} -> {nome_local, id_região}

3. **SALA (id_sala, nome_sala, id_local)**
   - {id_sala} -> {nome_sala, id_local}

4. **VIAGENS_SALAS (sala_origem, sala_destino)**
   - {sala_origem} -> {sala_destino}

5. **TIPO_PERSONAGEM_HISTORIA (id_personagem, caracterização)**
   - {id_personagem} -> {caracterização}

6. **PLAY_CHARACTER (id_play_character, nome, nivel, xp, vida_maxima, vida_atual, mana_max, mana_atual, stamina_max, stamina_atual, id_sala)**
   - {id_play_character} -> {nome, nivel, xp, vida_maxima, vida_atual, mana_max, mana_atual, stamina_max, stamina_atual, id_sala}

7. **NOT_PLAY_CHARACTER (id_npc, nome, vida_máxima, nível, xp)**
   - {id_npc} -> {nome, vida_máxima, nível, xp}

8. **HOSTILIDADE (id_personagem, id_personagem)**
   - {id_personagem} -> {id_personagem}

9. **ALIADOS (id_personagem, id_personagem)**
   - {id_personagem} -> {id_personagem}

10. **NOT_PLAY_CHARACTER_FORM (id_npc, forma)**
    - {id_npc} -> {forma}

11. **HUMANOIDE (id_humanoide, eqp_bota, eqp_luva, eqp_calça, eqp_colar, eqp_peitoral, eqp_anel, eqp_cabeça, mão_esq, mão_dir, stamina_max, mana_max, id_especie)**
    - {id_humanoide} -> {eqp_bota, eqp_luva, eqp_calça, eqp_colar, eqp_peitoral, eqp_anel, eqp_cabeça, mão_esq, mão_dir, stamina_max, mana_max, id_especie}

12. **MAGIA_HUMANOIDE (id_humanoide, id_magia)**
    - {(id_humanoide, id_magia)} (Chave composta)

13. **MAGIA (id_magia, elemento, dano, nível, custo_mana)**
   - {id_magia} -> {elemento, dano, nível, custo_mana}
