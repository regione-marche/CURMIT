/*======================================================================*/
/* table coimimst: stato iimpianti
/*======================================================================*/

create table coimimst
     ( cod_imst        char(01)     not null
     , descr_imst      varchar2(40)  not null
     ) tablespace &ts_dat;

create unique index coimimst_00
    on coimimst
     ( cod_imst
     ) tablespace &ts_idx;
