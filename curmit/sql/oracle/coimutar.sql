/*================================================================*/
/* table coimutar : collegamento utenti - area di competenza      */
/*================================================================*/

create table coimutar
     ( cod_area          varchar2(08)  not null
     , id_utente         varchar2(10)  not null
     , data_ins          date
     , data_mod          date
     , utente            varchar2(10)
     ) tablespace &ts_dat;

create unique index coimutar_00
    on coimutar
     ( cod_area
     , id_utente
     ) tablespace &ts_idx;
