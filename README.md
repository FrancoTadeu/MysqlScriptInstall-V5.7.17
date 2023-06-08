<h1 align="center"> MySQL 5.7.17 Instalação via RPM packages </h1>
<div align="center">

![text-x-script-icon](https://pngimg.com/uploads/mysql/mysql_PNG36.png)


 <h1>

</div>
  
 <b>Este Script realiza a instalação do MySQL 5.7.17 e configura o serviço | Download Link : https://downloads.mysql.com/archives/get/p/23/file/mysql-5.7.17-1.el7.x86_64.rpm-bundle.tar </b>
  

  [Execução do script]
  - chmod +x <b>mysql_install_v5717_rpm.sh</b>
      - ./mysql_install_v5717_rpm.sh 
  

   <h1></h1>
  [Passos da execução]
 
  <b> Criação do diretório de trabalho /tmp/mysql-install e CASO NECESSÁRIO instala o PERL </b>
 
![image](https://github-production-user-asset-6210df.s3.amazonaws.com/93008112/244263855-943ef685-cf22-419a-a2eb-64abab5452e0.png)


   <h1></h1>
   <b> Realiza o Download dos pacotes </b>
 
 ![image](https://github.com/FrancoTadeu/MysqlScriptInstall-V5.7.17/assets/93008112/6f7812b1-ecd1-4c80-938f-af250f348c28)

 
   <h1></h1>
   <b> Tentativa de inicio do MySQL Server service, caso não seja iniciado o erro abaixo será retornado </b>
 
 ![image](https://github.com/FrancoTadeu/MysqlScriptInstall-V5.7.17/assets/93008112/ab1a6748-1a3a-4391-b203-dcf61cf36968)
 
 
   <h1></h1>
   <b> A senha temporária  do usuário root gerada no arquivo /var/log/mysql.log será exibida neste campo</b>
 
 ![image](https://github.com/FrancoTadeu/MysqlScriptInstall-V5.7.17/assets/93008112/fe42cd68-be7f-4872-82d1-8f4ab9587de0)
 
 
  [Resolução de dependências do MySQL Client]
 
     - O pacote mysql-community-client-5.7.17-1.el7.x86_64.rpm possui uma Dependência no pacote ncurses-compat-libs-6.1-7.20180224.el8.x86_64, ela foi resolvida realizando a instalação do ncurses no script. Por este motivo a ordem de instalação dos pacotes é importante. O MySQL Client e MySQL Server sempre serão os últimos. 
     
