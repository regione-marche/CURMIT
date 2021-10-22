/*=================================================================*/
/* table coimtpin_manu : tipologia installazioni del manutentore   */
/*=================================================================*/


create table coimtpin_manu
           ( cod_coimtpin_manu      integer     not null
           , cod_manutentore        varchar(8)  not null
           , cod_coimtpin           integer     not null
           , creation_user          varchar(10)
           , creation_date          date

);

create unique index coimtpin_manu_00
    on coimtpin_manu
     ( cod_coimtpin_manu
     );

create unique index coimtpin_manu_01
    on coimtpin_manu
     ( cod_manutentore
     , cod_coimtpin_manu
     );

