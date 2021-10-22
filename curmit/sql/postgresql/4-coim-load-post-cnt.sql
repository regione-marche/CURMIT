-- \encoding iso-8859-15 \copy coimaimp (cod_impianto, cod_impianto_est, n_generatori) from file/coimaimp.dat using delimiters '|' with null as ''
\encoding iso-8859-15 \copy coimaimp (cod_impianto, cod_impianto_est, cod_combustibile, provenienza_dati, cod_tpim, potenza, potenza_utile, cod_potenza, data_installaz, data_attivaz, data_rottamaz,  stato, flag_dichiarato, data_prima_dich, data_ultim_dich, consumo_annuo, n_generatori, stato_conformita, cod_cted, tariffa, cod_responsabile, flag_resp, cod_intestatario, cod_proprietario, cod_occupante, cod_amministratore, cod_manutentore, localita, cod_via, toponimo, indirizzo, numero, esponente, scala, piano, interno, cod_comune, cod_provincia, cap, cod_tpdu, cod_qua, cod_urb,data_ins ,data_mod , utente , flag_dpr412, anno_costruzione, marc_effic_energ, volimetria_risc, gb_x, gb_y, note, data_scad_dich) from file_cnt/coimaimp.dat using delimiters '|' with null as ''
\echo aimp


\encoding iso-8859-15 \copy coimanom (cod_cimp_dimp,prog_anom, tipo_anom, cod_tanom, flag_origine) from file_cnt/coimanom.dat using delimiters '|' with null as ''
\echo anom


\encoding iso-8859-15 \copy coimcimp (cod_cimp, cod_impianto, gen_prog, data_controllo, presenza_libretto, libretto_manutenz, stato_coiben, verifica_areaz, rend_comb_conv, rend_comb_min, indic_fumosita_1a, indic_fumosita_2a, indic_fumosita_3a, indic_fumosita_md, temp_h2o_out_1a, temp_h2o_out_2a, temp_h2o_out_3a, temp_h2o_out_md, t_aria_comb_1a, t_aria_comb_2a, t_aria_comb_3a, t_aria_comb_md, temp_fumi_1a, temp_fumi_2a, temp_fumi_3a, temp_fumi_md, co_1a, co_2a, co_3a, co_md, co2_1a, co2_2a, co2_3a, co2_md, o2_1a, o2_2a, o2_3a, o2_md, temp_mant_1a, temp_mant_2a, temp_mant_3a, temp_mant_md, cod_combustibile, libretto_corretto, mis_pot_focolare, eccesso_aria_perc, eccesso_aria_perc_2a, eccesso_aria_perc_3a, eccesso_aria_perc_md, manutenzione_8a, co_fumi_secchi_8b, indic_fumosita_8c, rend_comb_8d, esito_verifica, note_conf, note_verificatore, note_resp, pot_utile_nom, pot_focolare_nom, cod_responsabile, new1_data_dimp, new1_data_paga_dimp, new1_conf_locale, new1_disp_regolaz, new1_foro_presente, new1_foro_corretto, new1_foro_accessibile, new1_data_ultima_manu, new1_data_ultima_anal, new1_co_rilevato, costo, nominativo_pres, dich_conformita, mis_port_combust, strumento, marca_strum, modello_strum, matr_strum, dt_tar_strum, tipologia_costo, riferimento_pag, utente, data_ins, flag_tracciato, new1_note_manu, new1_dimp_pres, new1_dimp_prescriz, new1_manu_prec_8a, new1_flag_peri_8p, pendenza, ventilaz_lib_ostruz, disp_reg_cont_pre, disp_reg_cont_funz, disp_reg_clim_funz, volumetria, comsumi_ultima_stag, data_prot, n_prot, cod_opve, new1_conf_accesso, new1_pres_mezzi, new1_pres_intercet, new1_pres_cartell, new1_pres_interrut, new1_asse_mate_estr, ora_inizio, ora_fine) from file_cnt/coimcimp.dat using delimiters '|' with null as ''



\echo cimp


