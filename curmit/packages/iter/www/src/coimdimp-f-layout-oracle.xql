<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_dimp_si_vie">
       <querytext>
                      select
                        a.cod_potenza
                       ,substr(a.data_installaz,1,4) as anno_costruzione
                       ,iter_edit.data(a.data_installaz) as data_installaz
                       ,a.potenza
		       ,a.cod_combustibile
                       ,b.cod_cost
                       ,c.descr_cost
                       ,b.modello
                       ,b.matricola
                       ,j.cod_manutentore
                       ,a.cod_proprietario
                       ,nvl(k.cognome, '')||' '||
                        nvl(k.nome, '') as nominativo_prop
                       ,d.cognome as cognome_prop
                       ,d.nome as nome_prop
                       ,d.indirizzo as indirizzo_prop
		       ,d.numero    as numero_prop
                       ,d.localita as localita_prop
                       ,d.comune as comune_prop
                       ,d.provincia as provincia_prop
                       ,d.cap as cap_prop
		       ,a.cod_occupante
                       ,e.cognome as cognome_util
		       ,e.nome as nome_util
                       ,e.indirizzo as indirizzo_util
		       ,e.numero    as numero_util
                       ,e.localita as localita_util
                       ,e.comune as comune_util
                       ,e.provincia as provincia_util
                       ,e.cap as cap_util
                       ,nvl(g.descr_topo,'')||' '||
                        nvl(g.descr_estesa,'')||' '||
                        nvl(a.numero, '')||' '||
                        nvl(a.esponente,'') as indirizzo_ubic
                       ,a.localita as localita_ubic
                       ,h.denominazione as comune_ubic
                       ,i.denominazione as provincia_ubic
                       ,a.cap as cap_ubic
                       ,j.garanzia
                       ,j.conformita
                       ,j.lib_impianto
                       ,j.lib_uso_man
                       ,j.inst_in_out
                       ,j.idoneita_locale
                       ,j.ap_ventilaz
                       ,j.ap_vent_ostruz
                       ,j.pendenza
                       ,j.sezioni
                       ,j.curve
                       ,j.lunghezza
                       ,j.conservazione
                       ,j.scar_ca_si
                       ,j.scar_parete
                       ,j.riflussi_locale
                       ,j.assenza_perdite
                       ,j.pulizia_ugelli
                       ,j.antivento
                       ,j.scambiatore
                       ,j.accens_reg
                       ,j.disp_comando
                       ,j.ass_perdite
                       ,j.valvola_sicur
                       ,j.vaso_esp
                       ,j.disp_sic_manom
                       ,j.organi_integri
                       ,j.circ_aria
                       ,j.guarn_accop
                       ,j.assenza_fughe
                       ,j.coibentazione
                       ,j.eff_evac_fum
                       ,j.cont_rend
                       ,iter_edit.data(j.data_controllo) as data_controllo
                       ,iter_edit.num(j.temp_fumi,2) as temp_fumi
                       ,iter_edit.num(j.temp_ambi,2) as temp_ambi
                       ,iter_edit.num(j.o2,2) as o2
                       ,iter_edit.num(j.co2,2) as co2
                       ,iter_edit.num(j.bacharach,2) as bacharach
                       ,j.co
                       ,iter_edit.num(j.rend_combust,2) as rend_combust
                       ,j.osservazioni
                       ,j.raccomandazioni
                       ,j.prescrizioni
                       ,j.data_utile_inter
                       ,j.n_prot
                       ,j.data_prot
                       ,j.delega_resp as firma_resp
                       ,j.delega_manut as firma_manut
                       ,j.riferimento_pag
                       ,j.cod_documento
                       ,j.flag_co_perc
                       ,a.cod_responsabile
                       ,j.data_controllo as data_controllo_db

                       ,iter_edit.num(j.tiraggio,2) as tiraggio_fumi
                       ,iter_edit.time(j.ora_inizio) as ora_inizio
                       ,iter_edit.time(j.ora_fine) as ora_fine
                       ,j.rapp_contr
                       ,j.rapp_contr_note
                       ,j.certificaz
                       ,j.certificaz_note
                       ,j.dich_conf
                       ,j.dich_conf_note
                       ,j.libretto_bruc
                       ,j.libretto_bruc_note
                       ,j.prev_incendi
                       ,j.prev_incendi_note
                       ,j.lib_impianto_note
                       ,j.ispesl
                       ,j.ispesl_note
                       ,iter_edit.data(j.data_scadenza) as data_scadenza_autocert
                       ,j.num_autocert
                       ,j.esame_vis_l_elet
                       ,j.funz_corr_bruc
                       ,j.lib_uso_man_note
                       ,b.locale
                       ,iter_edit.data(b.data_costruz_gen) as data_costruz_gen
                       ,iter_edit.data(b.data_costruz_bruc) as data_costruz_bruc
                       ,b.marc_effic_energ  
                       ,iter_edit.num(j.volimetria_risc,2) as volimetria_risc
                       ,iter_edit.num(j.consumo_annuo,2) as consumo_annuo
                       ,iter_edit.num(b.pot_focolare_nom,2) as pot_focolare_nom
                       ,b.mod_funz
                       ,b.tipo_bruciatore
                       ,iter_edit.num(b.campo_funzion_max,2) as campo_funzion_max
                       ,iter_edit.num(b.campo_funzion_min,2) as campo_funzion_min
                       ,b.matricola_bruc
                       ,b.modello_bruc
                       ,l.descr_cost as costruttore_bruc
                       ,a.cod_impianto_est
                       ,m.sigla as prov_ubic
                       ,a.flag_resp
                       ,n.descr_utgi as destinazione
                       ,j.flag_status
                  from coimdimp j
                     , coimgend b 
                     , coimcost c 
                     , coimaimp a                       
                     , coimcitt d
                     , coimcitt e 
                     , coimviae g 
                     , coimcomu h 
                     , coimprov i
                     , coimcitt k  
                     , coimcost l
                     , coimprov m
                     , coimutgi n
                 where j.cod_dimp         = :cod_dimp
                   and a.cod_impianto     = j.cod_impianto
		   and b.cod_impianto  (+)= j.cod_impianto
                   and b.gen_prog      (+)= :gen_progg
                   and c.cod_cost      (+)= b.cod_cost
                   and d.cod_cittadino (+)= a.cod_proprietario
                   and e.cod_cittadino (+)= a.cod_occupante
                   and g.cod_comune    (+)= a.cod_comune
                   and g.cod_via       (+)= a.cod_via 
                   and h.cod_comune    (+)= a.cod_comune
                   and i.cod_provincia (+)= a.cod_provincia
                   and k.cod_cittadino (+)= a.cod_responsabile
                   and l.cod_cost      (+)= b.cod_cost_bruc
                   and m.cod_provincia (+)= a.cod_provincia
                   and n.cod_utgi      (+)= b.cod_utgi
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_no_vie">
       <querytext>
                      select
                        a.cod_potenza
                       ,substr(a.data_installaz,1,4) as anno_costruzione
                       ,iter_edit.data(a.data_installaz) as data_installaz
                       ,a.potenza
		       ,a.cod_combustibile
                       ,b.cod_cost
                       ,c.descr_cost
                       ,b.modello
                       ,b.matricola
                       ,j.cod_manutentore
                       ,a.cod_proprietario
                       ,nvl(k.cognome, '')||' '||
                        nvl(k.nome, '') as nominativo_prop
                       ,d.cognome as cognome_prop
                       ,d.nome as nome_prop
                       ,d.indirizzo as indirizzo_prop
		       ,d.numero    as numero_prop
                       ,d.localita as localita_prop
                       ,d.comune as comune_prop
                       ,d.provincia as provincia_prop
                       ,d.cap as cap_prop
		       ,a.cod_occupante
                       ,e.cognome as cognome_util
		       ,e.nome as nome_util
                       ,e.indirizzo as indirizzo_util
		       ,e.numero    as numero_util
                       ,e.localita as localita_util
                       ,e.comune as comune_util
                       ,e.provincia as provincia_util
                       ,e.cap as cap_util
                       ,nvl(a.toponimo,'')||' '||
                        nvl(a.indirizzo,'')||' '||
			nvl(a.numero,'')||' '||
                        nvl(a.esponente,'') as indirizzo_ubic
                       ,a.localita as localita_ubic
                       ,h.denominazione as comune_ubic
                       ,i.denominazione as provincia_ubic
                       ,a.cap as cap_ubic
                       ,j.garanzia
                       ,j.conformita
                       ,j.lib_impianto
                       ,j.lib_uso_man
                       ,j.inst_in_out
                       ,j.idoneita_locale
                       ,j.ap_ventilaz
                       ,j.ap_vent_ostruz
                       ,j.pendenza
                       ,j.sezioni
                       ,j.curve
                       ,j.lunghezza
                       ,j.conservazione
                       ,j.scar_ca_si
                       ,j.scar_parete
                       ,j.riflussi_locale
                       ,j.assenza_perdite
                       ,j.pulizia_ugelli
                       ,j.antivento
                       ,j.scambiatore
                       ,j.accens_reg
                       ,j.disp_comando
                       ,j.ass_perdite
                       ,j.valvola_sicur
                       ,j.vaso_esp
                       ,j.disp_sic_manom
                       ,j.organi_integri
                       ,j.circ_aria
                       ,j.guarn_accop
                       ,j.assenza_fughe
                       ,j.coibentazione
                       ,j.eff_evac_fum
                       ,j.cont_rend
                       ,iter_edit.data(j.data_controllo) as data_controllo
                       ,iter_edit.num(j.temp_fumi,2) as temp_fumi
                       ,iter_edit.num(j.temp_ambi,2) as temp_ambi
                       ,iter_edit.num(j.o2,2) as o2
                       ,iter_edit.num(j.co2,2) as co2
                       ,iter_edit.num(j.bacharach,2) as bacharach
                       ,iter_edit.num(j.co,2) as co
                       ,iter_edit.num(j.rend_combust,2) as rend_combust
                       ,j.osservazioni
                       ,j.raccomandazioni
                       ,j.prescrizioni
                       ,j.data_utile_inter
                       ,j.n_prot
                       ,j.data_prot
                       ,j.delega_resp as firma_resp
                       ,j.delega_manut as firma_manut
                       ,j.riferimento_pag
                       ,j.cod_documento
                       ,j.flag_co_perc
                       ,a.cod_responsabile
                       ,j.data_controllo as data_controllo_db

                       ,iter_edit.num(j.tiraggio,2) as tiraggio_fumi
                       ,iter_edit.time(j.ora_inizio) as ora_inizio
                       ,iter_edit.time(j.ora_fine) as ora_fine
                       ,j.rapp_contr
                       ,j.rapp_contr_note
                       ,j.certificaz
                       ,j.certificaz_note
                       ,j.dich_conf
                       ,j.dich_conf_note
                       ,j.libretto_bruc
                       ,j.libretto_bruc_note
                       ,j.prev_incendi
                       ,j.prev_incendi_note
                       ,j.lib_impianto_note
                       ,j.ispesl
                       ,j.ispesl_note
                       ,iter_edit.data(j.data_scadenza) as data_scadenza_autocert
                       ,j.num_autocert
                       ,j.esame_vis_l_elet
                       ,j.funz_corr_bruc
                       ,j.lib_uso_man_note
                       ,b.locale
                       ,iter_edit.data(b.data_costruz_gen) as data_costruz_gen
                       ,iter_edit.data(b.data_costruz_bruc) as data_costruz_bruc
                       ,b.marc_effic_energ  
                       ,iter_edit.num(j.volimetria_risc,2) as volimetria_risc
                       ,iter_edit.num(j.consumo_annuo,2) as consumo_annuo
                       ,iter_edit.num(b.pot_focolare_nom,2) as pot_focolare_nom
                       ,b.mod_funz
                       ,b.tipo_bruciatore
                       ,iter_edit.num(b.campo_funzion_max,2) as campo_funzion_max
                       ,iter_edit.num(b.campo_funzion_min,2) as campo_funzion_min
                       ,b.matricola_bruc
                       ,b.modello_bruc
                       ,l.descr_cost as costruttore_bruc
                       ,a.cod_impianto_est
                       ,m.sigla as prov_ubic
                       ,a.flag_resp
                       ,n.descr_utgi as destinazione
                       ,j.flag_status/
                  from coimdimp j
                     , coimgend b 
                     , coimcost c 
                     , coimaimp a                       
                     , coimcitt d
                     , coimcitt e 
                     , coimcomu h 
                     , coimprov i
                     , coimcitt k
                     , coimcost l
                     , coimprov m
                     , coimutgi n
                 where j.cod_dimp         = :cod_dimp
                   and a.cod_impianto     = j.cod_impianto
		   and b.cod_impianto  (+)= j.cod_impianto
                   and b.gen_prog      (+)= :gen_progg
                   and c.cod_cost      (+)= b.cod_cost
                   and d.cod_cittadino (+)= a.cod_proprietario
                   and e.cod_cittadino (+)= a.cod_occupante
                   and h.cod_comune    (+)= a.cod_comune
                   and i.cod_provincia (+)= a.cod_provincia
                   and k.cod_cittadino (+)= a.cod_responsabile
                   and l.cod_cost      (+)= b.cod_cost_bruc
                   and m.cod_provincia (+)= a.cod_provincia
                   and n.cod_utgi      (+)= b.cod_utgi
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp">
       <querytext>
                   select modello
                        , descrizione
                        , tipo_foco as tipo_gen_foco
                        , tiraggio
                     from coimgend
                    where cod_impianto = :cod_impianto   
                      and gen_prog     = :gen_progg        
       </querytext>
    </fullquery>

    <fullquery name="sel_comb">
       <querytext>
                   select descr_comb
                     from coimcomb
                    where cod_combustibile = :cod_combustibile
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
                  select nome
                       , cognome
                       , indirizzo
                       , localita
                       , provincia
                       , telefono     
                    from coimmanu
                   where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_docu_next">
        <querytext>
           select coimdocu_s.nextval as cod_documento
             from dual
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
                        , tipo_documento
                        , cod_impianto
                        , data_documento
                        , data_stampa
			, protocollo_02
                        , data_prot_02
                        , tipo_soggetto
                        , cod_soggetto
                        , data_ins
                        , utente)
                   values
                        ( :cod_documento
                        , :tipo_documento
                        , :cod_impianto
                        , :data_controllo_db
                        , sysdate
                        , :n_prot
                        , :data_prot
                        , 'C'
                        , :cod_responsabile
                        , sysdate
                        , :id_utente)
       </querytext>
    </partialquery>

    <partialquery name="upd_docu">
       <querytext>
                   update coimdocu
                      set data_documento = sysdate
                        , data_mod       = sysdate
                        , utente         = :id_utente
                    where cod_documento  = :cod_documento
       </querytext>
    </partialquery>

    <partialquery name="upd_docu_2">
       <querytext>
                   update coimdocu
                      set tipo_contenuto = :tipo_contenuto
                        , contenuto      = empty_blob()
                    where cod_documento  = :cod_documento
                returning contenuto
                     into :1                     
       </querytext>
    </partialquery> 

    <partialquery name="upd_dimp">
       <querytext>
                   update coimdimp
                      set cod_documento = :cod_documento
                    where cod_dimp      = :cod_dimp
       </querytext>
    </partialquery> 

    <fullquery name="sel_anom">
        <querytext>
           select cod_tanom
             from coimanom
            where cod_cimp_dimp = :cod_dimp
              and tipo_anom     = '1'
       </querytext>
    </fullquery>

    <fullquery name="sel_cod_gend">
       <querytext>
         select * 
           from (
              select a.gen_prog as gen_progg
                from coimgend a
                   , coimdimp b
               where b.cod_dimp     =  :cod_dimp
                 and a.cod_impianto = b.cod_impianto
                 and a.flag_attivo  =  'S'
               order by a.gen_prog_est
           ) 
           where rownum <= 1
      </querytext>
    </fullquery>

</queryset>
