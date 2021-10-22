<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_ogge">
       <querytext>
select livello
     , scelta_1
     , scelta_2
     , scelta_3
     , scelta_4
     , tipo
     , descrizione
     , nome_funz as nome_funz_d
  from coimogge
 where 1 = 1
$where_last
$where_word
order by livello, scelta_1, scelta_2, scelta_3, scelta_4
       </querytext>
    </partialquery>

</queryset>
