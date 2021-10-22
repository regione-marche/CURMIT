-- Tabella Utenti

create table coimuten
     ( id_utente       varchar2(10)               not null
     , cognome         varchar2(40)               not null
     , nome            varchar2(40)               not null
     , password        varchar2(15)               not null
     , id_settore      varchar2(20)               not null
     , id_ruolo        varchar2(20)               not null
     , lingua	       varchar2(02)  default 'it'
     , e_mail	       varchar2(100)              not null
     , rows_per_page   number(08)    default 10   not null
     , data            date
     , livello         number(01)
     , flag_menu_yui       boolean      not null default 't'
     , flag_alto_contrasto boolean      not null default 'f'
     ) tablespace &ts_dat;

create unique index coimuten_00
    on coimuten
     ( id_utente
     ) tablespace &ts_idx;
