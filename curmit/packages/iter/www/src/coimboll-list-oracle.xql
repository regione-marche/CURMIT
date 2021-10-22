<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_boll">
       <querytext>
select a.cod_bollini
     , iter_edit.data(a.data_consegna)   as data_consegna_edit
     , nvl (b.cognome, ' ') ||' '|| nvl (b.nome, ' ') as manutentore
     , iter_edit.num(a.nr_bollini, 0)    as nr_bollini_edit
     , iter_edit.num(a.nr_bollini_resi, 0) as nr_bollini_resi_edit
     , a.data_consegna
     , a.matricola_da
     , a.matricola_a
     , iter_edit.num (a.costo_unitario, 2) as costo_unitario
     , a.cod_manutentore
     , decode (a.pagati
              ,'S', 'Si'
              ,'N', 'No'
              ,' '
              )  as pagati
     , iter_edit.num (((nvl(a.nr_bollini, 0) - nvl(a.nr_bollini_resi, 0)) * nvl(a.costo_unitario, 0)), 2) as importo
     , c.descr_tpbo
     , iter_edit.num(imp_pagato, 2) as imp_pagato
     , e.num_fatt
  from coimboll a
     , coimmanu b
     , coimtpbo c
     , coimfatt e
 where 1=1
   and b.cod_manutentore (+) = a.cod_manutentore
   and c.cod_tpbo        (+) = a.cod_tpbo
   and e.matr_da         (+) = a.matricola_da
   and e.matr_a          (+) = a.matricola_a
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
      , iter_edit.num(
            sum((nvl(nr_bollini, 0) - nvl(nr_bollini_resi, 0)) * nvl(costo_unitario, 0))
          , 2
      ) as tot_imp_boll
      , iter_edit.num(sum(imp_pagato), 2) as tot_imp_pagato
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
             , nome
          from coimmanu
         where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

</queryset>

