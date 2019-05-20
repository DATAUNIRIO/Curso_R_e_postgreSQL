library(RPostgreSQL)
con <- dbConnect('PostgreSQL',user = 'postgres',
                 password = 'SENHA',
                 host = 'localhost',port = 5432,
                 dbname = 'My_Database')
dbListTables(con)
# disconnect from the database
dbDisconnect(con)

###########################################################################
# PostgreSQL and dplyr                                                    #
# If you do use dplyr, the good news is that you can connect to a         #      
# PostgreSQL database directly through the dplyr function src_postgres(). #
########################################################################### 

library('dplyr')
# Connect to local PostgreSQL via dplyr
localdb <- src_postgres(dbname = 'My_Database',
                        host = 'localhost',
                        port = 5432,
                        user = 'postgres',
                        password = 'SENHA')
# The tbl() command lets you access tables in the database remotely, 
# and sql() lets you send queries.
# this is not a data frame; it's a dplyr PostgreSQL handle into the database
dados = tbl(localdb, "imdb") 
dados
summary(dados)
summary(as.data.frame(dados))


library(ggplot2)
library(ggthemes)
ggplot(data = dados) +
  aes(x = Metascore, y = Runtime) +
  geom_point(color = "#fd9567") +
  geom_smooth(span = 0.75) +
  labs(title = "ggplot do banco de dados em postgreSQL ",
       x = "Escore",
       y = "Tempo") +
  theme_solarized()

# 2014
dados2<-as.data.frame(dados)
dados2<-dados %>%
  filter(Year == 2014)
# ggplot 2014
ggplot(data = dados2) +
  aes(x = Metascore, y = Runtime) +
  geom_point(color = "#fd9567") +
  geom_smooth(span = 0.75) +
  labs(title = "ggplot do banco de dados em postgreSQL em 2014",
       x = "Escore",
       y = "Tempo") +
  theme_economist()

# shuts down database
rm(list=c('dados','dados2','localdb')); gc() 

# What is the difference between gc() and rm()
# https://stackoverflow.com/questions/8813753/what-is-the-difference-between-gc-and-rm

#-------------------------------------------------------------------------------------------------



#######################################################################
#######################################################################
#######################################################################

