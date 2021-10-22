--===========================================================================================
-- table coimdope_gend: Tabella delle dichiarazioni di frequenza e di elenco operazioni di
--                      controllo e manutenzione dell'impianto
--===========================================================================================

create table coimdope_gend
( cod_dope_aimp		number(9,0) not null
, gen_prog              number(8,0) not null
, num_oper              number(3,0) not null -- Progressivo a parita' dei primi due campi
, operazione            varchar2(400) not null
, frequenza             varchar2(50)
, data_ins		date          not null default current_date
, utente_ins		varchar2(10)
, data_mod		date
, utente_mod		varchar2(10)
) tablespace &ts_dat;

create unique index coimdope_gend_00
    on coimdope_gend
     ( cod_dope_aimp
     , gen_prog
     , num_oper
     ) tablespace &ts_idx;
