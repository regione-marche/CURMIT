<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_inco_si_viae">
       <querytext>
select nvl(iter_edit.data(a.data_verifica),'&nbsp;') as data_verifica
     , decode (a.esito
       , 'P' , 'Positivo'
       , 'N' , 'Negativo'
       , '&nbsp;') as desc_esito
     , nvl(a.ora_verifica,'&nbsp;') as ora_verifica
     , b.cognome||' '||nvl(b.nome,'') as nome_opve
     , c.ragione_01
     , d.cod_impianto_est
     , e.cognome||' '||nvl(e.nome,'') as nome_resp
     , nvl(e.telefono,'&nbsp;') as telefono
     , nvl(e.cellulare,'&nbsp;') as cellulare
     , nvl(f.descr_topo,'') ||' '||nvl(f.descr_estesa,'')||' '||nvl(d.numero,'')||' '||nvl(d.esponente, '') as indir
     , nvl(g.denominazione,'&nbsp;') as denom_comune
     , nvl(a.note,'&nbsp;') as note
     , h.descr_inst as stato_inco
 from coiminco a
    , coimopve b
    , coimenve c
    , coimaimp d
    , coimcitt e
    , coimviae f
    , coimcomu g
    , coiminst h 
 where a.cod_cinc = :cod_cinc
$where_stato
$where_data_app
$where_data_spe
   and b.cod_opve $opve_join_ora = a.cod_opve
   and c.cod_enve $enve_join_ora = b.cod_enve
   and d.cod_impianto = a.cod_impianto
   $where_comune
   and e.cod_cittadino (+) = d.cod_responsabile
   and f.cod_via       (+) = d.cod_via
   and f.cod_comune    (+) = d.cod_comune
   and g.cod_comune    (+) = d.cod_comune
   and h.cod_inst          = a.stato
$where_opve
$where_enve
order by c.ragione_01, nome_opve, a.data_verifica
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_no_viae">
       <querytext>
select nvl(iter_edit.data(a.data_verifica),'&nbsp;') as data_verifica
     , decode (a.esito
       , 'P' , 'Positivo'
       , 'N' , 'Negativo'
       , '&nbsp;') as desc_esito
     , nvl(a.ora_verifica,'&nbsp;') as ora_verifica
     , b.cognome||' '||nvl(b.nome,'') as nome_opve
     , c.ragione_01
     , d.cod_impianto_est
     , e.cognome||' '||nvl(e.nome,'') as nome_resp
     , nvl(e.telefono,'&nbsp;') as telefono
     , nvl(e.cellulare,'&nbsp;') as cellulare
     , nvl(d.toponimo,'')||' '||nvl(d.indirizzo,'')||' '||nvl(d.numero,'')||' '||nvl(d.esponente, '') as indir
     , nvl(g.denominazione,'&nbsp;') as denom_comune
     , nvl(a.note,'&nbsp;') as note
     , h.descr_inst as stato_inco
 from coiminco a
    , coimopve b
    , coimenve c
    , coimaimp d
    , coimcitt e
    , coimcomu g
    , coiminst h
    , coimcmar i 
 where a.cod_cinc = :cod_cinc
 $where_stato
 $where_data_app
 $where_data_spe
   and b.cod_opve $opve_join_ora = a.cod_opve
   and c.cod_enve $enve_join_ora = b.cod_enve
   and d.cod_impianto = a.cod_impianto
   $where_comune
   and e.cod_cittadino (+) = d.cod_responsabile
   and g.cod_comune    (+) = d.cod_comune
   and h.cod_inst          = a.stato
$where_opve
$where_enve
   and i.cod_comune    (+) = g.cod_comune
$where_area
order by c.ragione_01, nome_opve, a.data_verifica
       </querytext>
    </fullquery>

    <fullquery name="sel_opve">
       <querytext>
        select a.cognome||' '||nvl(a.nome,'') as nome_opve
             , b.ragione_01
          from coimopve a
             , coimenve b
         where a.cod_opve = :cod_opve
           and b.cod_enve = a.cod_enve
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
       select descrizione as desc_cinc
         from coimcinc
        where cod_cinc = :cod_cinc
       </querytext>
    </fullquery>

    <fullquery name="sel_enve">
       <querytext>
        select ragione_01
          from coimenve
         where cod_enve = :cod_enve
       </querytext>
    </fullquery>

    <fullquery name="sel_desc_stato">
       <querytext>
        select descr_inst as desc_stato
          from coiminst
         where cod_inst = :flag_stato_appuntamento
       </querytext>
    </fullquery>

    <fullquery name="sel_desc_comu">
       <querytext>
        select denominazione as desc_comune
          from coimcomu
         where cod_comune = :cod_comune
       </querytext>
    </fullquery>

</queryset>
