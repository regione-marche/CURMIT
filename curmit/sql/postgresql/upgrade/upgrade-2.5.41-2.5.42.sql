-- Simone 17/01/2016

begin;

alter table coimpote add flag_tipo_impianto  varchar(1);

update coimpote set flag_tipo_impianto = 'R';

--duplico le potenze e le assegno al freddo
insert into coimpote
 select 'F' || cod_potenza
      , descr_potenza
      , potenza_min
      , potenza_max
      , data_ins
      , data_mod
      , utente
      , 'F' 
from coimpote
where flag_tipo_impianto = 'R';

--bonificao i dati già presenti
update coimtari 
   set cod_potenza = 'F' || cod_potenza 
 where tipo_costo  = 8;

update coimaimp 
   set cod_potenza = 'F' || cod_potenza 
 where flag_tipo_impianto = 'F';



end;
