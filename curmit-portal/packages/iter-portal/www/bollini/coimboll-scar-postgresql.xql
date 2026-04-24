<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>


    <partialquery name="sel_boll">
       <querytext>
select a.cod_bollini
     , iter_edit_data(a.data_consegna)     as data_consegna_edit
     , coalesce (b.name, ' ')              as manutentore
     , b.iter_code                         as cod_manutentore
     , iter_edit_num(a.nr_bollini, 0)      as nr_bollini_edit
     , iter_edit_num(a.nr_bollini_resi, 0) as nr_bollini_resi_edit
     , a.data_consegna
     , a.matricola_da
     , a.matricola_a
     , iter_edit_num (a.costo_unitario, 2) as costo_unitario
     , case a.pagati
         when 'S' then 'Si'
         when 'N' then 'No'
         else ''
       end as pagati
     , case a.cod_tpbo
        when '1' then 'G'
        when '2' then 'F1'
        when '3' then 'F2'
        when '4' then 'E'
        else ''
       end as tipo_bollino
     , iter_edit_num (((a.nr_bollini - a.nr_bollini_resi) * a.costo_unitario), 2) as importo
     , iter_edit_num(imp_pagato, 2) as imp_pagato
     , coalesce(d.cognome, '')||' '||coalesce(d.nome, '') as utente
     , d.id_utente
  from coimboll a
       left outer join coimuten d on d.id_utente    = a.utente
       inner join iter_maintainers b on b.iter_code = a.cod_manutentore
 where 1=1
 $where_manu
 $where_range
order by a.data_consegna, a.cod_bollini
       </querytext>
    </partialquery>

</queryset>
