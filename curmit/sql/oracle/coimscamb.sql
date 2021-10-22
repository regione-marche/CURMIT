/*==============================================================*/
/* table coimscamb :		                                */
/*==============================================================*/


create table coimscamb
     (cod_impianto     varchar2(8)	not null
     ,scamb_prog       numeric(8,0)     not null
     ,potenza          numeric(9,2)
  ) tablespace &ts_dat;


create unique index coimscamb_00
    on coimscamb
     ( cod_impianto
     , scamb_prog
     ) tablespace &ts_idx;

