<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_ver">
       <querytext>
                   select iter_edit_data(a.data_verifica) as data_verifica
                        , coalesce(b.cognome,'')||' '||coalesce(b.nome,'') as verificatore
                        , coalesce(c.ragione_01,'')||' '||coalesce(ragione_01,'') as desc_enve
                        , c.telefono as tel_enve
                     from coiminco a
                   left outer join coimopve b on b.cod_opve = a.cod_opve
                   left outer join coimenve c on c.cod_enve = b.cod_enve
                    where a.cod_inco = :cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_date">
       <querytext>
         select to_char(current_date, 'dd/mm/yyyy') as data_corrente
       </querytext>
    </fullquery>

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

    <fullquery name="sel_inco_cod_documento">
       <querytext>
           select cod_documento_02 as cod_documento
             from coiminco
            where cod_inco = :cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_2">
       <querytext>
                   select stato
                     from coiminco
                    where cod_inco = :cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp">
       <querytext>
           select a.cod_cimp
                , a.note_conf
                , a.note_verificatore
                , b.gen_prog_est
             from coimcimp a
  left outer join coimgend b on b.cod_impianto = a.cod_impianto
              and b.gen_prog     = a.gen_prog
            where a.cod_inco     =  :cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_anom">
       <querytext>
            select a.cod_tanom
                 , b.descr_tano
              from coimanom a
                 , coimtano b
             where a.cod_cimp_dimp = :cod_cimp
	       and a.flag_origine  = 'RV'
               and b.cod_tano      = a.cod_tanom
          order by to_number(a.prog_anom,'99999999')
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_si_viae">
       <querytext>
  select a.cod_inco
       , a.cod_impianto
       , b.cod_impianto_est
       , a.esito
       , iter_edit_data(a.data_avviso_01) as data_avviso_01
       , a.cod_documento_01
       , a.cod_documento_02 as cod_documento
       , b.potenza
       , b.flag_dichiarato
       , coalesce(c.descr_topo,'')||' '||coalesce(c.descr_estesa,'')||' '||coalesce(b.numero,'')||' '||coalesce(b.esponente,'') as indir
       , f.denominazione as comu
       , g.denominazione as prov
       , e.cod_cittadino
       , initcap(e.cognome) as cognome_resp
       , initcap(e.nome) as nome_resp
       , initcap(e.indirizzo) as indirizzo_resp
       , e.numero as numero_resp
       , e.cap as cap_resp
       , initcap(e.comune) as comune_resp
       , e.provincia as provincia_resp
      from      coiminco a
     inner join coimaimp b  on b.cod_impianto  = a.cod_impianto
left outer join coimviae c  on c.cod_via       = b.cod_via
                           and c.cod_comune    = b.cod_comune
left outer join coimcitt e  on e.cod_cittadino = b.cod_responsabile
left outer join coimcomu f  on f.cod_comune    = b.cod_comune
                           and f.cod_provincia = b.cod_provincia
left outer join coimprov g  on g.cod_provincia = b.cod_provincia
   where a.stato = '8'
     and a.esito is not null
     and a.cod_cinc = :cod_cinc
  $where_inco
  $where_data
  $where_codice
  $where_tecn
  $where_comune
  $where_via
  $where_tipo_estr
  $where_enve
  $where_comb
  $where_anno_inst_da
  $where_anno_inst_a
order by a.cod_inco
       </querytext>
    </fullquery>

    <fullquery name="sel_inco_no_viae">
       <querytext>
  select a.cod_inco
       , a.cod_impianto
       , b.cod_impianto_est
       , a.esito
       , iter_edit_data(a.data_avviso_01) as data_avviso_01
       , a.cod_documento_01
       , a.cod_documento_02 as cod_documento
       , b.potenza
       , b.flag_dichiarato
       , coalesce(b.toponimo,'')||' '||coalesce(b.indirizzo,'')||' '||coalesce(b.numero,'')||' '||coalesce(b.esponente,'') as indir
       , f.denominazione as comu
       , g.denominazione as prov
       , e.cod_cittadino
       , initcap(e.cognome)   as cognome_resp
       , initcap(e.nome)      as nome_resp
       , initcap(e.indirizzo) as indirizzo_resp
       , e.numero             as numero_resp
       , e.cap                as cap_resp
       , initcap(e.comune)    as comune_resp
       , e.provincia          as provincia_resp
           from coiminco a
     inner join coimaimp b on b.cod_impianto  = a.cod_impianto
left outer join coimcitt e on e.cod_cittadino = b.cod_responsabile
left outer join coimcomu f  on f.cod_comune    = b.cod_comune
                           and f.cod_provincia = b.cod_provincia
left outer join coimprov g  on g.cod_provincia = b.cod_provincia
   where a.stato     = '8'
     and a.esito    is not null
     and a.cod_cinc  = :cod_cinc
  $where_inco
  $where_data
  $where_codice
  $where_tecn
  $where_comune
  $where_via
  $where_tipo_estr
  $where_enve
  $where_comb
  $where_anno_inst_da
  $where_anno_inst_a
order by a.cod_inco
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

    <fullquery name="sel_aimp">
       <querytext>
            select coalesce(b.cognome,'')||' '||coalesce(b.nome,'') as nome_resp
                 , iter_edit_data(b.data_nas) as data_nas
                 , coalesce(b.comune_nas,'') as comune_nas
                 , coalesce(b.comune,'') as comune
                 , coalesce(b.indirizzo,'') as indiriz
                 , coalesce(b.numero,'') as numero
              from coimaimp a
                   left outer join coimcitt b on b.cod_cittadino = a.cod_responsabile
             where a.cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_2">
       <querytext>
            select coalesce(protocollo_01,'') as protocollo_01
              from coimdocu
             where cod_documento = :cod_documento_01
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
                      set cod_documento_02 = :cod_documento
                        , data_avviso_02   = current_date
                        , data_mod         = current_date
                        , utente           = :id_utente
                    where cod_inco         = :cod_inco
       </querytext>
    </partialquery>

    <fullquery name="sel_aimp_2">
       <querytext>
        select coalesce(b.cognome,'')||' '||coalesce(b.nome,'') as nome_resp
          from coimaimp a
               left outer join coimcitt b on b.cod_cittadino = a.cod_responsabile
         where a.cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_cimp_1">
       <querytext>
           select cod_cimp
             from coimcimp
            where cod_inco     =  :cod_inco
           limit 1
       </querytext>
    </fullquery>

    <fullquery name="sel_ente">
       <querytext>
            select f.denominazione as nome_ente
                 , f.indirizzo as indirizzo_ente
                 , f.numero as numero_ente
                 , f.cap as cap_ente      
                 , f.comune as comune_ente
                 , f.provincia as provincia_ente
                 , f.cod_area
              from coimanom a
                 , coimanrg b
                 , coimrgen c
                 , coimenrg d
                 , coimenre e
                 , coimenti f
                 , coimaimp g
                 , coimcmar h
                 , coimarea i
             where a.cod_cimp_dimp = :cod_cimp
	            and a.flag_origine  = 'RV'
               and a.cod_tanom     = b.cod_tano
               and b.cod_rgen      = c.cod_rgen
               and c.cod_rgen      = d.cod_rgen
               and d.cod_enre      = e.cod_enre
               and e.cod_enre      = f.cod_enre
               and g.cod_impianto  = :cod_impianto
               and g.cod_comune    = h.cod_comune
               and h.cod_area      = i.cod_area
               and i.cod_area      = f.cod_area
       </querytext>
    </fullquery>

</queryset>
