/*====================================================================*/
/* table coimadre: tabella addizionali regionali                      */
/*====================================================================*/

create table coimadre
     ( cod_adre        varchar2(08) not null
     , cod_potenza     varchar2(08) not null
     , importo         numeric(6,2)
     , data_valid      date
     ) tablespace &ts_dat;

create unique index coimadre_00
    on coimadre
     ( cod_adre
    ) tablespace &ts_idx;
