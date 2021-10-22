/*==============================================================*/
/* table coimaimp:				                */
/*==============================================================*/

create table coimaimp_st
     ( cod_impianto        varchar(08)  not null
     , cod_impianto_est    varchar(20)
     , cod_impianto_prov   varchar(08)
     , descrizione         varchar(50)
     , provenienza_dati    char(01)   
     , cod_combustibile    varchar(08)
     , cod_potenza         varchar(08)
     , potenza             numeric(9,2) 
     , potenza_utile       numeric(9,2)
     , data_installaz      date         
     , data_attivaz        date
     , data_rottamaz       date
     , note                varchar(4000)
     , stato               char(01)
     , flag_dichiarato     char(01)
     , data_prima_dich     date
     , data_ultim_dich     date
     , cod_tpim            varchar(08)
     , consumo_annuo       numeric(9,2)
     , n_generatori        numeric(2)
     , stato_conformita    char(01)
     , cod_cted            varchar(08)
     , tariffa             varchar(08)
     , cod_responsabile    varchar(08)
     , flag_resp           char(01)
     , cod_intestatario    varchar(08)
     , flag_intestatario   char(01)
     , cod_proprietario    varchar(08)
     , cod_occupante       varchar(08)
     , cod_amministratore  varchar(08)
     , cod_manutentore     varchar(08)
     , cod_installatore    varchar(08)
     , cod_distributore    varchar(08)
     , cod_progettista     varchar(08)
     , cod_amag            varchar(10)
     , cod_ubicazione      varchar(08)
     , localita            varchar(40)
     , cod_via             varchar(08)
     , toponimo            varchar(20)
     , indirizzo           varchar(100)
     , numero              varchar(08)
     , esponente           varchar(03)
     , scala               varchar(05)
     , piano               varchar(05)
     , interno             varchar(05)
     , cod_comune          varchar(08)
     , cod_provincia       varchar(08)
     , cap                 varchar(05)
     , cod_catasto         varchar(20) 
     , cod_tpdu            varchar(08)
     , cod_qua             varchar(08)
     , cod_urb             varchar(08)
     , data_ins            date
     , data_mod            date
     , utente              varchar(10)
     , flag_dpr412         char(01)
     , cod_impianto_dest   varchar(08)
     , anno_costruzione    date
     , marc_effic_energ    varchar(10)
     , volimetria_risc     numeric (9,2)
     , gb_x                varchar(50)
     , gb_y                varchar(50)
     , data_scad_dich      date
     , flag_coordinate     varchar(2)
     , flag_targa_stampata char(01)
     , cod_impianto_old    varchar(20)
     , portata             numeric(9,2) 
     , palazzo             varchar(100)
     , n_unita_immob       numeric(9,0)
     , cod_tipo_attivita   varchar(8)
     , adibito_a           varchar(500)
     , utente_ins          varchar(10)
     , igni_progressivo    numeric(5,0)
     , cod_iterman         varchar(30)
     , circuito_primario   char(01)
     , distr_calore	   char(01)
     , n_scambiatori	   numeric(5,0)
     , potenza_scamb_tot   numeric(9,2)
     , nome_rete	   varchar(100)
     , cod_alim		   char(01)
     , cod_fdc		   integer
     , note_dest	   varchar(4000)
     , cop		   numeric(4,2)
     , per		   numeric(4,2)
     , st_progressivo	   integer	not null default nextval('coimaimp_st_seq'::regclass)
     , st_utente	   varchar(10)
     , st_operazione	   char(01)
     , st_data_validita	   timestamp with time zone 
     );

