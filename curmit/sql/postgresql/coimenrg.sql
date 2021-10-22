/*=========================================================================*/
/* table coimenrg: tabella relazioni raggruppamenti enti/enti responsabili */
/*=========================================================================*/

create table coimenrg
     ( cod_rgen        varchar(08) not null
     , cod_enre        varchar(08) not null
     );

create unique index coimenrg_00
    on coimenrg
     ( cod_rgen
     , cod_enre
     );

