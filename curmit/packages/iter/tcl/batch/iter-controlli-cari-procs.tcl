ad_proc iter_controlli_cari {
    {
	-cod_batc      ""
	-id_utente     ""
        -file_name     ""
    }
} {
    Elaborazione     Caricamento controlli da file esterno
    @author          dob
    @creation-date   10/2011
} {

    ns_log notice "prova dobelli inizio iter_controlli_cari"
  
    # aggiorno stato di coimbatc
    iter_batch_upd_flg_sta -iniz $cod_batc
    
    
    with_catch error_msg {
	db_transaction {
	    
	    
	    ns_log notice "prova dobelli inizio transaction"
	    
	    
	    # reperisco le colonne della tabella parametri
	    iter_get_coimtgen
	    
	    # valorizzo la data_corrente (serve per l'inserimento)
	    set data_corrente  [iter_set_sysdate]
	    
	    set permanenti_dir [iter_set_permanenti_dir]
	    set permanenti_dir_url [iter_set_permanenti_dir_url]
	    set file_inp_name  "Controlli-da-esterno-input"
	    set file_inp_name  [iter_temp_file_name -permanenti $file_inp_name]
	    set file_esi_name  "Controlli-da-esterno-esito"
	    set file_esi_name  [iter_temp_file_name -permanenti $file_esi_name]
	    set file_out_name  "Controlli-da-esterno-caricati"
	    set file_out_name  [iter_temp_file_name -permanenti $file_out_name]
	    set file_err_name  "Controlli-da-esterno-scartati"
	    set file_err_name  [iter_temp_file_name -permanenti $file_err_name]
	    
	    set file_inp       "${permanenti_dir}/$file_inp_name.csv"
	    set file_esi       "${permanenti_dir}/$file_esi_name.adp"
	    set file_out       "${permanenti_dir}/$file_out_name.txt"
	    set file_err       "${permanenti_dir}/$file_err_name.txt"
	    set file_inp_url   "${permanenti_dir_url}/$file_inp_name.csv"
	    # in file_esi_url non metto .adp altrimenti su vestademo non
	    # viene trovata la url!!
	    set file_esi_url   "${permanenti_dir_url}/$file_esi_name"
	    set file_out_url   "${permanenti_dir_url}/$file_out_name.txt"
	    set file_err_url   "${permanenti_dir_url}/$file_err_name.txt"
	    
	    # rinomino il file (che per ora ha lo stesso nome di origine)
	    # con un nome legato al programma ed all'ora di esecuzione
	    exec mv $file_name $file_inp
	    
	    # apro il file in lettura e metto in file_inp_id l'identificativo
	    # del file per poterlo leggere successivamente
	    if {[catch {set file_inp_id [open $file_inp r]}]} {
		iter_return_complaint "File csv di input non aperto: $file_inp"
	    }
	    # dichiaro di leggere in formato iso West European e di utilizzare
	    # crlf come fine riga (di default andrebbe a capo anche con gli
	    # eventuali lf contenuti tra doppi apici).
	    fconfigure $file_inp_id -encoding iso8859-1 -translation crlf
	    
	    # apro il file in scrittura e metto in file_esi_id l'identificativo
	    # del file per poterlo scrivere successivamente
	    if {[catch {set file_esi_id [open $file_esi w]}]} {
		iter_return_complaint "File di esito caricamento non aperto: $file_esi"
	    }
	    # dichiaro di scrivere in formato iso West European
	    fconfigure $file_esi_id -encoding iso8859-1
	    
	    # apro il file in scrittura e metto in file_out_id l'identificativo
	    # del file per poterlo scrivere successivamente
	    if {[catch {set file_out_id [open $file_out w]}]} {
		iter_return_complaint "File csv dei record caricati non aperto: $file_out"
	    }
	    # dichiaro di scrivere in formato iso West European
	    fconfigure $file_out_id -encoding iso8859-1
	    
	    # apro il file in scrittura e metto in file_err_id l'identificativo
	    # del file per poterlo scrivere successivamente
	    if {[catch {set file_err_id [open $file_err w]}]} {
		iter_return_complaint "File csv dei record scartati non aperto: $file_err"
	    }
	    # dichiaro di scrivere in formato iso West European
	    fconfigure $file_err_id -encoding iso8859-1
	    
	    
	    # preparo e scrivo scrivo la riga di intestazione per file out
	    set     head_cols ""
	    lappend head_cols "Impianto"
	    lappend head_cols "Generatore"
	    iter_put_csv $file_out_id head_cols
	    
	    # preparo e scrivo la riga di intestazione del file degli errori
	    lappend head_cols "Motivo di scarto"
	    iter_put_csv $file_err_id head_cols
	    
	    # definisco il tracciato record del file di input
	    set     file_cols [list]
	    lappend file_cols "codice_impianto"
	    lappend file_cols "gen_prog"
	    lappend file_cols "data_controllo"
	    lappend file_cols "tipo_documento"
	    lappend file_cols "num_rapporto"
	    lappend file_cols "ora_inizio"
	    lappend file_cols "ora_fine"
	    lappend file_cols "num_protocollo"
	    lappend file_cols "data_protocollo"
	    lappend file_cols "cogn_verificatore"
	    lappend file_cols "nome_verificatore"
	    lappend file_cols "data_ult_autocert"
	    lappend file_cols "data_pag_ult_autocert"
	    lappend file_cols "nome_resp"
	    lappend file_cols "cogn_resp"
	    lappend file_cols "indir_resp"
	    lappend file_cols "comune_resp"
	    lappend file_cols "prov_resp"
	    lappend file_cols "natura_giur_resp"
	    lappend file_cols "cap_resp"
	    lappend file_cols "ident_fisc_resp"
	    lappend file_cols "telef_resp"
	    lappend file_cols "delegato_resp"
	    lappend file_cols "volumetria"
	    lappend file_cols "consumi_ult_stag"
	    lappend file_cols "combustibile"
	    lappend file_cols "potenza_focolare_nom"
	    lappend file_cols "potenza_utile_nom"
	    lappend file_cols "portata_comb"
	    lappend file_cols "potenza_focolare_nom_imp"
	    lappend file_cols "pendenza_canali"
	    lappend file_cols "verifica_scarico"
	    lappend file_cols "presenza_foro"
	    lappend file_cols "foro_corretto"
	    lappend file_cols "stato_coibentazione"
	    lappend file_cols "foro_accessibile"
	    lappend file_cols "conformita_locale"
	    lappend file_cols "dispos_contr_pres"
	    lappend file_cols "dispos_contr_funz"
	    lappend file_cols "verif_areaz"
	    lappend file_cols "accesso_centrale"
	    lappend file_cols "mezzi_antincedio"
	    lappend file_cols "rubinetto_intercett"
	    lappend file_cols "cartell_prevista"
	    lappend file_cols "interr_gen_est"
	    lappend file_cols "assenza_mat_estr"
	    lappend file_cols "apert_ventil_libera"
	    lappend file_cols "disp_regol_clima_pres"
	    lappend file_cols "disp_regol_clima_funz"
	    lappend file_cols "pres_libretto"
	    lappend file_cols "libretto_corretto"
	    lappend file_cols "libretto_manut_imp"
	    lappend file_cols "libretto_manut_bruc"
	    lappend file_cols "dich_conf_imp"
	    lappend file_cols "dich_conf_imp_elett"
	    lappend file_cols "certif_prev_incendi"
	    lappend file_cols "data_ult_manut"
	    lappend file_cols "data_ult_anal_comb"
	    lappend file_cols "autocert_pres"
	    lappend file_cols "note"
	    lappend file_cols "autocert_con_prescr"
	    lappend file_cols "descr_strum"
	    lappend file_cols "marca_strum"
	    lappend file_cols "modello_strum"
	    lappend file_cols "matricola_strum"
	    lappend file_cols "data_taratura_strum"
	    lappend file_cols "fumos_mis_1"
	    lappend file_cols "fumos_mis_2"
	    lappend file_cols "fumos_mis_3"
	    lappend file_cols "temp_flu_mand_mis_1"
	    lappend file_cols "temp_flu_mand_mis_2"
	    lappend file_cols "temp_flu_mand_mis_3"
	    lappend file_cols "temp_flu_mand_med"
	    lappend file_cols "temp_aria_comb_mis_1"
	    lappend file_cols "temp_aria_comb_mis_2"
	    lappend file_cols "temp_aria_comb_mis_3"
	    lappend file_cols "temp_aria_comb_med"
	    lappend file_cols "temp_fumi_mis_1"
	    lappend file_cols "temp_fumi_mis_2"
	    lappend file_cols "temp_fumi_mis_3"
	    lappend file_cols "temp_fumi_med"
	    lappend file_cols "co_mis_1"
	    lappend file_cols "co_mis_2"
	    lappend file_cols "co_mis_3"
	    lappend file_cols "co_med"
	    lappend file_cols "co2_mis_1"
	    lappend file_cols "co2_mis_2"
	    lappend file_cols "co2_mis_3"
	    lappend file_cols "co2_med"
	    lappend file_cols "o2_mis_1"
	    lappend file_cols "o2_mis_2"
	    lappend file_cols "o2_mis_3"
	    lappend file_cols "o2_med"
	    lappend file_cols "temp_mant_mis_1"
	    lappend file_cols "temp_mant_mis_2"
	    lappend file_cols "temp_mant_mis_3"
	    lappend file_cols "temp_mant_med"
	    lappend file_cols "eccesso_aria_mis_1"
	    lappend file_cols "eccesso_aria_mis_2"
	    lappend file_cols "eccesso_aria_mis_3"
	    lappend file_cols "eccesso_aria_med"
	    lappend file_cols "manutenzione_8a"
	    lappend file_cols "manutenzione_anni_prec"
	    lappend file_cols "co_rilevato"
	    lappend file_cols "co_fumi_secchi_8b"
	    lappend file_cols "fumos_med"
	    lappend file_cols "indice_fumos_8c"
	    lappend file_cols "rend_min"
	    lappend file_cols "rend_combustione"
	    lappend file_cols "rend_combustibile_8d"
	    lappend file_cols "pericolosita"
	    lappend file_cols "esito"
	    lappend file_cols "note_conformita"
	    lappend file_cols "note_verificatore"
	    lappend file_cols "note_responsabile"
	    lappend file_cols "mod_pagam"
	    lappend file_cols "costo_verifica"
	    lappend file_cols "rifer_pagam"
	    lappend file_cols "data_ins"
	    lappend file_cols "data_modif"
	    lappend file_cols "ultimo_utente"
	    lappend file_cols "anomalie"

	    # costruisco il record di input
#	    set file_inp_col_list ""
#	    set ind 0
#	    foreach column_name $file_cols {
#    ns_log notice "prova dobelli ciclo costruzione file_inp_col_list  $ind $column_name"
#		lappend file_inp_col_list [set $column_name]
#		incr ind
#	    }
#    ns_log notice "prova dobelli file_inp_col_list = $file_inp_col_list"
	    
	    set ctr_inp 0
	    set ctr_scarto 0
	    set ctr_out 0
	    set ctr_ins 0

    ns_log notice "prova dobelli inizio ciclo lettura file $file_inp_id "
	    
	    # Salto il primo record che deve essere di testata
	    iter_get_csv $file_inp_id file_inp_col_list
	    
	    # Ciclo di lettura sul file di input
	    # uso la proc perche' i file csv hanno caratteristiche 'particolari'
	    iter_get_csv $file_inp_id file_inp_col_list
	    while {![eof $file_inp_id]} {
		incr ctr_inp
    ns_log notice "prova dobelli letto record $ctr_inp $file_inp_col_list "
		
		# valorizzo le relative colonne
		set ind 0
		foreach column_name $file_cols {
		    
                    set valore_colonna [lindex $file_inp_col_list $ind]
		    set valore_colonna [string trim $valore_colonna]
		    set $column_name   $valore_colonna
		    incr ind
		    #ns_log notice "prova dobelli ciclo costruzione riga $ind  column_name = $column_name valore_colonna = $valore_colonna"
		}
		
		ns_log notice "prova dobelli 111"
		ns_log notice "prova dobelli $codice_impianto $cogn_verificatore"


		# ......................................... controlli

		set carica "S"
		set motivo_scarto ""

		if {[string equal $cogn_verificatore ""]} {
                    set carica        "N"
                    append motivo_scarto "/ Manca cognome verificatore"
                } else {
		    if {[db_0or1row sel_verif "select cod_opve from coimopve where cognome = :cogn_verificatore"] == 0} {
                        set carica        "N"
                        append motivo_scarto "/ Verificatore inesistente"
                    }
		}
ns_log notice "prova dobelli data controllo $data_controllo"
		if {[string equal $data_controllo ""]} {
                    set carica        "N"
                    append motivo_scarto "/ Manca data controllo"
                } else {

                    set data_controllo_ck [db_string query "select iter_edit_data(:data_controllo)"]
ns_log notice "prova dobelli data controllo 2  $data_controllo"
		    if {[iter_check_date $data_controllo_ck] == "0"} {
			set carica        "N"
			append motivo_scarto "/ Data controllo non corretta"		
		    }
		}
ns_log notice "prova dobelli ora inizio $ora_inizio"
                if {[string equal $ora_inizio ""]} {
                    set carica        "N"
                    append motivo_scarto "/ Manca ora inizio"
                } else {
		    set ora_inizio_ck [iter_check_time $ora_inizio]
		    if {$ora_inizio_ck == 0} {
			set carica        "N"
                        append motivo_scarto "/ Ora inizio non corretta"
		    }
		} 

ns_log notice "prova dobelli ora fine $ora_fine"
		if {[string equal $ora_fine ""]} {
                    set carica        "N"
                    append motivo_scarto "/ Manca ora fine"
                } else {
                    set ora_fine_ck [iter_check_time $ora_fine]
                    if {$ora_fine_ck == 0} {
                        set carica        "N"
                        append motivo_scarto "/ Ora fine non corretta"
                    }
                }

ns_log notice "prova dobelli resp cogn $cogn_resp nome $nome_resp indir $indir_resp comune $comune_resp prov $prov_resp"

		if {[string equal $cogn_resp ""]} {
		    set carica        "N"
                    append motivo_scarto "/ Manca cognome responsabile"
		} else {
		    if {[string equal $nome_resp ""]} {
			set where_nome_chk " and nome is null"
		    } else {
			set where_nome_chk " and upper(nome) = :nome_resp"
		    }
  		    if {[string equal $indir_resp ""]} {
			set where_indirizzo_chk " and indirizzo is null"
		    } else {
			set where_indirizzo_chk " and upper(indirizzo) = :indir_resp"
		    }
		    if {[string equal $comune_resp ""]} {
			set where_comune_chk " and comune is null"
		    } else {
			set where_comune_chk " and upper(comune) = :comune_resp"
		    }
		    if {[string equal $prov_resp ""]} {
			set where_provincia_chk " and provincia is null"
		    } else {
			set where_provincia_chk " and upper(provincia) = :prov_resp"
		    }
		    if {[db_0or1row sel_citt "select cod_cittadino from coimcitt
		                                                         where upper(cognome) = :cogn_resp
	                                                                $where_nome_chk
	                                                                $where_indirizzo_chk
	                                                                $where_comune_chk
	                                                                $where_provincia_chk"] == "0"} {
			set carica        "N"
			append motivo_scarto "/ Il responsabile non e' presente in anagrafica"
		    }
		}

ns_log notice "prova dobelli combustibile $combustibile"  
		if {[string equal $combustibile ""]} {
                    set carica        "N"
                    append motivo_scarto "/ Manca combustibile"
		} else {
		    if {[db_0or1row sel_comb "select cod_combustibile from coimcomb where descr_comb = :combustibile"] == 0} {
			set carica        "N"
			append motivo_scarto "/ Combustibile inesistente"
                   
		    }
		}

ns_log notice "prova dobelli potenza $potenza_focolare_nom"
		if {[string equal $potenza_focolare_nom ""]} {
                    set carica        "N"
                    append motivo_scarto "/ Manca la potenza"
                } else {
		    if {$potenza_focolare_nom < 35} {
			set carica        "N"
			append motivo_scarto "/ La potenza deve essere superiore o uguale a 35 kW"
		    } else {
                        if {[db_0or1row sel_pot "select cod_potenza from coimpote where potenza_min <= :potenza_focolare_nom and potenza_max >= :potenza_focolare_nom limit 1 "] == 0} {
			    set carica        "N"
			    append motivo_scarto "/ La potenza non e' compresa in nessuna fascia."
			}
                    }
		}

		if {[string equal $codice_impianto ""]} {
		    set carica        "N"
		    append motivo_scarto "/ Manca codice impianto"
		}
		if {[string equal $gen_prog ""]} {
		    set carica        "N"
		    append motivo_scarto "/ Manca il generatore"
		}
		if {![db_0or1row sel_imp "select a.cod_impianto
                                               , a.flag_resp
                                         from coimaimp a
                                             ,coimgend b
                                        where a.cod_impianto     = b.cod_impianto
                                          and b.gen_prog         = :gen_prog
                                          and a.cod_impianto_est = :codice_impianto"]} {
		    set carica        "N"
		    append motivo_scarto "/ Impianto o generatore non presente a sistema"
		}
		set cod_inco ""
#		if {[db_0or1row sel_inco "select cod_inco from coiminco where data_verifica = :data_controllo 
#                                                        and cod_impianto = :cod_impianto limit 1 "] == 0} {
#                        set carica        "N"
#                        append motivo_scarto "/ Incontro inesistente data $data_controllo $ora_inizio $ora_fine"
#		}
				
		ns_log notice "prova dobelli fine controlli iter_controlli_cari"
		
		# fine controlli 
		
		# ricostruisco il record di output
		set file_out_col_list ""
		set ind 0
		foreach column_name $file_cols {
		    lappend file_out_col_list [set $column_name]
		    incr ind
		}
		if {$carica == "S"} {
		    db_1row query "select nextval('coimcimp_s') as cod_cimp"

		    #inserisco il controllo nel DB  
		    db_dml ins_cimp "  insert
             into coimcimp 
                ( cod_cimp
                , cod_impianto
                , gen_prog
                , cod_inco
                , data_controllo
                , cod_opve
                , costo
                , nominativo_pres
                , presenza_libretto
                , libretto_corretto
                , dich_conformita
                , libretto_manutenz
                , mis_port_combust
                , mis_pot_focolare
                , stato_coiben
		, effic_evac
                , verifica_areaz
                , rend_comb_conv
                , rend_comb_min
                , temp_fumi_md
                , t_aria_comb_md
                , temp_mant_md
                , temp_h2o_out_md
                , co2_md
                , o2_md
                , co_md
                , indic_fumosita_1a
                , indic_fumosita_2a
                , indic_fumosita_3a
                , indic_fumosita_md
                , manutenzione_8a
                , co_fumi_secchi_8b
                , indic_fumosita_8c
                , rend_comb_8d
                , esito_verifica
                , note_verificatore
                , note_resp
                , note_conf
                , tipologia_costo
                , riferimento_pag
                , pot_utile_nom
                , pot_focolare_nom
                , cod_combustibile
                , cod_responsabile
                , flag_pericolosita
                , data_ins
                , utente
                , flag_tracciato
                , new1_data_dimp
                , new1_data_paga_dimp
                , new1_conf_locale
                , new1_disp_regolaz
                , new1_lavoro_nom_iniz
                , new1_lavoro_nom_fine
                , new1_lavoro_lib_iniz
                , new1_lavoro_lib_fine
                , new1_note_manu
                , new1_dimp_pres
                , new1_dimp_prescriz
                , new1_data_ultima_manu
                , new1_data_ultima_anal
                , new1_manu_prec_8a
                , new1_co_rilevato
                , new1_flag_peri_8p
                , new1_foro_presente
                , new1_foro_corretto
                , new1_foro_accessibile
                , n_prot
                , data_prot
                , verb_n
                , data_verb
                , pendenza
                , ventilaz_lib_ostruz
                , disp_reg_cont_pre
                , disp_reg_cont_funz
                , disp_reg_clim_funz
                , volumetria
                , comsumi_ultima_stag
                , temp_h2o_out_1a
                , temp_h2o_out_2a
                , temp_h2o_out_3a
                , t_aria_comb_1a
                , t_aria_comb_2a
                , t_aria_comb_3a
                , temp_fumi_1a
                , temp_fumi_2a
                , temp_fumi_3a
                , co_1a
                , co_2a
                , co_3a
                , co2_1a
                , co2_2a
                , co2_3a
                , o2_1a
                , o2_2a
                , o2_3a                                     
                , cod_sanzione_1
                , cod_sanzione_2
                , tiraggio
                , cod_strumento_01
                , cod_strumento_02
                )
           values 
                (:cod_cimp
                ,:codice_impianto
                ,:gen_prog
                ,:cod_inco
                ,:data_controllo
                ,:cod_opve
                ,:costo_verifica
                ,null
                ,:pres_libretto
                ,:libretto_corretto
                ,:dich_conf_imp
                ,:libretto_manut_imp
                ,null
                ,null
                ,:stato_coibentazione
                ,null
                ,:verif_areaz
                ,null
                ,null
                ,:temp_fumi_med
                ,:temp_aria_comb_med
                ,:temp_mant_med
                ,null
                ,:co2_med
                ,:o2_med
                ,:co_med
                ,:fumos_mis_1
                ,:fumos_mis_2
                ,:fumos_mis_3
                ,null
                ,:manutenzione_8a
                ,:co_fumi_secchi_8b
                ,:indice_fumos_8c
                ,:rend_combustibile_8d
                ,:esito
                ,:note_verificatore
                ,:note_responsabile
                ,:note_conformita
                ,null
                ,:rifer_pagam
                ,:potenza_utile_nom
                ,:potenza_focolare_nom
                ,:cod_combustibile
                ,:cod_cittadino
                ,:pericolosita
                , current_date
                ,:ultimo_utente
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,null
                ,:num_protocollo
                ,:data_protocollo
                ,null
                ,null
                ,:pendenza_canali
                ,:apert_ventil_libera
                ,null
                ,null
                ,:disp_regol_clima_funz
                ,:volumetria
                ,:consumi_ult_stag
                ,null
                ,null
                ,null
                ,:temp_aria_comb_mis_1
                ,:temp_aria_comb_mis_2
                ,:temp_aria_comb_mis_3
                ,:temp_fumi_mis_1
                ,:temp_fumi_mis_2
                ,:temp_fumi_mis_3
                ,:co_mis_1
                ,:co_mis_2
                ,:co_mis_3
                ,:co2_mis_1
                ,:co2_mis_2
                ,:co2_mis_3
                ,:o2_mis_1
                ,:o2_mis_2
                ,:o2_mis_3
                ,null
                ,null
                ,null
                ,null
                ,null
                )"
		    db_dml upd_aimp " update coimaimp
              set cod_responsabile = :cod_cittadino
	        , flag_resp        = :flag_resp
                , data_mod         =  current_date
                , utente           = :id_utente
	    where cod_impianto     = :cod_impianto
"
		    #scrivo un record sul file di out con i controlli inseriti
                    set file_out_col_list ""
		    lappend file_out_col_list $codice_impianto
		    lappend file_out_col_list $gen_prog
		    iter_put_csv $file_out_id file_out_col_list
		    incr ctr_ins
		} else {
                    #aggiungo la colonna dei motivi di scarto e 
		    #scrivo un record sul file degli scarti
                    set file_err_col_list ""
		    lappend file_err_col_list $codice_impianto
		    lappend file_err_col_list $gen_prog
		    lappend file_err_col_list $motivo_scarto
		    iter_put_csv $file_err_id file_err_col_list
		    incr ctr_scarto
		    
		}
		
		# lettura del record successivo
		iter_get_csv $file_inp_id file_inp_col_list
	    }
	    
	    ns_log notice "prova dobelli scrive esito iter_controlli_cari"
	    # scrivo la pagina di esito
	    set page_title "Esito caricamento controlli da file esterno"
	    set context_bar [iter_context_bar \
				 [list "javascript:window.close()" "Chiudi finestra"] \
				 "$page_title"]
	    
	    set pagina_esi [subst {
		<master   src="../../master">
		<property name="title">$page_title</property>
		<property name="context_bar">$context_bar</property>
		
		<center>
		
		<table>
		<tr><td valign=top class=form_title align=center colspan=4>
		<b>ELABORAZIONE TERMINATA</b>
		</td>
		</tr>
		
		<tr><td valign=top class=form_title>Letti Controlli:</td>
		<td valign=top class=form_title>$ctr_inp</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
                </tr>
		
                <tr><td colspan=4>&nbsp;</td>
		
                <tr><td valign=top class=form_title>Caricati Controlli:</td>
		<td valign=top class=form_title>$ctr_out</td>
		<td>&nbsp;</td>
		<td valign=top class=form_title><a target="Controlli caricati" href="$file_out_url">Scarica il file csv dei controlli/impianti caricati</a></td>
                </tr>
		
                <tr><td colspan=4>&nbsp;</td>
		
                <tr><td valign=top class=form_title>Scartati Controlli/Impianti:</td>
		<td valign=top class=form_title>$ctr_scarto</td>
		<td>&nbsp;</td>
		<td valign=top class=form_title><a target="Controlli scartati" href="$file_err_url">Scarica il file csv dei controlli/impianti scartati</a></td>
                </tr>
	    }]
	    
	    foreach motivo_scarto [lsort [array names ctr_scarto]] {
		set ws_mot_scarto $motivo_scarto
		regsub -all "à" $ws_mot_scarto {\&agrave;} ws_mot_scarto
		regsub -all "è" $ws_mot_scarto {\&egrave;} ws_mot_scarto
		regsub -all "ì" $ws_mot_scarto {\&igrave;} ws_mot_scarto
		regsub -all "ò" $ws_mot_scarto {\&ograve;} ws_mot_scarto
		regsub -all "ù" $ws_mot_scarto {\&ugrave;} ws_mot_scarto
		
		append pagina_esi [subst {
		    <tr>
                    <td valign=top class=form_title colspan=2>&nbsp;&nbsp;&nbsp;Per [ad_quotehtml $ws_mot_scarto]:</td>
                    <td valign=top class=form_title>$ctr_scarto($motivo_scarto)</td>
                    <td>&nbsp;</td>
		    </tr>
		}]
	    }
	    
	    append pagina_esi [subst {
                <tr><td colspan=4>&nbsp;</td>
		
		</tr>
                </table>
		</center>
	    }]
	    
	    puts $file_esi_id $pagina_esi
	    
	    close $file_inp_id
	    close $file_esi_id
	    close $file_out_id
	    close $file_err_id
	    
	    # inserisco i link ai file di esito sulla tabella degli esiti
	    # ed aggiorno lo stato del batch a 'Terminato'
	    set     esit_list ""
	    lappend esit_list [list "Esito caricamento"  $file_esi_url $file_esi]
	    iter_batch_upd_flg_sta -fine $cod_batc $esit_list
	    ns_log notice "prova dobelli aggiorna stato coimbatc iter_controlli_cari"
	}
	# fine db_transaction ed ora fine with_catch
    } {
	iter_batch_upd_flg_sta -abend $cod_batc
	ns_log Error "iter_controlli_cari: $error_msg"
    }
    return
}
