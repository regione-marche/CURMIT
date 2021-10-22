\encoding iso-8859-15;
\copy coimaces from file_prmn/coimaces.dat using delimiters '|' with null as ''
\echo coimaces from file_prmn/coimaces.dat using delimiters '|' with null as ''
\copy coimacts from file_prmn/coimacts.dat using delimiters '|' with null as ''
\echo coimacts from file_prmn/coimacts.dat using delimiters '|' with null as ''

\copy coimaimp(cod_impianto, cod_impianto_est, cod_impianto_prov, descrizione, provenienza_dati, cod_combustibile, cod_potenza, potenza, potenza_utile, data_installaz, data_attivaz, data_rottamaz, note, stato, flag_dichiarato, data_prima_dich, data_ultim_dich, cod_tpim, consumo_annuo, n_generatori, stato_conformita, cod_cted, tariffa, cod_responsabile, flag_resp, cod_intestatario, flag_intestatario, cod_proprietario, cod_occupante, cod_amministratore, cod_manutentore, cod_installatore, cod_distributore, cod_progettista, cod_amag, cod_ubicazione, localita, cod_via, toponimo, indirizzo, numero, esponente, scala, piano, interno, cod_comune, cod_provincia, cap, cod_catasto, cod_tpdu, cod_qua, cod_urb, data_ins, data_mod, utente, flag_dpr412, cod_impianto_dest) from file_prmn/coimaimp.dat using delimiters '|' with null as ''
\echo coimaimp from file_prmn/coimaimp.dat using delimiters '|' with null as ''

\copy coimanec from file_prmn/coimanec.dat using delimiters '|' with null as ''
\echo coimanec from file_prmn/coimanec.dat using delimiters '|' with null as ''
\copy coimanom from file_prmn/coimanom.dat using delimiters '|' with null as ''
\echo coimanom from file_prmn/coimanom.dat using delimiters '|' with null as ''
\copy coimanrg from file_prmn/coimanrg.dat using delimiters '|' with null as ''
\echo coimanrg from file_prmn/coimanrg.dat using delimiters '|' with null as ''
\copy coimarea from file_prmn/coimarea.dat using delimiters '|' with null as ''
\echo coimarea from file_prmn/coimarea.dat using delimiters '|' with null as ''
\copy coimbatc from file_prmn/coimbatc.dat using delimiters '|' with null as ''
\echo coimbatc from file_prmn/coimbatc.dat using delimiters '|' with null as ''

\copy coimboll from file_prmn/coimboll.dat using delimiters '|' with null as ''
\echo coimboll from file_prmn/coimboll.dat using delimiters '|' with null as ''

