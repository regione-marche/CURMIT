-- Nicola 17/03/2014

begin;

-- Aggiunte colonne cod_mode e cod_mode_bruc per memorizzare il codice della tabella coimmode
-- anche se rimangono valorizzate le colonne modello e modello_bruc (serve per eventuali cambi
-- di descrizione sulla tabella modelli)
-- Script spostato nell'upgrade-2.5.4-2.5.5
--alter table coimgend add column cod_mode      integer;
--alter table coimgend add column cod_mode_bruc integer;

-- Aggiunto campo pec sulla coimmanu
alter table coimmanu add column pec           varchar(150);

end;
