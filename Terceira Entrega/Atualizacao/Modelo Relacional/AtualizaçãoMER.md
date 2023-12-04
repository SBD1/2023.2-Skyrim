# Atualização do Modelo Relacional

Após a correção do professor e com o novo Diagrama de Entidade e Relacionamento, uma série de mudanças foram feitas no MER junto com a sua reestruturação.

## Sumário
* [Mudanças](#Mudanças)
 * [Modelo Relacional](#Modelo-Relacional)
 * [Histórico de Versão](#Histórico-de-Versão)

##  Mudanças:
  As principais mudanças que ocorreram foram:

  1 - Com a criação das Gemas, foi criada uma tabela de relação entre os encantamentos que cada gema pode proporcionar.
  
  2- Agora o PC pode aprender um encantamento, desse modo, foi criada uma tabela para verificar os encantamentos que o PC pode fazer. Se o status for TRUE, ele sabe, por outro lado, se for NULL, ele ainda não aprendeu.
  
  3 - O humanoide pode realizar uma magia. Para saber se ele pode ou não fazer certa magia, temos a tabela MAGIA_HUMANOIDE. Desse modo, a magia pode sofrer mudança de nível e aumento do seu dano de acordo com o desenvolvimento da história.

  4- Da mesma forma que a MAGIA_HUMANOIDE, podemos também ter a evolução de uma habilidade da espécie, por isso temos a tabela HABILIDADE_ESPECIE.

  5- Um certo nível pode possuir um conjunto de missões nele. Por exemplo, o nível 1 pode ter 4 ou mais missões. Desse modo, existe a tabela MISSAO_NIVEL em que é uma tabela que categoriza as missões por nível.

  6- Em missão_MATAR_NPC, existe o atributo tipo_instancia_npc, que é um guia para saber de qual npc a instância tem que ser originada para fazer parte da missão. Isso foi feito por meio de um trigger.

  7- Uma instância de um item pode estar em diversos tipos de lugares diferentes, seja uma sala, um inventário ou em uma loja. Por isso, ela possui atributos que podem ser NULL ou não dependendo da sua localização.

  8 - Foi criada a tabela CONSOME, ela é utilizada para verificar a quantidade máxima que um PC pode consumir um certo item durante um nível. Por exemplo, durante o nível 1, o PC só pode consumir até 3 porções de cura.

  9 - Os consumíveis podem ser classificados em 3 tipos diferentes: "FORCE" ou "ENERGY" ou "HEAL". Se for força, aumenta a mana, se for cura aumenta a vida e se for Energia aumenta a stamina. 

  **Importante:** Como uma forma de otimizar o banco, foi escolhido não criar tabelas específicas para cada especialidade dos consumíveis e sim apenas a tabela consumível com o seu tipo definido como atributo, já que o aumento seria o mesmo valor para qualquer tipo. Portanto, o controle para os efeitos dos consumíveis são feitos por meio de um procede.

  10 - Os diálogos dão formados por uma tábela entre a missão e o personagem em si, pois as insTâncias falariam as mesmas coisas.


## Modelo Relacional:

O modelo relacional pode ser observado por meio da imagem abaixo. No entanto, se desejar visualizá-lo de modo mais legível, é possivel por meio de 

- MER em PDF no [link](ModeloRelacionalSkyrim_Reorganização_2.00.pdf)
- MER em Drawio no [link](ModeloRelacionalSkyrim_Reorganização_2.00.drawio)
- MER em PNG no [link](ModeloRelacionalSkyrim_Reorganização_2.00.png)

  ### Versão Atualizada:

    Foram corrigidos o últimos detalhes do Modelo Relacional.
<div align="center">
  <img src="ModeloRelacionalSkyrim_Reorganização_2.00.png">
  Figura: Modelo Relacional reestruturado
</div>


## Histórico de Versão

| Versão | Alteração | Responsável | Revisor | Data |
| - | - | - | - | - |
| 1.0 | Criaçao do novo MER| Larissa Stéfane | - | 24/11/2023
| 2.0 | Criaçao do md| Larissa Stéfane | - | 01/12/2023
  
