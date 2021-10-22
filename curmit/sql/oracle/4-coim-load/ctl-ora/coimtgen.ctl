--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimtgen
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_TGEN                      CHAR(8) NULLIF (COD_TGEN = BLANKS) "RTRIM(:COD_TGEN)"
,VALID_MOD_H                   DECIMAL EXTERNAL(9) NULLIF (VALID_MOD_H = BLANKS)
,GG_COMUNIC_MOD_H              DECIMAL EXTERNAL(9) NULLIF (GG_COMUNIC_MOD_H = BLANKS)
,FLAG_ENTE                     CHAR(1) NULLIF (FLAG_ENTE = BLANKS)
,COD_PROV                      CHAR(8) NULLIF (COD_PROV = BLANKS) "RTRIM(:COD_PROV)"
,COD_COMU                      CHAR(8) NULLIF (COD_COMU = BLANKS) "RTRIM(:COD_COMU)"
,FLAG_VIARIO                   CHAR(1) NULLIF (FLAG_VIARIO = BLANKS)
,FLAG_MOD_H_B                  CHAR(1) NULLIF (FLAG_MOD_H_B = BLANKS)
,VALID_MOD_H_B                 DECIMAL EXTERNAL(9) NULLIF (VALID_MOD_H_B = BLANKS)
,GG_COMUNIC_MOD_H_B            DECIMAL EXTERNAL(9) NULLIF (GG_COMUNIC_MOD_H_B = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE_ULT                    CHAR(10) NULLIF (UTENTE_ULT = BLANKS) "RTRIM(:UTENTE_ULT)"
,GG_CONFERMA_INCO              DECIMAL EXTERNAL(9) NULLIF (GG_CONFERMA_INCO = BLANKS)
,GG_SCAD_PAG_MH                DECIMAL EXTERNAL(4) NULLIF (GG_SCAD_PAG_MH = BLANKS)
,MESI_EVIDENZA_MOD             DECIMAL EXTERNAL(3) NULLIF (MESI_EVIDENZA_MOD = BLANKS)
,FLAG_AGG_SOGG                 CHAR(1) NULLIF (FLAG_AGG_SOGG = BLANKS)
,FLAG_DT_SCAD                  CHAR(1) NULLIF (FLAG_DT_SCAD = BLANKS)
,FLAG_AGG_DA_VERIF             CHAR(1) NULLIF (FLAG_AGG_DA_VERIF = BLANKS)
,FLAG_COD_AIMP_AUTO            CHAR(1) NULLIF (FLAG_COD_AIMP_AUTO = BLANKS)
,FLAG_GG_MODIF_MH              DECIMAL EXTERNAL(5) NULLIF (FLAG_GG_MODIF_MH = BLANKS)
,FLAG_GG_MODIF_RV              DECIMAL EXTERNAL(5) NULLIF (FLAG_GG_MODIF_RV = BLANKS)
,GG_SCAD_PAG_RV                DECIMAL EXTERNAL(4) NULLIF (GG_SCAD_PAG_RV = BLANKS)
,GG_ADAT_ANOM_OBLIG            CHAR(1) NULLIF (GG_ADAT_ANOM_OBLIG = BLANKS)
,GG_ADAT_ANOM_AUTOM            CHAR(1) NULLIF (GG_ADAT_ANOM_AUTOM = BLANKS)
,POPOLAZ_CITT_TGEN             DECIMAL EXTERNAL(8) NULLIF (POPOLAZ_CITT_TGEN = BLANKS)
,POPOLAZ_AIMP_TGEN             DECIMAL EXTERNAL(8) NULLIF (POPOLAZ_AIMP_TGEN = BLANKS)
,FLAG_AIMP_CITT_ESTR           CHAR(1) NULLIF (FLAG_AIMP_CITT_ESTR = BLANKS)
,FLAG_STAT_ESTR_CALC           CHAR(1) NULLIF (FLAG_STAT_ESTR_CALC = BLANKS)
,FLAG_COD_VIA_AUTO             CHAR(1) NULLIF (FLAG_COD_VIA_AUTO = BLANKS)
,LINK_CAP                      CHAR(500) NULLIF (LINK_CAP = BLANKS) "RTRIM(:LINK_CAP)"
,FLAG_ENTI_COMPET              CHAR(1) NULLIF (FLAG_ENTI_COMPET = BLANKS)
)
