# Instalação


## Pré-requisitos

Tenha um sistema operacional baseado em UNIX preferencialmente.

Programas necessários :
```
docker
virtualenv
docker-compose
pip
```

Para criar um ambiente isolado e ativá-lo, digite:
``` 
virtualenv skyrim_venv
source ./skyrim_venv/bin/activate
``` 
Para instalar as dependências :
```
pip install -r requirements.txt 
sudo docker-compose up -d
```
Para executar o programa :

```
python main.py
```
