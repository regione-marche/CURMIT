<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_enrg">
       <querytext>
select a.cod_enre
     , a.cod_rgen
     , coalesce (b.denominazione, '')  as denominazione
  from coimenrg a left outer join
       coimenre b
    on b.cod_enre = a.cod_enre 
 where 1 = 1
   and a.cod_rgen = :cod_rgen
$where_last
$where_word
order by upper(b.denominazione), a.cod_enre
       </querytext>

    </partialquery>
    <partialquery name="del_enrg">
       <querytext>
                delete
                  from coimenrg
                 where cod_enre    = :cod_enre
                   and cod_rgen    = :cod_rgen
       </querytext>
    </partialquery>

</queryset>
