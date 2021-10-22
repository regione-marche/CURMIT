<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_tgen1">
       <querytext>
                   select cod_tgen
                        , iter_edit_num(a.valid_mod_h, 0) as valid_mod_h
                        , iter_edit_num(a.gg_comunic_mod_h, 0) as gg_comunic_mod_h
                        , case a.flag_ente
			      when 'C' then 'Comune'
                              when 'P' then 'Provincia'
			  end as flag_ente
                        , b.sigla as sigla_prov
                        , c.denominazione as desc_comu
                        , a.flag_viario
                        ,iter_edit_num(a.gg_conferma_inco, 0) as gg_conferma_inco
                        , iter_edit_num(a.gg_scad_pag_mh,0) as gg_scad_pag_mh
                        , iter_edit_num(a.gg_scad_pag_rv,0) as gg_scad_pag_rv
                        , iter_edit_num(a.mesi_evidenza_mod,0) as mesi_evidenza_mod
                        , a.flag_agg_sogg
                        , a.flag_dt_scad
			, a.flag_agg_da_verif
			, a.flag_cod_aimp_auto
			, a.flag_cod_via_auto
                        , a.flag_gg_modif_mh
                        , a.flag_gg_modif_rv
                        , a.gg_adat_anom_oblig
                        , a.gg_adat_anom_autom
                        , iter_edit_num(a.popolaz_citt_tgen,0) as popolaz_citt_tgen
                        , iter_edit_num(a.popolaz_aimp_tgen,0) as popolaz_aimp_tgen
                        , a.flag_aimp_citt_estr
                        , a.flag_stat_estr_calc
                        , a.link_cap
                        , a.flag_enti_compet
                        , a.flag_master_ente
                        , a.flag_codifica_reg
                        , a.flag_pesi
                        , a.flag_sanzioni
                        , a.flag_avvisi
                        , a.flag_mod_gend
                        , a.flag_asse_data
                        , a.flag_obbligo_canne
                        , a.flag_default_contr_fumi
                        , a.cod_imst_cari_manu
                        , a.cod_imst_annu_manu
                        , a.max_gg_modimp
                        , a.flag_bollino_obb
                        , a.flag_limite_portaf
                        , iter_edit_num(a.valore_limite_portaf, 2) as valore_limite_portaf
                        , flag_multivie
                        , flag_stp_presso_terzo_resp
                        , flag_portale
                        , flag_gest_coimmode   -- 2014-03-04
                        , lun_num_cod_imp_est  -- 2016-02-04
                        , flag_potenza         -- 2016-02-12
                        , flag_gest_targa      -- 2016-09-06
                        , flag_gest_rcee_legna -- 2017-02-20
                        , flag_verifica_impianti --2017-06-30
			, flag_single_sign_on   --rom01 2018-02-27
			, indirizzo_pec    -- rom01-2018-03-22
			, nome_utente_pec  -- rom01-2018-03-22
			, password_pec     -- rom01-2018-03-22
			, stmp_pec         -- rom01-2018-03-22
			, porta_uscita_pec -- rom01-2018-03-22
                        , flag_obbligo_dati_catastali --sim06
                    from coimtgen a
                          inner join coimprov b on b.cod_provincia = a.cod_prov
                     left outer join coimcomu c on c.cod_comune    = a.cod_comu
                    where a.cod_tgen = '1'
       </querytext>
    </fullquery>

    <partialquery name="upd_tgen">
       <querytext>
                   update coimtgen
		      set valid_mod_h         = :valid_mod_h  
			, gg_comunic_mod_h    = :gg_comunic_mod_h 
			, gg_conferma_inco    = :gg_conferma_inco
			, gg_scad_pag_mh      = :gg_scad_pag_mh
			, gg_scad_pag_rv      = :gg_scad_pag_rv
                        , mesi_evidenza_mod   = :mesi_evidenza_mod
                        , flag_agg_sogg       = :flag_agg_sogg
                        , flag_dt_scad        = :flag_dt_scad
			, flag_agg_da_verif   = :flag_agg_da_verif
			, flag_cod_aimp_auto  = :flag_cod_aimp_auto
			, flag_cod_via_auto  = :flag_cod_via_auto
			, flag_gg_modif_mh    = :flag_gg_modif_mh
                        , flag_gg_modif_rv    = :flag_gg_modif_rv
                        , data_mod            = :current_date
                        , utente_ult          = :id_utente
                        , gg_adat_anom_oblig  = :gg_adat_anom_oblig
                        , gg_adat_anom_autom  = :gg_adat_anom_autom
                        , popolaz_citt_tgen   = :popolaz_citt_tgen
                        , popolaz_aimp_tgen   = :popolaz_aimp_tgen
                        , flag_aimp_citt_estr = :flag_aimp_citt_estr
                        , flag_stat_estr_calc = :flag_stat_estr_calc
                        , link_cap            = :link_cap
                        , flag_enti_compet    = :flag_enti_compet
                        , flag_master_ente    = :flag_master_ente
                        , flag_codifica_reg   = :flag_codifica_reg
                        , flag_pesi           = :flag_pesi
                        , flag_sanzioni       = :flag_sanzioni
                        , flag_avvisi         = :flag_avvisi
                        , flag_mod_gend       = :flag_mod_gend
                        , flag_asse_data      = :flag_asse_data
                        , flag_obbligo_canne  = :flag_obbligo_canne
                        , flag_default_contr_fumi = :flag_default_contr_fumi
                        , cod_imst_cari_manu  = :cod_imst_cari_manu
                        , cod_imst_annu_manu  = :cod_imst_annu_manu
                        , max_gg_modimp	      = :max_gg_modimp 
                        , flag_bollino_obb    = :flag_bollino_obb
                        , flag_limite_portaf  = :flag_limite_portaf
                        , valore_limite_portaf = :valore_limite_portaf
                        , flag_multivie        = :flag_multivie
                        , flag_stp_presso_terzo_resp = :flag_stp_presso_terzo_resp
                        , flag_portale               = :flag_portale
                        , flag_gest_coimmode         = :flag_gest_coimmode   -- 2014-03-04
                        , lun_num_cod_imp_est        = :lun_num_cod_imp_est  -- 2016-02-04
                        , flag_potenza               = :flag_potenza         -- 2016-02-12
                        , flag_gest_targa            = :flag_gest_targa      -- 2016-09-06
                        , flag_gest_rcee_legna       = :flag_gest_rcee_legna -- 2017-02-20
			, flag_verifica_impianti     = :flag_verifica_impianti --2017-06-30
			, flag_single_sign_on        = :flag_single_sign_on    --rom01 2018-02-27 
			, indirizzo_pec    = :indirizzo_pec    -- rom01-2018-03-22
			, nome_utente_pec  = :nome_utente_pec  -- rom01-2018-03-22
			, password_pec     = :password_pec     -- rom01-2018-03-22
			, stmp_pec         = :stmp_pec         -- rom01-2018-03-22
			, porta_uscita_pec = :porta_uscita_pec -- rom01-2018-03-22
                        , flag_obbligo_dati_catastali = :flag_obbligo_dati_catastali --sim06
			where cod_tgen            = :cod_tgen
       </querytext>
    </partialquery>

    <fullquery name="sel_dual_date">
       <querytext>
                   select to_char(current_date, 'yyyymmdd') as current_date 
       </querytext>
    </fullquery>

    <fullquery name="check_tgen">
       <querytext>
            select '1'
              from coimtgen
             where cod_tgen = :cod_tgen
       </querytext>
    </fullquery>

    <fullquery name="selec_max_aimp">
       <querytext>
            select coalesce(max(to_number(cod_impianto_est, '9999999990') ),0)+1 as max_cod_impianto_est
              from coimaimp
	     where cod_impianto_est < 'A'
        </querytext>
    </fullquery>

    <fullquery name="selec_max_via">
       <querytext>
            select coalesce(max(to_number(cod_via, '9999999990') ),0)+1 as max_cod_via
              from coimviae
        </querytext>
    </fullquery>

    <partialquery name="drop_sequence">
       <querytext>
       drop sequence coimaimp_est_s
       </querytext>
    </partialquery>

    <partialquery name="create_sequence">
       <querytext>
       create sequence coimaimp_est_s start $max_cod_impianto_est
       </querytext>
    </partialquery>

    <partialquery name="drop_sequence_via">
       <querytext>
       drop sequence coimviae_s
       </querytext>
    </partialquery>

    <partialquery name="create_sequence_via">
       <querytext>
       create sequence coimviae_s start $max_cod_via
       </querytext>
    </partialquery>

    <fullquery name="sel_aimp_count">
       <querytext>
            select iter_edit_num(count(*),0) as conta_impianti
              from coimaimp
	     where stato = 'A'
        </querytext>
    </fullquery>


</queryset>
