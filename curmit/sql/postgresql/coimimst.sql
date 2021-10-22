/*======================================================================*/
/* table coimimst: stato iimpianti                                      */
/*======================================================================*/

create table coimimst
     ( cod_imst        char(01)     not null
     , descr_imst      varchar(40)  not null
     , fl_imst         char(1)
     );

create unique index coimimst_00
    on coimimst
     ( cod_imst
     );
