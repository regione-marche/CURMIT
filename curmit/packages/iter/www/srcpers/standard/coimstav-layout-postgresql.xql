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

    <fullquery name="sel_inco_2">
       <querytext>
                   select stato
                     from coiminco
                    where cod_inco = :cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_si_viae">
       <querytext>
  select a.cod_inco
       , a.cod_impianto
       , b.cod_impianto_est
       , a.cod_documento_01 as cod_documento
       , iter_edit_data(a.data_verifica) as data_verifica_edit
       , substr(a.ora_verifica,1,5) as ora_verifica_edit
       , b.potenza
       , b.flag_dichiarato
       , coalesce(c.descr_topo,'')||' '||coalesce(c.descr_estesa,'')||' '||coalesce(b.numero,'')||' '||coalesce(b.esponente,'') as indir
       , coalesce(d.cognome,'')||' '||coalesce(d.nome,'') as nome_opve
       , a.cod_opve
       , d.cod_enve
       , f.ragione_01 as desc_enve
       , f.comune     as comune_enve
       , e.cod_cittadino
       , initcap(e.cognome) as cognome_resp
       , initcap(e.nome) as nome_resp
       , initcap(e.indirizzo) as indirizzo_resp
       , e.numero as numero_resp
       , e.cap as cap_resp
       , initcap(e.comune) as comune_resp
       , e.provincia as provincia_resp
       , e.localita as localita_resp
       , d.cellulare as cell_opve
       , iter_edit_num(g.importo,2) as costo
       , b.cap as cap_aimp
       , h.denominazione as comu_aimp
       , b.flag_resp        -- 13/11/2013
       , b.cod_responsabile -- 13/11/2013
    from coiminco a
    left outer join coimopve d on d.cod_opve      = a.cod_opve
         inner join coimaimp b on b.cod_impianto  = a.cod_impianto
    left outer join coimviae c on c.cod_via       = b.cod_via
                              and c.cod_comune    = b.cod_comune
    left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
    left outer join coimenve f on f.cod_enve      = d.cod_enve
    left outer join coimtari g on g.cod_potenza   = b.cod_potenza
                              and g.tipo_costo    = '2'
                              and g.data_inizio   = (select max(h.data_inizio) 
                                                       from coimtari h 
                                                      where h.cod_potenza = b.cod_potenza
                                                        and h.tipo_costo  = '2'
                                                        and h.data_inizio <= current_date) 
    left outer join coimcomu h on h.cod_comune   = b.cod_comune
   where 1=1
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
  $where_area
order by a.cod_inco
$limit_pos
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_no_viae">
       <querytext>
  select a.cod_inco
       , a.cod_impianto
       , b.cod_impianto_est
       , a.cod_documento_01 as cod_documento
       , iter_edit_data(a.data_verifica) as data_verifica_edit
       , substr(a.ora_verifica,1,5) as ora_verifica_edit
       , b.potenza
       , b.flag_dichiarato
       , coalesce(b.toponimo,'')||' '||coalesce(b.indirizzo,'')||' '||coalesce(b.numero,'')||' '||coalesce(b.esponente,'') as indir
       , coalesce(d.cognome,'')||' '||coalesce(d.nome,'') as nome_opve
       , a.cod_opve
       , d.cod_enve
       , f.ragione_01 as desc_enve
       , f.comune     as comune_enve
       , e.cod_cittadino
       , initcap(e.cognome) as cognome_resp
       , initcap(e.nome) as nome_resp
       , initcap(e.indirizzo) as indirizzo_resp
       , e.numero as numero_resp
       , e.cap as cap_resp
       , initcap(e.comune) as comune_resp
       , e.provincia as provincia_resp
       , e.localita as localita_resp
       , d.cellulare as cell_opve
       , iter_edit_num(g.importo,2) as costo
       , b.cap as cap_aimp
       , h.denominazione as comu_aimp
       , b.flag_resp        -- 13/11/2013
       , b.cod_responsabile -- 13/11/2013
    from coiminco a
    left outer join coimopve d on d.cod_opve      = a.cod_opve
         inner join coimaimp b on b.cod_impianto  = a.cod_impianto
    left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
    left outer join coimenve f on f.cod_enve      = d.cod_enve
    left outer join coimtari g on g.cod_potenza   = b.cod_potenza
                              and g.tipo_costo    = '2'
                              and g.data_inizio   = (select max(h.data_inizio) 
                                                       from coimtari h 
                                                      where h.cod_potenza = b.cod_potenza
                                                        and h.tipo_costo  = '2'
                                                        and h.data_inizio <= current_date) 
    left outer join coimcomu h on h.cod_comune   = b.cod_comune
   where 1=1
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
  $where_area
