/*==============================================================*/
/* table coimscamb :		                                */
/*==============================================================*/


create table coimscamb
     (cod_impianto     varchar(8)	not null
     ,scamb_prog       numeric(8,0)     not null
     ,potenza          numeric(9,2)
  );


create unique index coimscamb_00
    on coimscamb
     ( cod_impianto
     , scamb_prog
     );

