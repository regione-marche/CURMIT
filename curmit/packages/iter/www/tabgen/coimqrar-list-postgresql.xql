<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_qrar">
       <querytext>
select a.cod_area
     , a.cod_qua
     , coalesce (b.descrizione, '')  as descrizione 
     , b.cod_comune
     , c.denominazione  as comune
  from coimqrar a left outer join
       coimcqua b
    on b.cod_qua = a.cod_qua
                  left outer join 
       coimcomu c
    on c.cod_comune  = a.cod_comune 
 where 1 = 1
   and a.cod_area = :cod_area
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
