/*==============================================================*/
/* table coimcted : Categorie edificio art.3 DPR.412 2003       */
/*==============================================================*/

create table coimcted
     ( cod_cted       varchar2(08) not null
     , descr_cted     varchar2(150) not null
     , data_ins       date
     , data_mod       date
     , utente         varchar2(10)
     ) tablespace &ts_dat;

create unique index coimcted_00
    on coimcted
     ( cod_cted
     ) tablespace &ts_idx;
