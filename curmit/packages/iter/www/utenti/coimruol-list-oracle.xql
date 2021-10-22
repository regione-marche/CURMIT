<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_ruol">
       <querytext>
select id_ruolo
     , descrizione
  from coimruol
 where 1 = 1
$where_last
$where_word
order by descrizione
       </querytext>
    </partialquery>

</queryset>
