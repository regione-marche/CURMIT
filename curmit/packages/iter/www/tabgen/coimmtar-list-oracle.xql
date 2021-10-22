<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_mtar">
       <querytext>
select a.cod_area
     , b.descrizione
  from coimmtar a
     , coimarea b
 where a.cod_manutentore = :cod_manutentore
   and b.cod_area        = a.cod_area
$where_last
$where_word
order by b.descrizione
       </querytext>
    </partialquery>

    <partialquery name="del_mtar">
       <querytext>
                delete
                  from coimmtar
                 where cod_area        = :cod_area
                   and cod_manutentore = :manu_canc
       </querytext>
    </partialquery>

</queryset>
