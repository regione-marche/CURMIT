<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_cinc_count">
       <querytext>
                   select count(*) as conta
                     from coimcinc
                    where stato = '1'
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc">
       <querytext>
                   select cod_cinc
                        , descrizione as desc_camp
                     from coimcinc
                    where stato = '1'
       </querytext>
    </fullquery>

    <fullquery name="get_desc_prov">
       <querytext>
                   select initcap(denominazione) as desc_prov
                     from coimprov
                    where cod_provincia = :cod_prov
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_si_viae">
       <querytext>
  select b.cod_impianto_est
       , b.flag_tipo_impianto
       , coalesce(c.descr_topo,'')||' '||coalesce(c.descrizione,'')||' '||coalesce(b.numero,'')||' '||coalesce(b.localita,'')||' '||coalesce(f.denominazione, '') as indir
       , coalesce(initcap(e.cognome),'')||' '||coalesce(initcap(e.nome),'') as nom_resp
       , initcap(e.indirizzo) as indirizzo_resp
       , e.cap as cap_resp
       , e.comune as comune_resp
       , e.localita as localita_resp
       , e.numero as numero_resp
       , e.provincia as provincia_resp
       , e.cod_cittadino
    from coimcimp a
         inner join coimaimp b on b.cod_impianto  = a.cod_impianto
         inner join coimgend h  on h.gen_prog = a.gen_prog and h.cod_impianto = a.cod_impianto 
    left outer join coiminco i on a.cod_inco      = i.cod_inco
    left outer join coimopve d on d.cod_opve      = a.cod_opve
    left outer join coimviae c on c.cod_via       = b.cod_via
                              and c.cod_comune    = b.cod_comune
    left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
    left outer join coimcomu f on f.cod_comune    = b.cod_comune
   where i.cod_documento_02 is null
  $where_anno_inst_da
  $where_anno_inst_a
  $where_comb
  $where_enve
  $where_codice
  $where_tecn
  $where_comune
  $where_via
  $where_tipo_estr
  $where_flag_pericolosita
  $where_esito_verifica
  $where_da_data_controllo
  $where_a_data_controllo
  $where_da_potenza
  $where_a_potenza
  $where_tipo_imp
  $where_cod_tano 
order by a.cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_no_viae">
       <querytext>
  select b.cod_impianto_est
       , b.flag_tipo_impianto
       , coalesce(b.toponimo,'')||' '||coalesce(b.indirizzo,'')||' '||coalesce(b.numero,'')||' '||coalesce(b.localita,'')||' '||coalesce(f.denominazione, '') as indir
       , coalesce(initcap(e.cognome),'')||' '||coalesce(initcap(e.nome),'') as nom_resp
       , initcap(e.indirizzo) as indirizzo_resp
       , e.cap as cap_resp
       , e.comune as comune_resp
       , e.localita as localita_resp
       , e.numero as numero_resp
       , e.provincia as provincia_resp
       , e.cod_cittadino
    from coimcimp a
    left outer join coimopve d on d.cod_opve      = a.cod_opve
         inner join coimaimp b on b.cod_impianto  = a.cod_impianto
         inner join coimgend h  on h.gen_prog = a.gen_prog and h.cod_impianto = a.cod_impianto 
   left outer join coiminco i on a.cod_inco      = i.cod_inco
    left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
    left outer join coimcomu f on f.cod_comune    = b.cod_comune
   where i.cod_documento_02 is null
  $where_anno_inst_da
  $where_anno_inst_a
  $where_comb
  $where_enve
  $where_codice
  $where_tecn
  $where_comune
  $where_flag_pericolosita
  $where_esito_verifica
  $where_da_data_controllo
  $where_a_data_controllo
  $where_da_potenza
  $where_a_potenza
  $where_tipo_imp
  $where_cod_tano 
order by a.cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_conta_inco_si_viae">
       <querytext>
  select iter_edit_num(count(*),0) as conta_inco
    from coimcimp a
         inner join coimaimp b on b.cod_impianto  = a.cod_impianto
         inner join coimgend h  on h.gen_prog = a.gen_prog and h.cod_impianto = a.cod_impianto 
     left outer join coiminco i on a.cod_inco      = i.cod_inco
    left outer join coimopve d on d.cod_opve      = a.cod_opve
    left outer join coimviae c on c.cod_via       = b.cod_via
                              and c.cod_comune    = b.cod_comune
    left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
   where i.cod_documento_02 is null
  $where_anno_inst_da
  $where_anno_inst_a
  $where_comb
  $where_enve
  $where_codice
  $where_tecn
  $where_comune
  $where_via
  $where_flag_pericolosita
  $where_esito_verifica
  $where_da_data_controllo
  $where_a_data_controllo
  $where_da_potenza
  $where_a_potenza
  $where_tipo_imp
  $where_cod_tano 
  </querytext>
    </fullquery>

    <fullquery name="sel_conta_inco_no_viae">
       <querytext>
  select iter_edit_num(count(*),0) as conta_inco
    from coimcimp a
    left outer join coimopve d on d.cod_opve   = a.cod_opve
         inner join coimaimp b on b.cod_impianto = a.cod_impianto
         inner join coimgend h  on h.gen_prog = a.gen_prog and h.cod_impianto = a.cod_impianto 
   left outer join coiminco i on a.cod_inco      = i.cod_inco
    left outer join coimcitt e on e.cod_cittadino   = b.cod_responsabile
   where i.cod_documento_02 is null
  $where_anno_inst_da
  $where_anno_inst_a
  $where_comb
  $where_enve
  $where_codice
  $where_tecn
  $where_comune
  $where_tipo_estr
  $where_flag_pericolosita
  $where_esito_verifica
  $where_da_data_controllo
  $where_a_data_controllo
  $where_da_potenza
  $where_a_potenza
  $where_tipo_imp
  $where_cod_tano 
  </querytext>
    </fullquery>

</queryset>
