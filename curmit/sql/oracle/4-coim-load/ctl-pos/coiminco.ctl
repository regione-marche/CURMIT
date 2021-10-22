--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coiminco
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_INCO                      CHAR(8) NULLIF (COD_INCO = BLANKS)
,COD_CINC                      CHAR(8) NULLIF (COD_CINC = BLANKS)
,TIPO_ESTRAZIONE               CHAR(8) NULLIF (TIPO_ESTRAZIONE = BLANKS)
,COD_IMPIANTO                  CHAR(8) NULLIF (COD_IMPIANTO = BLANKS)
,DATA_ESTRAZIONE               DATE(10) "YYYY-MM-DD" NULLIF (DATA_ESTRAZIONE = BLANKS)
,DATA_ASSEGN                   DATE(10) "YYYY-MM-DD" NULLIF (DATA_ASSEGN = BLANKS)
,COD_OPVE                      CHAR(8) NULLIF (COD_OPVE = BLANKS)
,DATA_VERIFICA                 DATE(10) "YYYY-MM-DD" NULLIF (DATA_VERIFICA = BLANKS)
,ORA_VERIFICA                  CHAR(8) NULLIF (ORA_VERIFICA = BLANKS)
,DATA_AVVISO_01                DATE(10) "YYYY-MM-DD" NULLIF (DATA_AVVISO_01 = BLANKS)
,COD_DOCUMENTO_01              CHAR(8) NULLIF (COD_DOCUMENTO_01 = BLANKS)
,DATA_AVVISO_02                DATE(10) "YYYY-MM-DD" NULLIF (DATA_AVVISO_02 = BLANKS)
,COD_DOCUMENTO_02              CHAR(8) NULLIF (COD_DOCUMENTO_02 = BLANKS)
,STATO                         CHAR(1) NULLIF (STATO = BLANKS)
,ESITO                         CHAR(1) NULLIF (ESITO = BLANKS)
,NOTE                          CHAR(4000) NULLIF (NOTE = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS)
,TIPO_LETTERA                  CHAR(1) NULLIF (TIPO_LETTERA = BLANKS)
)
