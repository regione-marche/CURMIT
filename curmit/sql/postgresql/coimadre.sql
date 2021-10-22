/*====================================================================*/
/* table coimadre: tabella addizionali regionali                      */
/*====================================================================*/

create table coimadre
     ( cod_adre        varchar(08) not null
     , cod_potenza     varchar(08) not null
     , importo         numeric(6,2)
     , data_valid      date
     );

create unique index coimadre_00
    on coimadre
     ( cod_adre
     );

