/*====================================================================*/
/* table coimstam: tabella contavilizzazioni addiz. regionali         */
/*====================================================================*/

create table coimstam
     ( progressivo        integer     not null
     , cod_impianto       varchar(08) not null
     , data_dichiarazione date
     , n_dichiarazioni    integer
     , cod_potenza        varchar(08)
     , periodo_rif        varchar(06)
     , flag_contab        char(01)
     , data_ins           date
     );

create unique index coimstam_00
    on coimstam
     ( progressivo
     );

