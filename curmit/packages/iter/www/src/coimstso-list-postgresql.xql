<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="get_desc_prov">
       <querytext>
                   select initcap(denominazione) as desc_prov
                     from coimprov
                    where cod_provincia = :cod_prov
       </querytext>
    </fullquery>

    <fullquery name="sel_movi_si_viae">
       <querytext>
  select b.cod_impianto_est
       , coalesce(c.descr_topo,'')||' '||coalesce(c.descrizione,'')||' '||coalesce(b.numero,'')||' '||coalesce(b.localita,'')||' '||coalesce(f.denominazione, '') as indir
       , coalesce(initcap(e.cognome),'')||' '||coalesce(initcap(e.nome),'') as nom_resp
       , initcap(e.indirizzo) as indirizzo_resp
       , e.cap as cap_resp
       , e.comune as comune_resp
       , e.localita as localita_resp
       , e.numero as numero_resp
       , e.provincia as provincia_resp
       , e.cod_cittadino
    from coimmovi a
         inner join coimaimp b on b.cod_impianto  = a.cod_impianto
    left outer join coimviae c on c.cod_via       = b.cod_via
                              and c.cod_comune    = b.cod_comune
    left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
    left outer join coimcomu f on f.cod_comune    = b.cod_comune
   where (flag_pagato <> 'S' or flag_pagato is null)
  $where_importo
  $where_contatore
  $where_id_caus
  $where_scadenza
  $where_comune
group by cod_impianto_est
       , indir
       , nom_resp
       , indirizzo_resp
       , cap_resp
       , comune_resp
       , localita_resp
       , numero_resp
       , provincia_resp
       , cod_cittadino
       </querytext>
    </fullquery>

    <fullquery name="sel_movi_no_viae">
       <querytext>
  select b.cod_impianto_est
       , coalesce(b.toponimo,'')||' '||coalesce(b.indirizzo,'')||' '||coalesce(b.numero,'')||' '||coalesce(b.localita,'')||' '||coalesce(f.denominazione, '') as indir
       , coalesce(initcap(e.cognome),'')||' '||coalesce(initcap(e.nome),'') as nom_resp
       , initcap(e.indirizzo) as indirizzo_resp
       , e.cap as cap_resp
       , e.comune as comune_resp
       , e.localita as localita_resp
       , e.numero as numero_resp
       , e.provincia as provincia_resp
       , e.cod_cittadino
    from coimmovi a
         inner join coimaimp b on b.cod_impianto  = a.cod_impianto
    left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
    left outer join coimcomu f on f.cod_comune    = b.cod_comune
   where (flag_pagato <> 'S' or flag_pagato is null)
  $where_importo
  $where_contatore
  $where_id_caus
  $where_scadenza
  $where_comune
group by cod_impianto_est
       , indir
       , nom_resp
       , indirizzo_resp
       , cap_resp
       , comune_resp
       , localita_resp
       , numero_resp
       , provincia_resp
       , cod_cittadino
       </querytext>
    </fullquery>

    <fullquery name="sel_conta_movi_si_viae">
       <querytext>
  select count(distinct(b.cod_impianto_est)) as conta_inco
    from coimmovi a
         inner join coimaimp b on b.cod_impianto  = a.cod_impianto
    left outer join coimviae c on c.cod_via       = b.cod_via
                              and c.cod_comune    = b.cod_comune
    left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
    left outer join coimcomu f on f.cod_comune    = b.cod_comune
   where (flag_pagato <> 'S' or flag_pagato is null)
  $where_importo
  $where_contatore
  $where_id_caus
  $where_scadenza
  $where_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_conta_movi_no_viae">
       <querytext>
  select count(distinct(b.cod_impianto_est)) as conta_inco
    from coimmovi a
         inner join coimaimp b on b.cod_impianto  = a.cod_impianto
    left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
    left outer join coimcomu f on f.cod_comune    = b.cod_comune
   where (flag_pagato <> 'S' or flag_pagato is null)
  $where_importo
  $where_contatore
  $where_id_caus
  $where_scadenza
  $where_comune
       </querytext>
    </fullquery>

</queryset>
