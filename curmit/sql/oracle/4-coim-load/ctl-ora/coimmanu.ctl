--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimmanu
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_MANUTENTORE               CHAR(8) NULLIF (COD_MANUTENTORE = BLANKS) "RTRIM(:COD_MANUTENTORE)"
,COGNOME                       CHAR(40) NULLIF (COGNOME = BLANKS) "RTRIM(:COGNOME)"
,NOME                          CHAR(40) NULLIF (NOME = BLANKS) "RTRIM(:NOME)"
,INDIRIZZO                     CHAR(40) NULLIF (INDIRIZZO = BLANKS) "RTRIM(:INDIRIZZO)"
,LOCALITA                      CHAR(40) NULLIF (LOCALITA = BLANKS) "RTRIM(:LOCALITA)"
,PROVINCIA                     CHAR(4) NULLIF (PROVINCIA = BLANKS) "RTRIM(:PROVINCIA)"
,CAP                           CHAR(5) NULLIF (CAP = BLANKS) "RTRIM(:CAP)"
,COMUNE                        CHAR(40) NULLIF (COMUNE = BLANKS) "RTRIM(:COMUNE)"
,COD_FISCALE                   CHAR(16) NULLIF (COD_FISCALE = BLANKS) "RTRIM(:COD_FISCALE)"
,COD_PIVA                      CHAR(16) NULLIF (COD_PIVA = BLANKS) "RTRIM(:COD_PIVA)"
,TELEFONO                      CHAR(15) NULLIF (TELEFONO = BLANKS) "RTRIM(:TELEFONO)"
,CELLULARE                     CHAR(15) NULLIF (CELLULARE = BLANKS) "RTRIM(:CELLULARE)"
,FAX                           CHAR(15) NULLIF (FAX = BLANKS) "RTRIM(:FAX)"
,EMAIL                         CHAR(35) NULLIF (EMAIL = BLANKS) "RTRIM(:EMAIL)"
,REG_IMPRESE                   CHAR(15) NULLIF (REG_IMPRESE = BLANKS) "RTRIM(:REG_IMPRESE)"
,LOCALITA_REG                  CHAR(40) NULLIF (LOCALITA_REG = BLANKS) "RTRIM(:LOCALITA_REG)"
,REA                           CHAR(15) NULLIF (REA = BLANKS) "RTRIM(:REA)"
,LOCALITA_REA                  CHAR(40) NULLIF (LOCALITA_REA = BLANKS) "RTRIM(:LOCALITA_REA)"
,CAPIT_SOCIALE                 DECIMAL EXTERNAL(13) NULLIF (CAPIT_SOCIALE = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS) "RTRIM(:UTENTE)"
,NOTE                          CHAR(4000) NULLIF (NOTE = BLANKS) "RTRIM(:NOTE)"
,FLAG_CONVENZIONATO            CHAR(1) NULLIF (FLAG_CONVENZIONATO = BLANKS)
,PROT_CONVENZIONE              CHAR(25) NULLIF (PROT_CONVENZIONE = BLANKS) "RTRIM(:PROT_CONVENZIONE)"
,PROT_CONVENZIONE_DT           DATE(10) "YYYY-MM-DD" NULLIF (PROT_CONVENZIONE_DT = BLANKS)
,FLAG_RUOLO                    CHAR(1) NULLIF (FLAG_RUOLO = BLANKS)
,DATA_INIZIO                   DATE(10) "YYYY-MM-DD" NULLIF (DATA_INIZIO = BLANKS)
,DATA_FINE                     DATE(10) "YYYY-MM-DD" NULLIF (DATA_FINE = BLANKS)
)
