-- Gabriele 30/06/2017

begin;

---Già lanciata manualmente sulle 3 di ucit
alter table coimdimp alter column tipologia_costo type varchar(8);
alter table coimmovi alter column tipo_pag type varchar(8);

--Aggiunto potenza utile per gli impianti del freddo. Il campo pot_utile_nom era stato riciclato per la potenza 
--di assorbimento
alter table coimgend add pot_utile_nom_freddo numeric(9,2);

update coimgend set pot_utile_nom_freddo =pot_utile_nom
from coimaimp
where coimgend.cod_impianto = coimaimp.cod_impianto
and flag_tipo_impianto='F';

end;
