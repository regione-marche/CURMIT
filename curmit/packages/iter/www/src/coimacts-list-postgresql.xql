<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_acts">
       <querytext>
select a.cod_acts
     , iter_edit_data(a.data_caric)       as data_caric_edit
     , a.data_caric
     , a.cod_documento
     , iter_edit_num(a.caricati, 0)       as caricati_edit
     , iter_edit_num(a.invariati, 0)      as invariati_edit
     , iter_edit_num(a.da_analizzare, 0)  as da_analizzare_edit
     , iter_edit_num(a.importati_aimp, 0) as importati_aimp_edit
     , iter_edit_num(a.chiusi_forzat, 0)  as chiusi_forzat_edit
     , case a.stato
       when 'A' then 'annullato'
       when 'C' then 'chiuso'
       when 'E' then 'in lavor.'
       when 'I' then 'interrotto'
       else ''
       end   as stato
     , b.ragione_01                    as distributore
  from coimacts a
  left outer join coimdist b on b.cod_distr = a.cod_distr
 where 1 = 1
$where_last
$where_word
order by b.ragione_01, a.data_caric desc
       </querytext>
    </partialquery>

</queryset>
