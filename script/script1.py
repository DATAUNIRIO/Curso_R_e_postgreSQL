# -*- coding: utf-8 -*-
"""
Created on Mon May  6 15:58:10 2019
@author: Steven Dutt Ross e Rafael Salazar Stavale
"""

#------------------------------------------------------------------------------------------------------


import psycopg2 as ps

try:
   connection = ps.connect(
                            host="localhost",
                            database="bancodedados",
                            user="postgres",
                            password='senha',
                            port="5432"
                            )
   cursor = connection.cursor()
   # Print PostgreSQL Connection properties
   print(connection.get_dsn_parameters(),"\n")
   # Print PostgreSQL version
   cursor.execute("SELECT version();")
   record = cursor.fetchone()
   print("Você está conectado a -", record,"\n")   
except (Exception, ps.Error) as error :
   print ("Erro ao conectar-se ao PostgreSQL", error)
finally:
   #closing database connection.
         if(connection):
            cursor.close()
            connection.close()
            print("conexão com PostgreSQL fechada")

   