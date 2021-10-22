/*==============================================================*/
/* table coimboll: tabella tipo bollini                         */
/*==============================================================*/

create table coimtpbo
     ( cod_tpbo          varchar(02)  not null
     , descr_tpbo        varchar(20)  not null
     , data_fine_valid   date
     , cod_potenza       varchar(8)
     );

create unique index coimtpbo_00
    on coimtpbo
     ( cod_tpbo   
     );