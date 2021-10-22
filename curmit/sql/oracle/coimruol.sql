
create table coimruol
     ( id_ruolo       varchar2(20) not null
     , descrizione    varchar2(50) not null
     ) tablespace &ts_dat;

create unique index coimruol_00
    on coimruol
     ( id_ruolo
     ) tablespace &ts_idx;
