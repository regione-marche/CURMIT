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

    <fullquery name="sel_aimp_si_viae">
       <querytext>
  select b.cod_impianto_est
       , coalesce(c.descr_topo,'')||' '||coalesce(c.descrizione,'')||' '||coalesce(b.numero,'')||' '||coalesce(b.localita,'')||' '||coalesce(f.denominazione, '') as indir
       , coalesce(initcap(e.cognome),'')||' '||coalesce(initcap(e.nome),'') as nom_resp

--13/11/2013, initcap(e.indirizzo) as indirizzo_resp
--13/11/2013, e.cap                as cap_resp
--13/11/2013, e.comune             as comune_resp
--13/11/2013, e.localita           as localita_resp
--13/11/2013, e.numero             as numero_resp
--13/11/2013, e.provincia          as provincia_resp

       , case                                           -- 13/11/2013
         when g.cod_legale_rapp is not null then        -- 13/11/2013
              'C/O '||initcap(coalesce(g.indirizzo,'')) -- 13/11/2013
         else                                           -- 13/11/2013
              initcap(e.indirizzo)                      -- 13/11/2013
         end                       as indirizzo_resp    -- 13/11/2013

       , case                                           -- 13/11/2013
         when g.cod_legale_rapp is not null then        -- 13/11/2013
              g.cap                                     -- 13/11/2013
         else                                           -- 13/11/2013
              e.cap                                     -- 13/11/2013
         end                       as cap_resp          -- 13/11/2013

       , case                                           -- 13/11/2013
         when g.cod_legale_rapp is not null then        -- 13/11/2013
              g.comune                                  -- 13/11/2013
         else                                           -- 13/11/2013
              e.comune                                  -- 13/11/2013
         end                       as comune_resp       -- 13/11/2013

       , case                                           -- 13/11/2013
         when g.cod_legale_rapp is not null then        -- 13/11/2013
              g.localita                                -- 13/11/2013
         else                                           -- 13/11/2013
              e.localita                                -- 13/11/2013
         end                       as localita_resp     -- 13/11/2013

       , case                                           -- 13/11/2013
         when g.cod_legale_rapp is not null then        -- 13/11/2013
              null                                      -- 13/11/2013
         else                                           -- 13/11/2013
              e.numero                                  -- 13/11/2013
         end                       as numero_resp       -- 13/11/2013

       , case                                           -- 13/11/2013
         when g.cod_legale_rapp is not null then        -- 13/11/2013
              g.provincia                               -- 13/11/2013
         else                                           -- 13/11/2013
              e.provincia                               -- 13/11/2013
         end                       as provincia_resp    -- 13/11/2013

       , e.cod_cittadino

    from coimaimp b
    left outer join coimviae c on c.cod_via       = b.cod_via
                              and c.cod_comune    = b.cod_comune
    left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
    left outer join coimcomu f on f.cod_comune    = b.cod_comune
    left outer join coimmanu g on g.cod_legale_rapp = b.cod_responsabile -- 13/11/2013
                              and b.flag_resp       = 'T'                -- 13/11/2013
                              and :flag_stp_presso_terzo_resp = 'T'      -- 13/11/2013

   where 1 = 1
  $where_comune
  $where_stato
  $where_escludi
  $where_da_imp
  $where_a_imp
order by cod_impianto_est
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_no_viae">
       <querytext>
  select b.cod_impianto_est
       , coalesce(b.toponimo,'')||' '||coalesce(b.indirizzo,'')||' '||coalesce(b.numero,'')||' '||coalesce(b.localita,'')||' '||coalesce(f.denominazione, '') as indir
       , coalesce(initcap(e.cognome),'')||' '||coalesce(initcap(e.nome),'') as nom_resp

--13/11/2013, initcap(e.indirizzo) as indirizzo_resp
--13/11/2013, e.cap                as cap_resp
--13/11/2013, e.comune             as comune_resp
--13/11/2013, e.localita           as localita_resp
--13/11/2013, e.numero             as numero_resp
--13/11/2013, e.provincia          as provincia_resp

       , case                                           -- 13/11/2013
         when g.cod_legale_rapp is not null then        -- 13/11/2013
              'C/O '||initcap(coalesce(g.indirizzo,'')) -- 13/11/2013
         else                                           -- 13/11/2013
              initcap(e.indirizzo)                      -- 13/11/2013
         end                       as indirizzo_resp    -- 13/11/2013

       , case                                           -- 13/11/2013
         when g.cod_legale_rapp is not null then        -- 13/11/2013
              g.cap                                     -- 13/11/2013
         else                                           -- 13/11/2013
              e.cap                                     -- 13/11/2013
         end                       as cap_resp          -- 13/11/2013

       , case                                           -- 13/11/2013
         when g.cod_legale_rapp is not null then        -- 13/11/2013
              g.comune                                  -- 13/11/2013
         else                                           -- 13/11/2013
              e.comune                                  -- 13/11/2013
         end                       as comune_resp       -- 13/11/2013

       , case                                           -- 13/11/2013
         when g.cod_legale_rapp is not null then        -- 13/11/2013
              g.localita                                -- 13/11/2013
         else                                           -- 13/11/2013
              e.localita                                -- 13/11/2013
         end                       as localita_resp     -- 13/11/2013

       , case                                           -- 13/11/2013
         when g.cod_legale_rapp is not null then        -- 13/11/2013
              null                                      -- 13/11/2013
         else                                           -- 13/11/2013
              e.numero                                  -- 13/11/2013
         end                       as numero_resp       -- 13/11/2013

       , case                                           -- 13/11/2013
         when g.cod_legale_rapp is not null then        -- 13/11/2013
              g.provincia                               -- 13/11/2013
         else                                           -- 13/11/2013
              e.provincia                               -- 13/11/2013
         end                       as provincia_resp    -- 13/11/2013

       , e.cod_cittadino
    from coimaimp b
    left outer join coimcitt e on e.cod_cittadino   = b.cod_responsabile
    left outer join coimcomu f on f.cod_comune      = b.cod_comune
    left outer join coimmanu g on g.cod_legale_rapp = b.cod_responsabile -- 13/11/2013
                              and b.flag_resp       = 'T'                -- 13/11/2013
                              and :flag_stp_presso_terzo_resp = 'T'      -- 13/11/2013
   where 1 = 1
  $where_comune
  $where_stato
  $where_escludi
  $where_da_imp
  $where_a_imp
order by cod_impianto_est
       </querytext>
    </fullquery>

    <fullquery name="sel_conta_aimp_si_viae">
       <querytext>
  select count(distinct(b.cod_impianto_est)) as conta_inco
    from coimaimp b
    left outer join coimviae c on c.cod_via       = b.cod_via
                              and c.cod_comune    = b.cod_comune
    left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
    left outer join coimcomu f on f.cod_comune    = b.cod_comune
   where 1 = 1
  $where_comune
  $where_stato
  $where_escludi
  $where_da_imp
  $where_a_imp
       </querytext>
    </fullquery>

    <fullquery name="sel_conta_aimp_no_viae">
       <querytext>
  select count(distinct(b.cod_impianto_est)) as conta_inco
    from coimaimp b
    left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
    left outer join coimcomu f on f.cod_comune    = b.cod_comune
   where 1 = 1
  $where_comune
  $where_stato
  $where_escludi
  $where_da_imp
  $where_a_imp
       </querytext>
    </fullquery>

</queryset>
