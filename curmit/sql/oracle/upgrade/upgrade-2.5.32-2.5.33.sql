-- Nicola 23/05/2016

begin;

insert
  into coimtari
     ( tipo_costo
     , cod_potenza
     , data_inizio
     , importo
     , cod_listino
     )
select 8 -- Dichiarazione fr
     , cod_potenza
     , data_inizio
     , importo
     , cod_listino
  from coimtari
 where tipo_costo = 1 -- Dichiarazione
;

end;