\copy coimcimp(cod_cimp, cod_impianto, cod_documento, gen_prog, cod_inco, data_controllo, verb_n, data_verb, cod_opve, costo, nominativo_pres, presenza_libretto, libretto_corretto, dich_conformita,libretto_manutenz, mis_port_combust, mis_pot_focolare, stato_coiben, stato_canna_fum, verifica_dispo, verifica_areaz, taratura_dispos, co_fumi_secchi, ppm, eccesso_aria_perc, perdita_ai_fumi, rend_comb_conv, rend_comb_min, temp_fumi_1a, temp_fumi_2a, temp_fumi_3a, temp_fumi_md, t_aria_comb_1a, t_aria_comb_2a, t_aria_comb_3a, t_aria_comb_md, temp_mant_1a, temp_mant_2a, temp_mant_3a, temp_mant_md, temp_h2o_out_1a, temp_h2o_out_2a, temp_h2o_out_3a, temp_h2o_out_md, co2_1a, co2_2a, co2_3a, co2_md, o2_1a, o2_2a, o2_3a, o2_md, co_1a, co_2a, co_3a, co_md, indic_fumosita_1a, indic_fumosita_2a, indic_fumosita_3a, indic_fumosita_md, manutenzione_8a, co_fumi_secchi_8b, indic_fumosita_8c, rend_comb_8d, esito_verifica, strumento, note_verificatore, note_resp, note_conf, tipologia_costo, riferimento_pag, utente, data_ins, data_mod, pot_utile_nom, pot_focolare_nom, cod_combustibile, cod_responsabile, flag_cpi, flag_ispes, flag_pericolosita, flag_tracciato, new1_data_dimp, new1_data_paga_dimp, new1_conf_locale, new1_conf_accesso, new1_pres_intercet, new1_pres_interrut, new1_asse_mate_estr, new1_pres_mezzi, new1_pres_cartell, new1_disp_regolaz, new1_foro_presente, new1_foro_corretto, new1_foro_accessibile, new1_canali_a_norma, new1_lavoro_nom_iniz, new1_lavoro_nom_fine, new1_lavoro_lib_iniz, new1_lavoro_lib_fine, new1_note_manu, new1_dimp_pres, new1_dimp_prescriz, new1_data_ultima_manu, new1_data_ultima_anal, new1_manu_prec_8a, new1_co_rilevato, new1_flag_peri_8p, flag_uso, flag_diffida, eccesso_aria_perc_2a, eccesso_aria_perc_3a, eccesso_aria_perc_md ) from file_prmn/coimcimp.dat using delimiters '|' with null as ''
\echo coimcimp from file_prmn/coimcimp.dat using delimiters '|' with null as ''

\copy coimcinc from file_prmn/coimcinc.dat using delimiters '|' with null as ''
\echo coimcinc from file_prmn/coimcinc.dat using delimiters '|' with null as ''
\copy coimcitt from file_prmn/coimcitt.dat using delimiters '|' with null as ''
\echo coimcitt from file_prmn/coimcitt.dat using delimiters '|' with null as ''
\copy coimcmar from file_prmn/coimcmar.dat using delimiters '|' with null as ''
\echo coimcmar from file_prmn/coimcmar.dat using delimiters '|' with null as ''
\copy coimcoma from file_prmn/coimcoma.dat using delimiters '|' with null as ''
\echo coimcoma from file_prmn/coimcoma.dat using delimiters '|' with null as ''

\copy coimcomb(cod_combustibile, descr_comb, data_ins, data_mod, utente) from file_prmn/coimcomb.dat using delimiters '|' with null as ''
\echo coimcomb from file_prmn/coimcomb.dat using delimiters '|' with null as ''

\copy coimcomu from file_prmn/coimcomu.dat using delimiters '|' with null as ''
\echo coimcomu from file_prmn/coimcomu.dat using delimiters '|' with null as ''
--\copy coimcont from file_prmn/coimcont.dat using delimiters '|' with null as ''
--\echo coimcont from file_prmn/coimcont.dat using delimiters '|' with null as ''
\copy coimcost from file_prmn/coimcost.dat using delimiters '|' with null as ''
\echo coimcost from file_prmn/coimcost.dat using delimiters '|' with null as ''
\copy coimcqua from file_prmn/coimcqua.dat using delimiters '|' with null as ''
\echo coimcqua from file_prmn/coimcqua.dat using delimiters '|' with null as ''
\copy coimcted from file_prmn/coimcted.dat using delimiters '|' with null as ''
\echo coimcted from file_prmn/coimcted.dat using delimiters '|' with null as ''
\copy coimcuar from file_prmn/coimcuar.dat using delimiters '|' with null as ''
\echo coimcuar from file_prmn/coimcuar.dat using delimiters '|' with null as ''
\copy coimcurb from file_prmn/coimcurb.dat using delimiters '|' with null as ''
\echo coimcurb from file_prmn/coimcurb.dat using delimiters '|' with null as ''
\copy coimdesc from file_prmn/coimdesc.dat using delimiters '|' with null as ''
\echo coimdesc from file_prmn/coimdesc.dat using delimiters '|' with null as ''

