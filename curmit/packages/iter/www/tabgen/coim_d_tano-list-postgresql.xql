<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_d_tano">
       <querytext>
select cod_tano
     , descr_breve
     , case flag_scatenante
         when 'T' then 'S&igrave'
         else 'No'
       end as flag_scatenante
  from coim_d_tano
 where 1 = 1
$where_last
$where_word
order by cod_tano
       </querytext>
    </partialquery>

</queryset>
