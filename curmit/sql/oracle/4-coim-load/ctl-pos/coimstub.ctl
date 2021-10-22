--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimstub
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_IMPIANTO                  CHAR(8) NULLIF (COD_IMPIANTO = BLANKS)
,DATA_FIN_VALID                DATE(10) "YYYY-MM-DD" NULLIF (DATA_FIN_VALID = BLANKS)
,COD_UBICAZIONE                CHAR(8) NULLIF (COD_UBICAZIONE = BLANKS)
,LOCALITA                      CHAR(40) NULLIF (LOCALITA = BLANKS)
,COD_VIA                       CHAR(8) NULLIF (COD_VIA = BLANKS)
,TOPONIMO                      CHAR(20) NULLIF (TOPONIMO = BLANKS)
,INDIRIZZO                     CHAR(100) NULLIF (INDIRIZZO = BLANKS)
,NUMERO                        CHAR(8) NULLIF (NUMERO = BLANKS)
,ESPONENTE                     CHAR(3) NULLIF (ESPONENTE = BLANKS)
,SCALA                         CHAR(5) NULLIF (SCALA = BLANKS)
,PIANO                         CHAR(5) NULLIF (PIANO = BLANKS)
,INTERNO                       CHAR(3) NULLIF (INTERNO = BLANKS)
,COD_COMUNE                    CHAR(8) NULLIF (COD_COMUNE = BLANKS)
,COD_PROVINCIA                 CHAR(8) NULLIF (COD_PROVINCIA = BLANKS)
,CAP                           CHAR(5) NULLIF (CAP = BLANKS)
,COD_CATASTO                   CHAR(20) NULLIF (COD_CATASTO = BLANKS)
,COD_TPDU                      CHAR(8) NULLIF (COD_TPDU = BLANKS)
,COD_QUA                       CHAR(8) NULLIF (COD_QUA = BLANKS)
,COD_URB                       CHAR(8) NULLIF (COD_URB = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS)
)
