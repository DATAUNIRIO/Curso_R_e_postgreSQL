--Cria-se a tabela antes de importar os dados ( Limitação do PostgreSQL )

CREATE TABLE public."GAME_OF_THRONES_TABLE"
(
  "ID" integer NOT NULL DEFAULT nextval('"GAME_OF_THRONES_TABLE_ID_seq"'::regclass),
  "Character" text,
  "Idade" text,
  "Morto" text,
  "Sexo" text,
  "CASA" text,
  CONSTRAINT "ID" PRIMARY KEY ("ID")
)
--Criando Tabela de Log
CREATE TABLE public.game_of_thrones_log
(
  operation character(1) NOT NULL,
  tstamp timestamp with time zone NOT NULL,
  userid text NOT NULL,
  cname text NOT NULL
)
--Agora deseja-se criar trigger que atualiza uma tabela separada de log
--Mas antes deve-se criar a função na qual a trigger executará

CREATE OR REPLACE FUNCTION gravar_log() RETURNS TRIGGER AS $GAME_OF_THRONES_LOG$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO GAME_OF_THRONES_LOG VALUES ('D', now(), user, OLD."Character");
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO GAME_OF_THRONES_LOG VALUES ('U', now(), user, NEW."Character");
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO GAME_OF_THRONES_LOG VALUES ('I', now(), user, NEW."Character");
            RETURN NEW;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$GAME_OF_THRONES_LOG$ LANGUAGE plpgsql;

CREATE TRIGGER got_trigger
AFTER INSERT OR UPDATE OR DELETE ON "GAME_OF_THRONES_TABLE"
    FOR EACH ROW EXECUTE PROCEDURE gravar_log();