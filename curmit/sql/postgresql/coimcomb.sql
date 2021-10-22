/*==============================================================*/
/* table coimcomb : combustibili                                */
/*==============================================================*/

create table coimcomb
     ( cod_combustibile varchar(08) not null
     , descr_comb       varchar(35) not null
     , data_ins         date
     , data_mod         date
     , utente           varchar(10)
     , tipo             varchar(1)
     , um               varchar(3)
     );

create unique index coimcomb_00
    on coimcomb
     ( cod_combustibile
     );
