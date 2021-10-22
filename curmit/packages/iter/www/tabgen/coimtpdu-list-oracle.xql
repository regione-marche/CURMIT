<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_tpdu">
       <querytext>
select cod_tpdu
     , descr_tpdu
  from coimtpdu
 where 1 = 1
$where_last
$where_word
order by upper(descr_tpdu)
       </querytext>
    </partialquery>

</queryset>
