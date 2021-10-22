--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimfunz
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(NOME_FUNZ                     CHAR(50) NULLIF (NOME_FUNZ = BLANKS)
,DESC_FUNZ                     CHAR(100) NULLIF (DESC_FUNZ = BLANKS)
,TIPO_FUNZ                     CHAR(20) NULLIF (TIPO_FUNZ = BLANKS)
,DETT_FUNZ                     CHAR(80) NULLIF (DETT_FUNZ = BLANKS)
,AZIONE                        CHAR(80) NULLIF (AZIONE = BLANKS)
,PARAMETRI                     CHAR(1000) NULLIF (PARAMETRI = BLANKS)
)