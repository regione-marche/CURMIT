/*==============================================================*/
/* table coimogge: elenco oggetti                               */
/*==============================================================*/

create table coimogge
     ( livello       varchar(02)  not null
     , scelta_1      varchar(02)  not null
     , scelta_2      varchar(02)  not null
     , scelta_3      varchar(02)  not null
     , scelta_4      varchar(02)  not null
     , tipo          varchar(20)  not null
     , check (tipo in ('menu', 'funzione', 'titolo'))    
     , descrizione   varchar(100)  not null 
     , nome_funz     varchar(50)     
     );

create unique index coimogge_00
    on coimogge
     ( livello
     , scelta_1
     , scelta_2
     , scelta_3
     , scelta_4
     );
