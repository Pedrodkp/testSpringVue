# testSpringVue
Poc para Stack: PL-SQL (Oracle) + Java (Spring) + JavaScript (VusJs)

## /db

Diretório contempla script para criação do banco de dados Oracle. 

Para teste rápido recomendo usar database gratuíto na Oracle Cloud.

How-To de criação de instância free-tier na nuvem e conexão no Dbeaver: 

https://dev.to/pinei/free-oracle-database-how-to-10hb

## /server

Diretório contempla projeto Java para BackEnd (APIs).

Este projeto utiliza lombok para código boilerplate, instale a extenção na sua IDE preferida (Eclipse recomendado):

https://projectlombok.org/setup/eclipse

O projeto foi criado com o Spring Initializr

https://start.spring.io/

Este projeto utiliza spring, que por sua vez conecta por SSH por .jks e não .sso/.p12,
configure o ojdbc.properties de sua wallet para utilizar keystore.

https://blogs.oracle.com/dev2dev/ssl-connection-to-oracle-db-using-jdbc,-tlsv12,-jks-or-oracle-wallets

### Para realização do crud

A montagem das apis para o crud de exemplo foi baseada no seguinte material:

https://mkyong.com/spring-boot/spring-boot-spring-data-jpa-oracle-example/

