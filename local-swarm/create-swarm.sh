#!/bin/sh

#
# Pré-requisitos da máquina local
# 
# 1. Instalação do VirtualBox
# https://www.virtualbox.org/manual/ch02.html
# 
# 2. Instalação do docker-machine, de acordo com seu sistema operacional
# https://docs.docker.com/machine/get-started/
# Docker for Windows (Windows 10 Pro+)
# Docker for Mac (Mac OS)
# Docker Toolbox (Windows 10 Home)
#

# 1. Crie as três máquinas virtuais
docker-machine create -d virtualbox manager && docker-machine create -d virtualbox worker1 && docker-machine create -d virtualbox worker2

# 2. Obtenha o endereço IP da máquinmanager
MANAGERIP=$(docker-machine ip manager)

# 3. Inicialize o modo swarm do Docker na máquinamanager
docker-machine ssh manager "docker swarm init --advertise-addr $MANAGERIP --listen-addr $MANAGERIP"

# 4. Obtenha o token do swarm que permite adicionar nós do tipo worker
SWARMTOKEN=$(docker-machine ssh manager "docker swarm join-token -q worker")

# 5. Adicione as máquinasworker1 e worker2 como nós do tipo worker 
docker-machine ssh worker1 "docker swarm join --token $SWARMTOKEN $MANAGERIP:2377" && docker-machine ssh worker2 "docker swarm join --token $SWARMTOKEN $MANAGERIP:2377"

# 6. Torne manager a maquina ativa (para conectar o cliente do Docker ao manager)
eval $(docker-machine env manager)
