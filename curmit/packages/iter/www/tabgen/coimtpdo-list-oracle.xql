<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_tpdo">
       <querytext>
select cod_tpdo
     , descrizione as descr_tpdo
  from coimtpdo
 where 1 = 1
$where_last
$where_word
order by upper(descrizione)
       </querytext>
    </partialquery>

</queryset>
