--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimfuge
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_FUGE                      CHAR(1) NULLIF (COD_FUGE = BLANKS)
,DESCR_FUGE                    CHAR(50) NULLIF (DESCR_FUGE = BLANKS) "RTRIM(:DESCR_FUGE)"
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS) "RTRIM(:UTENTE)"
)