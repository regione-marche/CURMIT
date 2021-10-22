--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimmenu
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(NOME_MENU                     CHAR(20) NULLIF (NOME_MENU = BLANKS)
,LIVELLO                       CHAR(2) NULLIF (LIVELLO = BLANKS)
,SCELTA_1                      CHAR(2) NULLIF (SCELTA_1 = BLANKS)
,SCELTA_2                      CHAR(2) NULLIF (SCELTA_2 = BLANKS)
,SCELTA_3                      CHAR(2) NULLIF (SCELTA_3 = BLANKS)
,SCELTA_4                      CHAR(2) NULLIF (SCELTA_4 = BLANKS)
,LVL                           DECIMAL EXTERNAL(3) NULLIF (LVL = BLANKS)
,SEQ                           DECIMAL EXTERNAL(3) NULLIF (SEQ = BLANKS)
)