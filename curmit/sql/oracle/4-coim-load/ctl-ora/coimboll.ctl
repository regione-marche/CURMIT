--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimboll
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_BOLLINI                   DECIMAL EXTERNAL(26) NULLIF (COD_BOLLINI = BLANKS)
,COD_MANUTENTORE               CHAR(8) NULLIF (COD_MANUTENTORE = BLANKS) "RTRIM(:COD_MANUTENTORE)"
,DATA_CONSEGNA                 DATE(10) "YYYY-MM-DD" NULLIF (DATA_CONSEGNA = BLANKS)
,NR_BOLLINI                    DECIMAL EXTERNAL(9) NULLIF (NR_BOLLINI = BLANKS)
,MATRICOLA_DA                  CHAR(20) NULLIF (MATRICOLA_DA = BLANKS) "RTRIM(:MATRICOLA_DA)"
,MATRICOLA_A                   CHAR(20) NULLIF (MATRICOLA_A = BLANKS) "RTRIM(:MATRICOLA_A)"
,PAGATI                        CHAR(1) NULLIF (PAGATI = BLANKS)
,COSTO_UNITARIO                DECIMAL EXTERNAL(8) NULLIF (COSTO_UNITARIO = BLANKS)
,NR_BOLLINI_RESI               DECIMAL EXTERNAL(9) NULLIF (NR_BOLLINI_RESI = BLANKS)
,NOTE                          CHAR(4000) NULLIF (NOTE = BLANKS) "RTRIM(:NOTE)"
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS) "RTRIM(:UTENTE)"
,DATA_SCADENZA                 DATE(10) "YYYY-MM-DD" NULLIF (DATA_SCADENZA = BLANKS)
,COD_TPBO                      CHAR(2) NULLIF (COD_TPBO = BLANKS) "RTRIM(:COD_TPBO)"
,IMP_PAGATO                    DECIMAL EXTERNAL(12) NULLIF (IMP_PAGATO = BLANKS)
)