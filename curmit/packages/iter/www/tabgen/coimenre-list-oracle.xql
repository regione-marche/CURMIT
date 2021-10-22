<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_enre">
       <querytext>
select a.cod_enre
     , a.denominazione
  from coimenre a
 where 1 = 1
$where_last
$where_word
order by cod_enre
       </querytext>
    </partialquery>

</queryset>
