--OPTIONS(DIRECT=TRUE)
LOAD DATA
INTO TABLE coimsrdg
REPLACE
FIELDS TERMINATED BY '|'
TRAILING NULLCOLS
(COD_CIMP                      CHAR(8) NULLIF (COD_CIMP = BLANKS) "RTRIM(:COD_CIMP)"
,LOC_ESCL_DEPOSITO_GASOLIO     CHAR(1) NULLIF (LOC_ESCL_DEPOSITO_GASOLIO = BLANKS)
,DEP_GASOLIO_ESTERNO           CHAR(1) NULLIF (DEP_GASOLIO_ESTERNO = BLANKS)
,ACCESSO_ESTER_CON_PORTA       CHAR(1) NULLIF (ACCESSO_ESTER_CON_PORTA = BLANKS)
,LOC_MATERIALE_INCOMBUSTIBILE  CHAR(1) NULLIF (LOC_MATERIALE_INCOMBUSTIBILE = BLANKS)
,NON_MENO_50_CM                CHAR(1) NULLIF (NON_MENO_50_CM = BLANKS)
,SOGLIA_PAVIMENTO              CHAR(1) NULLIF (SOGLIA_PAVIMENTO = BLANKS)
,TRA_PARETI_60_CM              CHAR(1) NULLIF (TRA_PARETI_60_CM = BLANKS)
,COMUN_CON_ALTRI_LOC           CHAR(1) NULLIF (COMUN_CON_ALTRI_LOC = BLANKS)
,DEP_SERB_IN_VISTA_APERTO      CHAR(1) NULLIF (DEP_SERB_IN_VISTA_APERTO = BLANKS)
,TETTOIA_ALL_APERTO            CHAR(1) NULLIF (TETTOIA_ALL_APERTO = BLANKS)
,BACINO_CONTENIMENTO           CHAR(1) NULLIF (BACINO_CONTENIMENTO = BLANKS)
,MESSA_A_TERRA                 CHAR(1) NULLIF (MESSA_A_TERRA = BLANKS)
,DEP_GASOLIO_INTERNO_INTERRATO CHAR(1) NULLIF (DEP_GASOLIO_INTERNO_INTERRATO = BLANKS)
,PORTA_SOLAIO_PARETI_REI90     CHAR(1) NULLIF (PORTA_SOLAIO_PARETI_REI90 = BLANKS)
,STRUTTURA_LOCALE_A_NORMA      CHAR(1) NULLIF (STRUTTURA_LOCALE_A_NORMA = BLANKS)
,DEP_GASOLIO_INTERNO           CHAR(1) NULLIF (DEP_GASOLIO_INTERNO = BLANKS)
,LOCALE_CARATTERISTICHE_REI120 CHAR(1) NULLIF (LOCALE_CARATTERISTICHE_REI120 = BLANKS)
,ACCESSO_ESTERNO               CHAR(1) NULLIF (ACCESSO_ESTERNO = BLANKS)
,PORTA_ESTERNA_INCOMBUSTIBILE  CHAR(1) NULLIF (PORTA_ESTERNA_INCOMBUSTIBILE = BLANKS)
,DISIMPEGNO                    CHAR(1) NULLIF (DISIMPEGNO = BLANKS)
,ACCESSO_INTERNO               CHAR(1) NULLIF (ACCESSO_INTERNO = BLANKS)
,DA_DISIMP_LATO_ESTERNO        CHAR(1) NULLIF (DA_DISIMP_LATO_ESTERNO = BLANKS)
,DA_DISIMP_SENZA_LATO_ESTERNO  CHAR(1) NULLIF (DA_DISIMP_SENZA_LATO_ESTERNO = BLANKS)
,AERAZ_DISIMP_05_MQ            CHAR(1) NULLIF (AERAZ_DISIMP_05_MQ = BLANKS)
,AERAZ_DISIMP_CONDOTTA         CHAR(1) NULLIF (AERAZ_DISIMP_CONDOTTA = BLANKS)
,PORTA_DISIMP                  CHAR(1) NULLIF (PORTA_DISIMP = BLANKS)
,COMUNIC_CON_ALTRI_LOC         CHAR(1) NULLIF (COMUNIC_CON_ALTRI_LOC = BLANKS)
,PORTA_DEPOSITO                CHAR(1) NULLIF (PORTA_DEPOSITO = BLANKS)
,PORTA_DEPOSITO_H_2_L_08       CHAR(1) NULLIF (PORTA_DEPOSITO_H_2_L_08 = BLANKS)
,TUBO_SFIATO                   CHAR(1) NULLIF (TUBO_SFIATO = BLANKS)
,SELLE_50_CM_TERRA             CHAR(1) NULLIF (SELLE_50_CM_TERRA = BLANKS)
,PAVIMENTO_IMPERMEABILE        CHAR(1) NULLIF (PAVIMENTO_IMPERMEABILE = BLANKS)
,TRA_SERB_E_PARETI             CHAR(1) NULLIF (TRA_SERB_E_PARETI = BLANKS)
,VALVOLA_A_STRAPPO             CHAR(1) NULLIF (VALVOLA_A_STRAPPO = BLANKS)
,INTERRUTTORE_FORZA_LUCE       CHAR(1) NULLIF (INTERRUTTORE_FORZA_LUCE = BLANKS)
,ESTINTORE                     CHAR(1) NULLIF (ESTINTORE = BLANKS)
,PARETE_CONF_ESTERNO           CHAR(1) NULLIF (PARETE_CONF_ESTERNO = BLANKS)
,VENTILAZIONE_LOCALE           CHAR(1) NULLIF (VENTILAZIONE_LOCALE = BLANKS)
,SEGN_VALVOLA_STRAPPO          CHAR(1) NULLIF (SEGN_VALVOLA_STRAPPO = BLANKS)
,SEGN_INTER_FORZA_LUCE         CHAR(1) NULLIF (SEGN_INTER_FORZA_LUCE = BLANKS)
,SEGN_ESTINTORE                CHAR(1) NULLIF (SEGN_ESTINTORE = BLANKS)
)
