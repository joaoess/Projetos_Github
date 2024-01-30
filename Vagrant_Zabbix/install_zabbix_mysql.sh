#!/bin/bash

# Atualizar repositórios
sudo apt-get update

# Instalar MySQL sem interação
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password senha_do_root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password senha_do_root'
sudo apt-get install -y mysql-server

# Instalar Zabbix Server
sudo apt-get install -y zabbix-server-mysql

# Criar banco de dados e usuário para o Zabbix Server
sudo mysql -uroot -psenha_do_root -e "CREATE DATABASE zabbix character set utf8 collate utf8_bin;"
sudo mysql -uroot -psenha_do_root -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'senha_do_zabbix';"
sudo mysql -uroot -psenha_do_root -e "GRANT ALL PRIVILEGES ON zabbix.* TO 'zabbix'@'localhost' WITH GRANT OPTION;"
sudo mysql -uroot -psenha_do_root -e "FLUSH PRIVILEGES;"

# Importar esquema do banco de dados do Zabbix
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | sudo mysql -uzabbix -psenha_do_zabbix zabbix

# Reiniciar serviços
sudo systemctl restart zabbix-server
sudo systemctl restart mysql
