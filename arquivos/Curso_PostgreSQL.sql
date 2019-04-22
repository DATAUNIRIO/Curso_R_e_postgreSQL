﻿--  CRIANDO A TABELA
CREATE TABLE CIDADESINTELIGENTES
(
timestamp varchar,
sensorID varchar,
longitude double precision,
latitude double precision,
temperature real
);

-- CRIANDO MAIS COLUNAS
ALTER TABLE CIDADESINTELIGENTES 
    ADD TEMPERATURA NUMERIC,
    ADD ENERGIA NUMERIC,
    ADD AGUA NUMERIC,
    ADD FUMACA NUMERIC,
    ADD CO2 NUMERIC,
    ADD QUALIDADEAR NUMERIC,
    ADD QUALIDADEAGUA NUMERIC,
    ADD TEMPERATURA2 NUMERIC;

-- MODIFICANDO A COLUNA DATA
ALTER TABLE CIDADESINTELIGENTES ALTER COLUMN timestamp TYPE real USING "timestamp"::real;	

INSERT INTO cidadesinteligentes (timestamp,sensorID,longitude,latitude,temperature,TEMPERATURA,ENERGIA,AGUA,FUMACA,CO2,QUALIDADEAR,QUALIDADEAGUA,TEMPERATURA2)
      VALUES (1539902333.98391,'SN100',-43.2060859,-22.9526124,30.4513990712304,30.4513990712304,30.4513990712304,30.4513990712304,30.4513990712304,30.4513990712304,30.4513990712304,30.4513990712304,30.4513990712304);

--TRUNCATE -- DELETA TODAS AS INFORMACOES DE UMA TABELA 
TRUNCATE  CIDADESINTELIGENTES ;