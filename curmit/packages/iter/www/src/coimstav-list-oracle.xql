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

--13/11/2013, initcap(e.indirizzo) as indirizzo_resp
--13/11/2013, e.cap                as cap_resp
--13/11/2013, e.comune             as comune_resp
--13/11/2013, e.localita           as localita_resp
--13/11/2013, e.numero             as numero_resp
--13/11/2013, e.provincia          as provincia_resp

       , case                                        -- 13/11/2013
         when g.cod_legale_rapp is not null then     -- 13/11/2013
              'C/O '||initcap(nvl(g.indirizzo,''))   -- 13/11/2013
         else                                        -- 13/11/2013
              initcap(e.indirizzo)                   -- 13/11/2013
         end                       as indirizzo_resp -- 13/11/2013

       , case                                        -- 13/11/2013
         when g.cod_legale_rapp is not null then     -- 13/11/2013
              g.cap                                  -- 13/11/2013
         else                                        -- 13/11/2013
              e.cap                                  -- 13/11/2013
         end                       as cap_resp       -- 13/11/2013

       , case                                        -- 13/11/2013
         when g.cod_legale_rapp is not null then     -- 13/11/2013
              g.comune                               -- 13/11/2013
         else                                        -- 13/11/2013
              e.comune                               -- 13/11/2013
         end                       as comune_resp    -- 13/11/2013

       , case                                        -- 13/11/2013
         when g.cod_legale_rapp is not null then     -- 13/11/2013
              g.localita                             -- 13/11/2013
         else                                        -- 13/11/2013
              e.localita                             -- 13/11/2013
         end                       as localita_resp  -- 13/11/2013

       , case                                        -- 13/11/2013
         when g.cod_legale_rapp is not null then     -- 13/11/2013
              null                                   -- 13/11/2013
         else                                        -- 13/11/2013
              e.numero                               -- 13/11/2013
         end                       as numero_resp    -- 13/11/2013

       , case                                        -- 13/11/2013
         when g.cod_legale_rapp is not null then     -- 13/11/2013
              g.provincia                            -- 13/11/2013
         else                                        -- 13/11/2013
              e.provincia                            -- 13/11/2013
         end                       as provincia_resp -- 13/11/2013

       , e.cod_cittadino

    from coiminco a
       , coimaimp b

    left outer join coimmanu g on g.cod_legale_rapp = b.cod_responsabile -- 13/11/2013
                              and b.flag_resp       = 'T'                -- 13/11/2013
                              and :flag_stp_presso_terzo_resp = 'T'      -- 13/11/2013
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
     and a.stato             = '2'
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
  $where_cod_area
order by a.cod_inco
)
$limit_ora
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

--13/11/2013, initcap(e.indirizzo) as indirizzo_resp
--13/11/2013, e.cap                as cap_resp
--13/11/2013, e.comune             as comune_resp
--13/11/2013, e.localita           as localita_resp
--13/11/2013, e.numero             as numero_resp
--13/11/2013, e.provincia          as provincia_resp

       , case                                        -- 13/11/2013
         when g.cod_legale_rapp is not null then     -- 13/11/2013
              'C/O '||initcap(nvl(g.indirizzo,''))   -- 13/11/2013
         else                                        -- 13/11/2013
              initcap(e.indirizzo)                   -- 13/11/2013
         end                       as indirizzo_resp -- 13/11/2013

       , case                                        -- 13/11/2013
         when g.cod_legale_rapp is not null then     -- 13/11/2013
              g.cap                                  -- 13/11/2013
         else                                        -- 13/11/2013
              e.cap                                  -- 13/11/2013
         end                       as cap_resp       -- 13/11/2013

       , case                                        -- 13/11/2013
         when g.cod_legale_rapp is not null then     -- 13/11/2013
              g.comune                               -- 13/11/2013
         else                                        -- 13/11/2013
              e.comune                               -- 13/11/2013
         end                       as comune_resp    -- 13/11/2013

       , case                                        -- 13/11/2013
         when g.cod_legale_rapp is not null then     -- 13/11/2013
              g.localita                             -- 13/11/2013
         else                                        -- 13/11/2013
              e.localita                             -- 13/11/2013
         end                       as localita_resp  -- 13/11/2013

       , case                                        -- 13/11/2013
         when g.cod_legale_rapp is not null then     -- 13/11/2013
              null                                   -- 13/11/2013
         else                                        -- 13/11/2013
              e.numero                               -- 13/11/2013
         end                       as numero_resp    -- 13/11/2013

       , case                                        -- 13/11/2013
         when g.cod_legale_rapp is not null then     -- 13/11/2013
              g.provincia                            -- 13/11/2013
         else                                        -- 13/11/2013
              e.provincia                            -- 13/11/2013
         end                       as provincia_resp -- 13/11/2013

       , e.cod_cittadino
    from coiminco a
       , coimaimp b

    left outer join coimmanu g on g.cod_legale_rapp = b.cod_responsabile -- 13/11/2013
                              and b.flag_resp       = 'T'                -- 13/11/2013
                              and :flag_stp_presso_terzo_resp = 'T'      -- 13/11/2013

       , coimopve d
       , coimcitt e
       , coimcomu f
   where 1=1
     and b.cod_impianto      = a.cod_impianto
     and d.cod_opve      (+) = a.cod_opve
     and e.cod_cittadino (+) = b.cod_responsabile
     and f.cod_comune    (+) = b.cod_comune
     and a.stato             = '2'
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
  $where_cod_area
order by a.cod_inco
)
$limit_ora
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
     and a.stato    = '2'
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
  $where_cod_area
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
     and a.stato    = '2'
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
  $where_cod_area
       </querytext>
    </fullquery>

    <fullquery name="sel_cmar">
       <querytext>
           select cod_comune
             from coimcmar
            where cod_area = :f_cod_area
       </querytext>
    </fullquery>

    <fullquery name="sel_area_tipo_01">
       <querytext>
               select tipo_01
                 from coimarea 
                where cod_area = :f_cod_area
       </querytext>
    </fullquery>


</queryset>
