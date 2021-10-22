/*==============================================================*/
/* table coimogge: elenco oggetti                               */
/*==============================================================*/

create table coimogge
     ( livello       varchar2(02)  not null
     , scelta_1      varchar2(02)  not null
     , scelta_2      varchar2(02)  not null
     , scelta_3      varchar2(02)  not null
     , scelta_4      varchar2(02)  not null
     , tipo          varchar2(20)  not null
     , check (tipo in ('menu', 'funzione', 'titolo'))    
     , descrizione   varchar2(100)  not null 
     , nome_funz     varchar2(50)     
     ) tablespace &ts_dat;

create unique index coimogge_00
    on coimogge
     ( livello
     , scelta_1
     , scelta_2
     , scelta_3
     , scelta_4
     ) tablespace &ts_idx;
