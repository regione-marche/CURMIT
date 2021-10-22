--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET WE8ISO8859P1
INTO TABLE coimacts
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_ACTS                      CHAR(8) NULLIF (COD_ACTS = BLANKS) "RTRIM(:COD_ACTS)"
,COD_DISTR                     CHAR(8) NULLIF (COD_DISTR = BLANKS) "RTRIM(:COD_DISTR)"
,DATA_CARIC                    DATE(10) "YYYY-MM-DD" NULLIF (DATA_CARIC = BLANKS)
,COD_DOCUMENTO                 CHAR(8) NULLIF (COD_DOCUMENTO = BLANKS) "RTRIM(:COD_DOCUMENTO)"
,CARICATI                      DECIMAL EXTERNAL(7) NULLIF (CARICATI = BLANKS)
,SCARTATI                      DECIMAL EXTERNAL(7) NULLIF (SCARTATI = BLANKS)
,INVARIATI                     DECIMAL EXTERNAL(7) NULLIF (INVARIATI = BLANKS)
,DA_ANALIZZARE                 DECIMAL EXTERNAL(7) NULLIF (DA_ANALIZZARE = BLANKS)
,IMPORTATI_AIMP                DECIMAL EXTERNAL(7) NULLIF (IMPORTATI_AIMP = BLANKS)
,CHIUSI_FORZAT                 DECIMAL EXTERNAL(7) NULLIF (CHIUSI_FORZAT = BLANKS)
,STATO                         CHAR(1) NULLIF (STATO = BLANKS)
,PERCORSO_FILE                 CHAR(50) NULLIF (PERCORSO_FILE = BLANKS) "RTRIM(:PERCORSO_FILE)"
,NOTE                          CHAR(4000) NULLIF (NOTE = BLANKS) "RTRIM(:NOTE)"
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS) "RTRIM(:UTENTE)"
)
