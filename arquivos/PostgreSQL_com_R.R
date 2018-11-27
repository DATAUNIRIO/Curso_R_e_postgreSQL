##---------------------------------------------------------------##
##                                                               ##
##    Nome: Curso PostgreSQL com o R                             ##
##                                                               ##
##                                                               ##
##                                                               ##
##    prof. Steven Dutt-Ross                                     ##
##    UFF/UNIRIO                                                 ##
##---------------------------------------------------------------##

library(RPostgreSQL)
# Conectar
con <- dbConnect('PostgreSQL',user = 'postgres',
                 password= 'SENHA',
                 host = 'localhost',port = 5432,
                 dbname= 'MEU_BANCO')

# lista as tabelas do banco de dados
dbListTables(con)

# estatisticas do banco de dados
output <- dbGetQuery(con, "SELECT * FROM cidadesinteligentes")
mean(output$temperatura)
table(output$sensorid)
summary(output)

# ggplot do banco de dados SQL
library(ggplot2)
library(ggthemes)
# temperatura
g <-ggplot(data = output) +
  aes(y = temperatura, x = seq_along(temperatura)) +
  geom_line(color = "#0c4c8a") +
  labs(title = "Temperatura",
       x = "tempo",
       y = "temperatura",
       caption = "Fonte: SCA Smart City Analytics") +
  theme_economist()
g

g <-ggplot(output, aes(x = as.factor(sensorid),y = temperatura,fill= as.factor(sensorid))) +
  geom_boxplot()
g + theme_economist() + 
  scale_color_economist() + 
  labs(title = "Temperatura por sensor da cidade",
     x = "Sensor",
     y = "temperatura",
     caption = "Fonte: SCA Smart City Analytics") +
  theme_economist()


# objetivo: fazer o box-plot para o nível de fumaça
g <-ggplot(output, aes(x = as.factor(sensorid),y = fumaca,fill= as.factor(sensorid))) +
  geom_boxplot()
g + theme_economist() + 
  scale_color_economist() + 
  labs(title = "Nivel de fumaça por sensor da cidade",
       x = "Sensor",
       y = "fumaça",
       caption = "Fonte: SCA Smart City Analytics") +
  theme_economist()


##############################################################################################
# Tidy
##############################################################################################

# filtro do sensor 'SN100'
library(dplyr)
output2<-output %>%
  filter(sensorid == "'SN100'")
g <-ggplot(output2, aes(x = as.factor(sensorid),y = temperatura,fill= as.factor(sensorid))) +
  geom_boxplot()
g + theme_economist() + 
  scale_color_economist() + 
  ggtitle("Temperatura por sensor da cidade")+
  xlab("Sensor")

# filtro de 50 observações para a série temporal
output3<- slice(output2, 1:50)
g <-ggplot(data = output3) +
  aes(y = temperatura, x = seq_along(temperatura)) +
  geom_line(color = "#0c4c8a") +
  labs(title = "Temperatura",
       x = "tempo",
       y = "temperatura",
       caption = "Fonte: SCA Smart City Analytics") +
  theme_economist()
g


# desconectar da base de dados
dbDisconnect(con)

# limpar todos os arquivos
rm(list=ls())




