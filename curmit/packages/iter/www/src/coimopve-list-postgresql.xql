<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_opve">
       <querytext>
select cod_opve
     , cod_enve
     , cognome
     , nome
     , matricola
     , case stato
       when '0' then 'Attivo'
       when '1' then 'Non attivo'
       else ''
       end as desc_stato
  from coimopve
 where 1 = 1
   and cod_enve = :cod_enve
$where_last
$where_word
order by cod_opve
       </querytext>
    </partialquery>

    <fullquery name="sel_enve">
       <querytext>
                 select ragione_01||' '||coalesce(ragione_02,'') as nome_enve
                   from coimenve
                  where cod_enve = :cod_enve
       </querytext>
    </fullquery>

</queryset>
