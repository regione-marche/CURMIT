/*================================================================*/
/* table coimmtar : collegamento manutentori - area di competenza */
/*================================================================*/

create table coimmtar
     ( cod_area          varchar(08)  not null
     , cod_manutentore   varchar(08)  not null
     , data_ins          date
     , data_mod          date
     , utente            varchar(10)
     );

create unique index coimmtar_00
    on coimmtar
     ( cod_area
     , cod_manutentore
     );
