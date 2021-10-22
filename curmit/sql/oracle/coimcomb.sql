/*==============================================================*/
/* table coimcomb : combustibili                                */
/*==============================================================*/

create table coimcomb
     ( cod_combustibile  varchar2(08) not null
     , descr_comb        varchar2(35) not null
     , data_ins          date
     , data_mod          date
     , utente            varchar2(10)
     ) tablespace &ts_dat;

create unique index coimcomb_00
    on coimcomb
     ( cod_combustibile
     ) tablespace &ts_idx;
