<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_todo">
       <querytext>
select a.cod_todo
     , a.cod_impianto
     , a.cod_cimp_dimp
     , b.descrizione as desc_tipologia
     , a.tipologia
     , decode (a.flag_evasione 
        , 'E', 'Evaso'
        , 'N', 'Non evaso'
        , 'A', 'Annullato'
       ) as evasione
     , iter_edit.data(a.data_evasione) as data_evasione_edit
     , iter_edit.data(a.data_scadenza) as data_scadenza_edit
     , substr(a.note,1,40) as note
  from coimtodo a
     , coimtpdo b
 where 1 = 1
   and b.cod_tpdo = a.tipologia
$where_aimp
$where_last
order by to_number(cod_todo, '99999999') desc
       </querytext>
    </partialquery>

</queryset>
