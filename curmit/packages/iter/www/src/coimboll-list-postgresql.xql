<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_boll">
       <querytext>
select a.cod_bollini
     , iter_edit_data(a.data_consegna)   as data_consegna_edit
     , coalesce (b.cognome, ' ') ||' '|| coalesce (b.nome, ' ') as manutentore
     , iter_edit_num(a.nr_bollini, 0)    as nr_bollini_edit
     , iter_edit_num(a.nr_bollini_resi, 0) as nr_bollini_resi_edit
     , a.data_consegna
     , a.matricola_da
     , a.matricola_a
     , iter_edit_num (a.costo_unitario, 2) as costo_unitario
     , a.cod_manutentore
     , case pagati
            when 'S' then 'Si'
            when 'N' then 'No'
            else ' '
       end as pagati
     , iter_edit_num (((coalesce(a.nr_bollini, 0) - coalesce(a.nr_bollini_resi, 0)) * coalesce(a.costo_unitario, 0)), 2) as importo
     , c.descr_tpbo
     , iter_edit_num(imp_pagato, 2) as imp_pagato
     , d.descrizione as tipologia
     , e.num_fatt
  from coimboll a
  left outer join coimmanu b on b.cod_manutentore = a.cod_manutentore
  left outer join coimtpbo c on c.cod_tpbo        = a.cod_tpbo
  left outer join coimtpbl d on d.cod_tipo_bol    = a.cod_tpbl
  left outer join coimfatt e on e.cod_fatt = a.cod_fatt
 where 1=1
$where_manu
$where_f_manu
$where_data_da
$where_data_a
$where_last
order by a.data_consegna desc, a.cod_bollini desc
       </querytext>
    </partialquery>

    <fullquery name="sel_boll_sum">
       <querytext>
 select count(*) as conta_records
      , iter_edit_num(
            sum((coalesce(nr_bollini, 0) - coalesce(nr_bollini_resi, 0)) * coalesce(costo_unitario, 0))
          , 2
      ) as tot_imp_boll
      , iter_edit_num(sum(imp_pagato), 2) as tot_imp_pagato
  from coimboll 
 where 1 = 1
$where_manu_count
$where_data_da_count
$where_data_a_count
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
        select cognome
              ,nome
              ,flag_attivo
          from coimmanu
         where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

</queryset>

