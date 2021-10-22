-- Nicola 11/12/2013

begin;

-- Storico rappresentanti legali delle ditte di manutenzione
\i ../coimstrl.sql

alter table coimtgen add column flag_portale char(01) not null default 'F';

end;
