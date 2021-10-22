/*================================================================*/
/* table coimmtar : collegamento manutentori - area di competenza */
/*================================================================*/

create table coimmtar
     ( cod_area          varchar2(08)  not null
     , cod_manutentore   varchar2(08)  not null
     , data_ins          date
     , data_mod          date
     , utente            varchar2(10)
     ) tablespace &ts_dat;

create unique index coimmtar_00
    on coimmtar
     ( cod_area
     , cod_manutentore
     ) tablespace &ts_idx;
