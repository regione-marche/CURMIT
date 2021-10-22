<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_funz">
       <querytext>
select nome_funz as nome_funz_prog
     , tipo_funz
     , dett_funz
  from coimfunz
 where 1 = 1
$where_last
$where_word
order by dett_funz
       </querytext>
    </partialquery>

</queryset>
