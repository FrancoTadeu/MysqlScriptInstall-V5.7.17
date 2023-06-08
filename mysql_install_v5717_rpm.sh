#!/bin/bash

######################################################
# Script Name: mysql_install_v5717_rpm.sh
# Description: This script will install MySQL Server specific Version 5.7.17 (SQL and DB Tunning will not be covered by this script)
# Author: Franco Tadeu (AGERI)
# Date: May 31, 2023
######################################################

workdir="/tmp/mysql-install"

#Cria diretorio de trabalho
mkdir $workdir
ls -laht /tmp | grep "mysql-install"
sleep 5

#Verifica instalação do perl, caso não esteja instalado executa a instalacao
if which perl >/dev/null 2>&1; then
    echo "####### Perl ja esta instalado ########"
else
    echo "###### Passo 01 / PERL NAO ENCONTRADO, EXECUTANDO INSTALACAO ######"
    sudo yum install -y perl >/dev/null

    if which perl >/dev/null 2>&1; then
        echo "PERL INSTALADO COM SUCESSO"
    else
        echo "######### INSTALAÇÃO DO PERL FALHOU #############"
    fi
fi

#Download dos pacotes do MySQL 5.7.17
echo -e '\033[05;31m###### Passo 02 / EXECUTANDO DOWNLOAD DOS PACOTES MYSQL 5.7.17 ######\033[00;37m'
wget --directory-prefix $workdir https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.17-1.el7.x86_64.rpm-bundle.tar
tar -xf $workdir/mysql-5.7.17-1.el7.x86_64.rpm-bundle.tar --directory $workdir
echo "TOTAL ARQUIVOS PRESENTES NO /tmp/mysql-install DEVE SER 13"
ls $workdir | wc -l 
sleep 5

#Executando instalacao dos primeiros pacotes
echo -e '\033[05;31m###### Passo 03 / INSTALANDO PRIMEIROS PACOTES  ######\033[00;37m'
rpm -i $workdir/mysql-community-common-5.7.17-1.el7.x86_64.rpm
rpm -i $workdir/mysql-community-libs-5.7.17-1.el7.x86_64.rpm
rpm -i $workdir/mysql-community-embedded-5.7.17-1.el7.x86_64.rpm
rpm -i $workdir/mysql-community-libs-compat-5.7.17-1.el7.x86_64.rpm
rpm -i $workdir/mysql-community-devel-5.7.17-1.el7.x86_64.rpm

sleep 5
#Instalar dependencia pacote mysql-client
echo -e '\033[05;31m###### Passo 04 / RESOLVENDO DEPENDENCIA PACOTE MYSQL-CLIENT  ######\033[00;37m'
yum install -y ncurses-compat-libs-6.1-7.20180224.el8.x86_64

#Executando instalacao dos pacotes client & server
echo -e '\033[05;31m###### Passo 05 / INSTALANDO PACOTE SERVER E CLIENT  ######\033[00;37m'
rpm -i $workdir/mysql-community-client-5.7.17-1.el7.x86_64.rpm
rpm -i $workdir/mysql-community-server-5.7.17-1.el7.x86_64.rpm

#Verificar se todos os pacotes foram instalados com exito
rpm -qa | grep mysql 
sleep 5

# Verificar status do mysqld e inicia-lo
sudo systemctl status mysqld
sleep 3
if systemctl start mysqld >/dev/null 2>&1; then
    echo -e '\033[05;32m###### Servico Mysqld iniciado com sucesso ######\033[00;32m'
else
    echo -e '\033[05;31m###### ERRO / Servico Mysqld nao iniciado ######\033[00;37m'
fi

#Obter a senha de root temporario gerada
senha=$(awk -F": " '/temporary password/ {print $2}' /var/log/mysqld.log)
echo -e '\033[05;33m###### IMPORTANTE / SENHA DE ROOT TEMPORARIA GERADA NO mysql.log ######\033[00;37m'
echo "A senha gerada e   ${senha}"

### Execucao do script de instalacao segura do MySQL
mysql_secure_installation -u root -p"${senha}" -h 127.0.0.1 -P 3306 --use-default
