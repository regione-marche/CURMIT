<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_rgen">
       <querytext>
select cod_rgen
     , descrizione
  from coimrgen
 where 1 = 1
$where_last
$where_word
order by cod_rgen
       </querytext>
    </partialquery>

</queryset>
