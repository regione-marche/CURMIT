<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_acts">
       <querytext>
select a.cod_acts
     , iter_edit.data(a.data_caric)       as data_caric_edit
     , a.data_caric
     , a.cod_documento
     , iter_edit.num(a.caricati, 0)       as caricati_edit
     , iter_edit.num(a.invariati, 0)      as invariati_edit
     , iter_edit.num(a.da_analizzare, 0)  as da_analizzare_edit
     , iter_edit.num(a.importati_aimp, 0) as importati_aimp_edit
     , iter_edit.num(a.chiusi_forzat, 0)  as chiusi_forzat_edit
     , decode (a.stato
              , 'A', 'annullato'
              , 'C', 'chiuso'
              , 'E', 'in lavor.'
              , 'I', 'interrotto'
              , '')   as stato
     , b.ragione_01                    as distributore
  from coimacts a
     , coimdist b 
 where 1 = 1
   and b.cod_distr (+) = a.cod_distr
$where_last
$where_word
order by b.ragione_01, a.data_caric desc
       </querytext>
    </partialquery>

</queryset>