\copy coimdimp(cod_dimp, cod_impianto, data_controllo, gen_prog, cod_manutentore, cod_responsabile, cod_proprietario, cod_occupante, cod_documento, flag_status, garanzia, conformita, lib_impianto, lib_uso_man, inst_in_out, idoneita_locale, ap_ventilaz, ap_vent_ostruz, pendenza, sezioni, curve, lunghezza, conservazione, scar_ca_si, scar_parete, riflussi_locale, assenza_perdite, pulizia_ugelli, antivento, scambiatore, accens_reg, disp_comando, ass_perdite, valvola_sicur, vaso_esp, disp_sic_manom, organi_integri, circ_aria, guarn_accop, assenza_fughe, coibentazione, eff_evac_fum, cont_rend, pot_focolare_mis, portata_comb_mis, temp_fumi, temp_ambi, o2, co2, bacharach, co, rend_combust, osservazioni, raccomandazioni, prescrizioni, data_utile_inter, n_prot, data_prot, delega_resp, delega_manut, num_bollo, costo, tipologia_costo, riferimento_pag, utente, data_ins, data_mod, potenza, flag_pericolosita, flag_co_perc, cod_docu_distinta) from file_prmn/coimdimp.dat using delimiters '|' with null as ''
\echo coimdimp from file_prmn/coimdimp.dat using delimiters '|' with null as ''

\copy coimdist from file_prmn/coimdist.dat using delimiters '|' with null as ''
\echo coimdist from file_prmn/coimdist.dat using delimiters '|' with null as ''
\copy coimdocu from file_prmn/coimdocu.dat using delimiters '|' with null as ''
\echo coimdocu copiata
--\echo tabella coimdocu non caricata: oid

\copy coimenre(cod_enre, denominazione,	indirizzo, numero, cap, localita, comune, provincia, denominazione2) from file_prmn/coimenre.dat using delimiters '|' with null as ''
\echo coimenre from file_prmn/coimenre.dat using delimiters '|' with null as ''

\copy coimenrg from file_prmn/coimenrg.dat using delimiters '|' with null as ''
\echo coimenrg from file_prmn/coimenrg.dat using delimiters '|' with null as ''
\copy coimenti from file_prmn/coimenti.dat using delimiters '|' with null as ''
\echo coimenti from file_prmn/coimenti.dat using delimiters '|' with null as ''
\copy coimenve from file_prmn/coimenve.dat using delimiters '|' with null as ''
\echo coimenve from file_prmn/coimenve.dat using delimiters '|' with null as ''
\copy coimesit from file_prmn/coimesit.dat using delimiters '|' with null as ''
\echo coimesit from file_prmn/coimesit.dat using delimiters '|' with null as ''
\copy coimfatt from file_prmn/coimfatt.dat using delimiters '|' with null as ''
\echo coimfatt from file_prmn/coimfatt.dat using delimiters '|' with null as ''
\copy coimfuge from file_prmn/coimfuge.dat using delimiters '|' with null as ''
\echo coimfuge from file_prmn/coimfuge.dat using delimiters '|' with null as ''
\copy coimfunp from file_prmn/coimfunp.dat using delimiters '|' with null as ''
\echo coimfunp from file_prmn/coimfunp.dat using delimiters '|' with null as ''
\copy coimfunz from file_prmn/coimfunz.dat using delimiters '|' with null as ''
\echo coimfunz from file_prmn/coimfunz.dat using delimiters '|' with null as ''
\copy coimgage from file_prmn/coimgage.dat using delimiters '|' with null as ''
\echo coimgage from file_prmn/coimgage.dat using delimiters '|' with null as ''

