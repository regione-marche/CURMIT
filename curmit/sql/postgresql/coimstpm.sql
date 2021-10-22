-- tabella stampe

create table coimstpm
     ( id_stampa         integer      not null
     , descrizione       varchar(50)
     , testo             varchar
     , campo1_testo      varchar(50)
     , campo1            varchar(50)
     , campo2_testo      varchar(50)
     , campo2            varchar(50)
     , campo3_testo      varchar(50)
     , campo3            varchar(50)
     , campo4_testo      varchar(50)
     , campo4            varchar(50)
     , campo5_testo      varchar(50)
     , campo5            varchar(50)
     , var_testo         char(1)
     , allegato          char(1)
     , tipo_foglio       char(1)
     , orientamento      char(1)
     , tipo_documento    varchar(02)
);

create unique index coimstpm_00
    on coimstpm
     ( id_stampa
     );
