--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimcimp
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_CIMP                      CHAR(8) NULLIF (COD_CIMP = BLANKS) "RTRIM(:COD_CIMP)"
,COD_IMPIANTO                  CHAR(8) NULLIF (COD_IMPIANTO = BLANKS) "RTRIM(:COD_IMPIANTO)"
,COD_DOCUMENTO                 CHAR(8) NULLIF (COD_DOCUMENTO = BLANKS) "RTRIM(:COD_DOCUMENTO)"
,GEN_PROG                      DECIMAL EXTERNAL(9) NULLIF (GEN_PROG = BLANKS)
,COD_INCO                      CHAR(8) NULLIF (COD_INCO = BLANKS) "RTRIM(:COD_INCO)"
,DATA_CONTROLLO                DATE(10) "YYYY-MM-DD" NULLIF (DATA_CONTROLLO = BLANKS)
,VERB_N                        CHAR(20) NULLIF (VERB_N = BLANKS) "RTRIM(:VERB_N)"
,DATA_VERB                     DATE(10) "YYYY-MM-DD" NULLIF (DATA_VERB = BLANKS)
,COD_OPVE                      CHAR(8) NULLIF (COD_OPVE = BLANKS) "RTRIM(:COD_OPVE)"
,COSTO                         DECIMAL EXTERNAL(11) NULLIF (COSTO = BLANKS)
,NOMINATIVO_PRES               CHAR(4000) NULLIF (NOMINATIVO_PRES = BLANKS) "RTRIM(:NOMINATIVO_PRES)"
,PRESENZA_LIBRETTO             CHAR(2) NULLIF (PRESENZA_LIBRETTO = BLANKS) "RTRIM(:PRESENZA_LIBRETTO)"
,LIBRETTO_CORRETTO             CHAR(2) NULLIF (LIBRETTO_CORRETTO = BLANKS) "RTRIM(:LIBRETTO_CORRETTO)"
,DICH_CONFORMITA               CHAR(2) NULLIF (DICH_CONFORMITA = BLANKS) "RTRIM(:DICH_CONFORMITA)"
,LIBRETTO_MANUTENZ             CHAR(2) NULLIF (LIBRETTO_MANUTENZ = BLANKS) "RTRIM(:LIBRETTO_MANUTENZ)"
,MIS_PORT_COMBUST              DECIMAL EXTERNAL(11) NULLIF (MIS_PORT_COMBUST = BLANKS)
,MIS_POT_FOCOLARE              DECIMAL EXTERNAL(11) NULLIF (MIS_POT_FOCOLARE = BLANKS)
,STATO_COIBEN                  CHAR(2) NULLIF (STATO_COIBEN = BLANKS) "RTRIM(:STATO_COIBEN)"
,STATO_CANNA_FUM               CHAR(2) NULLIF (STATO_CANNA_FUM = BLANKS) "RTRIM(:STATO_CANNA_FUM)"
,VERIFICA_DISPO                CHAR(2) NULLIF (VERIFICA_DISPO = BLANKS) "RTRIM(:VERIFICA_DISPO)"
,VERIFICA_AREAZ                CHAR(2) NULLIF (VERIFICA_AREAZ = BLANKS) "RTRIM(:VERIFICA_AREAZ)"
,TARATURA_DISPOS               CHAR(2) NULLIF (TARATURA_DISPOS = BLANKS) "RTRIM(:TARATURA_DISPOS)"
,CO_FUMI_SECCHI                DECIMAL EXTERNAL(11) NULLIF (CO_FUMI_SECCHI = BLANKS)
,PPM                           DECIMAL EXTERNAL(11) NULLIF (PPM = BLANKS)
,ECCESSO_ARIA_PERC             DECIMAL EXTERNAL(11) NULLIF (ECCESSO_ARIA_PERC = BLANKS)
,PERDITA_AI_FUMI               DECIMAL EXTERNAL(11) NULLIF (PERDITA_AI_FUMI = BLANKS)
,REND_COMB_CONV                DECIMAL EXTERNAL(11) NULLIF (REND_COMB_CONV = BLANKS)
,REND_COMB_MIN                 DECIMAL EXTERNAL(11) NULLIF (REND_COMB_MIN = BLANKS)
,TEMP_FUMI_1A                  DECIMAL EXTERNAL(8) NULLIF (TEMP_FUMI_1A = BLANKS)
,TEMP_FUMI_2A                  DECIMAL EXTERNAL(8) NULLIF (TEMP_FUMI_2A = BLANKS)
,TEMP_FUMI_3A                  DECIMAL EXTERNAL(8) NULLIF (TEMP_FUMI_3A = BLANKS)
,TEMP_FUMI_MD                  DECIMAL EXTERNAL(8) NULLIF (TEMP_FUMI_MD = BLANKS)
,T_ARIA_COMB_1A                DECIMAL EXTERNAL(8) NULLIF (T_ARIA_COMB_1A = BLANKS)
,T_ARIA_COMB_2A                DECIMAL EXTERNAL(8) NULLIF (T_ARIA_COMB_2A = BLANKS)
,T_ARIA_COMB_3A                DECIMAL EXTERNAL(8) NULLIF (T_ARIA_COMB_3A = BLANKS)
,T_ARIA_COMB_MD                DECIMAL EXTERNAL(8) NULLIF (T_ARIA_COMB_MD = BLANKS)
,TEMP_MANT_1A                  DECIMAL EXTERNAL(8) NULLIF (TEMP_MANT_1A = BLANKS)
,TEMP_MANT_2A                  DECIMAL EXTERNAL(8) NULLIF (TEMP_MANT_2A = BLANKS)
,TEMP_MANT_3A                  DECIMAL EXTERNAL(8) NULLIF (TEMP_MANT_3A = BLANKS)
,TEMP_MANT_MD                  DECIMAL EXTERNAL(8) NULLIF (TEMP_MANT_MD = BLANKS)
,TEMP_H2O_OUT_1A               DECIMAL EXTERNAL(8) NULLIF (TEMP_H2O_OUT_1A = BLANKS)
,TEMP_H2O_OUT_2A               DECIMAL EXTERNAL(8) NULLIF (TEMP_H2O_OUT_2A = BLANKS)
,TEMP_H2O_OUT_3A               DECIMAL EXTERNAL(8) NULLIF (TEMP_H2O_OUT_3A = BLANKS)
,TEMP_H2O_OUT_MD               DECIMAL EXTERNAL(8) NULLIF (TEMP_H2O_OUT_MD = BLANKS)
,CO2_1A                        DECIMAL EXTERNAL(8) NULLIF (CO2_1A = BLANKS)
,CO2_2A                        DECIMAL EXTERNAL(8) NULLIF (CO2_2A = BLANKS)
,CO2_3A                        DECIMAL EXTERNAL(8) NULLIF (CO2_3A = BLANKS)
,CO2_MD                        DECIMAL EXTERNAL(8) NULLIF (CO2_MD = BLANKS)
,O2_1A                         DECIMAL EXTERNAL(8) NULLIF (O2_1A = BLANKS)
,O2_2A                         DECIMAL EXTERNAL(8) NULLIF (O2_2A = BLANKS)
,O2_3A                         DECIMAL EXTERNAL(8) NULLIF (O2_3A = BLANKS)
,O2_MD                         DECIMAL EXTERNAL(8) NULLIF (O2_MD = BLANKS)
,CO_1A                         DECIMAL EXTERNAL(12) NULLIF (CO_1A = BLANKS)
,CO_2A                         DECIMAL EXTERNAL(12) NULLIF (CO_2A = BLANKS)
,CO_3A                         DECIMAL EXTERNAL(12) NULLIF (CO_3A = BLANKS)
,CO_MD                         DECIMAL EXTERNAL(12) NULLIF (CO_MD = BLANKS)
,INDIC_FUMOSITA_1A             DECIMAL EXTERNAL(8) NULLIF (INDIC_FUMOSITA_1A = BLANKS)
,INDIC_FUMOSITA_2A             DECIMAL EXTERNAL(8) NULLIF (INDIC_FUMOSITA_2A = BLANKS)
,INDIC_FUMOSITA_3A             DECIMAL EXTERNAL(8) NULLIF (INDIC_FUMOSITA_3A = BLANKS)
,INDIC_FUMOSITA_MD             DECIMAL EXTERNAL(8) NULLIF (INDIC_FUMOSITA_MD = BLANKS)
,MANUTENZIONE_8A               CHAR(2) NULLIF (MANUTENZIONE_8A = BLANKS) "RTRIM(:MANUTENZIONE_8A)"
,CO_FUMI_SECCHI_8B             CHAR(2) NULLIF (CO_FUMI_SECCHI_8B = BLANKS) "RTRIM(:CO_FUMI_SECCHI_8B)"
,INDIC_FUMOSITA_8C             CHAR(2) NULLIF (INDIC_FUMOSITA_8C = BLANKS) "RTRIM(:INDIC_FUMOSITA_8C)"
,REND_COMB_8D                  CHAR(2) NULLIF (REND_COMB_8D = BLANKS) "RTRIM(:REND_COMB_8D)"
,ESITO_VERIFICA                CHAR(2) NULLIF (ESITO_VERIFICA = BLANKS) "RTRIM(:ESITO_VERIFICA)"
,STRUMENTO                     CHAR(100) NULLIF (STRUMENTO = BLANKS) "RTRIM(:STRUMENTO)"
,NOTE_VERIFICATORE             CHAR(4000) NULLIF (NOTE_VERIFICATORE = BLANKS) "RTRIM(:NOTE_VERIFICATORE)"
,NOTE_RESP                     CHAR(4000) NULLIF (NOTE_RESP = BLANKS) "RTRIM(:NOTE_RESP)"
,NOTE_CONF                     CHAR(4000) NULLIF (NOTE_CONF = BLANKS) "RTRIM(:NOTE_CONF)"
,TIPOLOGIA_COSTO               CHAR(2) NULLIF (TIPOLOGIA_COSTO = BLANKS) "RTRIM(:TIPOLOGIA_COSTO)"
,RIFERIMENTO_PAG               CHAR(20) NULLIF (RIFERIMENTO_PAG = BLANKS) "RTRIM(:RIFERIMENTO_PAG)"
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS) "RTRIM(:UTENTE)"
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,POT_UTILE_NOM                 DECIMAL EXTERNAL(11) NULLIF (POT_UTILE_NOM = BLANKS)
,POT_FOCOLARE_NOM              DECIMAL EXTERNAL(11) NULLIF (POT_FOCOLARE_NOM = BLANKS)
,COD_COMBUSTIBILE              CHAR(8) NULLIF (COD_COMBUSTIBILE = BLANKS) "RTRIM(:COD_COMBUSTIBILE)"
,COD_RESPONSABILE              CHAR(8) NULLIF (COD_RESPONSABILE = BLANKS) "RTRIM(:COD_RESPONSABILE)"
,FLAG_CPI                      CHAR(1) NULLIF (FLAG_CPI = BLANKS)
,FLAG_ISPES                    CHAR(1) NULLIF (FLAG_ISPES = BLANKS)
,FLAG_PERICOLOSITA             CHAR(1) NULLIF (FLAG_PERICOLOSITA = BLANKS)
,FLAG_TRACCIATO                CHAR(2) NULLIF (FLAG_TRACCIATO = BLANKS) "RTRIM(:FLAG_TRACCIATO)"
,NEW1_DATA_DIMP                DATE(10) "YYYY-MM-DD" NULLIF (NEW1_DATA_DIMP = BLANKS)
,NEW1_DATA_PAGA_DIMP           DATE(10) "YYYY-MM-DD" NULLIF (NEW1_DATA_PAGA_DIMP = BLANKS)
,NEW1_CONF_LOCALE              CHAR(1) NULLIF (NEW1_CONF_LOCALE = BLANKS)
,NEW1_CONF_ACCESSO             CHAR(1) NULLIF (NEW1_CONF_ACCESSO = BLANKS)
,NEW1_PRES_INTERCET            CHAR(1) NULLIF (NEW1_PRES_INTERCET = BLANKS)
,NEW1_PRES_INTERRUT            CHAR(1) NULLIF (NEW1_PRES_INTERRUT = BLANKS)
,NEW1_ASSE_MATE_ESTR           CHAR(1) NULLIF (NEW1_ASSE_MATE_ESTR = BLANKS)
,NEW1_PRES_MEZZI               CHAR(1) NULLIF (NEW1_PRES_MEZZI = BLANKS)
,NEW1_PRES_CARTELL             CHAR(1) NULLIF (NEW1_PRES_CARTELL = BLANKS)
,NEW1_DISP_REGOLAZ             CHAR(1) NULLIF (NEW1_DISP_REGOLAZ = BLANKS)
,NEW1_FORO_PRESENTE            CHAR(1) NULLIF (NEW1_FORO_PRESENTE = BLANKS)
,NEW1_FORO_CORRETTO            CHAR(1) NULLIF (NEW1_FORO_CORRETTO = BLANKS)
,NEW1_FORO_ACCESSIBILE         CHAR(1) NULLIF (NEW1_FORO_ACCESSIBILE = BLANKS)
,NEW1_CANALI_A_NORMA           CHAR(1) NULLIF (NEW1_CANALI_A_NORMA = BLANKS)
,NEW1_LAVORO_NOM_INIZ          DECIMAL EXTERNAL(11) NULLIF (NEW1_LAVORO_NOM_INIZ = BLANKS)
,NEW1_LAVORO_NOM_FINE          DECIMAL EXTERNAL(11) NULLIF (NEW1_LAVORO_NOM_FINE = BLANKS)
,NEW1_LAVORO_LIB_INIZ          DECIMAL EXTERNAL(11) NULLIF (NEW1_LAVORO_LIB_INIZ = BLANKS)
,NEW1_LAVORO_LIB_FINE          DECIMAL EXTERNAL(11) NULLIF (NEW1_LAVORO_LIB_FINE = BLANKS)
,NEW1_NOTE_MANU                CHAR(4000) NULLIF (NEW1_NOTE_MANU = BLANKS) "RTRIM(:NEW1_NOTE_MANU)"
,NEW1_DIMP_PRES                CHAR(1) NULLIF (NEW1_DIMP_PRES = BLANKS)
,NEW1_DIMP_PRESCRIZ            CHAR(1) NULLIF (NEW1_DIMP_PRESCRIZ = BLANKS)
,NEW1_DATA_ULTIMA_MANU         DATE(10) "YYYY-MM-DD" NULLIF (NEW1_DATA_ULTIMA_MANU = BLANKS)
,NEW1_DATA_ULTIMA_ANAL         DATE(10) "YYYY-MM-DD" NULLIF (NEW1_DATA_ULTIMA_ANAL = BLANKS)
,NEW1_MANU_PREC_8A             CHAR(1) NULLIF (NEW1_MANU_PREC_8A = BLANKS)
,NEW1_CO_RILEVATO              DECIMAL EXTERNAL(8) NULLIF (NEW1_CO_RILEVATO = BLANKS)
,NEW1_FLAG_PERI_8P             CHAR(1) NULLIF (NEW1_FLAG_PERI_8P = BLANKS)
,FLAG_USO                      CHAR(1) NULLIF (FLAG_USO = BLANKS)
,FLAG_DIFFIDA                  CHAR(1) NULLIF (FLAG_DIFFIDA = BLANKS)
,ECCESSO_ARIA_PERC_2A          DECIMAL EXTERNAL(11) NULLIF (ECCESSO_ARIA_PERC_2A = BLANKS)
,ECCESSO_ARIA_PERC_3A          DECIMAL EXTERNAL(11) NULLIF (ECCESSO_ARIA_PERC_3A = BLANKS)
,ECCESSO_ARIA_PERC_MD          DECIMAL EXTERNAL(11) NULLIF (ECCESSO_ARIA_PERC_MD = BLANKS)
,N_PROT                        CHAR(20) NULLIF (N_PROT = BLANKS) "RTRIM(:N_PROT)"
,DATA_PROT                     DATE(10) "YYYY-MM-DD" NULLIF (DATA_PROT = BLANKS)
,SEZIONI_CORR                  CHAR(1) NULLIF (SEZIONI_CORR = BLANKS)
,CURVE_CORR                    CHAR(1) NULLIF (CURVE_CORR = BLANKS)
,LUNGH_CORR                    CHAR(1) NULLIF (LUNGH_CORR = BLANKS)
,RIFLUSSI_LOC                  CHAR(1) NULLIF (RIFLUSSI_LOC = BLANKS)
,PERDITE_COND                  CHAR(1) NULLIF (PERDITE_COND = BLANKS)
,DISP_FUNZ                     CHAR(1) NULLIF (DISP_FUNZ = BLANKS)
,ASSENZA_FUGHE                 CHAR(1) NULLIF (ASSENZA_FUGHE = BLANKS)
,EFFIC_EVAC                    CHAR(1) NULLIF (EFFIC_EVAC = BLANKS)
,AUTODICH                      CHAR(1) NULLIF (AUTODICH = BLANKS)
,DICH_CONF                     CHAR(1) NULLIF (DICH_CONF = BLANKS)
,MANUT_PROG                    CHAR(1) NULLIF (MANUT_PROG = BLANKS)
,MARCA_STRUM                   CHAR(50) NULLIF (MARCA_STRUM = BLANKS) "RTRIM(:MARCA_STRUM)"
,MODELLO_STRUM                 CHAR(50) NULLIF (MODELLO_STRUM = BLANKS) "RTRIM(:MODELLO_STRUM)"
,MATR_STRUM                    CHAR(50) NULLIF (MATR_STRUM = BLANKS) "RTRIM(:MATR_STRUM)"
,DT_TAR_STRUM                  DATE(10) "YYYY-MM-DD" NULLIF (DT_TAR_STRUM = BLANKS)
,INDICE_ARIA                   DECIMAL EXTERNAL(8) NULLIF (INDICE_ARIA = BLANKS)
,PERD_CAL_SENS                 DECIMAL EXTERNAL(8) NULLIF (PERD_CAL_SENS = BLANKS)
,DOC_ISPESL                    CHAR(1) NULLIF (DOC_ISPESL = BLANKS)
,DOC_PREV_INCENDI              CHAR(1) NULLIF (DOC_PREV_INCENDI = BLANKS)
,LIBR_MANUT_BRUC               CHAR(1) NULLIF (LIBR_MANUT_BRUC = BLANKS)
,UBIC_LOCALE_NORMA             CHAR(1) NULLIF (UBIC_LOCALE_NORMA = BLANKS)
,DISP_CHIUS_PORTA              CHAR(1) NULLIF (DISP_CHIUS_PORTA = BLANKS)
,SPAZI_NORMA                   CHAR(1) NULLIF (SPAZI_NORMA = BLANKS)
,APERT_SOFFITTO                CHAR(1) NULLIF (APERT_SOFFITTO = BLANKS)
,RUBIN_MANUALE_ACCES           CHAR(1) NULLIF (RUBIN_MANUALE_ACCES = BLANKS)
,ASSENZA_APP_PERIC             CHAR(1) NULLIF (ASSENZA_APP_PERIC = BLANKS)
,RUBIN_CHIUSO                  CHAR(1) NULLIF (RUBIN_CHIUSO = BLANKS)
,ELETTROVALV_ESTERNE           CHAR(1) NULLIF (ELETTROVALV_ESTERNE = BLANKS)
,TUBAZ_PRESS                   CHAR(1) NULLIF (TUBAZ_PRESS = BLANKS)
,TOLTA_TENSIONE                CHAR(1) NULLIF (TOLTA_TENSIONE = BLANKS)
,TERMOST_ESTERNO               CHAR(1) NULLIF (TERMOST_ESTERNO = BLANKS)
,CHIUSURA_FORO                 CHAR(1) NULLIF (CHIUSURA_FORO = BLANKS)
,ACCENS_FUNZ_GEN               CHAR(1) NULLIF (ACCENS_FUNZ_GEN = BLANKS)
,PENDENZA                      CHAR(1) NULLIF (PENDENZA = BLANKS)
,VENTILAZ_LIB_OSTRUZ           CHAR(1) NULLIF (VENTILAZ_LIB_OSTRUZ = BLANKS)
,DISP_REG_CONT_PRE             CHAR(1) NULLIF (DISP_REG_CONT_PRE = BLANKS)
,DISP_REG_CONT_FUNZ            CHAR(1) NULLIF (DISP_REG_CONT_FUNZ = BLANKS)
,DISP_REG_CLIM_FUNZ            CHAR(1) NULLIF (DISP_REG_CLIM_FUNZ = BLANKS)
,CONF_IMP_ELETTRICO            CHAR(1) NULLIF (CONF_IMP_ELETTRICO = BLANKS)
,VOLUMETRIA                    DECIMAL EXTERNAL(11) NULLIF (VOLUMETRIA = BLANKS)
,COMSUMI_ULTIMA_STAG           DECIMAL EXTERNAL(11) NULLIF (COMSUMI_ULTIMA_STAG = BLANKS)
)