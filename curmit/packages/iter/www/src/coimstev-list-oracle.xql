<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

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
select * 
  from (
   select /* FIRST_ROWS */ 
         b.cod_impianto_est
       , nvl(c.descr_topo,'')||' '||nvl(c.descrizione,'')||' '||nvl(b.numero,'')||' '||nvl(b.localita,'')||' '||nvl(f.denominazione, '') as indir
       , nvl(initcap(e.cognome),'')||' '||nvl(initcap(e.nome),'') as nom_resp
       , initcap(e.indirizzo) as indirizzo_resp
       , e.cap as cap_resp
       , e.comune as comune_resp
       , e.localita as localita_resp
       , e.numero as numero_resp
       , e.provincia as provincia_resp
       , e.cod_cittadino
    from coiminco a
       , coimaimp b
       , coimopve d
       , coimviae c
       , coimcitt e
       , coimcomu f
   where 1=1
     and b.cod_impianto      = a.cod_impianto
     and d.cod_opve      (+) = a.cod_opve
     and c.cod_via       (+) = b.cod_via
     and c.cod_comune    (+) = b.cod_comune
     and e.cod_cittadino (+) = b.cod_responsabile
     and f.cod_comune    (+) = b.cod_comune
     and a.stato             = '8'
     and a.cod_cinc          = :cod_cinc
  $where_anno_inst_da
  $where_anno_inst_a
  $where_comb
  $where_enve
  $where_inco
  $where_data
  $where_codice
  $where_tecn
  $where_comune
  $where_via
  $where_tipo_estr
order by a.cod_inco
)
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_no_viae">
       <querytext>
select * 
  from (
   select /* FIRST_ROWS */ 
         b.cod_impianto_est
       , nvl(b.toponimo,'')||' '||nvl(b.indirizzo,'')||' '||nvl(b.numero,'')||' '||nvl(b.localita,'')||' '||nvl(f.denominazione, '') as indir
       , nvl(initcap(e.cognome),'')||' '||nvl(initcap(e.nome),'') as nom_resp
       , initcap(e.indirizzo) as indirizzo_resp
       , e.cap as cap_resp
       , e.comune as comune_resp
       , e.localita as localita_resp
       , e.numero as numero_resp
       , e.provincia as provincia_resp
       , e.cod_cittadino
    from coiminco a
       , coimaimp b
       , coimopve d
       , coimcitt e
       , coimcomu f
   where 1=1
     and b.cod_impianto      = a.cod_impianto
     and d.cod_opve      (+) = a.cod_opve
     and e.cod_cittadino (+) = b.cod_responsabile
     and f.cod_comune    (+) = b.cod_comune
     and a.stato             = '8'
     and a.cod_cinc          = :cod_cinc
  $where_anno_inst_da
  $where_anno_inst_a
  $where_comb
  $where_enve
  $where_inco
  $where_data
  $where_codice
  $where_tecn
  $where_comune
  $where_tipo_estr
order by a.cod_inco
)
       </querytext>
    </fullquery>


    <fullquery name="sel_conta_inco_si_viae">
       <querytext>
  select iter_edit.num(count(*),0) as conta_inco
    from coiminco a
       , coimaimp b
       , coimopve d
       , coimviae c
       , coimcitt e
   where 1=1
     and b.cod_impianto      = a.cod_impianto
     and d.cod_opve      (+) = a.cod_opve
     and c.cod_via       (+) = b.cod_via
     and c.cod_comune    (+) = b.cod_comune
     and e.cod_cittadino (+) = b.cod_responsabile
     and a.stato    = '8'
     and a.cod_cinc = :cod_cinc
  $where_anno_inst_da
  $where_anno_inst_a
  $where_comb
  $where_enve
  $where_inco
  $where_data
  $where_codice
  $where_tecn
  $where_comune
  $where_via
  $where_tipo_estr
       </querytext>
    </fullquery>

    <fullquery name="sel_conta_inco_no_viae">
       <querytext>
  select iter_edit.num(count(*),0) as conta_inco
    from coiminco a
       , coimaimp b
       , coimopve d
       , coimcitt e
   where 1=1
     and b.cod_impianto      = a.cod_impianto
     and d.cod_opve      (+) = a.cod_opve
     and e.cod_cittadino (+) = b.cod_responsabile
     and a.stato    = '8'
     and a.cod_cinc = :cod_cinc
  $where_anno_inst_da
  $where_anno_inst_a
  $where_comb
  $where_enve
  $where_inco
  $where_data
  $where_codice
  $where_tecn
  $where_comune
  $where_tipo_estr
       </querytext>
    </fullquery>

</queryset>
