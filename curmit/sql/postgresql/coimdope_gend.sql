--===========================================================================================
-- table coimdope_gend: Tabella delle dichiarazioni di frequenza e di elenco operazioni di
--                      controllo e manutenzione dell'impianto
--===========================================================================================

create table coimdope_gend
( cod_dope_aimp		integer      not null
, gen_prog              numeric(8,0) not null
, num_oper              numeric(3,0) not null -- Progressivo a parita' dei primi due campi
, operazione            varchar(400) not null
, frequenza             varchar(50)
, data_ins		date         not null default current_date
, utente_ins		varchar(10)
, data_mod		date
, utente_mod		varchar(10)
);

create unique index coimdope_gend_00
    on coimdope_gend
     ( cod_dope_aimp
     , gen_prog
     , num_oper
     );
