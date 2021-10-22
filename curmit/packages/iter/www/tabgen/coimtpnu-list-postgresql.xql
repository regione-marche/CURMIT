<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_tpnu">
       <querytext>
select cod_tpnu
     , descr
     , descr_est
     , progressivo
  from coimtpnu
 where 1 = 1
$where_last
order by upper(descr)
       </querytext>
    </partialquery>

</queryset>
