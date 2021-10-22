--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimmovi
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_MOVI                      DECIMAL EXTERNAL(9) NULLIF (COD_MOVI = BLANKS)
,TIPO_MOVI                     CHAR(2) NULLIF (TIPO_MOVI = BLANKS) "RTRIM(:TIPO_MOVI)"
,COD_IMPIANTO                  CHAR(8) NULLIF (COD_IMPIANTO = BLANKS) "RTRIM(:COD_IMPIANTO)"
,DATA_SCAD                     DATE(10) "YYYY-MM-DD" NULLIF (DATA_SCAD = BLANKS)
,IMPORTO                       DECIMAL EXTERNAL(26) NULLIF (IMPORTO = BLANKS)
,IMPORTO_PAG                   DECIMAL EXTERNAL(26) NULLIF (IMPORTO_PAG = BLANKS)
,DATA_PAG                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_PAG = BLANKS)
,TIPO_PAG                      CHAR(2) NULLIF (TIPO_PAG = BLANKS) "RTRIM(:TIPO_PAG)"
,DATA_COMPET                   DATE(10) "YYYY-MM-DD" NULLIF (DATA_COMPET = BLANKS)
,RIFERIMENTO                   CHAR(8) NULLIF (RIFERIMENTO = BLANKS) "RTRIM(:RIFERIMENTO)"
,NOTA                          CHAR(1000) NULLIF (NOTA = BLANKS) "RTRIM(:NOTA)"
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS) "RTRIM(:UTENTE)"
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
)
