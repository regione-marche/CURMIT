
create table coimruol
     ( id_ruolo       varchar(20) not null
     , descrizione    varchar(50) not null
     );

create unique index coimruol_00
    on coimruol
     ( id_ruolo
     );
