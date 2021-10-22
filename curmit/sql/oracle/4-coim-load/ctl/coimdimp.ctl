--OPTIONS(DIRECT=TRUE)
LOAD DATA
CHARACTERSET UTF8
INTO TABLE coimdimp
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_DIMP                      CHAR(8) NULLIF (COD_DIMP = BLANKS)
,COD_IMPIANTO                  CHAR(8) NULLIF (COD_IMPIANTO = BLANKS)
,DATA_CONTROLLO                DATE(10) "YYYY-MM-DD" NULLIF (DATA_CONTROLLO = BLANKS)
,GEN_PROG                      DECIMAL EXTERNAL(9) NULLIF (GEN_PROG = BLANKS)
,COD_MANUTENTORE               CHAR(8) NULLIF (COD_MANUTENTORE = BLANKS)
,COD_RESPONSABILE              CHAR(8) NULLIF (COD_RESPONSABILE = BLANKS)
,COD_PROPRIETARIO              CHAR(8) NULLIF (COD_PROPRIETARIO = BLANKS)
,COD_OCCUPANTE                 CHAR(8) NULLIF (COD_OCCUPANTE = BLANKS)
,COD_DOCUMENTO                 CHAR(8) NULLIF (COD_DOCUMENTO = BLANKS)
,FLAG_STATUS                   CHAR(1) NULLIF (FLAG_STATUS = BLANKS)
,GARANZIA                      CHAR(1) NULLIF (GARANZIA = BLANKS)
,CONFORMITA                    CHAR(1) NULLIF (CONFORMITA = BLANKS)
,LIB_IMPIANTO                  CHAR(1) NULLIF (LIB_IMPIANTO = BLANKS)
,LIB_USO_MAN                   CHAR(1) NULLIF (LIB_USO_MAN = BLANKS)
,INST_IN_OUT                   CHAR(1) NULLIF (INST_IN_OUT = BLANKS)
,IDONEITA_LOCALE               CHAR(1) NULLIF (IDONEITA_LOCALE = BLANKS)
,AP_VENTILAZ                   CHAR(1) NULLIF (AP_VENTILAZ = BLANKS)
,AP_VENT_OSTRUZ                CHAR(1) NULLIF (AP_VENT_OSTRUZ = BLANKS)
,PENDENZA                      CHAR(1) NULLIF (PENDENZA = BLANKS)
,SEZIONI                       CHAR(1) NULLIF (SEZIONI = BLANKS)
,CURVE                         CHAR(1) NULLIF (CURVE = BLANKS)
,LUNGHEZZA                     CHAR(1) NULLIF (LUNGHEZZA = BLANKS)
,CONSERVAZIONE                 CHAR(1) NULLIF (CONSERVAZIONE = BLANKS)
,SCAR_CA_SI                    CHAR(1) NULLIF (SCAR_CA_SI = BLANKS)
,SCAR_PARETE                   CHAR(1) NULLIF (SCAR_PARETE = BLANKS)
,RIFLUSSI_LOCALE               CHAR(1) NULLIF (RIFLUSSI_LOCALE = BLANKS)
,ASSENZA_PERDITE               CHAR(1) NULLIF (ASSENZA_PERDITE = BLANKS)
,PULIZIA_UGELLI                CHAR(1) NULLIF (PULIZIA_UGELLI = BLANKS)
,ANTIVENTO                     CHAR(1) NULLIF (ANTIVENTO = BLANKS)
,SCAMBIATORE                   CHAR(1) NULLIF (SCAMBIATORE = BLANKS)
,ACCENS_REG                    CHAR(1) NULLIF (ACCENS_REG = BLANKS)
,DISP_COMANDO                  CHAR(1) NULLIF (DISP_COMANDO = BLANKS)
,ASS_PERDITE                   CHAR(1) NULLIF (ASS_PERDITE = BLANKS)
,VALVOLA_SICUR                 CHAR(1) NULLIF (VALVOLA_SICUR = BLANKS)
,VASO_ESP                      CHAR(1) NULLIF (VASO_ESP = BLANKS)
,DISP_SIC_MANOM                CHAR(1) NULLIF (DISP_SIC_MANOM = BLANKS)
,ORGANI_INTEGRI                CHAR(1) NULLIF (ORGANI_INTEGRI = BLANKS)
,CIRC_ARIA                     CHAR(1) NULLIF (CIRC_ARIA = BLANKS)
,GUARN_ACCOP                   CHAR(1) NULLIF (GUARN_ACCOP = BLANKS)
,ASSENZA_FUGHE                 CHAR(1) NULLIF (ASSENZA_FUGHE = BLANKS)
,COIBENTAZIONE                 CHAR(1) NULLIF (COIBENTAZIONE = BLANKS)
,EFF_EVAC_FUM                  CHAR(1) NULLIF (EFF_EVAC_FUM = BLANKS)
,CONT_REND                     CHAR(1) NULLIF (CONT_REND = BLANKS)
,POT_FOCOLARE_MIS              DECIMAL EXTERNAL(8) NULLIF (POT_FOCOLARE_MIS = BLANKS)
,PORTATA_COMB_MIS              DECIMAL EXTERNAL(8) NULLIF (PORTATA_COMB_MIS = BLANKS)
,TEMP_FUMI                     DECIMAL EXTERNAL(8) NULLIF (TEMP_FUMI = BLANKS)
,TEMP_AMBI                     DECIMAL EXTERNAL(8) NULLIF (TEMP_AMBI = BLANKS)
,O2                            DECIMAL EXTERNAL(8) NULLIF (O2 = BLANKS)
,CO2                           DECIMAL EXTERNAL(8) NULLIF (CO2 = BLANKS)
,BACHARACH                     DECIMAL EXTERNAL(8) NULLIF (BACHARACH = BLANKS)
,CO                            DECIMAL EXTERNAL(12) NULLIF (CO = BLANKS)
,REND_COMBUST                  DECIMAL EXTERNAL(8) NULLIF (REND_COMBUST = BLANKS)
,OSSERVAZIONI                  CHAR(4000) NULLIF (OSSERVAZIONI = BLANKS)
,RACCOMANDAZIONI               CHAR(4000) NULLIF (RACCOMANDAZIONI = BLANKS)
,PRESCRIZIONI                  CHAR(4000) NULLIF (PRESCRIZIONI = BLANKS)
,DATA_UTILE_INTER              DATE(10) "YYYY-MM-DD" NULLIF (DATA_UTILE_INTER = BLANKS)
,N_PROT                        CHAR(20) NULLIF (N_PROT = BLANKS)
,DATA_PROT                     DATE(10) "YYYY-MM-DD" NULLIF (DATA_PROT = BLANKS)
,DELEGA_RESP                   CHAR(50) NULLIF (DELEGA_RESP = BLANKS)
,DELEGA_MANUT                  CHAR(50) NULLIF (DELEGA_MANUT = BLANKS)
,NUM_BOLLO                     CHAR(20) NULLIF (NUM_BOLLO = BLANKS)
,COSTO                         DECIMAL EXTERNAL(8) NULLIF (COSTO = BLANKS)
,TIPOLOGIA_COSTO               CHAR(2) NULLIF (TIPOLOGIA_COSTO = BLANKS)
,RIFERIMENTO_PAG               CHAR(20) NULLIF (RIFERIMENTO_PAG = BLANKS)
,UTENTE                        CHAR(10) NULLIF (UTENTE = BLANKS)
,DATA_INS                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_INS = BLANKS)
,DATA_MOD                      DATE(10) "YYYY-MM-DD" NULLIF (DATA_MOD = BLANKS)
,POTENZA                       DECIMAL EXTERNAL(11) NULLIF (POTENZA = BLANKS)
,FLAG_PERICOLOSITA             CHAR(1) NULLIF (FLAG_PERICOLOSITA = BLANKS)
,FLAG_CO_PERC                  CHAR(1) NULLIF (FLAG_CO_PERC = BLANKS)
,FLAG_TRACCIATO                CHAR(2) NULLIF (FLAG_TRACCIATO = BLANKS)
,COD_DOCU_DISTINTA             CHAR(8) NULLIF (COD_DOCU_DISTINTA = BLANKS)
,SCAR_CAN_FU                   CHAR(1) NULLIF (SCAR_CAN_FU = BLANKS)
,TIRAGGIO                      DECIMAL EXTERNAL(11) NULLIF (TIRAGGIO = BLANKS)
,ORA_INIZIO                    CHAR(8) NULLIF (ORA_INIZIO = BLANKS)
,ORA_FINE                      CHAR(8) NULLIF (ORA_FINE = BLANKS)
,RAPP_CONTR                    CHAR(1) NULLIF (RAPP_CONTR = BLANKS)
,RAPP_CONTR_NOTE               CHAR(4000) NULLIF (RAPP_CONTR_NOTE = BLANKS)
,CERTIFICAZ                    CHAR(1) NULLIF (CERTIFICAZ = BLANKS)
,CERTIFICAZ_NOTE               CHAR(4000) NULLIF (CERTIFICAZ_NOTE = BLANKS)
,DICH_CONF                     CHAR(1) NULLIF (DICH_CONF = BLANKS)
,DICH_CONF_NOTE                CHAR(4000) NULLIF (DICH_CONF_NOTE = BLANKS)
,LIBRETTO_BRUC                 CHAR(1) NULLIF (LIBRETTO_BRUC = BLANKS)
,LIBRETTO_BRUC_NOTE            CHAR(4000) NULLIF (LIBRETTO_BRUC_NOTE = BLANKS)
,PREV_INCENDI                  CHAR(1) NULLIF (PREV_INCENDI = BLANKS)
,PREV_INCENDI_NOTE             CHAR(4000) NULLIF (PREV_INCENDI_NOTE = BLANKS)
,LIB_IMPIANTO_NOTE             CHAR(4000) NULLIF (LIB_IMPIANTO_NOTE = BLANKS)
,ISPESL                        CHAR(1) NULLIF (ISPESL = BLANKS)
,ISPESL_NOTE                   CHAR(4000) NULLIF (ISPESL_NOTE = BLANKS)
,DATA_SCADENZA                 DATE(10) "YYYY-MM-DD" NULLIF (DATA_SCADENZA = BLANKS)
,NUM_AUTOCERT                  CHAR(20) NULLIF (NUM_AUTOCERT = BLANKS)
,ESAME_VIS_L_ELET              CHAR(1) NULLIF (ESAME_VIS_L_ELET = BLANKS)
,FUNZ_CORR_BRUC                CHAR(1) NULLIF (FUNZ_CORR_BRUC = BLANKS)
,LIB_USO_MAN_NOTE              CHAR(4000) NULLIF (LIB_USO_MAN_NOTE = BLANKS)
,VOLIMETRIA_RISC               DECIMAL EXTERNAL(11) NULLIF (VOLIMETRIA_RISC = BLANKS)
,CUNSUMO_ANNUO                 DECIMAL EXTERNAL(11) NULLIF (CUNSUMO_ANNUO = BLANKS)
)
