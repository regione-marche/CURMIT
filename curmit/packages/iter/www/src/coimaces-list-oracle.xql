<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_aces">
       <querytext>
select a.cod_aces
     , a.cod_aces_est
     , a.cod_acts
     , Nvl(a.cognome, '') ||' '||Nvl(a.nome, '') as nominativo
     , Nvl(a.indirizzo, '')||' '||Nvl(a.numero, '') as indirizzo_num
     , a.indirizzo
     , a.cognome
     , a.comune
     , a.provincia
     , a.cod_combustibile
     , decode (a.stato_01
              ,'I', 'Invariato su catasto'
              ,'D', 'Da analizzare'
              ,'E', 'Gi&agrave; segnalato'
              ,'S', 'Record scartato'
              ,'P', 'Caricato su catasto'
              ,'V', 'Variato su catasto'
              ,''
              ) as stato
     , a.stato_01
     , b.descr_comb        as descr_comb
  from coimaces a
     , coimacts c
     , coimcomb b 
 where 1 = 1
   and c.stato                = :stato_acts
   and b.cod_combustibile (+) = a.cod_combustibile
   and c.cod_acts             = a.cod_acts
$where_last
$where_word
$where_cod_aces
$where_cod_acts
$where_nat_giur
$where_cod_comb
$where_stato
$where_via
$where_comune
$where_cognome
order by a.comune, a.indirizzo, a.cognome, a.cod_aces
       </querytext>
    </partialquery>


    <partialquery name="sel_comu">
       <querytext>
select denominazione  as denom_comune
  from coimcomu
 where cod_comune = :f_comune

       </querytext>
    </partialquery>
</queryset>
