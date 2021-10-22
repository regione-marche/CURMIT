ad_page_contract {
    Elaborazione     Caricamento anomalie modelli F
    @author          Valentina Catte
    @creation-date   12/05/2008
    @cvs-id          iter_cari_anom_f

}

with_catch error_msg {

    ns_log Notice "Inizio della procedura Caricamento anomalie mod.F"
    
    if {[db_0or1row sel_esit "select coalesce(max(data_elaborazione), '2008-05-01') as data_elaborazione
                               from coim_d_esit
                              where flag_tracciato = 'F'"] == 0} {
	set data_elaborazione "2008-05-01"
    }

    db_foreach sel_dimp_g "select a.cod_dimp
                                    , a.cod_impianto 
                                    , b.cod_cost
                                    , b.modello
                                    , b.matricola
                                    , b.data_costruz_gen
                                    , b.pot_focolare_nom
                                    , b.cod_combustibile
                                    , b.data_installaz
                                    , a.data_controllo
                                    , a.conformita
                                    , a.lib_impianto
                                    , a.idoneita_locale
                                    , a.ap_ventilaz
                                    , a.ap_vent_ostruz
                                    , a.pendenza
                                    , a.sezioni
                                    , a.curve
                                    , a.lunghezza
                                    , a.conservazione
                                    , a.disp_comando
                                    , a.ass_perdite
                                    , a.valvola_sicur
                                    , a.disp_sic_manom
                                    , a.assenza_fughe
                                    , a.coibentazione
                                    , a.eff_evac_fum
                                    , a.cont_rend
                                    , a.temp_fumi
                                    , a.temp_ambi
                                    , a.o2
                                    , a.co2
                                    , a.bacharach
                                    , a.co
                                    , a.rend_combust
                                    , a.tiraggio
                                    , b.tiraggio as tiraggio_gend
                                    , b.tipo_foco
                                    , b.cod_emissione
                                    , a.prescrizioni
                                    , a.raccomandazioni
                                    , a.flag_status
                                    , a.fl_firma_tecnico
                                    , a.fl_firma_resp 
                                    , a.fl_timbro
                                    , a.fl_assenza_dati_op
                                    , a.rapp_contr
                                    , a.certificaz
                                    , a.dich_conf
                                    , a.ispesl
                                    , a.prev_incendi
                                    , a.esame_vis_l_elet
                                    , a.accens_reg
                                    , a.organi_integri
                                    , a.potenza
                                    , a.scar_parete
                                 from coimdimp a
                                    , coimgend b
                                where a.cod_impianto = b.cod_impianto
                                  and a.gen_prog     = b.gen_prog
                                  and a.flag_tracciato = 'F'
                                  and (a.data_ins >= :data_elaborazione
                                    or a.data_mod >= :data_elaborazione)
                                  and not exists (select 1 from coimdimp aa 
                                                   where aa.cod_impianto = a.cod_impianto
                                                     and aa.cod_dimp <> a.cod_dimp  
                                                     and aa.data_controllo >= a.data_controllo)
                                  and a.data_ins > '2008-05-01'" {

					set lista_anom [list]
					set lista_anom_m [list]
					
					if {$cod_combustibile != "7"} {
					    if {[string equal $cod_cost ""]
						|| [string equal $modello ""]
						|| [string equal $matricola ""]
						|| [string equal $data_costruz_gen ""]} {
						lappend lista_anom_m "FA1"
					    }
					}
					if {$cod_combustibile != "7"} {
					    if {[string equal $potenza ""]} {
						lappend lista_anom "FA2"
					    }
					}
					if {[string equal $cod_combustibile ""]} {
					    lappend lista_anom "FA3"
					}
					if {$cod_combustibile != "7"} {
					    if {[string equal $data_installaz ""]
						|| [string equal $data_installaz "1900-01-01"]} {
						lappend lista_anom_m "FA4"
					    }
					}
					if {$cod_combustibile != "7"} {
					    if {[string equal $data_controllo "1900-01-01"]} {
						lappend lista_anom_m "FA5"
					    }
					}
					
#					if {[string equal $lib_impianto "N"]} {
#					    lappend lista_anom "FB1"
#					}
					if {[string equal $rapp_contr "N"] && ([string equal $cod_combustibile "3"] || $cod_combustibile eq "4")} {
					    lappend lista_anom "FB2"
					}
					if {[string equal $certificaz "N"]} {
					    lappend lista_anom "FB3"
					}
					if {[string equal $dich_conf "N"]} {
					    lappend lista_anom "FB4"
					}
					if {[string equal $ispesl "N"]} {
					    lappend lista_anom "FB5"
					}
					if {[string equal $prev_incendi "N"] && ($pot_focolare_nom > 115 || ($pot_focolare_nom eq "" && $potenza > 115))} {
					    lappend lista_anom "FB6"
					}


					if {[string equal $idoneita_locale "N"]} {
					    lappend lista_anom "FC11"
					}
					if {$idoneita_locale != "E"} {
					    if {[string equal $ap_ventilaz "N"]} {
						lappend lista_anom "FC12"
					    }
					    if {[string equal $ap_vent_ostruz "N"]} {
						lappend lista_anom "FC13"
					    }
					}

					if {[string equal $esame_vis_l_elet "N"]} {
					    lappend lista_anom "FC21"
					}
					if {[string equal $accens_reg "N"]} {
					    lappend lista_anom "FC42"
					}
					if {[string equal $disp_comando "N"]} {
					    lappend lista_anom "FC43"
					}
					if {[string equal $ass_perdite "N"]} {
					    lappend lista_anom "FC44"
					}
					if {[string equal $disp_sic_manom "N"]} {
					    lappend lista_anom "FC45"
					}
					if {[string equal $organi_integri "N"]} {
					    lappend lista_anom "FC46"
					}
					if {[string equal $assenza_fughe "N"]} {
					    lappend lista_anom "FC51"
					}
					if {[string equal $coibentazione "N"]} {
					    lappend lista_anom "FC61"
					}
					if {[string equal $conservazione "N"]} {
					    lappend lista_anom "FC71"
					}
					
					if {[string equal $cont_rend "N"]
					    || [string equal $cont_rend ""]} {
					    lappend lista_anom "FH1"
					} else {
					    if {[string equal $temp_fumi ""]
						|| $temp_fumi > 300.00} {
						lappend lista_anom "FH2"
					    }
					    if {[string equal $temp_ambi ""]
						|| $temp_ambi < -5.00} {
						lappend lista_anom "FH3"
					    }
					    if {[string equal $o2 ""]
						|| $o2 < 0.30} {
						lappend lista_anom "FH4"
					    }
					    if {[string equal $co2 ""]
						|| $co2 > 30.00} {
						lappend lista_anom "FH5"
					    }
					    if {$cod_combustibile == "1"
						&&  ([string equal $bacharach ""]
						     || $bacharach > 2.00
						     )} {
						lappend lista_anom "FH6"
					    }
					    if {$cod_combustibile == "2"
						&&  ([string equal $bacharach ""]
						     || $bacharach > 6.00
						     )} {
						lappend lista_anom "FH6"
					    }
					    if {[string equal $co ""]
						|| $co > 1000
						|| [string equal $co "0.00"]} {
						lappend lista_anom "FH7"
					    }
					    if {$data_installaz < "1994-01-01"
						&& $rend_combust < 85.00} {
						lappend lista_anom "FH8"
					    }
					    if {$data_installaz <= "2004-10-07"
						&& $data_installaz >= "1994-01-01" 
						&& $rend_combust < 86.00} {
						lappend lista_anom "FH8"
					    }
					    if {$data_installaz > "2004-10-07"
						&& $data_installaz >= "2005-01-01" 
						&& $rend_combust < 91.00} {
						lappend lista_anom "FH8"
					    }
					    if {$data_installaz > "2005-01-01"
						&& $rend_combust < 89.50} {
						lappend lista_anom "FH8"
					    }
					    if {![string equal $tiraggio ""]
						&& $tiraggio < 3
						&& $tiraggio_gend == "N"
						&& $scar_parete != "S"} {
						lappend lista_anom "FH9"
					    }
					}

					if {$flag_status == "N"
					    || [string equal $flag_status ""]} {
					    lappend lista_anom "FI1"
					}
					if {![string equal $raccomandazioni ""]} {
					    lappend lista_anom "FL1"
					}
					if {![string equal $prescrizioni ""]} {
					    lappend lista_anom "FL2"
					}
					if {$fl_assenza_dati_op == "N"} {
					    lappend lista_anom_m "FM1"
					}
					if {$fl_firma_tecnico == "N"
					    || $fl_timbro == "N"} {
					    lappend lista_anom_m "FN1"
					}
					if {$fl_firma_resp == "N"} {
					    lappend lista_anom "FO1"
					}
					
					db_transaction {
					    db_dml del_anom "delete from coim_d_anom where cod_dimp = :cod_dimp"
					    foreach cod_d_tano $lista_anom {
						db_1row sel_descr "select descr_breve from coim_d_tano where cod_tano = :cod_d_tano"
						db_dml ins_anom "insert into coim_d_anom
                                                                           ( cod_d_tano
                                                                           , cod_dimp
                                                                           , data_controllo
                                                                           , cod_impianto
                                                                           , descr_breve
                                                                           , utente
                                                                           , data_ins
                                                                           ) values (
                                                                            :cod_d_tano
                                                                           ,:cod_dimp
                                                                           ,:data_controllo
                                                                           ,:cod_impianto
                                                                           ,:descr_breve
                                                                           , 'batch'
                                                                           , current_date
                                                                           )
"
					      
					    }


					    db_dml del_anom_m "delete from coim_dm_anom where cod_dimp = :cod_dimp"
					    foreach cod_d_tano $lista_anom_m {
						db_1row sel_descr "select descr_breve 
                                                                     from coim_d_tano 
                                                                    where cod_tano = :cod_d_tano"
						db_dml ins_anom "insert into coim_dm_anom
                                                                           ( cod_d_tano
                                                                           , cod_dimp
                                                                           , data_controllo
                                                                           , cod_impianto
                                                                           , descr_breve
                                                                           , utente
                                                                           , data_ins
                                                                           ) values (
                                                                            :cod_d_tano
                                                                           ,:cod_dimp
                                                                           ,:data_controllo
                                                                           ,:cod_impianto
                                                                           ,:descr_breve
                                                                           , 'batch'
                                                                           , current_date
                                                                           )
"
					      
					    }







					}
				    }
    
    db_dml ins_esit "insert into coim_d_esit ( progressivo
                                              , data_elaborazione
                                              , flag_tracciato
                                              ) values (
                                                nextval('coim_d_esit_s')
                                              , current_date 
                                              , 'F')
                                           "
    ns_log Notice "Fine della procedura Caricamento anomalie mod.F"
} {
    ns_log Error "Caricamento anomalie mod.F: $error_msg"
}
