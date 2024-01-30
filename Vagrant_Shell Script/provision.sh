#!/bin/bash

# Atualizar repositórios
sudo apt-get update

# Instalar pacotes
sudo apt-get install -y vim curl telnet unzip wget net-tools htop nmap

# Definir nome da máquina
sudo hostnamectl set-hostname Vagrant_Sehll

# Criar usuário com o seu nome
sudo useradd -m -s /bin/bash joaoess
sudo passwd

# Fornecer privilégios sudo ao usuário
sudo usermod -aG sudo joaoess