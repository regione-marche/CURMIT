<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_tp_pag">
       <querytext>
select cod_tipo_pag
     , descrizione
     , ordinamento
  from coimtp_pag
 where 1 = 1
$where_last
order by ordinamento
       </querytext>
    </partialquery>

</queryset>
