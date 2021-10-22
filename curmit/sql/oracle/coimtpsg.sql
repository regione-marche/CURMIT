/*==============================================================*/
/* table coimptsg: tipi soggetto                                */
/*==============================================================*/
create table coimtpsg
     ( tipo_soggetto     char(1)
     , descrizione       varchar2(100)
     ) tablespace &ts_dat;

create unique index coimtpsg_00
    on coimtpsg
     ( tipo_soggetto
     ) tablespace &ts_idx;