\encoding iso-8859-15 \copy coimcitt (cod_cittadino, natura_giuridica, cognome, nome, indirizzo, numero, cap, localita, comune, provincia, cod_fiscale, telefono) from file_cnt/coimcitt.dat using delimiters '|' with null as ''
\echo citt


\encoding iso-8859-15 \copy coimcomb (cod_combustibile, descr_comb) from file_cnt/coimcomb.dat using delimiters '|' with null as ''
\echo comb


\encoding iso-8859-15 \copy coimcost (cod_cost, descr_cost) from file_cnt/coimcost.dat using delimiters '|' with null as ''
\echo cost


\encoding iso-8859-15 \copy coimdimp (cod_dimp, cod_impianto, data_controllo, flag_status, gen_prog, cod_manutentore, cod_responsabile, cod_proprietario, cod_occupante, conformita, lib_impianto, lib_uso_man, inst_in_out, rapp_contr, certificaz, libretto_bruc, ispesl, prev_incendi, esame_vis_l_elet, funz_corr_bruc, idoneita_locale, ap_ventilaz, ap_vent_ostruz, pendenza, sezioni, curve, lunghezza, conservazione, scar_ca_si, scar_parete, riflussi_locale, assenza_perdite, pulizia_ugelli, antivento, scambiatore, accens_reg, disp_comando, ass_perdite, valvola_sicur, vaso_esp, disp_sic_manom, organi_integri, circ_aria, guarn_accop, assenza_fughe, coibentazione, eff_evac_fum, cont_rend, pot_focolare_mis, temp_fumi, temp_ambi, o2, co2, bacharach, flag_co_perc,  co, rend_combust, osservazioni, raccomandazioni, prescrizioni, data_utile_inter, n_prot, data_prot, delega_resp, delega_manut, num_bollo, costo, tipologia_costo, riferimento_pag, utente, data_ins, data_mod, potenza, flag_tracciato, tiraggio, ora_inizio, ora_fine, data_scadenza, num_autocert, volimetria_risc, consumo_annuo) from file_cnt/coimdimp.dat using delimiters '|' with null as ''
\echo dimp


\encoding iso-8859-15 \copy coimgend (cod_impianto, gen_prog, gen_prog_est, descrizione, flag_attivo, matricola, modello, cod_cost, matricola_bruc, modello_bruc, cod_cost_bruc, tipo_foco, mod_funz, cod_utgi, tipo_bruciatore, tiraggio, locale, cod_emissione, cod_combustibile, data_installaz, pot_focolare_lib, pot_utile_lib, pot_focolare_nom, pot_utile_nom, note, campo_funzion_min, campo_funzion_max, data_costruz_gen, data_rottamaz) from file_cnt/coimgend.dat using delimiters '|' with null as ''
\echo gend


\encoding iso-8859-15 \copy coimmanu (cod_manutentore, cognome, nome, indirizzo, cap, localita, comune, provincia, cod_fiscale, telefono, flag_convenzionato) from file_cnt/coimmanu.dat using delimiters '|' with null as ''
\echo manu


\encoding iso-8859-15 \copy coimopve (cod_opve, cod_enve, cognome, nome) from file_cnt/coimopve.dat using delimiters '|' with null as ''
\echo opve


\encoding iso-8859-15 \copy coimprog (cod_progettista, cognome, nome, indirizzo, cap, comune, provincia, cod_fiscale, telefono) from file_cnt/coimprog.dat using delimiters '|' with null as ''
\echo prog


\encoding iso-8859-15 \copy coimtopo (cod_topo, descr_topo) from file_cnt/coimtopo.dat using delimiters '|' with null as ''
\echo topo


\encoding iso-8859-15 \copy coimviae (cod_via, cod_comune, descrizione, descr_topo, descr_estesa) from file_cnt/coimviae.dat using delimiters '|' with null as ''
\echo viae

update coimcimp set flag_tracciato = '' where flag_tracciato is null
update coimgend set flag_attivo = 'S' where flag_attivo != 'N'
