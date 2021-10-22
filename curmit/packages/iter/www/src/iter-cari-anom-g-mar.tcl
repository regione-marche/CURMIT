ad_page_contract {
    Elaborazione     Caricamento anomalie modelli G
    @author          Valentina Catte
    @creation-date   12/05/2008
    @cvs-id          iter_cari_anom_g

}

with_catch error_msg {

    ns_log Notice "Inizio della procedura Caricamento anomalie mod.G"
    
    if {[db_0or1row sel_esit "select coalesce(max(data_elaborazione), '2008-05-01') as data_elaborazione
                               from coim_d_esit
                              where flag_tracciato = 'G'"] == 0} {
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
                                    , b.cod_emissione
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
                                    , a.prescrizioni
                                    , a.raccomandazioni
                                    , a.flag_status
                                    , a.fl_firma_tecnico
                                    , a.fl_firma_resp 
                                    , a.fl_timbro
                                    , a.fl_assenza_dati_op
                                    , a.potenza
                                    , a.scar_parete
                                 from coimdimp a
                                    , coimgend b
                                where a.cod_impianto = b.cod_impianto
                                  and a.gen_prog     = b.gen_prog
                                  and a.flag_tracciato = 'G'
                                  and (a.data_ins >= :data_elaborazione
                                    or a.data_mod >= :data_elaborazione)
                                  and not exists (select 1 from coimdimp aa 
                                                   where aa.cod_impianto = a.cod_impianto
                                                     and aa.cod_dimp <> a.cod_dimp  
                                                     and aa.data_controllo >= a.data_controllo)
                                  and a.data_ins > '2008-05-01'" {
				      
					set lista_anom [list]
					set lista_anom_m [list]

					#identificazione impianto
					if {[string equal $cod_combustibile ""]} {
					    lappend lista_anom "C14"
					} else {
					    if {$cod_combustibile != "7"} {
						if {[string equal $cod_cost ""]} {
						    lappend lista_anom "C1"
						}
						if {[string equal $modello ""]} {
						    lappend lista_anom "C2"
						}						
						if {[string equal $matricola ""]} {
						    lappend lista_anom "C4"						
						}
						if {[string equal $data_costruz_gen ""]} {
						    lappend lista_anom_m "C5"
						}
						if {[string equal $pot_focolare_nom ""]} {
						    lappend lista_anom_m "C7"
						}
						if {$pot_focolare_nom >= 35.00} {
                                                    lappend lista_anom_m "C8"
						}
						if {[string equal $potenza ""]} {
						    lappend lista_anom "C9"
						}
						if {[string equal $data_installaz ""]
						    || [string equal $data_installaz "1900-01-01"]} {
							lappend lista_anom_m "C16"
						}
						if {[string equal $data_controllo "1900-01-01"]} {
						    lappend lista_anom_m "C17"
						}
						if {[string equal $tiraggio ""]} {
						    lappend lista_anom "C12"
						}
					    }				
					}

					#documentazione tecnica di corredo
					if {[string equal $conformita ""]
					    && $data_installaz > "1990-03-12"} { 
					    lappend lista_anom "E1"
					}
					if {[string equal $conformita "No"]
                                            && $data_installaz > "1990-03-12"} {
                                            lappend lista_anom "E3"
                                        }
					if {[string equal $conformita "N.C."]
					    && $data_installaz > "1990-03-12"} {
					    lappend lista_anom "E4"
					}
                                        if {[string equal $lib_impianto ""]} {
                                            lappend lista_anom "E5"
                                        }
                                        if {[string equal $lib_impianto "N"]} {
					    lappend lista_anom "E7"
					}
                                        if {[string equal $lib_impianto "N.C."]} {
                                            lappend lista_anom "E8"
                                        }
                                        if {[string equal $idoneita_locale ""]} {
                                            lappend lista_anom "F1"
                                        }
                                        if {[string equal $idoneita_locale "N"]} {
				            lappend lista_anom "F3"
					}
                                        if {[string equal $ap_ventilaz ""]} {
                                            lappend lista_anom "F4"
                                        }
                                        if {[string equal $ap_ventilaz "N"]} {
                                            lappend lista_anom "F6"
					}
                                        if {[string equal $ap_ventilaz "N.C."]} {
                                            lappend lista_anom "F7"
                                        }
					if {[string equal $ap_vent_ostruz "N"]} {
                                            lappend lista_anom "F10"
                                        }
					if {[string equal $ap_vent_ostruz "N.C."]} {
                                            lappend lista_anom "F11"
                                        }

					#Esame visivo dei canali da fumo
					if {[string equal $pendenza ""]
					    || [string equal $sezioni ""]
					    || [string equal $curve ""]
					    || [string equal $lunghezza ""]
					    || [string equal $conservazione ""]
					    && [$locale == "Interno"
                                                ||  $locale == ""]} {
					    lappend lista_anom "G1"
					}
					if {[string equal $pendenza ""]
                                            || [string equal $sezioni ""]
                                            || [string equal $curve ""]
                                            || [string equal $lunghezza ""]
                                            || [string equal $conservazione ""]
                                            && [$locale == "Esterno"
						||  $locale == "Tecnico"]} {
					    lappend list_anom "G2"
                                        }
					if {[string equal $pendenza "N"]
                                            || [string equal $sezioni "N"]
                                            || [string equal $curve "N"]
                                            || [string equal $lunghezza "N"]
                                            || [string equal $conservazione "N"]
                                            && [$locale == "Interno"
                                                ||  $locale == ""]} {
                                            lappend list_ªanom "G4"
                                        }
					if {[string equal $pendenza "N"]
                                            || [string equal $sezioni "N"]
                                            || [string equal $curve "N"]
                                            || [string equal $lunghezza "N"]
                                            || [string equal $conservazione "N"]
                                            && [$locale == "Esterno"
                                                ||  $locale == ""]} {
                                            lappend list_anom "G5"
                                        }


 





					if {[string equal $sezioni "N"]} {
					    lappend lista_anom "GD2"
					}
					if {[string equal $curve "N"]} {
					    lappend lista_anom "GD3"
					}
					if {[string equal $lunghezza "N"]} {
					    lappend lista_anom "GD4"
					}
					if {[string equal $conservazione "N"]} {
					    lappend lista_anom "GD5"
					}
					
					if {[string equal $disp_comando "N"]} {
					    lappend lista_anom "GF5"
					}
					if {[string equal $ass_perdite "N"]} {
					    lappend lista_anom "GF6"
					}
					if {[string equal $valvola_sicur "N"]} {
					    lappend lista_anom "GF7"
					}
					if {[string equal $disp_sic_manom "N"]} {
					    lappend lista_anom "GF9"
					}
					
					if {[string equal $assenza_fughe "N"]} {
					    lappend lista_anom "GG1"
					}
					if {[string equal $coibentazione "N"]} {
					    lappend lista_anom "GG2"
					}
					if {[string equal $eff_evac_fum "N"]} {
					    lappend lista_anom "GG3"
					}
					
					if {[string equal $cont_rend "N"]
					    || [string equal $cont_rend ""]} {
					    lappend lista_anom "GH1"
					} else {
					    if {[string equal $temp_fumi ""]
						|| $temp_fumi > 300.00} {
						lappend lista_anom "GH2"
					    }
					    if {[string equal $temp_ambi ""]
						|| $temp_ambi < -5.00} {
						lappend lista_anom "GH3"
					    }
					    if {[string equal $o2 ""]
						|| $o2 < 0.30} {
						lappend lista_anom "GH4"
					    }
					    if {[string equal $co2 ""]
						|| $co2 > 30.00} {
						lappend lista_anom "GH5"
					    }
					    if {$cod_combustibile == "1"
						&&  ([string equal $bacharach ""]
						     || $bacharach > 2.00
						     || [string equal $bacharach "0.00"])} {
						lappend lista_anom "GH6"
					    }
					
					    if {$cod_combustibile == "2"
						&&  ([string equal $bacharach ""]
						     || $bacharach > 6.00)} {
						lappend lista_anom "GH6"
					    }
					    if {[string equal $co ""]
						|| $co > 1000
						|| [string equal $co "0.00"]} {
						lappend lista_anom "GH7"
					    }
					    
					    if {$data_installaz < "1994-01-01"
						&& $rend_combust < 85.00} {
						lappend lista_anom "GH8"
					    }
					    if {$data_installaz <= "2004-10-07"
						&& $data_installaz >= "1994-01-01" 
						&& $rend_combust < 86.00} {
						lappend lista_anom "GH8"
					    }
					    if {$data_installaz > "2004-10-07"
						&& $data_installaz >= "2005-01-01" 
						&& $rend_combust < 91.00} {
						lappend lista_anom "GH8"
					    }
					    if {$data_installaz > "2005-01-01"
						&& $rend_combust < 89.50} {
						lappend lista_anom "GH8"
					    }
					    if {![string equal $tiraggio ""]
						&& $tiraggio < 3
						&& $tiraggio_gend == "N"
						&& $scar_parete != "S"} {
						lappend lista_anom "GH9"
					    }
					}

					if {$flag_status == "N"
					    || [string equal $flag_status ""]} {
					    lappend lista_anom "GI1"
					}
					if {![string equal $raccomandazioni ""]} {
					    lappend lista_anom "GL1"
					}
					if {![string equal $prescrizioni ""]} {
					    lappend lista_anom "GL2"
					}
					if {$fl_assenza_dati_op == "N"} {
					    lappend lista_anom_m "GM1"
					}
					if {$fl_firma_tecnico == "N"
					    || $fl_timbro == "N"} {
					    lappend lista_anom_m "GN1"
					}
					if {$fl_firma_resp == "N"} {
					    lappend lista_anom "GO1"
					}

					db_transaction {
					    db_dml del_anom "delete from coim_d_anom where cod_dimp = :cod_dimp"
					    foreach cod_d_tano $lista_anom {
						db_1row sel_descr "select descr_breve 
                                                                     from coim_d_tano 
                                                                    where cod_tano = :cod_d_tano"
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
                                              , 'G')
                                           "
    ns_log Notice "Fine della procedura Caricamento anomalie mod.G"
} {
    ns_log Error "Caricamento anomalie mod.G: $error_msg"
}
