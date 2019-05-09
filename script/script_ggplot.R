

#IMDB <- readr::read_csv("https://raw.githubusercontent.com/DATAUNIRIO/Curso_R_e_postgreSQL/master/arquivos/IMDB.csv")
#GOT <- readr::read_delim("https://raw.githubusercontent.com/DATAUNIRIO/Curso_R_e_postgreSQL/master/arquivos/Game_of_Thrones_Data.csv", ";", escape_double = FALSE, trim_ws = TRUE)

#------------------------------------------------------------------------------------------------------


library(ggplot2)
library(ggthemes)

ggplot(data = IMDB) +
  aes(x = Metascore, y = Runtime) +
  geom_point(color = "#fd9567") +
  geom_smooth(span = 0.75) +
  labs(title = "ggplot do banco de dados em postgreSQL ",
    x = "Escore",
    y = "Tempo") +
  theme_solarized()


ggplot(data = GOT) +
  aes(x = CASA, y = Idade) +
  geom_boxplot(fill = "#31688e") +
  theme_solarized()
