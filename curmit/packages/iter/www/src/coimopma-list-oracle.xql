<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_opma">
       <querytext>
select cod_opma
     , cod_manutentore
     , cognome
     , nome
     , matricola
      ,decode (stato
              , '0', 'Attivo'
              , '1', 'Non attivo'
              , '')   as desc_stato
  from coimopma
 where 1 = 1
   and cod_manutentore = :cod_manutentore
$where_last
$where_word
order by cod_opma
       </querytext>
    </partialquery>

    <fullquery name="sel_manu">
       <querytext>
                 select ragione_01||' '||nvl(ragione_02,'') as nome_manu
                   from coimmanu
                  where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

</queryset>
