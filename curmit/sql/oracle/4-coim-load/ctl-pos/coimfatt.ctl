--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimfatt
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_FATT                      CHAR(8) NULLIF (COD_FATT = BLANKS)
,DATA_FATT                     DATE(10) "YYYY-MM-DD" NULLIF (DATA_FATT = BLANKS)
,NUM_FATT                      CHAR(10) NULLIF (NUM_FATT = BLANKS)
,COD_SOGG                      CHAR(8) NULLIF (COD_SOGG = BLANKS)
,TIPO_SOGG                     CHAR(1) NULLIF (TIPO_SOGG = BLANKS)
,IMPONIBILE                    DECIMAL EXTERNAL(10) NULLIF (IMPONIBILE = BLANKS)
,PERC_IVA                      DECIMAL EXTERNAL(7) NULLIF (PERC_IVA = BLANKS)
,FLAG_PAG                      CHAR(1) NULLIF (FLAG_PAG = BLANKS)
,MATR_DA                       CHAR(20) NULLIF (MATR_DA = BLANKS)
,MATR_A                        CHAR(20) NULLIF (MATR_A = BLANKS)
,N_BOLLINI                     DECIMAL EXTERNAL(26) NULLIF (N_BOLLINI = BLANKS)
,NOTA                          CHAR(4000) NULLIF (NOTA = BLANKS)
,MOD_PAG                       CHAR(400) NULLIF (MOD_PAG = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,ID_UTENTE                     CHAR(10) NULLIF (ID_UTENTE = BLANKS)
)
