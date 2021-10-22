<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_flre">
       <querytext>
select cod_flre
     , sigla
  from coimflre
 where 1 = 1
$where_last
order by upper(sigla), cod_flre
       </querytext>
    </partialquery>

</queryset>
