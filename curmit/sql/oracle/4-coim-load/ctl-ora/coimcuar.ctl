--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimcuar
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_AREA                      CHAR(8) NULLIF (COD_AREA = BLANKS)
,COD_COMUNE                    CHAR(8) NULLIF (COD_COMUNE = BLANKS)
,COD_URB                       CHAR(8) NULLIF (COD_URB = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS)
)
