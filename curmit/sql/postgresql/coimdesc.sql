/*==============================================================*/
/* table coimdesc : descrizioni generali                        */
/*==============================================================*/

create table coimdesc
     ( cod_desc          integer      not null
     , nome_ente         varchar(80)
     , tipo_ufficio      varchar(80)
     , assessorato       varchar(80)
     , indirizzo         varchar(80)
     , telefono          varchar(50)
     , resp_uff          varchar(40)
     , uff_info          varchar(80)
     , dirigente         varchar(40)
     );

create unique index coimdesc_00
    on coimdesc
     ( cod_desc
     );
