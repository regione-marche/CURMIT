<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_dimp_aimp">
       <querytext>
           select a.cod_dimp         as dimp_cod_dimp
                , a.data_ins         as dimp_data_ins
                , a.data_controllo   as dimp_data_controllo
                , a.cod_manutentore  as dimp_cod_manutentore
                , a.cod_proprietario as dimp_cod_proprietario
                , a.cod_occupante    as dimp_cod_occupante
                , a.conformita       as dimp_conformita
                , a.lib_impianto     as dimp_lib_impianto
                , a.lib_uso_man      as dimp_lib_uso_man
                , a.idoneita_locale  as dimp_idoneita_locale
                , a.ap_ventilaz      as dimp_ap_ventilaz
                , a.ap_vent_ostruz   as dimp_ap_vent_ostruz
                , a.pendenza         as dimp_pendenza
                , a.sezioni          as dimp_sezioni
                , a.curve            as dimp_curve
                , a.lunghezza        as dimp_lunghezza
                , a.conservazione    as dimp_conservazione
                , a.scar_ca_si       as dimp_scar_ca_si
                , a.scar_parete      as dimp_scar_parete
                , a.riflussi_locale  as dimp_riflussi_locale
                , a.assenza_perdite  as dimp_assenza_perdite
                , a.pulizia_ugelli   as dimp_pulizia_ugelli
                , a.antivento        as dimp_antivento
                , a.scambiatore      as dimp_scambiatore
                , a.accens_reg       as dimp_accens_reg
                , a.disp_comando     as dimp_disp_comando
                , a.ass_perdite      as dimp_ass_perdite
                , a.valvola_sicur    as dimp_valvola_sicur
                , a.vaso_esp         as dimp_vaso_esp
                , a.disp_sic_manom   as dimp_disp_sic_manom
                , a.organi_integri   as dimp_organi_integri
                , a.circ_aria        as dimp_circ_aria
                , a.guarn_accop      as dimp_guarn_accop
                , a.assenza_fughe    as dimp_assenza_fughe
                , a.coibentazione    as dimp_coibentazione
                , a.eff_evac_fum     as dimp_eff_evac_fum
                , a.cont_rend        as dimp_cont_rend
                , a.temp_fumi        as dimp_temp_fumi
                , a.temp_ambi        as dimp_temp_ambi
                , a.o2               as dimp_o2
                , a.co2              as dimp_co2
                , a.bacharach        as dimp_bacharach
                , a.co               as dimp_co
                , a.rend_combust     as dimp_rend_combust
                , a.osservazioni     as dimp_osservazioni
                , a.raccomandazioni  as dimp_raccomandazioni
                , a.prescrizioni     as dimp_prescrizioni

                , a.data_utile_inter   as dimp_data_utile_inter
                , a.n_prot             as dimp_n_prot
                , a.data_prot          as dimp_data_prot
                , a.delega_resp        as dimp_delega_resp
                , a.delega_manut       as dimp_delega_manut
                , a.num_bollo          as dimp_num_bollo
                , a.costo              as dimp_costo
                , a.tipologia_costo    as dimp_tipologia_costo
                , a.riferimento_pag    as dimp_riferimento_pag
                , a.potenza            as dimp_potenza
                , a.flag_pericolosita  as dimp_flag_pericolosita
                , a.flag_tracciato     as dimp_flag_tracciato
                , a.cod_docu_distinta  as dimp_cod_docu_distinta
                , a.scar_can_fu        as dimp_scar_can_fu
                , a.tiraggio           as dimp_tiraggio
                , a.ora_inizio         as dimp_ora_inizio
                , a.ora_fine           as dimp_ora_fine
                , a.rapp_contr         as dimp_rapp_contr
                , a.rapp_contr_note    as dimp_rapp_contr_note
                , a.certificaz         as dimp_certificaz
                , a.certificaz_note    as dimp_certificaz_note
                , a.dich_conf          as dimp_dich_conf
                , a.dich_conf_note     as dimp_dich_conf_note
                , a.libretto_bruc      as dimp_libretto_bruc
                , a.libretto_bruc_note as dimp_libretto_bruc_note
                , a.prev_incendi       as dimp_prev_incendi
                , a.prev_incendi_note  as dimp_prev_incendi_note
                , a.lib_impianto_note  as dimp_lib_impianto_note
                , a.ispesl             as dimp_ispesl
                , a.ispesl_note        as dimp_ispesl_note
                , a.data_scadenza      as dimp_data_scadenza
                , a.num_autocert       as dimp_num_autocert
                , a.esame_vis_l_elet   as dimp_esame_vis_l_elet
                , a.funz_corr_bruc     as dimp_funz_corr_bruc
                , a.lib_uso_man_note   as dimp_lib_uso_man_note
                , a.volimetria_risc    as dimp_volimetria_risc
                , a.consumo_annuo      as dimp_consumo_annuo
                , a.cod_opmanu         as dimp_cod_opmanu
                , a.data_arrivo_ente   as dimp_data_arrivo_ente

                , b.cod_impianto_est as aimp_cod_impianto_est
                , b.cod_impianto     as aimp_cod_impianto
                , b.cod_comune       as aimp_cod_comune
                , b.cod_via          as aimp_cod_via
                , b.toponimo         as aimp_toponimo
                , b.indirizzo        as aimp_indirizzo
                , b.numero           as aimp_numero
                , b.esponente        as aimp_esponente
                , b.scala            as aimp_scala
                , b.piano            as aimp_piano
                , b.interno          as aimp_interno
                , b.cap              as aimp_cap
                , b.localita         as aimp_localita
                , b.cod_comune       as aimp_cod_comune
                , b.cod_impianto     as aimp_cod_impianto
                , b.cod_combustibile as aimp_cod_combustibile
                , b.potenza          as aimp_potenza
                , b.data_installaz   as aimp_data_installaz
             from coimdimp a
                , coimaimp b
            where b.cod_impianto  = a.cod_impianto
           $where_manu
           $where_data_ins
           $where_data_controllo
        $order_by
       </querytext>
    </fullquery>

    <fullquery name="sel_viae">
       <querytext>
           select descr_topo   as viae_descr_topo
                , descr_estesa as viae_descr_estesa
             from coimviae
            where cod_comune = :viae_cod_comune
              and cod_via    = :viae_cod_via
       </querytext>
    </fullquery>

    <fullquery name="sel_comu">
       <querytext>
           select denominazione as comu_denominazione
             from coimcomu
            where cod_comune = :comu_cod_comune
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
           select cognome    as manu_cognome
                , nome       as manu_nome
                , indirizzo  as manu_indirizzo
                , cap        as manu_cap
                , localita   as manu_localita
                , comune     as manu_comune
                , provincia  as manu_provincia
                , telefono   as manu_telefono
             from coimmanu
            where cod_manutentore = :manu_cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_citt">
       <querytext>
           select cognome   as citt_cognome
                , nome      as citt_nome
                , indirizzo as citt_indirizzo
                , numero    as citt_numero
                , cap       as citt_cap
                , localita  as citt_localita
                , comune    as citt_comune
                , provincia as citt_provincia
             from coimcitt
            where cod_cittadino = :citt_cod_cittadino
       </querytext>
    </fullquery>

    <fullquery name="sel_gend">
       <querytext>
           select a.tipo_foco   as gend_tipo_foco
                , a.tiraggio    as gend_tiraggio
                , a.descrizione as gend_descrizione
                , a.cod_cost    as gend_cod_cost
                , a.modello     as gend_modello
                , a.matricola   as gend_matricola
             from coimgend a
            where a.cod_impianto = :gend_cod_impianto
              and a.gen_prog_est = (select min(b.gen_prog_est)
                                      from coimgend b
                                     where b.cod_impianto = :gend_cod_impianto
                                       and b.flag_attivo  = 'S')
      </querytext>
    </fullquery>

    <fullquery name="sel_cost">
       <querytext>
           select descr_cost as cost_descr_cost
             from coimcost
            where cod_cost   = :cost_cod_cost
       </querytext>
    </fullquery>

    <fullquery name="sel_comb">
       <querytext>
           select descr_comb as comb_descr_comb
             from coimcomb
            where cod_combustibile = :comb_cod_combustibile
       </querytext>
    </fullquery>

</queryset>
