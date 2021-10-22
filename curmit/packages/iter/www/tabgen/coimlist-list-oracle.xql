<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_tari">
       <querytext>
select cod_listino
     , descrizione 
  from coimlist
order by cod_listino
       </querytext>
    </partialquery>

</queryset>
