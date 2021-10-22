<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_tano">
       <querytext>
select cod_tano
     , descr_breve
     , case
         when flag_scatenante = 'T'
         then 'S&igrave'
         else 'No'
       end as flag_scatenante
  from coimtano
 where 1 = 1
$where_last
$where_word
order by cod_tano
       </querytext>
    </partialquery>

</queryset>
