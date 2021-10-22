/*======================================================================*/
/* table coimtano: elenco non conformita' riscontrabili degli impianti  */
/*                 termici                                              */
/*======================================================================*/

create table coimtano
     ( cod_tano         varchar(08)  not null
     , descr_tano       varchar(200) not null
     , descr_breve      varchar(80) 
     , data_ins         date
     , data_mod         date
     , utente           varchar(10) 
     , flag_scatenante  char(01)
     -- flag_scatenante (T, F)
     , norma            varchar(100)
     , flag_stp_esito   char(01) 
     , gg_adattamento   numeric(3)
     , flag_report      char(01)
     , flag_modello     char(01)
     , data_fine_valid  date
     , flag_tipo_ispezione char(01)
     , ente_competente     char(01)
     );

create unique index coimtanom_00
    on coimtano
     ( cod_tano
     );
