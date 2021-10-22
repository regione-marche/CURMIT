--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimrelg
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_RELG                      DECIMAL EXTERNAL(9) NULLIF (COD_RELG = BLANKS)
,DATA_REL                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_REL = BLANKS)
,ENTE_ISTAT                    CHAR(6) NULLIF (ENTE_ISTAT = BLANKS)
,RESP_PROC                     CHAR(80) NULLIF (RESP_PROC = BLANKS)
,NIMP_TOT_STIM_ENTE            DECIMAL EXTERNAL(9) NULLIF (NIMP_TOT_STIM_ENTE = BLANKS)
,NIMP_TOT_AUT_ENTE             DECIMAL EXTERNAL(9) NULLIF (NIMP_TOT_AUT_ENTE = BLANKS)
,NIMP_TOT_CENTR_ENTE           DECIMAL EXTERNAL(9) NULLIF (NIMP_TOT_CENTR_ENTE = BLANKS)
,NIMP_TOT_TELERISC_ENTE        DECIMAL EXTERNAL(9) NULLIF (NIMP_TOT_TELERISC_ENTE = BLANKS)
,CONV_ASS_CATEG                DATE(10) "YYYY-MM-DD" NULLIF (CONV_ASS_CATEG = BLANKS)
,CONF_DGR7_7568                CHAR(1) NULLIF (CONF_DGR7_7568 = BLANKS)
,NPIVA_ADER_CONV               DECIMAL EXTERNAL(6) NULLIF (NPIVA_ADER_CONV = BLANKS)
,NPIVA_ASS_ACC_REG             DECIMAL EXTERNAL(6) NULLIF (NPIVA_ASS_ACC_REG = BLANKS)
,DELIB_AUTODIC                 CHAR(1) NULLIF (DELIB_AUTODIC = BLANKS)
,RIFER_DATAI                   DATE(10) "YYYY-MM-DD" NULLIF (RIFER_DATAI = BLANKS)
,RIFER_DATAF                   DATE(10) "YYYY-MM-DD" NULLIF (RIFER_DATAF = BLANKS)
,VALID_DATAI                   DATE(10) "YYYY-MM-DD" NULLIF (VALID_DATAI = BLANKS)
,VALID_DATAF                   DATE(10) "YYYY-MM-DD" NULLIF (VALID_DATAF = BLANKS)
,NTOT_AUTODIC_PERV             DECIMAL EXTERNAL(9) NULLIF (NTOT_AUTODIC_PERV = BLANKS)
,NTOT_PRESCRIZIONI             DECIMAL EXTERNAL(9) NULLIF (NTOT_PRESCRIZIONI = BLANKS)
,N_VER_INTERNI                 DECIMAL EXTERNAL(6) NULLIF (N_VER_INTERNI = BLANKS)
,N_VER_ESTERNI                 DECIMAL EXTERNAL(6) NULLIF (N_VER_ESTERNI = BLANKS)
,N_ACCERT_ENEA                 DECIMAL EXTERNAL(6) NULLIF (N_ACCERT_ENEA = BLANKS)
,N_ACCERT_ALTRI                DECIMAL EXTERNAL(6) NULLIF (N_ACCERT_ALTRI = BLANKS)
,NOME_FILE_GEN                 CHAR(50) NULLIF (NOME_FILE_GEN = BLANKS)
,NOME_FILE_TEC                 CHAR(50) NULLIF (NOME_FILE_TEC = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS)
)