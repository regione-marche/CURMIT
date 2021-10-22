SET echo OFF feedback OFF head OFF linesize      21242
SET pagesize 0 space 0 tab OFF trimspool ON termout OFF verify OFF colsep "|"
COLUMN cod_cimp                         FORMAT A8                                       HEADING 'X'
COLUMN cod_impianto                     FORMAT A8                                       HEADING 'X'
COLUMN cod_documento                    FORMAT A8                                       HEADING 'X'
COLUMN gen_prog                         FORMAT 09999999                                 HEADING 'X'
COLUMN cod_inco                         FORMAT A8                                       HEADING 'X'
COLUMN data_controllo                   FORMAT A10                                      HEADING 'X'
COLUMN verb_n                           FORMAT A20                                      HEADING 'X'
COLUMN data_verb                        FORMAT A10                                      HEADING 'X'
COLUMN cod_opve                         FORMAT A8                                       HEADING 'X'
COLUMN costo                            FORMAT 0999999.99                               HEADING 'X'
COLUMN nominativo_pres                  FORMAT A4000                                    HEADING 'X'
COLUMN presenza_libretto                FORMAT A2                                       HEADING 'X'
COLUMN libretto_corretto                FORMAT A2                                       HEADING 'X'
COLUMN dich_conformita                  FORMAT A2                                       HEADING 'X'
COLUMN libretto_manutenz                FORMAT A2                                       HEADING 'X'
COLUMN mis_port_combust                 FORMAT 0999999.99                               HEADING 'X'
COLUMN mis_pot_focolare                 FORMAT 0999999.99                               HEADING 'X'
COLUMN stato_coiben                     FORMAT A2                                       HEADING 'X'
COLUMN stato_canna_fum                  FORMAT A2                                       HEADING 'X'
COLUMN verifica_dispo                   FORMAT A2                                       HEADING 'X'
COLUMN verifica_areaz                   FORMAT A2                                       HEADING 'X'
COLUMN taratura_dispos                  FORMAT A2                                       HEADING 'X'
COLUMN co_fumi_secchi                   FORMAT 0999999.99                               HEADING 'X'
COLUMN ppm                              FORMAT 0999999.99                               HEADING 'X'
COLUMN eccesso_aria_perc                FORMAT 0999999.99                               HEADING 'X'
COLUMN perdita_ai_fumi                  FORMAT 0999999.99                               HEADING 'X'
COLUMN rend_comb_conv                   FORMAT 0999999.99                               HEADING 'X'
COLUMN rend_comb_min                    FORMAT 0999999.99                               HEADING 'X'
COLUMN temp_fumi_1a                     FORMAT 0999.99                                  HEADING 'X'
COLUMN temp_fumi_2a                     FORMAT 0999.99                                  HEADING 'X'
COLUMN temp_fumi_3a                     FORMAT 0999.99                                  HEADING 'X'
COLUMN temp_fumi_md                     FORMAT 0999.99                                  HEADING 'X'
COLUMN t_aria_comb_1a                   FORMAT 0999.99                                  HEADING 'X'
COLUMN t_aria_comb_2a                   FORMAT 0999.99                                  HEADING 'X'
COLUMN t_aria_comb_3a                   FORMAT 0999.99                                  HEADING 'X'
COLUMN t_aria_comb_md                   FORMAT 0999.99                                  HEADING 'X'
COLUMN temp_mant_1a                     FORMAT 0999.99                                  HEADING 'X'
COLUMN temp_mant_2a                     FORMAT 0999.99                                  HEADING 'X'
COLUMN temp_mant_3a                     FORMAT 0999.99                                  HEADING 'X'
COLUMN temp_mant_md                     FORMAT 0999.99                                  HEADING 'X'
COLUMN temp_h2o_out_1a                  FORMAT 0999.99                                  HEADING 'X'
COLUMN temp_h2o_out_2a                  FORMAT 0999.99                                  HEADING 'X'
COLUMN temp_h2o_out_3a                  FORMAT 0999.99                                  HEADING 'X'
COLUMN temp_h2o_out_md                  FORMAT 0999.99                                  HEADING 'X'
COLUMN co2_1a                           FORMAT 0999.99                                  HEADING 'X'
COLUMN co2_2a                           FORMAT 0999.99                                  HEADING 'X'
COLUMN co2_3a                           FORMAT 0999.99                                  HEADING 'X'
COLUMN co2_md                           FORMAT 0999.99                                  HEADING 'X'
COLUMN o2_1a                            FORMAT 0999.99                                  HEADING 'X'
COLUMN o2_2a                            FORMAT 0999.99                                  HEADING 'X'
COLUMN o2_3a                            FORMAT 0999.99                                  HEADING 'X'
COLUMN o2_md                            FORMAT 0999.99                                  HEADING 'X'
COLUMN co_1a                            FORMAT 099999.9999                              HEADING 'X'
COLUMN co_2a                            FORMAT 099999.9999                              HEADING 'X'
COLUMN co_3a                            FORMAT 099999.9999                              HEADING 'X'
COLUMN co_md                            FORMAT 099999.9999                              HEADING 'X'
COLUMN indic_fumosita_1a                FORMAT 0999.99                                  HEADING 'X'
COLUMN indic_fumosita_2a                FORMAT 0999.99                                  HEADING 'X'
COLUMN indic_fumosita_3a                FORMAT 0999.99                                  HEADING 'X'
COLUMN indic_fumosita_md                FORMAT 0999.99                                  HEADING 'X'
COLUMN manutenzione_8a                  FORMAT A2                                       HEADING 'X'
COLUMN co_fumi_secchi_8b                FORMAT A2                                       HEADING 'X'
COLUMN indic_fumosita_8c                FORMAT A2                                       HEADING 'X'
COLUMN rend_comb_8d                     FORMAT A2                                       HEADING 'X'
COLUMN esito_verifica                   FORMAT A2                                       HEADING 'X'
COLUMN strumento                        FORMAT A100                                     HEADING 'X'
COLUMN note_verificatore                FORMAT A4000                                    HEADING 'X'
COLUMN note_resp                        FORMAT A4000                                    HEADING 'X'
COLUMN note_conf                        FORMAT A4000                                    HEADING 'X'
COLUMN tipologia_costo                  FORMAT A2                                       HEADING 'X'
COLUMN riferimento_pag                  FORMAT A20                                      HEADING 'X'
COLUMN utente                           FORMAT A10                                      HEADING 'X'
COLUMN data_ins                         FORMAT A10                                      HEADING 'X'
COLUMN data_mod                         FORMAT A10                                      HEADING 'X'
COLUMN pot_utile_nom                    FORMAT 0999999.99                               HEADING 'X'
COLUMN pot_focolare_nom                 FORMAT 0999999.99                               HEADING 'X'
COLUMN cod_combustibile                 FORMAT A8                                       HEADING 'X'
COLUMN cod_responsabile                 FORMAT A8                                       HEADING 'X'
COLUMN flag_cpi                         FORMAT A1                                       HEADING 'X'
COLUMN flag_ispes                       FORMAT A1                                       HEADING 'X'
COLUMN flag_pericolosita                FORMAT A1                                       HEADING 'X'
COLUMN flag_tracciato                   FORMAT A2                                       HEADING 'X'
COLUMN new1_data_dimp                   FORMAT A10                                      HEADING 'X'
COLUMN new1_data_paga_dimp              FORMAT A10                                      HEADING 'X'
COLUMN new1_conf_locale                 FORMAT A1                                       HEADING 'X'
COLUMN new1_conf_accesso                FORMAT A1                                       HEADING 'X'
COLUMN new1_pres_intercet               FORMAT A1                                       HEADING 'X'
COLUMN new1_pres_interrut               FORMAT A1                                       HEADING 'X'
COLUMN new1_asse_mate_estr              FORMAT A1                                       HEADING 'X'
COLUMN new1_pres_mezzi                  FORMAT A1                                       HEADING 'X'
COLUMN new1_pres_cartell                FORMAT A1                                       HEADING 'X'
COLUMN new1_disp_regolaz                FORMAT A1                                       HEADING 'X'
COLUMN new1_foro_presente               FORMAT A1                                       HEADING 'X'
COLUMN new1_foro_corretto               FORMAT A1                                       HEADING 'X'
COLUMN new1_foro_accessibile            FORMAT A1                                       HEADING 'X'
COLUMN new1_canali_a_norma              FORMAT A1                                       HEADING 'X'
COLUMN new1_lavoro_nom_iniz             FORMAT 0999999.99                               HEADING 'X'
COLUMN new1_lavoro_nom_fine             FORMAT 0999999.99                               HEADING 'X'
COLUMN new1_lavoro_lib_iniz             FORMAT 0999999.99                               HEADING 'X'
COLUMN new1_lavoro_lib_fine             FORMAT 0999999.99                               HEADING 'X'
COLUMN new1_note_manu                   FORMAT A4000                                    HEADING 'X'
COLUMN new1_dimp_pres                   FORMAT A1                                       HEADING 'X'
COLUMN new1_dimp_prescriz               FORMAT A1                                       HEADING 'X'
COLUMN new1_data_ultima_manu            FORMAT A10                                      HEADING 'X'
COLUMN new1_data_ultima_anal            FORMAT A10                                      HEADING 'X'
COLUMN new1_manu_prec_8a                FORMAT A1                                       HEADING 'X'
COLUMN new1_co_rilevato                 FORMAT 0999.99                                  HEADING 'X'
COLUMN new1_flag_peri_8p                FORMAT A1                                       HEADING 'X'
COLUMN flag_uso                         FORMAT A1                                       HEADING 'X'
COLUMN flag_diffida                     FORMAT A1                                       HEADING 'X'
COLUMN eccesso_aria_perc_2a             FORMAT 0999999.99                               HEADING 'X'
COLUMN eccesso_aria_perc_3a             FORMAT 0999999.99                               HEADING 'X'
COLUMN eccesso_aria_perc_md             FORMAT 0999999.99                               HEADING 'X'
COLUMN n_prot                           FORMAT A20                                      HEADING 'X'
COLUMN data_prot                        FORMAT A10                                      HEADING 'X'
COLUMN sezioni_corr                     FORMAT A1                                       HEADING 'X'
COLUMN curve_corr                       FORMAT A1                                       HEADING 'X'
COLUMN lungh_corr                       FORMAT A1                                       HEADING 'X'
COLUMN riflussi_loc                     FORMAT A1                                       HEADING 'X'
COLUMN perdite_cond                     FORMAT A1                                       HEADING 'X'
COLUMN disp_funz                        FORMAT A1                                       HEADING 'X'
COLUMN assenza_fughe                    FORMAT A1                                       HEADING 'X'
COLUMN effic_evac                       FORMAT A1                                       HEADING 'X'
COLUMN autodich                         FORMAT A1                                       HEADING 'X'
COLUMN dich_conf                        FORMAT A1                                       HEADING 'X'
COLUMN manut_prog                       FORMAT A1                                       HEADING 'X'
COLUMN marca_strum                      FORMAT A50                                      HEADING 'X'
COLUMN modello_strum                    FORMAT A50                                      HEADING 'X'
COLUMN matr_strum                       FORMAT A50                                      HEADING 'X'
COLUMN dt_tar_strum                     FORMAT A10                                      HEADING 'X'
COLUMN indice_aria                      FORMAT 0999.99                                  HEADING 'X'
COLUMN perd_cal_sens                    FORMAT 0999.99                                  HEADING 'X'
COLUMN doc_ispesl                       FORMAT A1                                       HEADING 'X'
COLUMN doc_prev_incendi                 FORMAT A1                                       HEADING 'X'
COLUMN libr_manut_bruc                  FORMAT A1                                       HEADING 'X'
COLUMN ubic_locale_norma                FORMAT A1                                       HEADING 'X'
COLUMN disp_chius_porta                 FORMAT A1                                       HEADING 'X'
COLUMN spazi_norma                      FORMAT A1                                       HEADING 'X'
COLUMN apert_soffitto                   FORMAT A1                                       HEADING 'X'
COLUMN rubin_manuale_acces              FORMAT A1                                       HEADING 'X'
COLUMN assenza_app_peric                FORMAT A1                                       HEADING 'X'
COLUMN rubin_chiuso                     FORMAT A1                                       HEADING 'X'
COLUMN elettrovalv_esterne              FORMAT A1                                       HEADING 'X'
COLUMN tubaz_press                      FORMAT A1                                       HEADING 'X'
COLUMN tolta_tensione                   FORMAT A1                                       HEADING 'X'
COLUMN termost_esterno                  FORMAT A1                                       HEADING 'X'
COLUMN chiusura_foro                    FORMAT A1                                       HEADING 'X'
COLUMN accens_funz_gen                  FORMAT A1                                       HEADING 'X'
COLUMN pendenza                         FORMAT A1                                       HEADING 'X'
COLUMN ventilaz_lib_ostruz              FORMAT A1                                       HEADING 'X'
COLUMN disp_reg_cont_pre                FORMAT A1                                       HEADING 'X'
COLUMN disp_reg_cont_funz               FORMAT A1                                       HEADING 'X'
COLUMN disp_reg_clim_funz               FORMAT A1                                       HEADING 'X'
COLUMN conf_imp_elettrico               FORMAT A1                                       HEADING 'X'
COLUMN volumetria                       FORMAT 0999999.99                               HEADING 'X'
COLUMN comsumi_ultima_stag              FORMAT 0999999.99                               HEADING 'X'
SELECT cod_cimp
      ,cod_impianto
      ,cod_documento
      ,gen_prog
      ,cod_inco
      ,TO_CHAR(data_controllo,'YYYY-MM-DD') data_controllo
      ,verb_n
      ,TO_CHAR(data_verb,'YYYY-MM-DD') data_verb
      ,cod_opve
      ,costo
      ,nominativo_pres
      ,presenza_libretto
      ,libretto_corretto
      ,dich_conformita
      ,libretto_manutenz
      ,mis_port_combust
      ,mis_pot_focolare
      ,stato_coiben
      ,stato_canna_fum
      ,verifica_dispo
      ,verifica_areaz
      ,taratura_dispos
      ,co_fumi_secchi
      ,ppm
      ,eccesso_aria_perc
      ,perdita_ai_fumi
      ,rend_comb_conv
      ,rend_comb_min
      ,temp_fumi_1a
      ,temp_fumi_2a
      ,temp_fumi_3a
      ,temp_fumi_md
      ,t_aria_comb_1a
      ,t_aria_comb_2a
      ,t_aria_comb_3a
      ,t_aria_comb_md
      ,temp_mant_1a
      ,temp_mant_2a
      ,temp_mant_3a
      ,temp_mant_md
      ,temp_h2o_out_1a
      ,temp_h2o_out_2a
      ,temp_h2o_out_3a
      ,temp_h2o_out_md
      ,co2_1a
      ,co2_2a
      ,co2_3a
      ,co2_md
      ,o2_1a
      ,o2_2a
      ,o2_3a
      ,o2_md
      ,co_1a
      ,co_2a
      ,co_3a
      ,co_md
      ,indic_fumosita_1a
      ,indic_fumosita_2a
      ,indic_fumosita_3a
      ,indic_fumosita_md
      ,manutenzione_8a
      ,co_fumi_secchi_8b
      ,indic_fumosita_8c
      ,rend_comb_8d
      ,esito_verifica
      ,strumento
      ,note_verificatore
      ,note_resp
      ,note_conf
      ,tipologia_costo
      ,riferimento_pag
      ,utente
      ,TO_CHAR(data_ins,'YYYY-MM-DD') data_ins
      ,TO_CHAR(data_mod,'YYYY-MM-DD') data_mod
      ,pot_utile_nom
      ,pot_focolare_nom
      ,cod_combustibile
      ,cod_responsabile
      ,flag_cpi
      ,flag_ispes
      ,flag_pericolosita
      ,flag_tracciato
      ,TO_CHAR(new1_data_dimp,'YYYY-MM-DD') new1_data_dimp
      ,TO_CHAR(new1_data_paga_dimp,'YYYY-MM-DD') new1_data_paga_dimp
      ,new1_conf_locale
      ,new1_conf_accesso
      ,new1_pres_intercet
      ,new1_pres_interrut
      ,new1_asse_mate_estr
      ,new1_pres_mezzi
      ,new1_pres_cartell
      ,new1_disp_regolaz
      ,new1_foro_presente
      ,new1_foro_corretto
      ,new1_foro_accessibile
      ,new1_canali_a_norma
      ,new1_lavoro_nom_iniz
      ,new1_lavoro_nom_fine
      ,new1_lavoro_lib_iniz
      ,new1_lavoro_lib_fine
      ,new1_note_manu
      ,new1_dimp_pres
      ,new1_dimp_prescriz
      ,TO_CHAR(new1_data_ultima_manu,'YYYY-MM-DD') new1_data_ultima_manu
      ,TO_CHAR(new1_data_ultima_anal,'YYYY-MM-DD') new1_data_ultima_anal
      ,new1_manu_prec_8a
      ,new1_co_rilevato
      ,new1_flag_peri_8p
      ,flag_uso
      ,flag_diffida
      ,eccesso_aria_perc_2a
      ,eccesso_aria_perc_3a
      ,eccesso_aria_perc_md
      ,n_prot
      ,TO_CHAR(data_prot,'YYYY-MM-DD') data_prot
      ,sezioni_corr
      ,curve_corr
      ,lungh_corr
      ,riflussi_loc
      ,perdite_cond
      ,disp_funz
      ,assenza_fughe
      ,effic_evac
      ,autodich
      ,dich_conf
      ,manut_prog
      ,marca_strum
      ,modello_strum
      ,matr_strum
      ,TO_CHAR(dt_tar_strum,'YYYY-MM-DD') dt_tar_strum
      ,indice_aria
      ,perd_cal_sens
      ,doc_ispesl
      ,doc_prev_incendi
      ,libr_manut_bruc
      ,ubic_locale_norma
      ,disp_chius_porta
      ,spazi_norma
      ,apert_soffitto
      ,rubin_manuale_acces
      ,assenza_app_peric
      ,rubin_chiuso
      ,elettrovalv_esterne
      ,tubaz_press
      ,tolta_tensione
      ,termost_esterno
      ,chiusura_foro
      ,accens_funz_gen
      ,pendenza
      ,ventilaz_lib_ostruz
      ,disp_reg_cont_pre
      ,disp_reg_cont_funz
      ,disp_reg_clim_funz
      ,conf_imp_elettrico
      ,volumetria
      ,comsumi_ultima_stag
  FROM coimcimp

spool file/\coimcimp.dat
/
spool OFF
