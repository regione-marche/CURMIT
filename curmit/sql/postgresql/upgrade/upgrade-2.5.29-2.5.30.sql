
begin;

--12/02/2016 Nicola per coimtgen.flag_potenza usato per regione Marche e provincia Livorno
alter table coimtgen add flag_potenza varchar(50) not null default 'pot_focolare_nom';
-- Valori possibili: pot_utile_nom, pot_focolare_nom

--16/02/2016 Sandro
alter table coimmanu alter column rea         type varchar(20);
alter table coimmanu alter column reg_imprese type varchar(20);

end;
