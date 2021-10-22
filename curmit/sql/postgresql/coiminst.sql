/*======================================================================*/
/* table coiminst: stato incontri                                       */
/*======================================================================*/

create table coiminst
     ( cod_inst        char(01)     not null
     , descr_inst      varchar(40)  not null
     );

create unique index coiminst_00
    on coiminst
     ( cod_inst
     );
