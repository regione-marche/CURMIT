<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_oper">
       <querytext>
select cod_operazione
     , descr_operazione
  from coimoper
 where 1 = 1
 order by upper(descr_operazione), cod_operazione
       </querytext>
    </partialquery>
</queryset>
