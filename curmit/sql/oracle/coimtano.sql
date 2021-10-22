/*======================================================================*/
/* table coimtano: elenco non conformita' riscontrabili degli impianti  */
/*                 termici                                              */
/*======================================================================*/

create table coimtano
     ( cod_tano         varchar2(08) not null
     , descr_tano       varchar2(200) not null
     , descr_breve      varchar2(80)
     , data_ins         date
     , data_mod         date
     , utente           varchar2(10) 
     , flag_scatenante  char(01)
     -- flag_scatenante (T, F)
     , norma            varchar2(100)
     , flag_stp_esito   char(01) 
     , gg_adattamento   number(3)
     , flag_report      char(01)
     , flag_tipo_ispezione char(01)
     , ente_competente     char(01)
     ) tablespace &ts_dat;

create unique index coimtanom_00
    on coimtano
     ( cod_tano
     ) tablespace &ts_idx;