\copy coimgend(cod_impianto, gen_prog, descrizione, matricola, modello, cod_cost, matricola_bruc, modello_bruc, cod_cost_bruc, tipo_foco, mod_funz, cod_utgi, tipo_bruciatore, tiraggio, locale, cod_emissione, cod_combustibile, data_installaz, data_rottamaz, pot_focolare_lib, pot_utile_lib, pot_focolare_nom, pot_utile_nom, flag_attivo, note, data_ins, data_mod, utente, gen_prog_est) from file_prmn/coimgend.dat using delimiters '|' with null as ''
\echo coimgend from file_prmn/coimgend.dat using delimiters '|' with null as ''

\copy coimimst from file_prmn/coimimst.dat using delimiters '|' with null as ''
\echo coimimst from file_prmn/coimimst.dat using delimiters '|' with null as '' 
\copy coiminco from file_prmn/coiminco.dat using delimiters '|' with null as ''
\echo coiminco from file_prmn/coiminco.dat using delimiters '|' with null as '' 
\copy coiminst from file_prmn/coiminst.dat using delimiters '|' with null as ''
\echo coiminst from file_prmn/coiminst.dat using delimiters '|' with null as ''
\copy coimmanu from file_prmn/coimmanu.dat using delimiters '|' with null as ''
\echo coimmanu from file_prmn/coimmanu.dat using delimiters '|' with null as ''
\copy coimmenp from file_prmn/coimmenp.dat using delimiters '|' with null as ''
\echo coimmenp from file_prmn/coimmenp.dat using delimiters '|' with null as ''
\copy coimmenu from file_prmn/coimmenu.dat using delimiters '|' with null as ''
\echo coimmenu from file_prmn/coimmenu.dat using delimiters '|' with null as ''
\copy coimmode from file_prmn/coimmode.dat using delimiters '|' with null as ''
\echo coimmode from file_prmn/coimmode.dat using delimiters '|' with null as ''
\copy coimmovi from file_prmn/coimmovi.dat using delimiters '|' with null as ''
\echo coimmovi from file_prmn/coimmovi.dat using delimiters '|' with null as ''
\copy coimmtar from file_prmn/coimmtar.dat using delimiters '|' with null as ''
\echo coimmtar from file_prmn/coimmtar.dat using delimiters '|' with null as ''
\copy coimnoveb from file_prmn/coimnoveb.dat using delimiters '|' with null as ''
\echo coimnoveb from file_prmn/coimnoveb.dat using delimiters '|' with null as ''
\copy coimogge from file_prmn/coimogge.dat using delimiters '|' with null as ''
\echo coimogge from file_prmn/coimogge.dat using delimiters '|' with null as ''
\copy coimopdi from file_prmn/coimopdi.dat using delimiters '|' with null as ''
\echo coimopdi from file_prmn/coimopdi.dat using delimiters '|' with null as ''

\copy coimopve(cod_opve, cod_enve, cognome, nome, matricola, stato, data_ins, data_mod, utente, telefono, cellulare, recapito, codice_fiscale, note) from file_prmn/coimopve.dat using delimiters '|' with null as ''
\echo coimopve from file_prmn/coimopve.dat using delimiters '|' with null as ''

