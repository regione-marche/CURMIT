<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_tppt">
       <querytext>
select cod_tppt
     , descr
     , descr_est
     , progressivo
  from coimtppt
 where 1 = 1
$where_last
order by upper(descr)
       </querytext>
    </partialquery>

</queryset>
