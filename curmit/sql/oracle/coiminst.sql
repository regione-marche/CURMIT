/*======================================================================*/
/* table coiminst: stato incontri                                       */
/*======================================================================*/

create table coiminst
     ( cod_inst        char(01)      not null
     , descr_inst      varchar2(40)  not null
     ) tablespace &ts_dat;

create unique index coiminst_00
    on coiminst
     ( cod_inst
     ) tablespace &ts_idx;
