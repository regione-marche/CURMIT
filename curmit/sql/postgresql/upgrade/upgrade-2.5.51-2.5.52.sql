
begin;


--già lanciata su Fano e iterprcs  e comune e provincia di udine
--INSERT COIMFUNZ

insert into coimfunz values ('carianomrcee','Caricamento anomalie mod. RCEE','primario','iter-cari-anom-rcee','src/', null);

--già lanciata su Fano e iterprcs e comune e provincia di udine
update coimogge
set nome_funz='carianomrcee'
  , descrizione = 'Anomalie RCEE'
where nome_funz='carianomg';


delete from coimmenu
USING coimogge ogg
where coimmenu.livello = ogg.livello
  and coimmenu.scelta_1 = ogg.scelta_1
  and coimmenu.scelta_2 = ogg.scelta_2
  and coimmenu.scelta_3 = ogg.scelta_3
  and coimmenu.scelta_4 = ogg.scelta_4
  and ogg.nome_funz='carialledimp'
  and ogg.descrizione = 'Caricamento scansionati e allegati G';

delete from coimogge where nome_funz='carialledimp' and descrizione = 'Caricamento scansionati e allegati G';

--Luca R. inizio gestione prove fumi multiple.
alter table coimgend add  num_prove_fumi integer default 1;

\i ../coimdimp_prfumi.sql

alter table coimgend add  cop numeric(4,2);
alter table coimgend add  per numeric(4,2);

end;
