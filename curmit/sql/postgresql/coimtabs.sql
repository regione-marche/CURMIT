/*==============================================================*/
/* table coimtabs: Anagrafica Tabelle                           */
/*==============================================================*/

create table coimtabs
     ( nome_tabella    varchar(08) not null
     , nome_colonna    varchar(40) not null
     , denominazione   varchar(100)
     , tipo_dato       varchar(8)
     , check (tipo_dato in ('varchar', 'numeric', 'date'))    
 --    , dimensione       numeric(6,2)
     , dimensione      varchar(8)
     , obbligatorio    varchar(1)
     , check (obbligatorio in ('S', 'N'))    
     , default_value   varchar(8)
     , range_value     varchar(4000)
     , ordinamento     integer
     );

create unique index coimtabs_00
    on coimtabs
     ( nome_tabella
     , nome_colonna
     );

