--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimanec
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_ENRE                      CHAR(8) NULLIF (COD_ENRE = BLANKS) "RTRIM(:COD_ENRE)"
,COD_CIMP                      CHAR(8) NULLIF (COD_CIMP = BLANKS) "RTRIM(:COD_CIMP)"
,TESTO_ANOM                    CHAR(4000) NULLIF (TESTO_ANOM = BLANKS) "RTRIM(:TESTO_ANOM)"
)
