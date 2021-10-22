--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimtpbo
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_TPBO                      CHAR(2) NULLIF (COD_TPBO = BLANKS) "RTRIM(:COD_TPBO)"
,DESCR_TPBO                    CHAR(20) NULLIF (DESCR_TPBO = BLANKS) "RTRIM(:DESCR_TPBO)"
)
