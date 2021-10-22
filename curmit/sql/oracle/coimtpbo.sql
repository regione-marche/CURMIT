/*==============================================================*/
/* table coimboll: tabella tipo bollini                         */
/*==============================================================*/

create table coimtpbo
     ( cod_tpbo          varchar2(02)  not null
     , descr_tpbo        varchar2(20)  not null
     , data_fine_valid   date
     , cod_potenza       varchar2(08)
     );

create unique index coimtpbo_00
    on coimtpbo
     ( cod_tpbo   
     );