-- Nicola 28/03/2014

begin;

-- Non rinomino la vecchia table coimuten e creo nuova view coimuten leggendo da utenti di openacs
-- perchè i menù dinamici leggono ora dalle vecchie tabelle dei menù e degli utenti di iter
--alter table coimuten rename to coimuten_old_menu_2014_03_26;
--\i ../coimuten.sql

-- Creo le nuove tabelle per la gestione dei messaggi
\i ../coimtmsg.sql
\i ../coimdmsg.sql

-- Creo la sequence coimboap_s
create sequence coimboap_s;
select setval('coimboap_s', max(cod_boap)) from coimboap;

-- Creo l'indice coimboap_03 (cod_bollini):
create        index coimboap_03
    on coimboap
     ( cod_bollini
     );

end;
