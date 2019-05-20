#install.packages("RPostgreSQL")
#Cria Conexao com o banco PostgreSQL
library(RPostgreSQL)
con <- dbConnect('PostgreSQL',user = 'postgres',
                 password = 'postgres', 
                 host = 'localhost',port = 5432,
                 dbname = 'My_Database')
#obten informações do banco de dados
RPostgreSQL::dbGetInfo(con)
#Lista as Tabelas do banco de dados
dbListTables(con)
#Lista os campos da tabela
colnames<- dbListFields(con,"GAME_OF_THRONES_TABLE")
#Fecha a conexão com o banco ( importante não ficar com a conexão aberta )
RPostgreSQL::postgresqlCloseConnection(con)

#RPostgreSQL::postgresqlCloseResult(rs)
#rs <- RPostgreSQL::dbSendQuery(con,'select * from "GAME_OF_THRONES_TABLE"')
#fetch(rs,2)

#Envia uma query para o banco de dados - Uso geérico, pode ser inconveniente montar a query
RPostgreSQL::dbSendQuery(con,'INSERT INTO "GAME_OF_THRONES_TABLE"("Character","Idade","Morto","Sexo","CASA") VALUES(\'personagem\',99,\'FALSE\',1,\'CASINHA\')')

#Forma mais fácil de copiar uma tabela inteira para um dataframe
got<- RPostgreSQL::dbReadTable(con,"GAME_OF_THRONES_TABLE")
got$ID <- NULL
#forma mais fácil de escrever dados em uma tabela
RPostgreSQL::postgresqlWriteTable(con,name = "GAME_OF_THRONES_TABLE",row.names = FALSE, value = got, append = T)

#Filtro
RPostgreSQL::dbGetQuery(con,'SELECT * FROM "GAME_OF_THRONES_TABLE" WHERE "Idade">50')

result <- RPostgreSQL::dbSendQuery(con,'SELECT * FROM "GAME_OF_THRONES_LOG" WHERE "tstamp" < \'2019-05-20 11:20:00\'::timestamp')


