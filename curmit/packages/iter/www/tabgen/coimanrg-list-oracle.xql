<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_anrg">
       <querytext>
select a.cod_tano
     , a.cod_rgen
     , Nvl(b.descr_breve, '')  as descr_breve
  from coimanrg a 
     , coimtano b
 where 1 = 1
   and a.cod_rgen       = :cod_rgen
   and b.cod_tano   (+) = a.cod_tano 
$where_last
$where_word
order by a.cod_tano
       </querytext>

    </partialquery>
    <partialquery name="del_anrg">
       <querytext>
                delete
                  from coimanrg
                 where cod_tano  = :cod_tano
                   and cod_rgen  = :cod_rgen
       </querytext>
    </partialquery>

</queryset>
