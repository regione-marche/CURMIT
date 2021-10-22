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

    from coiminco a
         inner join coimaimp b on b.cod_impianto    = a.cod_impianto
    left outer join coimopve d on d.cod_opve        = a.cod_opve
    left outer join coimviae c on c.cod_via         = b.cod_via
                              and c.cod_comune      = b.cod_comune
    left outer join coimcitt e on e.cod_cittadino   = b.cod_responsabile
    left outer join coimcomu f on f.cod_comune      = b.cod_comune
    left outer join coimmanu g on g.cod_legale_rapp = b.cod_responsabile -- 13/11/2013
                              and b.flag_resp       = 'T'                -- 13/11/2013
                              and :flag_stp_presso_terzo_resp = 'T'      -- 13/11/2013

   where 1=1
     and a.stato    = '2'
     and a.cod_cinc = :cod_cinc
  $where_anno_inst_da
  $where_anno_inst_a
  $where_tipo_imp
  $where_data_verifica
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
  $where_dich
order by a.cod_inco
$limit_pos
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_no_viae">
       <querytext>
  select b.cod_impianto_est
       , b.flag_tipo_impianto
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
    from coiminco a
    left outer join coimopve d on d.cod_opve        = a.cod_opve
         inner join coimaimp b on b.cod_impianto    = a.cod_impianto
    left outer join coimcitt e on e.cod_cittadino   = b.cod_responsabile
    left outer join coimcomu f on f.cod_comune      = b.cod_comune
    left outer join coimmanu g on g.cod_legale_rapp = b.cod_responsabile -- 13/11/2013
                              and b.flag_resp       = 'T'                -- 13/11/2013
                              and :flag_stp_presso_terzo_resp = 'T'      -- 13/11/2013

   where 1=1
     and a.stato    = '2'
     and a.cod_cinc = :cod_cinc
  $where_anno_inst_da
  $where_anno_inst_a
  $whre_tipo_imp
  $where_comb
  $where_enve
  $where_data_verifica
  $where_inco
  $where_data
  $where_codice
  $where_tecn
  $where_comune
  $where_tipo_estr
  $where_cod_area
  $where_dich
order by a.cod_inco
$limit_pos
       </querytext>
    </fullquery>

    <fullquery name="sel_conta_inco_si_viae">
       <querytext>
  select iter_edit_num(count(*),0) as conta_inco
    from coiminco a
         inner join coimaimp b on b.cod_impianto  = a.cod_impianto
    left outer join coimopve d on d.cod_opve      = a.cod_opve
    left outer join coimviae c on c.cod_via       = b.cod_via
                              and c.cod_comune    = b.cod_comune
    left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
   where 1=1
     and a.stato    = '2'
     and a.cod_cinc = :cod_cinc
  $where_anno_inst_da
  $where_anno_inst_a
  $where_tipo_imp
  $where_data_verifica
  $where_comb
  $where_enve
  $where_inco
  $where_data_verifica
  $where_data
  $where_codice
  $where_tecn
  $where_comune
  $where_via
  $where_tipo_estr
  $where_cod_area
  $where_dich
       </querytext>
    </fullquery>

    <fullquery name="sel_conta_inco_no_viae">
       <querytext>
  select iter_edit_num(count(*),0) as conta_inco
    from coiminco a
    left outer join coimopve d on d.cod_opve   = a.cod_opve
         inner join coimaimp b on b.cod_impianto = a.cod_impianto
    left outer join coimcitt e on e.cod_cittadino   = b.cod_responsabile
   where 1=1
     and a.stato    = '2'
     and a.cod_cinc = :cod_cinc
  $where_anno_inst_da
  $where_anno_inst_a
  $where_tipo_imp
  $where_data_verifica
  $where_comb
  $where_enve
  $where_inco
  $where_data_verifica
  $where_data
  $where_codice
  $where_tecn
  $where_comune
  $where_tipo_estr
  $where_cod_area
  $where_dich
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
