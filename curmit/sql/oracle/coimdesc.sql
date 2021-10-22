/*==============================================================*/
/* table coimdesc : descrizioni generali                        */
/*==============================================================*/

create table coimdesc
     ( cod_desc          number(08)     not null
     , nome_ente         varchar2(80)
     , tipo_ufficio      varchar2(80)
     , assessorato       varchar2(80)
     , indirizzo         varchar2(80)
     , telefono          varchar2(50)
     , resp_uff          varchar2(40)
     , uff_info          varchar2(80)
     , dirigente         varchar2(40)
     ) tablespace &ts_dat;

create unique index coimdesc_00
    on coimdesc
     ( cod_desc
     ) tablespace &ts_idx;
