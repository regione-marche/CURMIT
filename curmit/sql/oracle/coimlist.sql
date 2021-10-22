/*==============================================================*/
/* table coimlist: testata dei listini, il corpo dei listini e' la tabella coimtari ecc*/
/*==============================================================*/

create table coimlist
     ( cod_listino    varchar2(08)    not null
     , descrizione    varchar2(50)   not null
     );

create unique index coimlist_00
    on coimlist
     ( cod_listino
     );