order by a.cod_inco
$limit_pos
       </querytext>
    </fullquery>

    <fullquery name="sel_manu_resp">
       <querytext>--13/11/2013
                select 'C/O '||coalesce(indirizzo,'') as indirizzo_resp
                     , null::varchar                  as numero_resp
                     , cap                            as cap_resp
                     , localita                       as localita_resp
                     , initcap(comune)                as comune_resp
                     , provincia                      as provincia_resp
                  from coimmanu
                 where cod_legale_rapp = :cod_responsabile
              order by cod_manutentore
                 limit 1
       </querytext>
    </fullquery>

    <fullquery name="sel_enve">
       <querytext>
        select telefono as tel
          from coimenve
         where cod_enve = :cod_enve
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_next">
        <querytext>
           select nextval('coimdocu_s') as cod_documento
       </querytext>
    </fullquery>

    <fullquery name="sel_docu">
        <querytext>
           select 1
             from coimdocu
            where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <partialquery name="ins_docu">
       <querytext>
                insert
                  into coimdocu 
                     ( cod_documento
                     , cod_soggetto
                     , tipo_soggetto
                     , tipo_documento
                     , cod_impianto
                     , data_documento
                     , data_stampa
                     , data_ins
                     , data_mod
                     , utente)
                values 
                     (:cod_documento
                     ,:cod_cittadino
                     ,'C'
                     ,:tipo_documento
                     ,:cod_impianto
                     ,current_date
                     ,current_date
                     ,current_date
                     ,current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_docu">
       <querytext>
                   update coimdocu
                      set data_documento = current_date
                        , data_mod       = current_date
                        , utente         = :id_utente
                    where cod_documento  = :cod_documento
       </querytext>
    </partialquery>

    <fullquery name="sel_docu_contenuto">
       <querytext>
          select contenuto as docu_contenuto_check
            from coimdocu
           where cod_documento = :cod_documento
       </querytext>
    </fullquery>

    <partialquery name="upd_docu_2">
       <querytext>
                   update coimdocu
                      set contenuto     = lo_unlink(coimdocu.contenuto)
                    where cod_documento = :cod_documento
       </querytext>
    </partialquery> 

    <partialquery name="upd_docu_3">
       <querytext>
                   update coimdocu
                   set tipo_contenuto = :tipo_contenuto
                     , contenuto      = lo_import(:contenuto_tmpfile)
                 where cod_documento  = :cod_documento
       </querytext>
    </partialquery> 

    <partialquery name="upd_inco">
       <querytext>
                   update coiminco
                      set cod_documento_01 = :cod_documento
                        , data_avviso_01   = current_date
                        , stato            = '3'
                        , data_mod         = current_date
                        , utente           = :id_utente
                    where cod_inco         = :cod_inco
       </querytext>
    </partialquery>

    <fullquery name="sel_aimp">
       <querytext>
        select coalesce(b.cognome,'')||' '||coalesce(b.nome,'') as nome_resp
          from coimaimp a
               left outer join coimcitt b on b.cod_cittadino = a.cod_responsabile
         where a.cod_impianto = :cod_impianto
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
