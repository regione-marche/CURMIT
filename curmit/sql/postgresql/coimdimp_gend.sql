--===========================================================================================
-- table coimdimp_gend: Tabella dei generatori indicati nelle dichiarazioni di avvenuta 
--                      manutenzione (usata dagli enti della Regione Marche)
--===========================================================================================

create table coimdimp_gend
( cod_dimp     		varchar(08)  not null
, gen_prog              numeric(07)  not null
, data_ult_man_o_disatt date
, data_ins		date         not null default current_date
, utente_ins		varchar(10)
, data_mod		date
, utente_mod		varchar(10)
);

create unique index coimdimp_gend_00
    on coimdimp_gend
     ( cod_dimp
     , gen_prog
     );
