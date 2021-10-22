<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


    <partialquery name="sel_boll">
       <querytext>
select a.cod_bollini
     , iter_edit.data(a.data_consegna)   as data_consegna_edit
     , Nvl (b.cognome, ' ') ||' '|| Nvl (b.nome, ' ') as manutentore
     , iter_edit.num(a.nr_bollini, 0)    as nr_bollini_edit
     , iter_edit.num(a.nr_bollini_resi, 0)  as nr_bollini_resi_edit
     , a.data_consegna
     , a.matricola_da
     , a.matricola_a
     , iter_edit.num (a.costo_unitario, 2) as costo_unitario
     , decode (a.pagati
             ,'S', 'Si'
             ,'N', 'No'
             ,'')
       as pagati
     , iter_edit.num (((a.nr_bollini - a.nr_bollini_resi) * a.costo_unitario), 2) as importo
  from coimboll a
     , coimmanu b
 where 1=1
   and b.cod_manutentore = a.cod_manutentore
$where_manu
$where_range
order by a.data_consegna, a.cod_bollini
       </querytext>
    </partialquery>

</queryset>
