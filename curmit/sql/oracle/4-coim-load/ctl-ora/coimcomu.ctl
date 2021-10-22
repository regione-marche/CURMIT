--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimcomu
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_COMUNE                    CHAR(8) NULLIF (COD_COMUNE = BLANKS) "RTRIM(:COD_COMUNE)"
,COD_PROVINCIA                 CHAR(8) NULLIF (COD_PROVINCIA = BLANKS) "RTRIM(:COD_PROVINCIA)"
,DENOMINAZIONE                 CHAR(40) NULLIF (DENOMINAZIONE = BLANKS) "RTRIM(:DENOMINAZIONE)"
,FLAG_VAL                      CHAR(1) NULLIF (FLAG_VAL = BLANKS)
,CAP                           CHAR(5) NULLIF (CAP = BLANKS) "RTRIM(:CAP)"
,ID_BELFIORE                   CHAR(4) NULLIF (ID_BELFIORE = BLANKS) "RTRIM(:ID_BELFIORE)"
,COD_ISTAT                     CHAR(7) NULLIF (COD_ISTAT = BLANKS) "RTRIM(:COD_ISTAT)"
,POPOLAZ_CITT                  DECIMAL EXTERNAL(8) NULLIF (POPOLAZ_CITT = BLANKS)
,POPOLAZ_AIMP                  DECIMAL EXTERNAL(8) NULLIF (POPOLAZ_AIMP = BLANKS)
)