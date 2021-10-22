/*==============================================================*/
/* table coimcost : costruttori                                 */
/*==============================================================*/

create table coimcost
     ( cod_cost       varchar2(08) not null
     , descr_cost     varchar2(35) not null
     , limite_inf     varchar2(35)
     , limite_sup     varchar2(35)
     , cert_cost      varchar2(35)
     , data_ins       date
     , data_mod       date
     , utente         varchar2(10)
     ) tablespace &ts_dat;

create unique index coimcost_00
    on coimcost
     ( cod_cost
     ) tablespace &ts_idx;
