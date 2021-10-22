<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    san01 12/08/2016 Aggiunto campo note.
-->
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_boll">
       <querytext>
select a.cod_bollini
     , iter_edit_data(a.data_consegna)   as data_consegna_edit
     , coalesce (b.cognome, ' ') ||' '|| coalesce (b.nome, ' ') as manutentore
     , iter_edit_num(a.nr_bollini, 0)    as nr_bollini_edit
     , iter_edit_num(a.nr_bollini_resi, 0)  as nr_bollini_resi_edit
     , a.data_consegna
     , a.matricola_da
     , a.matricola_a
     , iter_edit_num (a.costo_unitario, 2) as costo_unitario
     , case a.pagati
       when 'S' then 'Si'
       when 'N' then 'No'
       else ''
       end as pagati
     , iter_edit_num (((a.nr_bollini - a.nr_bollini_resi) * a.costo_unitario), 2) as importo
     , iter_edit_num(imp_pagato, 2) as imp_pagato
     , coalesce(d.cognome, '')||' '||coalesce(d.nome, '') as utente
     , b.cod_manutentore
     , d.id_utente
     , a.note      -- san01
  from coimboll a
  left outer join coimuten d on d.id_utente    = a.utente
inner join coimmanu b
        on b.cod_manutentore = a.cod_manutentore
 where 1=1
$where_manu
$where_range
order by a.data_consegna, a.cod_bollini
       </querytext>
    </partialquery>

</queryset>