copy coimparm from file_prmn/coimparm.dat using delimiters '|' with null as ''
echo coimparm from file_prmn/coimparm.dat using delimiters '|' with null as ''
\copy coimpote from file_prmn/coimpote.dat using delimiters '|' with null as ''
\echo coimpote from file_prmn/coimpote.dat using delimiters '|' with null as ''
\copy coimprof from file_prmn/coimprof.dat using delimiters '|' with null as ''
\echo coimprof from file_prmn/coimprof.dat using delimiters '|' with null as ''
\copy coimprog from file_prmn/coimprog.dat using delimiters '|' with null as ''
\echo coimprog from file_prmn/coimprog.dat using delimiters '|' with null as ''
\copy coimprov from file_prmn/coimprov.dat using delimiters '|' with null as ''
\echo coimprov from file_prmn/coimprov.dat using delimiters '|' with null as ''
\copy coimprvv from file_prmn/coimprvv.dat using delimiters '|' with null as ''
\echo coimprvv from file_prmn/coimprvv.dat using delimiters '|' with null as ''
\copy coimqrar from file_prmn/coimqrar.dat using delimiters '|' with null as ''
\echo coimqrar from file_prmn/coimqrar.dat using delimiters '|' with null as ''
\copy coimregi from file_prmn/coimregi.dat using delimiters '|' with null as ''
\echo coimregi from file_prmn/coimregi.dat using delimiters '|' with null as ''
\copy coimrelg from file_prmn/coimrelg.dat using delimiters '|' with null as ''
\echo coimrelg from file_prmn/coimrelg.dat using delimiters '|' with null as ''
\copy coimrelt from file_prmn/coimrelt.dat using delimiters '|' with null as ''
\echo coimrelt from file_prmn/coimrelt.dat using delimiters '|' with null as ''
\copy coimrgen from file_prmn/coimrgen.dat using delimiters '|' with null as ''
\echo coimrgen from file_prmn/coimrgen.dat using delimiters '|' with null as ''
\copy coimrgh  from file_prmn/coimrgh.dat using delimiters '|' with null as ''
\echo coimrgh  from file_prmn/coimrgh.dat using delimiters '|' with null as ''
\copy coimrife from file_prmn/coimrife.dat using delimiters '|' with null as ''
\echo coimrife from file_prmn/coimrife.dat using delimiters '|' with null as ''
\copy coimruol from file_prmn/coimruol.dat using delimiters '|' with null as ''
\echo coimruol from file_prmn/coimruol.dat using delimiters '|' with null as ''
\copy coimsett from file_prmn/coimsett.dat using delimiters '|' with null as ''
--\copy coimsrcg from file_prmn/coimsrcg.dat using delimiters '|' with null as ''
--\copy coimsrcm from file_prmn/coimsrcm.dat using delimiters '|' with null as ''
--\copy coimsrdg from file_prmn/coimsrdg.dat using delimiters '|' with null as ''
\echo coimsett from file_prmn/coimsett.dat using delimiters '|' with null as ''

\copy coimstpm(id_stampa, descrizione, testo, campo1_testo, campo1, campo2_testo, campo2, campo3_testo, campo3, campo4_testo, campo4, campo5_testo, campo5, var_testo, allegato, tipo_foglio, orientamento) from file_prmn/coimstpm.dat using delimiters '|' with null as ''
\echo coimstpm from file_prmn/coimstpm.dat using delimiters '|' with null as ''

\copy coimstub from file_prmn/coimstub.dat using delimiters '|' with null as ''
\echo coimstub from file_prmn/coimstub.dat using delimiters '|' with null as ''
copy coimtabs from file_prmn/coimtabs.dat using delimiters '|' with null as ''
echo coimtabs from file_prmn/coimtabs.dat using delimiters '|' with null as ''
\copy coimtano from file_prmn/coimtano.dat using delimiters '|' with null as ''
\echo coimtano from file_prmn/coimtano.dat using delimiters '|' with null as ''

\copy coimtari(tipo_costo, cod_potenza, data_inizio, importo) from file_prmn/coimtari.dat using delimiters '|' with null as ''
\echo coimtari from file_prmn/coimtari.dat using delimiters '|' with null as ''

\copy coimtcar from file_prmn/coimtcar.dat using delimiters '|' with null as ''
\echo coimtcar from file_prmn/coimtcar.dat using delimiters '|' with null as ''
\copy coimtdoc from file_prmn/coimtdoc.dat using delimiters '|' with null as ''
\echo coimtdoc from file_prmn/coimtdoc.dat using delimiters '|' with null as ''

