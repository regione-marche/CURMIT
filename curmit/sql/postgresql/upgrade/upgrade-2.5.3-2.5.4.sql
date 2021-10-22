-- Nicola 04/03/2014

begin;

-- Aggiunta tabella coimmode per gestire in modo tabellare i modelli di generatore (per Rimini)
-- ed aggiunto un nuovo parametro per gestire o meno in modo tabellare i modelli di generatore.
-- Per ora andrà attivato solo per Rimini.
\i ../coimmode.sql

alter table coimtgen add column flag_gest_coimmode char(01) not null default 'F';

end;
