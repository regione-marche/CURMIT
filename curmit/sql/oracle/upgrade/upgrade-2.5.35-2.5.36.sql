-- Simone 27/06/2016

begin;

--Aggiunti campi su coimtari per gestire le tariffe sugliimpianti vecchi della Regione Calabria

alter table coimtari add flag_tariffa_impianti_vecchi boolean not null default 'f';
alter table coimtari add anni_fine_tariffa_base       numeric (2,0);
alter table coimtari add tariffa_impianti_vecchi      numeric (9,2);

--Aggiunto patentino sui manutentori
alter table coimmanu add patentino                    boolean not null default 'f';

end;
