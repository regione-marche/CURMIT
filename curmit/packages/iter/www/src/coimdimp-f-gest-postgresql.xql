<?xml version="1.0"?>
<!--
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim02 17/11/2016 Gestito la potenza in base al flag_tipo_impianto

    sim01 27/06/2016 Se flag_tariffa_impianti_vecchi eq "t" e il combustibile e' Gas o Metano
    sim01            devo verificare se l'impianto e' vecchio e quindi usare un'altra tariffa.
-->
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_old_dimp">
        <querytext>
	select '1'
          from coimdimp$stn
         where cod_impianto = :cod_impianto
        limit 1
       </querytext>
    </fullquery>

    <partialquery name="ins_trans">
       <querytext>
                insert
                  into coimtrans_manu
                     ( id_transazione
                     , cod_dimp
                     , num_gen
                     , rimborso_reg
                     , costo_bollino
                     , azione
                     , data_ora
                     , utente)
                values
                     (nextval('coimtrans_manu_s')
                     ,:cod_dimp
                     ,:gen_prog
                     ,:importo_tariffa
                     ,:costo
                     ,:azione
                     ,current_timestamp
                     ,:id_utente)
       </querytext>
    </partialquery>

    <partialquery name="ins_dimp">
       <querytext>
           insert into coimdimp$stn 
                     ( cod_dimp
                     , cod_impianto
                     , data_controllo
                     , gen_prog
                     , cod_manutentore
                     , cod_responsabile
                     , cod_proprietario
                     , cod_occupante
                     , flag_status
                     , garanzia
                     , lib_impianto
                     , lib_uso_man
                     , inst_in_out
                     , idoneita_locale
                     , ap_ventilaz
                     , ap_vent_ostruz
                     , conservazione
                     , pulizia_ugelli
                     , scambiatore
                     , accens_reg
                     , disp_comando
                     , ass_perdite
                     , vaso_esp
                     , disp_sic_manom
                     , organi_integri
                     , assenza_fughe
                     , coibentazione
                     , cont_rend
                     , pot_focolare_mis
                     , portata_comb_mis
                     , temp_fumi
                     , temp_ambi
                     , o2
                     , co2
                     , bacharach
                     , co
                     , rend_combust
                     , osservazioni
                     , raccomandazioni
                     , prescrizioni
                     , data_utile_inter
                     , n_prot
                     , data_prot
                     , delega_resp
                     , delega_manut
                     , utente
                     , data_ins
                     , num_bollo
                     , costo
                     , tipologia_costo
                     , riferimento_pag
                     , potenza
		     , flag_co_perc
                     , flag_tracciato
                     , tiraggio
                     , ora_inizio
                     , ora_fine
                     , rapp_contr
                     , rapp_contr_note
                     , certificaz
                     , certificaz_note
                     , dich_conf
                     , dich_conf_note
                     , libretto_bruc
                     , libretto_bruc_note
                     , prev_incendi
                     , prev_incendi_note
                     , lib_impianto_note
                     , ispesl
                     , ispesl_note
                     , data_scadenza
                     , num_autocert
                     , esame_vis_l_elet
                     , funz_corr_bruc
                     , lib_uso_man_note
                     , volimetria_risc
                     , consumo_annuo
		     , utente_ins
		     , data_arrivo_ente
                     , cod_opmanu_new
                     , consumo_annuo2
                     , stagione_risc
                     , stagione_risc2
                     , schemi_funz_idr
                     , schemi_funz_ele
                     , schemi_funz_idr_note
                     , schemi_funz_ele_note
                     , tariffa
                     , importo_tariffa
                     , cod_cind)
                values 
                     (:cod_dimp
                     ,:cod_impianto
                     ,:data_controllo
                     ,:gen_prog
                     ,:cod_manutentore
                     ,:cod_responsabile
                     ,:cod_proprietario
                     ,:cod_occupante
                     ,:flag_status
                     ,:garanzia
                     ,:lib_impianto
                     ,:lib_uso_man
                     ,:inst_in_out
                     ,:idoneita_locale
                     ,:ap_ventilaz
                     ,:ap_vent_ostruz
                     ,:conservazione
                     ,:pulizia_ugelli
                     ,:scambiatore
                     ,:accens_reg
                     ,:disp_comando
                     ,:ass_perdite
                     ,:vaso_esp
                     ,:disp_sic_manom
                     ,:organi_integri
                     ,:assenza_fughe
                     ,:coibentazione
                     ,:cont_rend
                     ,:pot_focolare_mis
                     ,:portata_comb_mis
                     ,:temp_fumi
                     ,:temp_ambi
                     ,:o2
                     ,:co2
                     ,:bacharach
                     ,:co
                     ,:rend_combust
                     ,:osservazioni
                     ,:raccomandazioni
                     ,:prescrizioni
                     ,:data_utile_inter
                     ,:n_prot
                     ,:data_prot
                     ,:delega_resp
                     ,:delega_manut
                     ,:id_utente
                     ,current_date
                     ,:num_bollo
                     ,:costo
                     ,:tipologia_costo
                     ,:riferimento_pag
		     ,:potenza
		     ,:flag_co_perc
                     ,'F'
                     ,:tiraggio_fumi
                     ,:ora_inizio
                     ,:ora_fine
                     ,:rapp_contr
                     ,:rapp_contr_note
                     ,:certificaz
                     ,:certificaz_note
                     ,:dich_conf
                     ,:dich_conf_note
                     ,:libretto_bruc
                     ,:libretto_bruc_note
                     ,:prev_incendi
                     ,:prev_incendi_note
                     ,:lib_impianto_note
                     ,:ispesl
                     ,:ispesl_note
                     ,:data_scadenza_autocert
                     ,:num_autocert
                     ,:esame_vis_l_elet
                     ,:funz_corr_bruc
                     ,:lib_uso_man_note
                     ,:volimetria_risc
                     ,:consumo_annuo
		     ,:id_utente
		     ,:data_arrivo_ente
                     ,:cod_opmanu_new
                     ,:consumo_annuo2
                     ,:stagione_risc
                     ,:stagione_risc2
                     ,:schemi_funz_idr
                     ,:schemi_funz_ele
                     ,:schemi_funz_idr_note
                     ,:schemi_funz_ele_note
                     ,:tariffa_reg
                     ,:importo_tariffa
                     ,:cod_cind)
       </querytext>
    </partialquery>

    <partialquery name="upd_dimp">
       <querytext>
                update coimdimp$stn
                   set cod_impianto       = :cod_impianto
                     , data_controllo     = :data_controllo
                     , gen_prog           = :gen_prog
                     , cod_manutentore    = :cod_manutentore
                     , cod_responsabile   = :cod_responsabile
                     , cod_proprietario   = :cod_proprietario
                     , cod_occupante      = :cod_occupante
                     , flag_status        = :flag_status
                     , garanzia           = :garanzia
                     , lib_impianto       = :lib_impianto
                     , lib_uso_man        = :lib_uso_man
                     , inst_in_out        = :inst_in_out
                     , idoneita_locale    = :idoneita_locale
                     , ap_ventilaz        = :ap_ventilaz
                     , ap_vent_ostruz     = :ap_vent_ostruz
                     , conservazione      = :conservazione
                     , pulizia_ugelli     = :pulizia_ugelli
                     , scambiatore        = :scambiatore
                     , accens_reg         = :accens_reg
                     , disp_comando       = :disp_comando
                     , ass_perdite        = :ass_perdite
                     , vaso_esp           = :vaso_esp
                     , disp_sic_manom     = :disp_sic_manom
                     , organi_integri     = :organi_integri
                     , assenza_fughe      = :assenza_fughe
                     , coibentazione      = :coibentazione
                     , cont_rend          = :cont_rend
                     , pot_focolare_mis   = :pot_focolare_mis
                     , portata_comb_mis   = :portata_comb_mis
                     , temp_fumi          = :temp_fumi
                     , temp_ambi          = :temp_ambi
                     , o2                 = :o2
                     , co2                = :co2
                     , bacharach          = :bacharach
                     , co                 = :co
                     , rend_combust       = :rend_combust
                     , osservazioni       = :osservazioni
                     , raccomandazioni    = :raccomandazioni
                     , prescrizioni       = :prescrizioni
                     , data_utile_inter   = :data_utile_inter
                     , n_prot             = :n_prot
                     , data_prot          = :data_prot
                     , delega_resp        = :delega_resp
                     , delega_manut       = :delega_manut
                     , utente             = :id_utente
                     , data_mod           = current_date
                     , num_bollo          = :num_bollo
                     , costo              = :costo
                     , tipologia_costo    = :tipologia_costo
                     , riferimento_pag    = :riferimento_pag
		     , potenza            = :potenza
                     , flag_co_perc       = :flag_co_perc
                     , tiraggio           = :tiraggio_fumi
                     , ora_inizio         = :ora_inizio
                     , ora_fine           = :ora_fine
                     , rapp_contr         = :rapp_contr
                     , rapp_contr_note    = :rapp_contr_note
                     , certificaz         = :certificaz
                     , certificaz_note    = :certificaz_note
                     , dich_conf          = :dich_conf
                     , dich_conf_note     = :dich_conf_note
                     , libretto_bruc      = :libretto_bruc
                     , libretto_bruc_note = :libretto_bruc_note
                     , prev_incendi       = :prev_incendi
                     , prev_incendi_note  = :prev_incendi_note
                     , lib_impianto_note  = :lib_impianto_note
                     , ispesl             = :ispesl
                     , ispesl_note        = :ispesl_note
                     , num_autocert       = :num_autocert
                     , esame_vis_l_elet   = :esame_vis_l_elet
                     , funz_corr_bruc     = :funz_corr_bruc
                     , lib_uso_man_note   = :lib_uso_man_note
                     , volimetria_risc    = :volimetria_risc
                     , consumo_annuo      = :consumo_annuo
		     , data_arrivo_ente   = :data_arrivo_ente
                     , cod_opmanu_new     = :cod_opmanu_new
                     , consumo_annuo2       = :consumo_annuo2
                     , stagione_risc        = :stagione_risc
                     , stagione_risc2       = :stagione_risc2
                     , schemi_funz_idr      = :schemi_funz_idr
                     , schemi_funz_ele      = :schemi_funz_ele
                     , schemi_funz_idr_note = :schemi_funz_idr_note
                     , schemi_funz_ele_note = :schemi_funz_ele_note
                     , cod_cind             = :cod_cind
                 where cod_dimp           = :cod_dimp
       </querytext>
    </partialquery>

    <partialquery name="del_dimp">
       <querytext>
                delete
                  from coimdimp$stn
                 where cod_dimp = :cod_dimp
       </querytext>
    </partialquery>

    <fullquery name="sel_dimp">
       <querytext>
             select a.cod_dimp
                  , a.cod_impianto
                  , iter_edit_data(a.data_controllo) as data_controllo
                  , a.gen_prog
                  , a.cod_manutentore
                  , a.cod_opmanu_new
                  , a.cod_responsabile
                  , a.cod_proprietario
                  , a.cod_occupante
                  , a.flag_status
                  , a.garanzia
                  , a.lib_impianto
                  , a.lib_uso_man
                  , a.inst_in_out
                  , a.idoneita_locale
                  , a.ap_ventilaz
                  , a.ap_vent_ostruz
                  , a.conservazione
                  , a.pulizia_ugelli
                  , a.scambiatore
                  , a.accens_reg
                  , a.disp_comando
                  , a.ass_perdite
                  , a.vaso_esp
                  , a.disp_sic_manom
                  , a.organi_integri
                  , a.assenza_fughe
                  , a.coibentazione
                  , a.cont_rend
                  , a.flag_tracciato
                  , iter_edit_num(a.volimetria_risc, 2)  as volimetria_risc
                  , iter_edit_num(a.consumo_annuo, 2)    as consumo_annuo
                  , iter_edit_num(a.pot_focolare_mis, 2) as pot_focolare_mis
                  , iter_edit_num(a.portata_comb_mis, 2) as portata_comb_mis
                  , iter_edit_num(a.temp_fumi, 2)        as temp_fumi
                  , iter_edit_num(a.temp_ambi, 2)        as temp_ambi
                  , iter_edit_num(a.o2, 2)               as o2
                  , iter_edit_num(a.co2, 2)              as co2
                  , iter_edit_num(a.bacharach, 2)        as bacharach
                  , a.co
                  , iter_edit_num(a.rend_combust, 2)     as rend_combust
                  , a.osservazioni
                  , a.raccomandazioni
                  , a.prescrizioni
                  , iter_edit_data(a.data_utile_inter)   as data_utile_inter
                  , a.n_prot
                  , iter_edit_data(a.data_prot)          as data_prot
                  , a.delega_resp
                  , a.delega_manut
                  , a.num_bollo
                  , b.cognome                            as cognome_manu
                  , b.nome                               as nome_manu
                  , c.cognome                            as cognome_resp
                  , c.nome                               as nome_resp
                  , d.cognome                            as cognome_prop
                  , d.nome                               as nome_prop
                  , e.cognome                            as cognome_occu
                  , e.nome                               as nome_occu
                  , i.nome                               as nome_opma
                  , i.cognome                            as cognome_opma
                  , g.cod_intestatario                   as cod_int_contr	
                  , h.cognome                            as cognome_contr
                  , h.nome                               as nome_contr
                  , iter_edit_num(a.costo, 2)            as costo
                  , a.tipologia_costo
                  , riferimento_pag
                  ,( select iter_edit_data(f.data_scad)  as data_scad from coimmovi f where f.riferimento      = a.cod_dimp
                                         and f.cod_impianto     = a.cod_impianto
                                         and f.id_caus = (select s.id_caus from coimcaus s where codice = 'MH')
                                       order by cod_movi desc limit 1) as data_scad
		  ,( select case
                      when importo_pag is null
                       and data_pag    is null
                      then 'N'
                      else 'S'
                    end         as flag_pagato 
                    from coimmovi f where f.riferimento      = a.cod_dimp
                                      and f.cod_impianto     = a.cod_impianto
                                      and f.id_caus = (select s.id_caus from coimcaus s where codice = 'MH')
                                    order by cod_movi desc limit 1) as flag_pagato
		  , iter_edit_num(a.potenza, 2)          as potenza
                  , a.data_ins
                  , a.flag_co_perc
                  , iter_edit_num(a.tiraggio, 2)         as tiraggio_fumi
                  , iter_edit_time(a.ora_inizio)         as ora_inizio
                  , iter_edit_time(a.ora_fine)           as ora_fine
                  , a.rapp_contr
                  , a.rapp_contr_note
                  , a.certificaz
                  , a.certificaz_note
                  , a.dich_conf
                  , a.dich_conf_note
                  , a.libretto_bruc
                  , a.libretto_bruc_note
                  , a.prev_incendi
                  , a.prev_incendi_note
                  , a.lib_impianto_note
                  , a.ispesl
                  , a.ispesl_note
                  , iter_edit_data(a.data_scadenza)      as data_scadenza_autocert
                  , a.num_autocert
                  , a.esame_vis_l_elet
                  , a.funz_corr_bruc
                  , a.lib_uso_man_note
		  , a.utente_ins
		  , iter_edit_data(a.data_arrivo_ente)   as data_arrivo_ente
                  , iter_edit_num(consumo_annuo2, 2)     as consumo_annuo2
                  , stagione_risc
                  , stagione_risc2
                  , schemi_funz_idr
                  , schemi_funz_ele
                  , schemi_funz_idr_note
                  , schemi_funz_ele_note
                  , cod_docu_distinta
                  , iter_edit_num(a.importo_tariffa,2)   as importo_tariffa
                  , a.tariffa                            as tariffa_reg
                  , g.cod_amministratore                 as cod_ammi
                  , l.cognome                            as cognome_ammi
                  , l.nome                               as nome_ammi
                  , g.flag_resp                          as flag_responsabile
                  , a.cod_cind
               from coimdimp$stn a
               left outer join coimmanu b on b.cod_manutentore  = a.cod_manutentore
                    inner join coimaimp g on g.cod_impianto     = a.cod_impianto
               left outer join coimcitt c on c.cod_cittadino    = a.cod_responsabile
	       left outer join coimcitt d on d.cod_cittadino    = a.cod_proprietario
               left outer join coimcitt e on e.cod_cittadino    = a.cod_occupante
               left outer join coimcitt h on h.cod_cittadino    = g.cod_intestatario
               left outer join coimopma i on i.cod_opma         = a.cod_opmanu_new
               left outer join coimcitt l on l.cod_cittadino    = g.cod_amministratore
              where a.cod_dimp = :cod_dimp
       </querytext>
    </fullquery>

    <fullquery name="sel_opma">
       <querytext>
             select cod_opma as cod_opma
               from coimopma
              where upper(cognome)   $eq_cognome
                and upper(nome)      $eq_nome
                and cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>
 
    <fullquery name="sel_dual_cod_dimp">
       <querytext>
        select nextval('coimdimp_s') as cod_dimp
       </querytext>
    </fullquery>

    <fullquery name="sel_manu">
       <querytext>
             select cod_manutentore
               from coimmanu
              where upper(cognome)   $eq_cognome
                and nome      $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="sel_citt">
       <querytext>
             select cod_cittadino
               from coimcitt
              where cognome   $eq_cognome
                and nome      $eq_nome
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_old">
       <querytext>
       select a.cod_manutentore    as cod_manutentore_old
            , a.cod_responsabile   as cod_responsabile_old
            , a.cod_occupante      as cod_occupante_old
            , a.cod_proprietario   as cod_proprietario_old
            , a.cod_intestatario   as cod_int_contr_old
            , a.cod_intestatario   as cod_intestatario_old
            , a.cod_amministratore as cod_ammi_old
	    , a.flag_resp          as flag_resp_old
	    , a.cod_potenza        as cod_potenza_old
            , a.potenza            as potenza_old
            , a.flag_dichiarato
            , a.data_installaz
            , a.note               as note_aimp
            , b.cognome            as cognome_manu_old
            , b.nome               as nome_manu_old
            , c.cognome            as cognome_resp_old
            , c.nome               as nome_resp_old
            , d.cognome            as cognome_occu_old
            , d.nome               as nome_occu_old
            , e.cognome            as cognome_prop_old
            , e.nome               as nome_prop_old
            , f.cognome            as cognome_contr_old
            , f.nome               as nome_contr_old
            , g.cognome            as cognome_ammi_old
            , g.nome               as nome_ammi_old
            , a.data_prima_dich    as dt_prima_dich
         from coimaimp a
	 left outer join coimmanu b on b.cod_manutentore = a.cod_manutentore 
	 left outer join coimcitt c on c.cod_cittadino   = a.cod_responsabile
	 left outer join coimcitt d on d.cod_cittadino   = a.cod_occupante
	 left outer join coimcitt e on e.cod_cittadino   = a.cod_proprietario
	 left outer join coimcitt f on f.cod_cittadino   = a.cod_intestatario
	 left outer join coimcitt g on g.cod_cittadino   = a.cod_amministratore
        where a.cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_check_data_controllo">
       <querytext>
       select '1' 
         from coimdimp$stn
        where cod_impianto   = :cod_impianto
          and data_controllo = :data_controllo
          $where_gen_prog
         limit 1
       </querytext>
    </fullquery>

    <fullquery name="sel_tari_old">
       <querytext>
       select sum(importo_tariffa) as importo_tariffa_old
         from coimdimp$stn
        where cod_impianto   = :cod_impianto
          and data_controllo = :data_controllo
          and importo_tariffa > 0
        </querytext>
    </fullquery>

    <fullquery name="sel_manu_flag_convenzionato">
       <querytext>
        select flag_convenzionato
          from coimmanu
         where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_check_riferimento_pag">
       <querytext>
        select count(*) as count_riferimento_pag
          from coimdimp$stn
         where riferimento_pag = :riferimento_pag
           and tipologia_costo = :tipologia_costo
        $where_codice
       </querytext>
    </fullquery>

    <fullquery name="sel_boll_manu">
       <querytext>
           select matricola_da
                , matricola_a 
                , cod_tpbo
             from coimboll 
            where cod_manutentore = :cod_manutentore
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_cod_movi">
        <querytext>
           select nextval('coimmovi_s') as cod_movi
       </querytext>
    </fullquery>

    <partialquery name="ins_movi">
       <querytext>
                insert
                  into coimmovi 
                     ( cod_movi
                     , tipo_movi
                     , cod_impianto
                     , data_scad
                     , data_compet
                     , importo
                     , importo_pag
                     , riferimento
                     , data_pag
                     , tipo_pag
                     , data_ins
                     , utente
                     , id_caus)
                values 
                     (:cod_movi
                     ,'MH'
                     ,:cod_impianto
                     ,:data_scad_pagamento
                     ,:data_controllo
                     ,:costo
                     ,:importo_pag
                     ,:cod_dimp
                     ,:data_pag
                     ,:tipologia_costo
                     , current_date
                     ,:id_utente
                     ,(select s.id_caus from coimcaus s where codice = 'MH'))
       </querytext>
    </partialquery>

    <partialquery name="upd_movi">
       <querytext>
                update coimmovi
                   set data_scad    = :data_scad_pagamento
                     , data_compet  = :data_controllo
                     , importo      = :costo
                     , importo_pag  = :importo_pag
                     , data_pag     = :data_pag
                     , tipo_pag     = :tipologia_costo
                     , data_mod     =  current_date
                     , utente       = :id_utente
                 where cod_movi     = :cod_movi                 
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_sogg">
       <querytext>
          update coimaimp
             set cod_manutentore  = :cod_manutentore
               , cod_responsabile = :cod_responsabile
               , cod_occupante    = :cod_occupante
               , cod_proprietario = :cod_proprietario
               , cod_amministratore = :cod_ammi
               , cod_intestatario   = :cod_int_contr
	       , flag_resp        = :flag_responsabile
               , data_mod         =  current_date
               , utente           = :id_utente
           where cod_impianto = :cod_impianto
       </querytext>
    </partialquery>

    <fullquery name="sel_rife_check">
       <querytext>
	 select '1'
           from coimrife
          where cod_impianto   = :cod_impianto
            and ruolo          = :ruolo
            and data_fin_valid = (current_date - 1)
       </querytext>
    </fullquery>

    <partialquery name="ins_rife">
       <querytext>
         insert
           into coimrife
              ( cod_impianto
              , ruolo
              , data_fin_valid 
              , cod_soggetto
              , data_ins
              , utente
     ) values (
               :cod_impianto
              ,:ruolo
              ,(current_date - 1)
              ,:cod_soggetto_old
              , current_date
              ,:id_utente
              )
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_flag_dich_data_inst">
       <querytext>
        update coimaimp
           set flag_dichiarato = :flag_dichiarato
             , data_installaz  = :data_installaz
             , note            = :note
             , data_mod        =  current_date
             , utente          = :id_utente 
         where cod_impianto    = :cod_impianto        
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_stato">
       <querytext>
          update coimaimp
             set stato_conformita = :stato_conformita
           where cod_impianto     = :cod_impianto
       </querytext>
    </partialquery>

    <fullquery name="sel_movi_check">
       <querytext>
       select cod_movi 
         from coimmovi
        where riferimento  = :cod_dimp
          and cod_impianto = :cod_impianto
          and id_caus      = (select s.id_caus from coimcaus s where codice = 'MH')
       </querytext>
    </fullquery>

    <partialquery name="del_movi">
       <querytext>
          delete from coimmovi
           where id_caus     = (select s.id_caus from coimcaus s where codice = 'MH')
             and riferimento = :cod_dimp
       </querytext>
    </partialquery>

    <fullquery name="sel_dimp_count">
        <querytext>
        select count(*) as conta_dimp
          from coimdimp$stn
         where cod_impianto = :cod_impianto 
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_last">
        <querytext>
	select max(data_controllo) as data_controllo
          from coimdimp$stn
         where cod_impianto  = :cod_impianto
           and cod_dimp     <> :cod_dimp
        </querytext>
    </fullquery>    

    <fullquery name="sel_tari">
        <querytext>
	select iter_edit_num(a.importo,2) as tariffa
             , a.flag_tariffa_impianti_vecchi                                        --sim01
             , a.anni_fine_tariffa_base                                              --sim01
             , iter_edit_num(a.tariffa_impianti_vecchi,2) as tariffa_impianti_vecchi --sim01
          from coimtari a
         where a.cod_potenza = :cod_potenza_old
           and a.tipo_costo  = '1' 
           and a.cod_listino = :cod_listino
           and a.data_inizio = (select max(d.data_inizio) 
                                  from coimtari d 
                                 where d.cod_potenza = :cod_potenza_old
                                   and d.cod_listino  = :cod_listino
                                   and d.tipo_costo  = '1'
                                   and d.data_inizio <= current_date)
       </querytext>
    </fullquery>

    <fullquery name="sel_tari_contributo">
        <querytext>
	select iter_edit_num(a.importo,2) as importo_tariffa
          from coimtari a
         where a.cod_potenza = :cod_potenza_old
           and a.tipo_costo  = '7' 
           and a.cod_listino = '0'
       </querytext>
    </fullquery>

    <fullquery name="sel_exist_tari">
        <querytext>
	select '1'
          from coimtari a
         where a.importo = :importo_tariffa_check
           and a.tipo_costo  = '7' 
           and a.cod_listino = '0'
       </querytext>
    </fullquery>

    <fullquery name="sel_gend_count">
       <querytext>
        select count(*) as conta_gend
          from coimgend
         where cod_impianto = :cod_impianto
           and flag_attivo  = 'S'
       </querytext>
    </fullquery>

    <partialquery name="upd_gend_pote">
       <querytext>
           update coimgend
	      set pot_focolare_lib = :potenza 
	        , pot_utile_lib    = :potenza
                , pot_focolare_nom = :potenza
                , pot_utile_nom    = :potenza
		, data_mod         =  current_date
		, utente           = :id_utente
            where cod_impianto     = :cod_impianto
              and flag_attivo      = 'S'
              and gen_prog = :gen_prog
       </querytext>
    </partialquery>

    <fullquery name="sel_pote_fascia">
       <querytext>
          select cod_potenza
            from coimpote 
           where potenza_min <= :potenza
             and potenza_max >= :potenza
             and flag_tipo_impianto = :flag_tipo_impianto --sim02 
       </querytext>
    </fullquery>

    <partialquery name="upd_aimp_pote">
       <querytext>
           update coimaimp
	      set cod_potenza    = :cod_potenza
                , potenza        = :potenza
                , potenza_utile  = :potenza
		, data_mod       =  current_date
		, utente         = :id_utente
            where cod_impianto   = :cod_impianto
       </querytext>
    </partialquery>


    <partialquery name="ins_anom">
       <querytext>
                insert
                  into coimanom 
                     ( cod_cimp_dimp
                     , prog_anom
                     , tipo_anom
                     , cod_tanom
                     , dat_utile_inter
		     , flag_origine)
                values 
                     (:cod_dimp
                     ,:prog_anom_db
                     ,'1'
                     ,:cod_anom_db
                     ,:data_ut_int_db
		     ,'MH')
       </querytext>
    </partialquery>

    <fullquery name="sel_tano">
       <querytext>
             select cod_tano||' '||coalesce(descr_tano,'') as note
               from coimtano
              where cod_tano = :cod_anom_db
       </querytext>
    </fullquery>

    <fullquery name="sel_dual_cod_todo">
       <querytext>
        select nextval('coimtodo_s') as cod_todo
       </querytext>
    </fullquery>

    <partialquery name="ins_todo">
        <querytext>
	    insert into 
            coimtodo ( cod_todo
                     , cod_impianto
                     , tipologia
                     , note
                     , cod_cimp_dimp
                     , flag_evasione
		     , data_evasione
                     , data_evento
                     , data_scadenza
                     , data_ins
                     , utente
                     ) values (
		      :cod_todo
		     ,:cod_impianto
		     ,:tipologia
		     ,:note
		     ,:cod_dimp
                     ,:flag_evasione
		     ,:data_evasione
                     ,:data_evento
                     ,:data_scadenza
                     , current_date
                     ,:id_utente
		     )
        </querytext>
    </partialquery>

    <fullquery name="sel_anom">
       <querytext>
           select prog_anom
	        , cod_tanom 
		, iter_edit_data(dat_utile_inter) as dat_utile_inter
             from coimanom 
            where cod_cimp_dimp = :cod_dimp
	      and flag_origine  = 'MH'
         order by to_number(prog_anom,'99999999')
            limit 5
       </querytext>
    </fullquery>

    <fullquery name="sel_anom_count">
       <querytext>
        select count(*) as conta_anom
          from coimanom
         where cod_cimp_dimp = :cod_dimp
           and cod_tanom     = :cod_anom_db
	   and flag_origine  = 'MH'
	   and prog_anom     > :prog_anom_max
	   and prog_anom    <> :prog_anom_db
       </querytext>
    </fullquery>

    <partialquery name="del_todo_anom">
       <querytext>
           delete 
             from coimtodo
            where cod_impianto     = :cod_impianto
              and tipologia        = '1'
              and cod_cimp_dimp    = :cod_dimp
	      and substr(note,1,3) = (select cod_tanom
                                        from coimanom
                                       where cod_cimp_dimp =  :cod_dimp
                                         and flag_origine  =  'MH'
                                         and prog_anom     =  :prog_anom_db)
       </querytext>
    </partialquery>

    <partialquery name="del_anom">
       <querytext>
                delete
                  from coimanom
                 where cod_cimp_dimp = :cod_dimp
		   and flag_origine  = 'MH'
                   and prog_anom     = :prog_anom_db
       </querytext>
    </partialquery>

    <partialquery name="del_todo_boll">
       <querytext>
           delete 
             from coimtodo
            where cod_impianto     = :cod_impianto
              and tipologia        = '1'
              and cod_cimp_dimp    = :cod_dimp
	      and note          like :note
       </querytext>
    </partialquery>

    <partialquery name="del_todo_all">
       <querytext>
        delete
          from coimtodo
         where cod_impianto  = :cod_impianto
           and tipologia    in ('1', '5')
           and cod_cimp_dimp = :cod_dimp
       </querytext>
    </partialquery>

    <partialquery name="del_anom_all">
       <querytext>
           delete
             from coimanom
            where cod_cimp_dimp = :cod_dimp
	      and flag_origine  = 'MH'
       </querytext>
    </partialquery>

    <fullquery name="sel_dimp_esito">
       <querytext>
           select flag_status
                , flag_pericolosita 
             from coimdimp$stn
            where cod_dimp = :cod_dimp
       </querytext>
    </fullquery>

    <fullquery name="sel_gend_no_mod">
       <querytext>
           select b.descr_cost as costruttore
		, a.modello
                , a.cod_mode -- 2014-05-15
		, a.matricola
		, c.descr_comb as combustibile
		, iter_edit_data(a.data_installaz) as data_insta
		, a.tiraggio
		, d.descr_utgi as destinazione
		, a.tipo_foco as tipo_a_c
                , a.locale
                , iter_edit_data(a.data_costruz_gen) as data_costruz_gen
                , iter_edit_data(a.data_costruz_bruc) as data_costruz_bruc
                , a.marc_effic_energ  
                , iter_edit_num(e.volimetria_risc,2) as volimetria_risc
                , iter_edit_num(e.consumo_annuo,2) as consumo_annuo
                , iter_edit_num(a.pot_focolare_nom,2) as pot_focolare_nom
                , iter_edit_num(a.pot_utile_nom,2) as pot_utile_nom
                , a.mod_funz
                , a.tipo_bruciatore
                , iter_edit_num(a.campo_funzion_min,2) as campo_funzion_min
                , iter_edit_num(a.campo_funzion_max,2) as campo_funzion_max
                , a.matricola_bruc
                , a.modello_bruc
                , a.cod_mode_bruc -- 2014-05-15
                , f.descr_cost as costruttore_bruc
             from coimaimp e
       inner join coimgend a on a.cod_impianto = e.cod_impianto
  left outer join coimcost b on b.cod_cost = a.cod_cost
  left outer join coimcomb c on c.cod_combustibile = a.cod_combustibile
  left outer join coimutgi d on d.cod_utgi = a.cod_utgi
  left outer join coimcost f on f.cod_cost = a.cod_cost_bruc
            where e.cod_impianto = :cod_impianto
              and a.gen_prog     = :gen_prog
       </querytext>
    </fullquery>

    <fullquery name="sel_gend_mod">
       <querytext>
           select b.cod_cost as costruttore
		, a.modello
                , a.cod_mode -- 2014-05-15
		, a.matricola
		, c.cod_combustibile as combustibile
		, iter_edit_data(a.data_installaz) as data_insta
		, a.tiraggio
		, d.cod_utgi as destinazione
		, a.tipo_foco as tipo_a_c
                , a.locale
                , iter_edit_data(a.data_costruz_gen) as data_costruz_gen
                , iter_edit_data(a.data_costruz_bruc) as data_costruz_bruc
                , a.marc_effic_energ  
                , iter_edit_num(e.volimetria_risc,2) as volimetria_risc
                , iter_edit_num(e.consumo_annuo,2) as consumo_annuo
                , iter_edit_num(a.pot_focolare_nom,2) as pot_focolare_nom
                , iter_edit_num(a.pot_utile_nom,2) as pot_utile_nom
                , a.mod_funz
                , a.tipo_bruciatore
                , iter_edit_num(a.campo_funzion_min,2) as campo_funzion_min
                , iter_edit_num(a.campo_funzion_max,2) as campo_funzion_max
                , a.matricola_bruc
                , a.modello_bruc
                , a.cod_mode_bruc -- 2014-05-15
                , f.cod_cost as costruttore_bruc
             from coimaimp e
       inner join coimgend a on a.cod_impianto = e.cod_impianto
  left outer join coimcost b on b.cod_cost = a.cod_cost
  left outer join coimcomb c on c.cod_combustibile = a.cod_combustibile
  left outer join coimutgi d on d.cod_utgi = a.cod_utgi
  left outer join coimcost f on f.cod_cost = a.cod_cost_bruc
            where e.cod_impianto = :cod_impianto
              and a.gen_prog     = :gen_prog
       </querytext>
    </fullquery>

    <fullquery name="sel_tano_scatenante">
       <querytext>
           select flag_scatenante
             from coimtano 
            where cod_tano = :cod_anomalia
       </querytext>
    </fullquery>

    <fullquery name="sel_tano_anom">
        <querytext>
           select a.cod_tanom       as cod_tanom_check 
                , b.flag_scatenante as flag_scatenante_check
             from coimanom a
                , coimtano b
            where a.cod_cimp_dimp = :cod_dimp
	      and a.flag_origine  = 'MH'
	      and b.cod_tano      = a.cod_tanom
        </querytext>
    </fullquery>

    <fullquery name="sel_anom_count2">
       <querytext>
        select count(*) as conta_anom_2
          from coimanom
         where cod_cimp_dimp = :cod_dimp
	   and flag_origine  = 'MH'
       </querytext>
    </fullquery>

    <partialquery name="sel_gage">
        <querytext>
            select iter_edit_data(data_prevista)   as data_prevista
              from coimgage
             where cod_opma     = :cod_opma
               and cod_impianto = :cod_impianto
               and data_ins     = :data_ins
        </querytext>
    </partialquery>

    <partialquery name="upd_gage">
        <querytext>
            update coimgage
               set data_esecuzione = :data_esecuzione
                 , stato           = :stato
             where cod_opma     = :cod_opma
               and cod_impianto = :cod_impianto
               and data_ins     = :data_ins
        </querytext>
    </partialquery>

    <fullquery name="sel_aimp_comu">
        <querytext>
              select cod_comune
                from coimaimp
	       where cod_impianto = :cod_impianto
        </querytext>
    </fullquery>

    <fullquery name="sel_tano_gg_adattamento">
        <querytext>
              select gg_adattamento
                from coimtano
	       where cod_tano = :cod_anomalia
        </querytext>
    </fullquery>


    <fullquery name="upd_aimp">
       <querytext>
            update coimaimp
               set cod_intestatario = :cod_int_contr
             where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>


    <fullquery name="upd_tppt">
       <querytext>
            update coimtppt
               set progressivo = progressivo + 1
             where cod_tppt = 'UC'
       </querytext>
    </fullquery>


    <fullquery name="check_modh_old">
       <querytext>
           select to_char(max(data_controllo), 'yyyymmdd') as data_ultimo_modh
             from coimdimp$stn
            where cod_impianto = :cod_impianto              
       </querytext>
    </fullquery>

    <fullquery name="sel_gend_list">
       <querytext>
           select gen_prog
             from coimgend
            where cod_impianto = :cod_impianto
	      and flag_attivo  = 'S'
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_check_multiple">
       <querytext>
           select count(*) as conta_dimp_multiple
             from coimdimp$stn
            where cod_impianto = :cod_impianto
	      and data_ins     = current_date
       </querytext>
    </fullquery>

    <fullquery name="sel_dimp_pag1">
       <querytext>
             select a.lib_impianto
                  , a.lib_impianto_note
                  , a.rapp_contr
                  , a.rapp_contr_note
                  , a.certificaz
                  , a.certificaz_note
                  , a.dich_conf
                  , a.dich_conf_note
                  , a.lib_uso_man
                  , a.lib_uso_man_note
                  , a.libretto_bruc
                  , a.libretto_bruc_note
                  , a.ispesl
                  , a.ispesl_note
                  , a.prev_incendi
                  , a.prev_incendi_note
                  , a.esame_vis_l_elet
                  , a.idoneita_locale
                  , a.assenza_fughe
                  , a.ap_ventilaz
                  , a.ap_vent_ostruz
                  , a.coibentazione
                  , a.conservazione
               from coimdimp$stn a
              where a.cod_impianto = :cod_impianto
                and a.data_ins = current_date
              limit 1
       </querytext>
    </fullquery>

    <fullquery name="add_months">
       <querytext>
	   select to_char(add_months(:data_controllo, :valid_mod_h_b),'yyyy-mm-dd') as data_scadenza_autocert
       </querytext>
    </fullquery>

    <fullquery name="sel_tgen">
       <querytext>
	   select *
             from coimtgen
       </querytext>
    </fullquery>

    <fullquery name="sel_min_data_controllo">
       <querytext>
	   select min(data_controllo) as min_data_controllo
             from coimdimp$stn
            where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_max_data_controllo">
       <querytext>
	   select max(data_controllo) as max_data_controllo
             from coimdimp$stn
            where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <partialquery name="upd_aimp_prima_dich">
       <querytext>
        update coimaimp
           set data_prima_dich  = :data_controllo
             , data_mod        =  current_date
             , utente          = :id_utente 
         where cod_impianto    = :cod_impianto        
       </querytext>
    </partialquery>

    <partialquery name="upd_aimp_ultim_dich">
       <querytext>
        update coimaimp
           set data_ultim_dich = :data_controllo
             , data_scad_dich  = :data_scadenza_autocert
             , data_mod        =  current_date
             , utente          = :id_utente 
         where cod_impianto    = :cod_impianto        
       </querytext>
    </partialquery>
    
    <fullquery name="sel_utente_ins">
       <querytext>	
          select coalesce(cognome,'')||' '||coalesce(nome,'') as nome_utente_ins
	  from coimuten
	  where id_utente = :utente_ins
       </querytext>
    </fullquery>

    <partialquery name="upd_gend">
       <querytext>
           update coimgend
	      set cod_cost         = :costruttore
                , modello          = :modello
		, cod_mode         = :cod_mode -- 2014-05-15
                , matricola        = :matricola
                , cod_combustibile = :combustibile
                , tipo_foco        = :tipo_a_c
                , data_installaz   = :data_insta
                , cod_utgi         = :destinazione
                , locale           = :locale
                , data_costruz_gen = :data_costruz_gen
                , marc_effic_energ = :marc_effic_energ
                , pot_focolare_nom = :pot_focolare_nom
                , pot_utile_nom    = :potenza
                , modello_bruc     = :modello_bruc
		, cod_mode_bruc    = :cod_mode_bruc -- 2014-05-15
                , matricola_bruc   = :matricola_bruc
	        , cod_cost_bruc    = :costruttore_bruc
                , mod_funz         = :mod_funz
                , tipo_bruciatore  = :tipo_bruciatore
	        , campo_funzion_max = :campo_funzion_max
	        , campo_funzion_min = :campo_funzion_min
                , data_costruz_bruc = :data_costruz_bruc
            where cod_impianto     = :cod_impianto
              and flag_attivo      = 'S'
              and gen_prog = :gen_prog
       </querytext>
    </partialquery>

    <fullquery name="upd_aimp_mod">
       <querytext>
            update coimaimp
               set cod_combustibile = :combustibile
                 , data_installaz   = :data_insta
                 , consumo_annuo    = :consumo_annuo
                 , marc_effic_energ = :marc_effic_energ
                 , volimetria_risc  = :volimetria_risc
                 , anno_costruzione = :data_costruz_bruc
             where cod_impianto = :cod_impianto
       </querytext>
    </fullquery>

    <fullquery name="sel_cod_legale">
       <querytext>
             select a.cod_legale_rapp as cod_terzi
                  , b.cognome as cognome_terzi
                  , b.nome as nome_terzi
               from coimmanu a
                  , coimcitt b
              where a.cod_manutentore = :cod_terzi
                and a.cod_legale_rapp = b.cod_cittadino
       </querytext>
    </fullquery>

</queryset>
