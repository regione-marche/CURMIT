-- Simone 19/10/2017

begin;

-- Aggiunto nuovo campo alla coimgend

alter table coimgend add num_circuiti integer;

--lo metto a 1 su tutti gli impianti del freddo
update coimgend
   set num_circuiti = 1 
from coimaimp 
where coimgend.cod_impianto=coimaimp.cod_impianto 
and flag_tipo_impianto='F';

end;
