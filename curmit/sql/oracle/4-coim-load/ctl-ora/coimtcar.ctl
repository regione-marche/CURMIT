--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimtcar
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_AREA                      CHAR(8) NULLIF (COD_AREA = BLANKS) "RTRIM(:COD_AREA)"
,COD_OPVE                      CHAR(8) NULLIF (COD_OPVE = BLANKS) "RTRIM(:COD_OPVE)"
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS) "RTRIM(:UTENTE)"
)
