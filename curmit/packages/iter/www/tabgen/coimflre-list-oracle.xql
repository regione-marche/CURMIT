<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_comb">
       <querytext>
select cod_combustibile
     , descr_comb
  from coimcomb
 where 1 = 1
$where_last
order by upper(descr_comb), cod_combustibile
       </querytext>
    </partialquery>

</queryset>
