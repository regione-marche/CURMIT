/*==============================================================*/
/* table coimcted : Categorie edificio art.3 DPR.412 2003       */
/*==============================================================*/

create table coimcted
     ( cod_cted       varchar(08) not null
     , descr_cted     varchar(150) not null
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     );

create unique index coimcted_00
    on coimcted
     ( cod_cted
     );
