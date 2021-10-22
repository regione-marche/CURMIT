/*==============================================================*/
/* table coimragr : tabella che collega i pesi ai modelli       */
/*==============================================================*/

create table coimdipe
     ( cod_impianto       varchar(08)  not null
     , cod_dimp           varchar(08)  not null
     , nome_campo         varchar(30)  not null
     , tipo_peso          char(02)     not null
     , peso_totale        numeric(09)
     , n_anomalie         numeric(09)
     );

create unique index coimdipe_00
    on coimdipe
     ( cod_impianto
     , cod_dimp
     , nome_campo
     , tipo_peso );
