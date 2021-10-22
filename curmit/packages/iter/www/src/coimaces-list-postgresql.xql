<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_aces">
       <querytext>
select a.cod_aces
     , a.cod_aces_est
     , a.cod_acts
     , coalesce(a.cognome, '') ||' '||coalesce(a.nome, '') as nominativo
     , coalesce(a.indirizzo, '')||' '||coalesce(a.numero, '') as indirizzo_num
     , a.indirizzo
     , a.cognome
     , a.comune
     , a.provincia
     , a.cod_combustibile
     , case a.stato_01
       when 'I' then 'Invariato su catasto'
       when 'D' then 'Da analizzare'
       when 'E' then 'Gi&agrave; segnalato'
       when 'S' then 'Record scartato'
       when 'P' then 'Caricato su catasto'
       when 'V' then 'Variato su catasto'
       else ''
       end as stato
     , a.stato_01
     , b.descr_comb        as descr_comb
  from coimaces a
       inner join coimacts c on c.cod_acts = a.cod_acts
  left outer join coimcomb b on b.cod_combustibile = a.cod_combustibile
 where 1 = 1
   and c.stato = :stato_acts
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
