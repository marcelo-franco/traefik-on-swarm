#!/bin/bash

# 1. Obtenha o endereco IP da maquina do01
echo ""
echo "Getting IP of do01..."
echo ""
DO1IP=$(docker-machine ip do01)

# 2. Inicialize o modo swarm do Docker na maquina do01 (manager)
echo ""
echo "Initializing Docker swarm mode on do01"
echo ""
docker-machine ssh do01 "docker swarm init --advertise-addr $DO1IP --listen-addr $DO1IP"

# 3. Torne do01 a maquina ativa (para conectar o cliente do Docker ao node do01)
# eval $(docker-machine env do01)
