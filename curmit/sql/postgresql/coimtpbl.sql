/*==============================================================*/
/* table coimboll: tabella tipi bollini per manutentore         */
/*==============================================================*/

create table coimtpbl
     ( cod_tipo_bol      varchar(08)  not null
     , descrizione       varchar(300)
     , data_fine_valid   date
     , cod_potenza       varchar(08)
     );

create unique index coimtpbl_00
    on coimtpbl
     ( cod_tipo_bol
     );
