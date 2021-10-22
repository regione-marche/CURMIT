/*==============================================================*/
/* table coimcomb_cnt : combustibili                                */
/*==============================================================*/

create table coimcomb_cnt
     ( cod_combustibile varchar(08) not null
     , descr_comb       varchar(35) not null
     , data_ins         date
     , data_mod         date
     , utente           varchar(10)
     );

create unique index coimcomb_cnt_00
    on coimcomb_cnt
     ( cod_combustibile
     );
