/*==============================================================*/
/* table coimcost_cnt : costruttori                                 */
/*==============================================================*/

create table coimcost_cnt
     ( cod_cost       varchar(08) not null
     , descr_cost     varchar(35) not null
     , limite_inf     varchar(35)
     , limite_sup     varchar(35)
     , cert_cost      varchar(35)
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     );

create unique index coimcost_cnt_00
    on coimcost_cnt
     ( cod_cost
     );
