--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimtodo
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_TODO                      CHAR(8) NULLIF (COD_TODO = BLANKS)
,COD_IMPIANTO                  CHAR(8) NULLIF (COD_IMPIANTO = BLANKS)
,TIPOLOGIA                     CHAR(8) NULLIF (TIPOLOGIA = BLANKS)
,NOTE                          CHAR(4000) NULLIF (NOTE = BLANKS)
,COD_CIMP_DIMP                 CHAR(8) NULLIF (COD_CIMP_DIMP = BLANKS)
,FLAG_EVASIONE                 CHAR(1) NULLIF (FLAG_EVASIONE = BLANKS)
,DATA_EVASIONE                 DATE(10) "YYYY-MM-DD" NULLIF (DATA_EVASIONE = BLANKS)
,DATA_EVENTO                   DATE(10) "YYYY-MM-DD" NULLIF (DATA_EVENTO = BLANKS)
,DATA_SCADENZA                 DATE(10) "YYYY-MM-DD" NULLIF (DATA_SCADENZA = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS)
)