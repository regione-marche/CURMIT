<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_qrar">
       <querytext>
select a.cod_area
     , a.cod_qua
     , Nvl(b.descrizione, '')  as descrizione 
     , b.cod_comune
     , c.denominazione  as comune
  from coimqrar a 
     , coimcqua b
     , coimcomu c
 where 1 = 1
   and a.cod_area       = :cod_area
   and b.cod_qua    (+) = a.cod_qua
   and c.cod_comune (+) = a.cod_comune 
$where_last
$where_word
order by upper(b.descrizione), a.cod_qua

       </querytext>
    </partialquery>

    <partialquery name="del_qrar">
       <querytext>
                delete
                  from coimqrar
                 where cod_area  = :cod_area
                   and cod_qua   = :qua_canc
       </querytext>
    </partialquery>

</queryset>
