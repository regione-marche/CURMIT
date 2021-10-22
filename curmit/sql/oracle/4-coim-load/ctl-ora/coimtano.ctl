--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimtano
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_TANO                      CHAR(8) NULLIF (COD_TANO = BLANKS) "RTRIM(:COD_TANO)"
,DESCR_TANO                    CHAR(200) NULLIF (DESCR_TANO = BLANKS) "RTRIM(:DESCR_TANO)"
,DESCR_BREVE                   CHAR(80) NULLIF (DESCR_BREVE = BLANKS) "RTRIM(:DESCR_BREVE)"
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS) "RTRIM(:UTENTE)"
,FLAG_SCATENANTE               CHAR(1) NULLIF (FLAG_SCATENANTE = BLANKS)
,NORMA                         CHAR(100) NULLIF (NORMA = BLANKS) "RTRIM(:NORMA)"
,FLAG_STP_ESITO                CHAR(1) NULLIF (FLAG_STP_ESITO = BLANKS)
,GG_ADATTAMENTO                DECIMAL EXTERNAL(4) NULLIF (GG_ADATTAMENTO = BLANKS)
,FLAG_REPORT                   CHAR(1) NULLIF (FLAG_REPORT = BLANKS)
)
