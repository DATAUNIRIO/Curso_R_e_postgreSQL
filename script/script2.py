# -*- coding: utf-8 -*-
"""
Created on Thu May  9 09:42:42 2019

@author: Steven Dutt Ross e Rafael Salazar Stavale
"""

import psycopg2 as ps
from sqlalchemy import create_engine
import pandas as pd
import io
import requests


# Importar e mostrar as 05 linhas 
url = "https://raw.githubusercontent.com/DATAUNIRIO/Curso_R_e_postgreSQL/master/arquivos/IMDB.csv"
s = requests.get(url).content
ds = pd.read_csv(io.StringIO(s.decode('utf-8')))
print(ds.head(5))

#------------------------------------------------------------------------------------------------------

mydb = create_engine('postgresql+psycopg2://postgres:SENHA@localhost:5432/BANCODEDADOS')

ds.to_sql(name='imdb', con=mydb, if_exists = 'replace', index=False)

# via pandas
data = pd.read_sql('SELECT * FROM IMDB', mydb)
print(data.head(5))

data.plot.scatter(x='Year', y='Runtime',c='DarkBlue')

