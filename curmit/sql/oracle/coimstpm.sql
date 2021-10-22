-- tabella stampe

create table coimstpm
     ( id_stampa         integer      not null
     , descrizione       varchar2(50)
     , testo             long
     , campo1_testo      varchar2(50)
     , campo1            varchar2(50)
     , campo2_testo      varchar2(50)
     , campo2            varchar2(50)
     , campo3_testo      varchar2(50)
     , campo3            varchar2(50)
     , campo4_testo      varchar2(50)
     , campo4            varchar2(50)
     , campo5_testo      varchar2(50)
     , campo5            varchar2(50)
     , var_testo         char(1)
     , allegato          char(1)
     , tipo_foglio       char(1)
     , orientamento      char(1)
     , tipo_documento    varchar2(02)
) tablespace &ts_dat;

create unique index coimstpm_00
    on coimstpm
     ( id_stampa
     ) tablespace &ts_idx;



