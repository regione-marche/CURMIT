<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


    <partialquery name="sel_aimp">
       <querytext>
       select    a.cod_amag           as cod_utenza
               , b.natura_giuridica
               , b.cognome            as cognome_inte
               , b.nome               as nome_inte
               , b.cod_fiscale 
               , b.cod_piva  
               , b.telefono           as telefono_inte
               , b.data_nas           as data_nas_inte
               , b.comune_nas         as comune_nas_inte
               , Nvl (a.toponimo, ' ') ||' '|| Nvl (c.descrizione, ' ') as indirizzo
               , a.numero
               , a.esponente
               , a.scala
               , a.piano 
               , a.interno
               , a.cap
               , a.localita
               , d.denominazione     as comune
               , e.sigla             as provincia
               , a.cod_combustibile  as descr_comb
               , iter_edit.num (a.consumo_annuo, 2) as consumo_annuo
               , a.tariffa
  from coimaimp a
     , coimcitt b
     , coimviae c
     , coimcomu d
     , coimprov e
   where a.cod_amag          > ' '
     and a.cod_distributore  > ' '
     and b.cod_cittadino (+) = a.cod_intestatario
     and c.cod_via       (+) = a.cod_via
     and c.cod_comune    (+) = a.cod_comune
     and d.cod_comune    (+) = a.cod_comune
     and d.cod_provincia (+) = a.cod_provincia
     and e.cod_provincia (+) = a.cod_provincia
order by a.cod_amag

       </querytext>
    </partialquery>

</queryset>
