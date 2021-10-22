-- Nicola, 01/08/2014 per Comune di Pesaro ed Urbino / Aspes
-- Creo tabella per gestione bollettini postali

-- Aggiunto parametro:
-- <parameter scope="instance" datatype="number"  min_n_values="1"  max_n_values="1" name="bpos_td896"  default="0" description="Valorizzare con 0 o con 1. Se valorizzato con 1, abilita l'esportazione del file csv per le poste con tracciato TD896"/>

begin;

\i ../coimbpos.sql

create sequence coimbpos_s start 1;

end;
