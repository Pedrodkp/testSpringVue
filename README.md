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

Para montar as APIs foram utilizados vários tutoriais diferentes, utilizando o que era útil em cada um.

A montagem base das APIs para o crud de exemplo foi baseada no seguinte material:

https://www.javaguides.net/2020/01/spring-boot-hibernate-oracle-crud-example.html

Porém utilizando de Lombok como feito neste material mas para MySQL:

https://www.oracle.com/br/technical-resources/articles/dsl/crud-rest-sb2-hibernate.html

Além disso, alguns imports do Java não estavam claros, as duvidas foram tiradas com base neste terceiro tutorial:

https://mkyong.com/spring-boot/spring-boot-spring-data-jpa-oracle-example/

A inclusão não funcionava devido ao erro 'ORA-32575: Explicit column default is not supported for modifying vie hibernate' onde o Oracle não permitia informar o campo ID como 'default' e o Hibernate exige informar o campo para ID como não NULL e com estratégia de geração. Como o campo é controlado pelo banco de dados foi usado um gerador dummy, como retirei deste material:

https://stackoverflow.com/questions/3194721/bypass-generatedvalue-in-hibernate-merge-data-not-in-db

A alteração não retornava os campos calculados da view devido ao cache do hibernate, como limpar ele foi retirado deste material:

https://stackoverflow.com/questions/25063995/spring-boot-handle-to-hibernate-sessionfactory