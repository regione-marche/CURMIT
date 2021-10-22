/*==============================================================*/
/* table coimcost : costruttori                                 */
/*==============================================================*/

create table coimcost
     ( cod_cost       varchar(08) not null
     , descr_cost     varchar(35) not null
     , limite_inf     varchar(35)
     , limite_sup     varchar(35)
     , cert_cost      varchar(35)
     , data_ins       date
     , data_mod       date
     , utente         varchar(10)
     );

create unique index coimcost_00
    on coimcost
     ( cod_cost
     );
