/*===============================================================*/
/* table coimtprc: tabella anagrafica tipi rapporti di controllo */
/*===============================================================*/

create table coimtprc
     ( cod_tprc    varchar(08)  not null
     , descr_tprc  varchar(1000) not null
     , esente      boolean      default false
     );
             
create unique index coimtprc_00
    on coimtprc
     ( cod_tprc
     );
