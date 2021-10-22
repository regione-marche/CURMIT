/*==============================================================*/
/* table coimlist: testata dei listini, il corpo dei listini e' la tabella coimtari ecc*/
/*==============================================================*/

create table coimlist
     ( cod_listino    varchar(8)    not null
     , descrizione    varchar(50)   not null
     );

create unique index coimlist_00
    on coimlist
     ( cod_listino
     );
