/*==============================================================*/
/* table coimptsg: tipi soggetto                                */
/*==============================================================*/
create table coimtpsg
     ( tipo_soggetto     char(1)
     , descrizione       varchar(100)
     );

create unique index coimtpsg_00
    on coimtpsg
     ( tipo_soggetto
     );