\copy coimtgen(cod_tgen, valid_mod_h, gg_comunic_mod_h, flag_ente, cod_prov, cod_comu, flag_viario, flag_mod_h_b, valid_mod_h_b, gg_comunic_mod_h_b, data_ins, data_mod, utente_ult, gg_conferma_inco, gg_scad_pag_mh, mesi_evidenza_mod, flag_agg_sogg, flag_dt_scad, flag_agg_da_verif, flag_cod_aimp_auto, flag_gg_modif_mh, flag_gg_modif_rv, gg_scad_pag_rv, gg_adat_anom_oblig, gg_adat_anom_autom, popolaz_citt_tgen, popolaz_aimp_tgen, flag_aimp_citt_estr, flag_stat_estr_calc, flag_cod_via_auto, link_cap ) from file_prmn/coimtgen.dat using delimiters '|' with null as ''
\echo coimtgen from file_prmn/coimtgen.dat using delimiters '|' with null as ''

\copy coimtodo from file_prmn/coimtodo.dat using delimiters '|' with null as ''
\echo coimtodo from file_prmn/coimtodo.dat using delimiters '|' with null as ''
\copy coimtopo from file_prmn/coimtopo.dat using delimiters '|' with null as ''
\echo coimtopo from file_prmn/coimtopo.dat using delimiters '|' with null as ''
\copy coimtpbo from file_prmn/coimtpbo.dat using delimiters '|' with null as ''
\echo coimtpbo from file_prmn/coimtpbo.dat using delimiters '|' with null as ''
\copy coimtpdo from file_prmn/coimtpdo.dat using delimiters '|' with null as ''
\echo coimtpdo from file_prmn/coimtpdo.dat using delimiters '|' with null as ''
\copy coimtpdu from file_prmn/coimtpdu.dat using delimiters '|' with null as ''
\echo coimtpdu from file_prmn/coimtpdu.dat using delimiters '|' with null as ''
\copy coimtpem from file_prmn/coimtpem.dat using delimiters '|' with null as ''
\echo coimtpem from file_prmn/coimtpem.dat using delimiters '|' with null as ''
--\copy coimtpes from file_prmn/coimtpes.dat using delimiters '|' with null as ''
--\echo coimtpes from file_prmn/coimtpes.dat using delimiters '|' with null as ''
\copy coimtpim from file_prmn/coimtpim.dat using delimiters '|' with null as ''
\echo coimtpim from file_prmn/coimtpim.dat using delimiters '|' with null as ''
\copy coimtppr from file_prmn/coimtppr.dat using delimiters '|' with null as ''
\echo coimtppr from file_prmn/coimtppr.dat using delimiters '|' with null as ''
--\copy coimtpsg from file_prmn/coimtpsg.dat using delimiters '|' with null as ''
--\echo coimtpsg from file_prmn/coimtpsg.dat using delimiters '|' with null as ''
\copy coimutar from file_prmn/coimutar.dat using delimiters '|' with null as ''
\echo coimutar from file_prmn/coimutar.dat using delimiters '|' with null as ''
\copy coimuten from file_prmn/coimuten.dat using delimiters '|' with null as ''
\echo coimuten from file_prmn/coimuten.dat using delimiters '|' with null as ''
\copy coimutgi from file_prmn/coimutgi.dat using delimiters '|' with null as ''
\echo coimutgi from file_prmn/coimutgi.dat using delimiters '|' with null as ''
\copy coimviae from file_prmn/coimviae.dat using delimiters '|' with null as ''
\echo coimviae from file_prmn/coimviae.dat using delimiters '|' with null as ''
\copy coimviar from file_prmn/coimviar.dat using delimiters '|' with null as ''
\echo coimviar from file_prmn/coimviar.dat using delimiters '|' with null as ''
--\copy coimlist from file_prmn/coimlist.dat using delimiters '|' with null as ''
--\echo coimlist from file_prmn/coimlist.dat using delimiters '|' with null as ''
--\copy coimereg from file_prmn/coimereg.dat using delimiters '|' with null as ''
--\echo coimereg from file_prmn/coimereg.dat using delimiters '|' with null as ''

\echo lanciare coim-sequence.sql dalla directory sql/postgresql
