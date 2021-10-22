<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_todo">
       <querytext>
select a.cod_todo
     , a.cod_impianto
     , a.cod_cimp_dimp
     , b.descrizione as desc_tipologia
     , a.tipologia
     , case 
         when a.flag_evasione = 'E' then 'Evaso'
         when a.flag_evasione = 'N' then 'Non evaso'
         when a.flag_evasione = 'A' then 'Annullato'
       end as evasione
     , iter_edit_data(a.data_evasione) as data_evasione_edit
     , iter_edit_data(a.data_scadenza) as data_scadenza_edit
     , substr(a.note,1,40) as note
  from coimtodo a
left outer join coimtpdo b on  b.cod_tpdo = a.tipologia
 where 1 = 1
$where_aimp
$where_last
order by to_number(cod_todo, '99999999') desc
       </querytext>
    </partialquery>

</queryset>
