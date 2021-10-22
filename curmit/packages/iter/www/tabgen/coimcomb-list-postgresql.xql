<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_comb">
       <querytext>
select cod_combustibile
     , descr_comb
     , um
     , case when tipo = 'G' then 'GASSOSO'
            when tipo = 'L' then 'LIQUIDO'
            when tipo = 'S' then 'SOLIDO'
	    when tipo = 'A' then 'ALTRO'
	    end as tipo
  from coimcomb
 where 1 = 1
$where_last
order by upper(descr_comb), cod_combustibile
       </querytext>
    </partialquery>

</queryset>
