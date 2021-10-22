<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_tgen1">
       <querytext>
                   select cod_tgen
                        , iter_edit.num(a.valid_mod_h, 0) as valid_mod_h
                        , iter_edit.num(a.gg_comunic_mod_h, 0) as gg_comunic_mod_h
                        , iter_edit.num(a.valid_mod_h_b, 0) as valid_mod_h_b
                        , iter_edit.num(a.gg_comunic_mod_h_b, 0) as gg_comunic_mod_h_b
                        , decode (a.flag_ente
			      ,'C' , 'Comune'
                              ,'P' , 'Provincia'
			  ) as flag_ente
                        , b.sigla as sigla_prov
                        , c.denominazione as desc_comu
                        , a.flag_viario
                        , a.flag_mod_h_b
                        , iter_edit.num(a.gg_conferma_inco, 0) as gg_conferma_inco
			, iter_edit.num(a.gg_scad_pag_mh,0) as gg_scad_pag_mh
			, iter_edit.num(a.gg_scad_pag_rv,0) as gg_scad_pag_rv
                        , iter_edit.num(a.mesi_evidenza_mod, 0) as mesi_evidenza_mod
                        , a.flag_agg_sogg
                        , a.flag_dt_scad
			, a.flag_agg_da_verif
			, a.flag_cod_aimp_auto
			, a.flag_cod_via_auto
                        , a.flag_gg_modif_mh
                        , a.flag_gg_modif_rv
                        , a.flag_gg_modif_mh
                        , a.flag_gg_modif_rv
                        , a.gg_adat_anom_oblig
                        , a.gg_adat_anom_autom
                        , iter_edit.num(a.popolaz_citt_tgen,0) as popolaz_citt_tgen
                        , iter_edit.num(a.popolaz_aimp_tgen,0) as popolaz_aimp_tgen
                        , a.flag_aimp_citt_estr
                        , a.flag_stat_estr_calc
                        , a.link_cap
                        , a.flag_enti_compet
                        , a.flag_master_ente
                        , a.flag_stp_presso_terzo_resp
                        , a.flag_portale
                        , a.flag_gest_coimmode
                        , a.lun_num_cod_imp_est
                        , a.flag_potenza
                     from coimtgen a
                        , coimprov b
                        , coimcomu c
                    where a.cod_tgen         = 1
		      and b.cod_provincia    = a.cod_prov
                      and c.cod_comune   (+) = a.cod_comu
       </querytext>
    </fullquery>

     <partialquery name="upd_tgen">
       <querytext>
                   update coimtgen
		      set valid_mod_h         = :valid_mod_h  
			, gg_comunic_mod_h    = :gg_comunic_mod_h 
			, valid_mod_h_b       = :valid_mod_h_b
			, gg_comunic_mod_h_b  = :gg_comunic_mod_h_b 
                        , flag_mod_h_b        = :flag_mod_h_b 
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
                        , flag_stp_presso_terzo_resp = :flag_stp_presso_terzo_resp
                        , flag_portale               = :flag_portale
                        , flag_gest_coimmode         = :flag_gest_coimmode
                        , lun_num_cod_imp_est        = :lun_num_cod_imp_est
                        , flag_potenza               = :flag_potenza
                    where cod_tgen            = :cod_tgen
       </querytext>
    </partialquery>

    <fullquery name="sel_dual_date">
       <querytext>
                   select to_char(sysdate, 'yyyymmdd') as current_date 
                     from dual
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
            select nvl(max(to_number(cod_impianto_est, '9999999990') ),0)+1 as max_cod_impianto_est
              from coimaimp
	     where cod_impianto_est < 'A'
        </querytext>
    </fullquery>

    <fullquery name="selec_max_via">
       <querytext>
            select nvl(max(to_number(cod_via, '9999999990') ),0)+1 as max_cod_via
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
       create sequence coimaimp_est_s start with $max_cod_impianto_est
       </querytext>
    </partialquery>

    <partialquery name="drop_sequence_via">
       <querytext>
       drop sequence coimviae_s
       </querytext>
    </partialquery>

    <partialquery name="create_sequence_via">
       <querytext>
       create sequence coimviae_s start with $max_cod_via
       </querytext>
    </partialquery>

    <fullquery name="sel_aimp_count">
       <querytext>
            select iter_edit.num(count(*),0) as conta_impianti
              from coimaimp
	     where stato = 'A'
        </querytext>
    </fullquery>


 </queryset>
