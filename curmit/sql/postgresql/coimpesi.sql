/*==============================================================*/
/* table coimragr : tabella pesi                                */
/*==============================================================*/

create table coimpesi
     ( nome_campo         varchar(30)  not null
     , codice_esterno     varchar(20)
     , descrizione_dimp   varchar(200)
     , descrizione_uten   varchar(200)
     , peso               numeric(09)
     , tipo_peso          char(02)
     , cod_raggruppamento varchar(08)
     );

create unique index coimpesi_00
    on coimpesi
     ( nome_campo
     , tipo_peso );
