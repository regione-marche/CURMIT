/*==============================================================*/
/* table coimddts: Testata caricamento anagrafiche              */
/*==============================================================*/
create table coimddts
     ( cod_ddts          varchar(08)  not null
     , cod_distr         varchar(08)
     , data_caric        date
     , anno_competenza   numeric(4,0)
     , cod_documento     varchar(08)
     , caricati          numeric(6,0)
     , scartati          numeric(6,0)
     , percorso_file     varchar(50)
     , note              varchar(4000)
     , data_ins          date
     , data_mod          date
     , utente_ins        varchar(10)
     , utente_mod        varchar(10)
     );

create unique index coimddts_00
    on coimddts
     ( cod_ddts
     );

create unique index coimddts_01
    on coimddts
     ( cod_distr
     , data_caric
     );
