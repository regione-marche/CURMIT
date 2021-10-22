<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_viar">
       <querytext>
select a.cod_area
     , a.cod_comune
     , a.cod_via
     , a.civico_iniz
     , a.civico_fine
     , b.denominazione as comune
     , c.descrizione   as descrizione
     , coalesce(c.descr_topo, '') || ' ' || coalesce(c.descrizione, '') as indirizzo
  from coimviar a
  left outer join coimcomu b on b.cod_comune = a.cod_comune
  left outer join coimviae c on c.cod_via    = a.cod_via 
 where 1 = 1
   and a.cod_area = :cod_area
$where_last
$where_word
order by b.denominazione, c.descrizione, a.cod_via
       </querytext>
    </partialquery>

</queryset>
