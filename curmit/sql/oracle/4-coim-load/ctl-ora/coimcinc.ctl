--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimcinc
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_CINC                      CHAR(8) NULLIF (COD_CINC = BLANKS) "RTRIM(:COD_CINC)"
,DESCRIZIONE                   CHAR(40) NULLIF (DESCRIZIONE = BLANKS) "RTRIM(:DESCRIZIONE)"
,DATA_INIZIO                   DATE(10) "YYYY-MM-DD" NULLIF (DATA_INIZIO = BLANKS)
,DATA_FINE                     DATE(10) "YYYY-MM-DD" NULLIF (DATA_FINE = BLANKS)
,NOTE                          CHAR(4000) NULLIF (NOTE = BLANKS) "RTRIM(:NOTE)"
,CTR_ESTRAT_01                 DECIMAL EXTERNAL(9) NULLIF (CTR_ESTRAT_01 = BLANKS)
,CTR_ESTRAT_02                 DECIMAL EXTERNAL(9) NULLIF (CTR_ESTRAT_02 = BLANKS)
,CTR_ESTRAT_03                 DECIMAL EXTERNAL(9) NULLIF (CTR_ESTRAT_03 = BLANKS)
,CTR_ESTRAT_04                 DECIMAL EXTERNAL(9) NULLIF (CTR_ESTRAT_04 = BLANKS)
,CTR_ESTRAT_05                 DECIMAL EXTERNAL(9) NULLIF (CTR_ESTRAT_05 = BLANKS)
,CTR_ESTRAT_06                 DECIMAL EXTERNAL(9) NULLIF (CTR_ESTRAT_06 = BLANKS)
,CTR_ESTRAT_08                 DECIMAL EXTERNAL(9) NULLIF (CTR_ESTRAT_08 = BLANKS)
,CTR_ESTRAT_09                 DECIMAL EXTERNAL(9) NULLIF (CTR_ESTRAT_09 = BLANKS)
,STATO                         CHAR(1) NULLIF (STATO = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,ID_UTENTE                     CHAR(10) NULLIF (ID_UTENTE = BLANKS) "RTRIM(:ID_UTENTE)"
,CONTROLLI_PREV                DECIMAL EXTERNAL(8) NULLIF (CONTROLLI_PREV = BLANKS)
)
