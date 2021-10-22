/*==============================================================*/
/* table coimaimp:				                */
/*==============================================================*/

create table coimaimp_st
     ( cod_impianto        varchar2(08)  not null
     , cod_impianto_est    varchar2(20)
     , cod_impianto_prov   varchar2(08)
     , descrizione         varchar2(50)
     , provenienza_dati    char(01)   
     , cod_combustibile    varchar2(08)
     , cod_potenza         varchar2(08)
     , potenza             numeric(9,2) 
     , potenza_utile       numeric(9,2)
     , data_installaz      date         
     , data_attivaz        date
     , data_rottamaz       date
     , note                varchar2(4000)
     , stato               char(01)
     , flag_dichiarato     char(01)
     , data_prima_dich     date
     , data_ultim_dich     date
     , cod_tpim            varchar2(08)
     , consumo_annuo       numeric(9,2)
     , n_generatori        numeric(2)
     , stato_conformita    char(01)
     , cod_cted            varchar2(08)
     , tariffa             varchar2(08)
     , cod_responsabile    varchar2(08)
     , flag_resp           char(01)
     , cod_intestatario    varchar2(08)
     , flag_intestatario   char(01)
     , cod_proprietario    varchar2(08)
     , cod_occupante       varchar2(08)
     , cod_amministratore  varchar2(08)
     , cod_manutentore     varchar2(08)
     , cod_installatore    varchar2(08)
     , cod_distributore    varchar2(08)
     , cod_progettista     varchar2(08)
     , cod_amag            varchar2(10)
     , cod_ubicazione      varchar2(08)
     , localita            varchar2(40)
     , cod_via             varchar2(08)
     , toponimo            varchar2(20)
     , indirizzo           varchar2(100)
     , numero              varchar2(08)
     , esponente           varchar2(03)
     , scala               varchar2(05)
     , piano               varchar2(05)
     , interno             varchar2(05)
     , cod_comune          varchar2(08)
     , cod_provincia       varchar2(08)
     , cap                 varchar2(05)
     , cod_catasto         varchar2(20) 
     , cod_tpdu            varchar2(08)
     , cod_qua             varchar2(08)
     , cod_urb             varchar2(08)
     , data_ins            date
     , data_mod            date
     , utente              varchar2(10)
     , flag_dpr412         char(01)
     , cod_impianto_dest   varchar2(08)
     , anno_costruzione    date
     , marc_effic_energ    varchar2(10)
     , volimetria_risc     numeric (9,2)
     , gb_x                varchar2(50)
     , gb_y                varchar2(50)
     , data_scad_dich      date
     , flag_coordinate     varchar2(2)
     , flag_targa_stampata char(01)
     , cod_impianto_old    varchar2(20)
     , portata             numeric(9,2) 
     , palazzo             varchar2(100)
     , n_unita_immob       numeric(9,0)
     , cod_tipo_attivita   varchar2(8)
     , adibito_a           varchar2(500)
     , utente_ins          varchar2(10)
     , igni_progressivo    numeric(5,0)
     , cod_iterman         varchar2(30)
     , circuito_primario   char(01)
     , distr_calore	   char(01)
     , n_scambiatori	   numeric(0,5)
     , potenza_scamb_tot   numeric(9,2)
     , nome_rete	   varchar2(100)
     , cod_alim		   char(01)
     , cod_fdc		   integer
     , note_dest	   varchar2(4000)
     , cop		   numeric(4,2)
     , per		   numeric(4,2)
     , st_progressivo      integer      not null default nextval('coimaimp_st_seq'::regclass)
     , st_utente	   varchar2(10)
     , st_operazione	   char(01)
     , st_data_validita	   timestamp with time zone 
     ) tablespace &ts_dat;

