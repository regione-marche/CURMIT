<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_costi">
       <querytext>
select
    a.cod_impianto
  , a.data_verifica
  , b.cod_impianto_est
  , b.flag_tipo_impianto
  , to_char(a.data_verifica, 'DD/MM/YYYY') as data_verifica_edit
  , c.denominazione
  , coalesce(d.cognome, '') || ' ' || coalesce(d.nome, '') as responsabile
  , e.importo
from
    coiminco a
  , coimaimp b
    left outer join coimcitt d on b.cod_responsabile = d.cod_cittadino
  , coimcomu c
  , coimtari e
  , coimopve f
where
    a.cod_opve = :cod_opve
$where_data_app
and a.stato = '8'
and f.cod_opve = a.cod_opve
and e.tipo_costo = '2'
and e.cod_listino = f.cod_listino
and a.cod_impianto = b.cod_impianto
and b.cod_comune = c.cod_comune
and b.cod_potenza = e.cod_potenza
order by b.flag_tipo_impianto, a.data_verifica, c.denominazione, d.cognome, a.cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_totale">
       <querytext>
select
   sum(e.importo) as totale
from
    coiminco a
  , coimaimp b
    left outer join coimcitt d on b.cod_responsabile = d.cod_cittadino
  , coimcomu c
  , coimtari e
  , coimopve f
where
    a.cod_opve = :cod_opve
$where_data_app
and a.stato = '8'
and f.cod_opve = a.cod_opve
and e.tipo_costo = '2'
and e.cod_listino = f.cod_listino
and a.cod_impianto = b.cod_impianto
and b.cod_comune = c.cod_comune
and b.cod_potenza = e.cod_potenza
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_si_viae">
       <querytext>
select coalesce(iter_edit_data(a.data_verifica),'&nbsp;') as data_verifica
     , case a.esito
       when 'P' then 'Positivo'
       when 'N' then 'Negativo'
       else '&nbsp;'
       end as desc_esito
     , coalesce(a.ora_verifica,'&nbsp;') as ora_verifica
     , coalesce(b.cognome,'')||' '||coalesce(b.nome,'') as nome_opve
     , c.ragione_01
     , d.cod_impianto_est
     , e.cognome||' '||coalesce(e.nome,'') as nome_resp
     , coalesce(e.telefono,'&nbsp;') as telefono
     , coalesce(e.cellulare,'&nbsp;') as cellulare
     , coalesce(f.descr_topo,'')||' '||coalesce(f.descr_estesa,'')||' '||coalesce(d.numero,'')||' '||coalesce(d.esponente, '') as indir
     , coalesce(g.denominazione,'&nbsp;') as denom_comune
     , coalesce(a.note,'&nbsp;') as note
     , h.descr_inst as stato_inco
  from coiminco a
   $opve_join_pos coimopve b on b.cod_opve = a.cod_opve
                                $where_opve
   $enve_join_pos coimenve c on c.cod_enve = b.cod_enve
                                $where_enve
       inner join coimaimp d on d.cod_impianto = a.cod_impianto
                             $where_comune
  left outer join coimcitt e on e.cod_cittadino = d.cod_responsabile
  left outer join coimviae f on f.cod_via       = d.cod_via
                            and f.cod_comune    = d.cod_comune
  left outer join coimcomu g on g.cod_comune    = d.cod_comune
       inner join coiminst h on h.cod_inst      = a.stato
  left outer join coimcmar i on i.cod_comune    = g.cod_comune
                            $where_area
 where a.cod_cinc = :cod_cinc
 $where_stato
 $where_data_app
 $where_data_spe
$order_by
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_no_viae">
       <querytext>
select coalesce(iter_edit_data(a.data_verifica),'&nbsp;') as data_verifica
     , case a.esito
       when 'P' then 'Positivo'
       when 'N' then 'Negativo'
       else '&nbsp;'
       end as desc_esito
     , coalesce(a.ora_verifica,'&nbsp;') as ora_verifica
     , coalesce(b.cognome,'')||' '||coalesce(b.nome,'') as nome_opve
     , c.ragione_01
     , d.cod_impianto_est
     , e.cognome||' '||coalesce(e.nome,'') as nome_resp
     , coalesce(e.telefono,'&nbsp;') as telefono
     , coalesce(e.cellulare,'&nbsp;') as cellulare
     , coalesce(d.toponimo,'')||' '||coalesce(d.indirizzo,'')||' '||coalesce(d.numero,'')||' '||coalesce(d.esponente, '') as indir
     , coalesce(g.denominazione,'&nbsp;') as denom_comune
     , coalesce(a.note,'&nbsp;') as note
     , h.descr_inst as stato_inco
  from coiminco a
   $opve_join_pos coimopve b on b.cod_opve = a.cod_opve
                                $where_opve
   $enve_join_pos coimenve c on c.cod_enve = b.cod_enve
                                $where_enve
       inner join coimaimp d on d.cod_impianto = a.cod_impianto
                             $where_comune
  left outer join coimcitt e on e.cod_cittadino = d.cod_responsabile
  left outer join coimcomu g on g.cod_comune    = d.cod_comune
       inner join coiminst h on h.cod_inst      = a.stato
 where a.cod_cinc = :cod_cinc
 $where_stato
 $where_data_app
 $where_data_spe
$order_by
       </querytext>
    </fullquery>

    <fullquery name="sel_opve">
       <querytext>
        select a.cognome||' '||coalesce(a.nome,'') as nome_opve
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
