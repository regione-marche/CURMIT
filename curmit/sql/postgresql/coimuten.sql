-- Tabella Utenti

create table coimuten
     ( id_utente           varchar(10)               not null
     , cognome             varchar(40)               not null
     , nome                varchar(40)               not null
     , password            varchar(15)               not null
     , id_settore          varchar(20)               not null
     , id_ruolo            varchar(20)               not null
     , lingua	           varchar(02)  default 'it'
     , e_mail	           varchar(100)              not null
     , rows_per_page       numeric(08)  default 10   not null
     , data                date
     , livello             numeric(01)
     , flag_menu_yui       boolean      not null default 't'
     , flag_alto_contrasto boolean      not null default 'f'
     );

create unique index coimuten_00
    on coimuten
     ( id_utente
     );
