ad_proc iter_aimp_cari_sche {
    {
	-cod_batc      ""
	-id_utente     ""
	-file_name     ""
    }

} {
    Elaborazione     Caricamento controlli/impianti da file esterno
    @author          Nicola Mortoni
    @creation-date   26/08/2005
    @cvs-id          iter-aimp-cari-sche    

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    sim04 22/05/2017 Personaliz. per Comune di Jesi: ricodificare gli impianti come da Legge
    sim04            Reg. Marche CMJE.
    sim04            Per Comune di Senigalli: CMSE

    gab01 12/04/2017 Gestito cod_impianto_est per provincia di Ancona

    sim03 08/02/2017 Gestito cod_impianto_est per Ancona

    sim02 28/09/2016 Taranto ha il cod. impianto composto dalle ultime 3 cifre del codice istat
    sim02            + un progressivo

    nic01 04/02/2016 Gestito coimtgen.lun_num_cod_impianto_est per regione MARCHE

    sim01 28/09/2015 Da ottobre 2015 gli enti della regione marche devono costruire il codice
    sim01            impianto con una sigla imposta dalla regione (es: CMPS) + un progressivo
    sim01            di 6 cifre.
} {


    ns_log notice "prova dob inizio programma"

    # aggiorno stato di coimbatc
    iter_batch_upd_flg_sta -iniz $cod_batc
 
    db_transaction {
	
	# reperisco le colonne della tabella parametri
	iter_get_coimtgen
     	set flag_codifica_reg   $coimtgen(flag_codifica_reg)
	set lun_num_cod_imp_est $coimtgen(lun_num_cod_imp_est);#nic01
	
	# valorizzo la data_corrente (serve per l'inserimento)
	set data_corrente  [iter_set_sysdate]
	
	set permanenti_dir [iter_set_permanenti_dir]
	set permanenti_dir_url [iter_set_permanenti_dir_url]
	set file_inp_name  "Caricamento scheda impianto-input"
	set file_inp_name  [iter_temp_file_name -permanenti $file_inp_name]
	set file_esi_name  "Caricamento scheda impianto-esito"
	set file_esi_name  [iter_temp_file_name -permanenti $file_esi_name]
	set file_out_name  "Caricamento scheda impianto-caricati"
	set file_out_name  [iter_temp_file_name -permanenti $file_out_name]
	set file_err_name  "Caricamento scheda impianto-scartati"
	set file_err_name  [iter_temp_file_name -permanenti $file_err_name]
	
	# salvo i file di output come .txt in modo che excel permetta di
	# indicare il formato delle colonne (testo) al momento
	# dell'importazione del file.
	# in caso contrario i numeri di telefono rimarrebbero senza lo zero
	# ed i civici 8/10 diverrebbero una data!
	# bisogna fare in modo che excel apra correttamente il file
	# degli scarti perche' l'utente potrebbe correggere gli errori
	# e provare a ricaricarli.
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
	# crlf come fine riga di default andrebbe a capo anche con gli
	# eventuali lf contenuti tra doppi apici.
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
	lappend head_cols "Cognome responsabile"
	lappend head_cols "Nome responsabile"
	lappend head_cols "Tipo toponimo"
	lappend head_cols "Nome toponimo"
	lappend head_cols "Civico"
	lappend head_cols "Cap"
	lappend head_cols "Comune"
	lappend head_cols "Codice via"
	lappend head_cols "Tipo toponimo ubicazione"
	lappend head_cols "Nome toponimo ubicazione"
	lappend head_cols "Civico ubicazione"
	lappend head_cols "Esponente ubicazione"
	lappend head_cols "Scala ubicazione"
	lappend head_cols "Piano ubicazione"
	lappend head_cols "Interno ubicazione"
	lappend head_cols "Cap ubicazione"
	lappend head_cols "Comune ubicazione"
	lappend head_cols "Codice Istat del Comune"
	lappend head_cols "Numero telefonico"
	lappend head_cols "Combustibile"
	lappend head_cols "Codice fiscale del responsabile"
	lappend head_cols "P.Iva del responsabile"
	lappend head_cols "Matricola"
	lappend head_cols "Modello"
	lappend head_cols "Costruttore"
	lappend head_cols "Potenza foc nom"
	lappend head_cols "Potenza foc util"
	lappend head_cols "Codice manutentore"
	lappend head_cols "Codice installatore"
	lappend head_cols "Data installazione"
	lappend head_cols "Data costruzione"
	lappend head_cols "Numero generatori"
	lappend head_cols "Tipo responsabile"
	# uso la proc perche' i file csv hanno caratterstiche 'particolari'
	set     out_cols  $head_cols
	lappend out_cols  "cod_cittadino inserito"
	lappend out_cols  "cod_impianto inserito"
	iter_put_csv $file_out_id out_cols
	
	# preparo e scrivo la riga di intestazione del file degli errori
	lappend head_cols "Motivo di scarto"
	iter_put_csv $file_err_id head_cols
	
	# definisco il tracciato record del file di input
	set     file_cols ""
	lappend file_cols "inp_cognome"
	lappend file_cols "inp_nome"
	lappend file_cols "inp_toponimo"
	lappend file_cols "inp_tipo_toponimo"
	lappend file_cols "inp_civico"
	lappend file_cols "inp_cap"
	lappend file_cols "inp_comune"
	lappend file_cols "inp_codice_via"
	lappend file_cols "inp_tipo_toponimo_ubic"
	lappend file_cols "inp_nome_toponimo_ubic"
	lappend file_cols "inp_civico_ubic"
	lappend file_cols "inp_esponente_ubic"
	lappend file_cols "inp_scala_ubic"
	lappend file_cols "inp_piano_ubic"
	lappend file_cols "inp_interno_ubic"
	lappend file_cols "inp_cap_ubic"
	lappend file_cols "inp_comune_ubic"
	lappend file_cols "inp_codice_istat"
	lappend file_cols "inp_numero_telefonico"
	lappend file_cols "inp_combustibile"
	lappend file_cols "inp_codice_fiscale"
	lappend file_cols "inp_piva"
	lappend file_cols "inp_matricola"
	lappend file_cols "inp_modello"
	lappend file_cols "inp_costruttore"
	lappend file_cols "inp_potenza_nom"
	lappend file_cols "inp_potenza_util"
	lappend file_cols "inp_codice_manutentore"
	lappend file_cols "inp_codice_installatore"
	lappend file_cols "inp_data_installazione"
	lappend file_cols "inp_data_costruzione"
	lappend file_cols "inp_numero_generatori"
	lappend file_cols "inp_tipo_responsabile"
	
	
	set ctr_inp 0
	set ctr_err 0
	set ctr_out 0
	set ctr_ins_citt 0
	set ctr_ins_aimp 0
	set ctr_ins_gend 0
	set ctr_ins_inco 0
	set tipologia ""
	
	# reperisco una volta sola max_cod_impianto_est
	if {$flag_codifica_reg != "T"} {
	    if {$coimtgen(flag_cod_aimp_auto) != "T"} {
		set max_cod_impianto_est [db_string sel_aimp_max_cod_impianto_est ""]
	    }
	}
	

	# Salto il primo record che deve essere di testata
	iter_get_csv $file_inp_id file_inp_col_list
	
	# Ciclo di lettura sul file di input
	# uso la proc perche' i file csv hanno caratteristiche 'particolari'

	################## inizio ciclo

	ns_log notice "prova dob inizia ciclo"

	iter_get_csv $file_inp_id file_inp_col_list
	while {![eof $file_inp_id]} {


	    incr ctr_inp
	    set ind 0
	    foreach column_name $file_cols {
		set $column_name [lindex $file_inp_col_list $ind]
		incr ind
	    }
	    
	    
	    set ws_cognome     [string trim $inp_cognome]
	    set ws_nome [string trim $inp_nome]
	    set ws_toponimo [string trim $inp_toponimo]
	    set ws_tipo_toponimo [string trim $inp_tipo_toponimo]
	    set ws_civico [string trim $inp_civico]
	    set ws_cap [string trim $inp_cap]
	    set ws_comune [string trim $inp_comune]
	    set ws_codice_via [string trim $inp_codice_via]
	    set ws_tipo_toponimo_ubic [string trim $inp_tipo_toponimo_ubic]
	    set ws_nome_toponimo_ubic [string trim $inp_nome_toponimo_ubic]
	    set ws_civico_ubic [string trim $inp_civico_ubic]
	    set ws_esponente_ubic [string trim $inp_esponente_ubic]
	    set ws_scala_ubic [string trim $inp_scala_ubic]
	    set ws_piano_ubic [string trim $inp_piano_ubic]
	    set ws_interno_ubic [string trim $inp_interno_ubic]
	    set ws_cap_ubic [string trim $inp_cap_ubic]
	    set ws_comune_ubic [string trim $inp_comune_ubic]
	    set ws_codice_istat [string trim $inp_codice_istat]
	    set ws_numero_telefonico [string trim $inp_numero_telefonico]
	    set ws_combustibile [string trim $inp_combustibile]
	    set ws_codice_fiscale [string trim $inp_codice_fiscale]
	    set ws_piva [string trim $inp_piva]
	    set ws_matricola [string trim $inp_matricola]
	    set ws_modello [string trim $inp_modello]
	    set ws_costruttore [string trim $inp_costruttore]
	    set ws_potenza_nom [string trim $inp_potenza_nom]
	    set ws_potenza_util [string trim $inp_potenza_util]
	    set ws_codice_manutentore [string trim $inp_codice_manutentore]
	    set ws_codice_installatore [string trim $inp_codice_installatore]
	    set ws_data_installazione [string trim $inp_data_installazione]
	    set ws_data_costruzione [string trim $inp_data_costruzione]
	    set ws_numero_generatori [string trim $inp_numero_generatori]
	    set ws_tipo_responsabile [string trim $inp_tipo_responsabile]
	    
	    set ws_cognome              [string toupper  $ws_cognome]
	    set ws_tipo_toponimo_ubic  [string toupper  $ws_tipo_toponimo_ubic]
	    set ws_nome_toponimo_ubic  [string toupper  $ws_nome_toponimo_ubic]
	    set ws_combustibile       [string toupper  $ws_combustibile]
	    set ws_costruttore        [string toupper  $ws_costruttore]
	    set ws_nome                [string toupper  $ws_nome]
	    set ws_civico              [string trimleft $ws_civico "0"]
	    set ws_civico_ubic         [string trimleft $ws_civico_ubic "0"]
	    

	    ns_log notice "prova dob ciclo nominativo $ws_cognome $ws_nome"


	    set carica "S"
	    
	    if {$carica == "S"} {
		if {[string equal $ws_cognome ""]} {
		    set carica        "N"
		    set motivo_scarto "Ragione sociale non valorizzata"
		}
	    }
	    
	    if {$carica == "S"} {
		if {[string equal $ws_tipo_toponimo ""]} {
		    set carica        "N"
		    set motivo_scarto "Tipo toponimo non valorizzato"
		}
	    }
	    if {$carica == "S"} {
		if {[string equal $ws_toponimo ""]} {
		    set carica        "N"
		    set motivo_scarto "Nome toponimo non valorizzato"
		}
	    }
	    
	    if {$carica == "S"} {
		if {[string equal $ws_nome_toponimo_ubic ""]} {
		    set carica        "N"
		    set motivo_scarto "Nome toponimo ubicazione non valorizzato"
		}
	    }
	    if {$carica == "S"} {
		if {[string equal $ws_tipo_toponimo_ubic ""]} {
		    set carica        "N"
		    set motivo_scarto "Tipo toponimo ubicazione non valorizzato"
		}
	    }
	    
	    
	    if {$carica == "S"} {
		if {[string equal $ws_civico ""]} {
		    set ws_civico ""
		}
	    }
	    
	    if {$carica == "S"} {
		if {[string equal $ws_cap ""]} {
		    set carica        "N"
		    set motivo_scarto "Cap non valorizzato"
		}
	    }
	    
	    if {$carica == "S"} {
		if {![string is integer $ws_cap]} {
		    set carica        "N"
		    set motivo_scarto "Cap non numerico"
		}
	    }
	    if {$carica == "S"} {
		if {![string is integer $ws_cap_ubic]} {
		    set carica        "N"
		    set motivo_scarto "Cap ubicazione non numerico"
		}
	    }
	    
	    ns_log Notice "Inizio della procedura 0 $ws_comune_ubic"
	    if {$carica == "S"} {
		if {![string equal $ws_comune_ubic ""]} {
		    set denominazione $ws_comune_ubic
		    db_1row sel_comu_check ""
		    if {$ctr_comu == 0} {
			set carica        "N"
			set motivo_scarto "Comune ubicazione non esistente in tabella Comuni"
		    }
		    if {$ctr_comu > 1} {
			set carica        "N"
			set motivo_scarto "Trovati piucomuni con questa denominazione"
		    }
		    if {$ctr_comu == 1} {
		   	if {[db_0or1row sel_comu ""] == 0} {
	           		    set carica        "N"
	           		    set motivo_scarto "Comune non esistente in tabella Comuni"
		   	} else {
		   	    if {$coimtgen(flag_ente) == "C"
		    		&&  $coimtgen(cod_comu)  != $cod_comune
		   	    } {
		   		set carica        "N"
	          			set motivo_scarto "Comune diverso da $coimtgen(denom_comune)"
		   	    }
		    	}
		   }
		}
	    }
	    
	    # if {$carica == "S"} {
	    #	if {[string equal $ws_codice_istat ""]} {
	    #	    set carica        "S"
	    #		    } else {
	    #	    set cod_istat [string range $ws_codice_istat 3 7]
	    #	    db_1row sel_istat_check ""
	    # 	    if {$ctr_istat == 0} {
	    #		set carica        "N"
	    #		set motivo_scarto "Codice istat non esistente in tabella Comuni"
	    #	    }
	    #	    if {$ctr_istat > 1} {
	    #		set carica        "N"
	    #		set motivo_scarto "Trovati piucomuni con questo codice"
	    #	    }
	    #	}
	    #}
	    
	    if {$coimtgen(flag_viario) == "T"
		&&  $carica == "S"
	    } {
		set descr_topo  $ws_tipo_toponimo_ubic
		set descrizione $ws_nome_toponimo_ubic
		db_1row sel_viae_check ""
		if {$ctr_viae == 0} {
		    set carica        "N"
		    set motivo_scarto "Toponimo ubicazione non esistente in tabella Viario"
		}
		if {$ctr_viae > 1} {
		    set carica        "N"
		    set motivo_scarto "Trovati più toponimi con questo nome in tabella Viario"
		}
	    }
	    
	    if {$carica == "S"} {
		set cod_combustibile ""
		if {[string equal $ws_combustibile ""]} {
		    set carica        "N"
		    set motivo_scarto "Combustibile non valorizzato"
		} else {
		    switch $ws_combustibile {
			"GASOLIO"             {set cod_combustibile "3"}
			"METANO"              {set cod_combustibile "5"}
			"GPL"                 {set cod_combustibile "4"}
			"OLIO"                {set cod_combustibile "1"}
			"COMBUSTIBILE SOLIDO" {set cod_combustibile "2"}
			"LEGNA"               {set cod_combustibile "8"}
			"TELERISCALDAMENTO"   {set cod_combustibile "10"}
			default {set carica "N"
			    set motivo_scarto "Combustibile non presente in tabella Combustibili"}
		    }
		}
	    }
	    
	    
	    if { $carica == "S"} {
		set descr_cost $ws_costruttore
		set ws_cod_cost ""
		db_1row sel_cost_check ""
		set ws_cod_cost  $cod_cost
		if {$ctr_cost == 0} {
		    set carica        "N"
		    set motivo_scarto "Costruttore non esistente in tabella"
		}
		if {$ctr_cost > 1} {
		    set carica        "N"
		    set motivo_scarto "Trovati più costruttori con questo nome : eseguire la bonifica"
		}
	    }	
	    
	 
#	    if {$carica == "S"} {
#		if {[regexp {[^0123456789.]} $ws_potenza_nom]} {
#		    set carica        "N"
#		    set motivo_scarto "la potenza nomina contine caratteri non validi"
#		    incr errori
#		    db_dml ins_anom "insert into $nome_tabella_anom values ( :id_riga , :cod_manutentore, 'cod_fiscale_resp' , :desc_errore )"
#		}
#	    }
 
	    if {$carica == "S"} {
		if {![string equal $ws_potenza_nom ""]} {
#		    set ws_potenza_nom [db_string query "select replace(:ws_potenza_nom,'.',',')"] 
#		    set ws_potenza_nom  [iter_edit_num $ws_potenza_nom 2]
		    set ws_potenza_nom [string map {"." ","} $ws_potenza_nom]
		    set ctr_virgole [regsub -all "," $ws_potenza_nom "," campo_di_comodo1]
                    if {$ctr_virgole > 1} {   
                        set carica "N"
			set motivo_scarto "Potenza nominale non numerica"
		    } 
		}
	    }
            if {$carica == "S"} {
		set ws_potenza_nom [iter_check_num $ws_potenza_nom 2]
		if {$ws_potenza_nom== "Error"} {
		    set carica "N"
		    set motivo_scarto "Potenza nominale non numerica"
		}
	    }
	    
	    if {$carica == "S"} {
		if {![string equal $ws_potenza_util ""]} {
		    set ws_potenza_util [string map {"." ","} $ws_potenza_util]
		    set ctr_virgole [regsub -all "," $ws_potenza_util "," campo_di_comodo1]
                    if {$ctr_virgole > 1} {   
                        set carica "N"
			set motivo_scarto "Potenza utile non numerica"
		    } 
		}
	    }
            if {$carica == "S"} {
		set ws_potenza_util [iter_check_num $ws_potenza_util 2]
		if {$ws_potenza_util == "Error"} {
		    set carica "N"
		    set motivo_scarto "Potenza utile non numerica"
		}
	    }
	    
	    ns_log notice "prova dob ciclo nominativo $ws_potenza_nom  $ws_potenza_util"
	    if {$carica == "S"} {
		if {![string equal $ws_numero_generatori ""]} {
		    set ws_numero_generatori [iter_check_num $ws_numero_generatori 2]
		    if {$ws_numero_generatori == "Error"} {
			set carica "N"
			set motivo_scarto "Numero generatori non numerici"
		    }
		}
	    }
	    
	    
	    if {$carica == "S"} {
		set cod_manutentore  $ws_codice_manutentore
		db_1row sel_manu_check ""
		if {$ctr_manu == 0} {
		    set carica        "N"
		    set motivo_scarto "Codice Manutentore inesitsente"
		}
	    }

	    if {![string equal $ws_codice_installatore ""]} {
		if {$carica == "S"} {
		    set cod_manutentore  $ws_codice_installatore
		    db_1row sel_manu_check ""
		    if {$ctr_manu == 0} {
			set carica        "N"
			set motivo_scarto "Codice Installatore inesistente"
		    }
		}
	    }
	    if {$carica == "S"} {
		set ws_data_costruzione [iter_edit_date $ws_data_costruzione]
		set ws_data_costruzione [iter_check_date $ws_data_costruzione]
		if {$ws_data_costruzione == 0} {
		    set carica        "N"
		    set motivo_scarto "Data costruzione non corretta"
		}
	    }
	    
	    if {$carica == "S"} {
		set ws_data_installazione [iter_edit_date $ws_data_installazione]
		set ws_data_installazione [iter_check_date $ws_data_installazione]
		if {$ws_data_installazione == 0} {
		    set carica        "N"
		    set motivo_scarto "Data installazione non corretta"
		}
	    }
	    
	    # assegnazione fascia
	    if {$carica == "S"} {
		set cod_potenza [db_string sel_pot "select coalesce(cod_potenza, '') from coimpote where potenza_min <= :ws_potenza_nom and potenza_max >= :ws_potenza_nom" -default 0]
	    }
	    # ns_log Notice "Inizio della procedura 0 $motivo_scarto"
	    
	    if {$carica == "S"} {
		
		set cognome      $ws_cognome
		set nome         $ws_nome
		if {[string length $cognome] > 100} {
		    set cognome  [string range $cognome 0 99]
		}
		if {[string length $nome] > 100} {
		    set nome     [string range $nome    0 99]
		}
		
		if {![string equal $nome ""]} {
		    set where_nome "and nome = :nome"
		} else {
		    set where_nome "and nome is null"
		}
		set comune        $ws_comune
		
		set indirizzo    "$ws_toponimo $ws_tipo_toponimo"
		if {[string length $indirizzo] > 40} {
		    set indirizzo [string range $indirizzo 0 39]
		}
		set numciv_espciv_list [iter_separa_numciv_espciv $ws_civico]
		set elab_numero        [lindex $numciv_espciv_list 0]
		set elab_esponente     [lindex $numciv_espciv_list 1]
		set msg_err            [lindex $numciv_espciv_list 2]
		
		if {[string length $elab_esponente] > 3} {
		    set elab_localita  $elab_esponente
		    set elab_esponente ""
		} else {
		    set elab_localita  ""
		}
		
		if {[string length $elab_numero] <= 6
		    && ![string is space $elab_esponente]
		} {
		    set numero        "$elab_numero/$elab_esponente"
		} else {
		    set numero         $elab_numero
		}
		
		if {[string length $numero] > 8} {
		    set numero        [string range $numero 0 7]
		}
		
		if {![string equal $numero ""]} {
		    set where_numero  "and numero = :numero"
		} else {
		    set where_numero   ""
		}
		
		db_1row sel_citt_check ""
		if {$ctr_citt != 1} {
		    
		    set cod_cittadino    [db_string sel_dual_cod_cittadino ""]
		    set natura_giuridica ""
		    set cap              $ws_cap
		    if {[string length $cap] > 5} {
			set cap          [string range $cap 0 4]
		    }
		    
		    set localita         $elab_localita
		    
		    set cod_fiscale      $ws_codice_fiscale
		    set cod_piva         $ws_piva
		    set telefono         $ws_numero_telefonico

		    if {[string length $telefono] > 15} {
			set telefono [string range $telefono 0 14]
		    }
		    
		    set cellulare        ""
		    set fax              ""
		    set email            ""
		    set data_nas         ""
		    set comune_nas       ""
		    set utente           $id_utente
		    set data_ins         $data_corrente
		    set data_mod         ""
		    set utente_ult       ""
		    set note             ""
		    
		    db_dml ins_citt ""
		    incr ctr_ins_citt
		    
		    set out_cod_cittadino $cod_cittadino
		} else {
		    set out_cod_cittadino ""
		}
	
	
                if {$flag_codifica_reg == "T"} {
                    #gab01 aggiunto || su provincia di Ancona
		    #sim03 aggiunto || su Ancona
		    if {$coimtgen(ente) eq "CPESARO" || $coimtgen(ente) eq "PPU" || $coimtgen(ente) eq "CFANO" || $coimtgen(ente) eq "CANCONA" || $coimtgen(ente) eq "PAN" || $coimtgen(ente) eq "CJESI" || $coimtgen(ente) eq "CSENIGALLIA"} {#sim01: aggiunta if ed il suo contenuto
			if {$coimtgen(ente) eq "CPESARO"} {
			    set sigla_est "CMPS"
			} elseif {$coimtgen(ente) eq "CFANO"} {
			    set sigla_est "CMFA"
			} elseif {$coimtgen(ente) eq "CANCONA"} {;#sim03
                            set sigla_est "CMAN"
			} elseif {$coimtgen(ente) eq "PAN"} {;#gab01
                            set sigla_est "PRAN"
			} elseif {$coimtgen(ente) eq "CJESI"} {;#sim04
                            set sigla_est "CMJE"
                        } elseif {$coimtgen(ente) eq "CSENIGALLIA"} {;#sim04
                            set sigla_est "CMSE"
                        } else {
			    set sigla_est "PRPU"
			}
			
			set progressivo_est [db_string sel "select nextval('coimaimp_est_s')"]
			
			# devo fare l'lpad con una seconda query altrimenti mi va in errore
			#nic01 set progressivo_est [db_string sel "select lpad(:progressivo_est,6,'0')"]
			set progressivo_est [db_string sel "select lpad(:progressivo_est,:lun_num_cod_imp_est,'0')"];#nic01
			
			set cod_impianto_est "$sigla_est$progressivo_est"

		    } else {#sim01

			# caso standard
				   
			if {![string equal $cod_comune ""]} {
			    db_1row sel_dati_comu "
                            select coalesce(progressivo,0) + 1 as progressivo --sim02
                           --sim02 coalesce(lpad((progressivo + 1), 7,'0'),'0000001') as progressivo
       		                 , cod_istat
			      from coimcomu
			     where cod_comune = :cod_comune"
			    
			    #sim02 uniformato agli altri pogrammi che codificano l'impianto
			    if {$coimtgen(ente) eq "PMS"} {#sim02: Riportato modifiche fatte per Massa in data 03/12/2015 per gli altri programmi dove e' presente la codifica dell'impianto 
				set progressivo [db_string query "select lpad(:progressivo, 5, '0')"]
				set cod_istat  "[string range $cod_istat 5 6]/"
			    } elseif {$coimtgen(ente) eq "PTA"} {#sim02: aggiunta if e suo contenuto
				set progressivo [db_string query "select lpad(:progressivo, 7, '0')"]
				set fine_istat  [string length $cod_istat]
				set iniz_ist    [expr $fine_istat -3]
				set cod_istat  "[string range $cod_istat $iniz_ist $fine_istat]"
			    } else {#sim02
				set progessivo [db_string query "select lpad(:progressivo, 7, '0')"];#sim01
			    };#sim02

			    if {![string equal $ws_potenza_nom "0.00"]
			    &&  ![string equal $ws_potenza_nom ""]
			    } {
				if {$ws_potenza_nom < 35} {
				    set tipologia "IN"
				} else {
				    set tipologia "CT"
				}
				#sim02 set cod_impianto_est "$cod_istat$tipologia$progressivo"
				set cod_impianto_est "$cod_istat$progressivo";#sim02

				db_dml upd_prog_comu "
                                update coimcomu
	                           set progressivo = :progressivo
                                 where cod_comune  = :cod_comune"
			    } else {
				if {![string equal $cod_potenza "0"]
				&&  ![string equal $cod_potenza ""]} { 
				    switch $cod_potenza {
					"B"  {set tipologia "IN"}
					"A"  {set tipologia "CT"}
					"MA" {set tipologia "CT"}
					"MB" {set tipologia "CT"}
				    }
				    
				    #sim02 set cod_impianto_est "$cod_istat$tipologia$progressivo"
				    set cod_impianto_est "$cod_istat$progressivo";#sim02

				    db_dml upd_prog_comu "
                                update coimcomu
                                   set progressivo = :progressivo
                                 where cod_comune  = :cod_comune"
				} else {
				    set cod_impianto_est ""
				}
			    }
			} else {
			    set cod_impianto_est ""
			}
		    };#sim01
		} else {
		    db_1row sel_dual_cod_impianto_est ""
		}            

 
             set ws_cod_impianto_est  $cod_impianto_est
		
             set cod_impianto      [db_string sel_dual_cod_impianto ""]
		#if {![string equal $ws_cod_impianto_est ""] } {
		#    set cod_impianto_est $ws_cod_impianto_est
		#} else {
		  #  if {$coimtgen(flag_cod_aimp_auto) == "T"} {
		#	set cod_impianto_est  [db_string sel_dual_cod_impianto_est ""]
		 #   } else {
		#	incr max_cod_impianto_est
		#	set cod_impianto_est  [format %010d $max_cod_impianto_est]
		 #   }
		#}   
        
              if {$ws_tipo_responsabile == "P"} {
		     set cod_proprietario  $cod_cittadino
                   set cod_occupante  ""
                   set cod_amministratore  ""
                 }

              if {$ws_tipo_responsabile == "O"} {
		     set cod_occupante  $cod_cittadino
                  set cod_amministratore  ""
                  set cod_proprietario  ""
                 }

              if {$ws_tipo_responsabile == "A"} {
		     set cod_amministratore  $cod_cittadino
                   set cod_occupante  ""
                   set cod_proprietario  ""
                 }

              if {$ws_tipo_responsabile == "T"} {
                  set cod_manutentore    $ws_codice_manutentore
                  db_1row sel_manu_rapp ""
		   if {![string equal $cod_legale_rapp ""]} {
        	      set cod_amministratore  ""
                    set cod_occupante  ""
                    set cod_proprietario  ""
                    set cod_cittadino    $cod_legale_rapp
                     } else {
                    set cod_amministratore  ""
                    set cod_occupante  ""
                    set cod_proprietario  ""
                    set cod_cittadino  $ws_codice_manutentore
                  }
               }

		ns_log Notice "Inizio della procedura 1"
              if {$tipologia == ""} {set  tipologia ""} 
		set cod_impianto_prov  ""
		set descrizione        ""
		set provenienza_dati   0
		set cod_combustibile   $cod_combustibile
		set cod_potenza        $cod_potenza
		set potenza            $ws_potenza_nom
		set potenza_utile      $ws_potenza_util
		set data_installaz     $ws_data_installazione
		set data_attivaz       ""
		set data_rottamaz      ""
		set note               ""
		set stato              "A"
		set flag_dichiarato    "S"
		set data_prima_dich    ""
		set data_ultim_dich    ""
		set cod_tpim           $tipologia
		set consumo_annuo      ""
		set n_generatori       $ws_numero_generatori
		set stato_conformita   ""
		set cod_cted           ""
		set tariffa            ""
		set cod_responsabile   $cod_cittadino
		set flag_resp          $ws_tipo_responsabile
		set cod_intestatario   ""
		set flag_intestatario  ""
		set cod_manutentore    $ws_codice_manutentore
		set cod_installatore   $ws_codice_installatore
		set cod_distributore   ""
		set cod_progettista    ""
		set cod_amag           ""
		set cod_ubicazione     ""
		set localita           $elab_localita
		
		if {$coimtgen(flag_viario) == "T"} {
		    
		    set toponimo       $ws_tipo_toponimo_ubic
		    set indirizzo      $ws_nome_toponimo_ubic
		} else {
		    set cod_via        ""
		    set toponimo       $ws_tipo_toponimo_ubic
		    if {[string length $toponimo] > 20} {
			set toponimo  [string range $toponimo 0 19]
		    }
		    
		    set indirizzo      $ws_nome_toponimo_ubic
		    if {[string length $indirizzo] > 100} {
			set indirizzo [string range $indirizzo 0 99]
		    }
		}
           # sistemazione del 16-01-11
            if {$ws_tipo_responsabile == "T"} {
		set numciv_espciv_list [iter_separa_numciv_espciv $ws_civico_ubic]
		set elab_numero        [lindex $numciv_espciv_list 0]
		set elab_esponente     [lindex $numciv_espciv_list 1]
		set msg_err            [lindex $numciv_espciv_list 2]
             }

		if {[string length $elab_numero] <= 8} {
		    set numero         $elab_numero
		} else {
		    set numero         [string range $elab_numero 0 7]
		}
		set esponente          $elab_esponente
		
		set scala              ""
		set piano              ""
		set interno            ""
		set cap                $ws_cap
		if {[string length $cap] > 5} {
		    set cap            [string range $cap 0 4]
		}
		set cod_catasto        ""
		set cod_tpdu           ""
		set cod_qua            ""
		set cod_urb            ""
		set data_ins           $data_corrente
		set data_mod           ""
		set utente             $id_utente
		set flag_dpr412        "S"
              set anno_costruzione   $ws_data_costruzione

		
		set where_indirizzo ""
		if {![string equal $localita ""]} {
		    append where_indirizzo " and localita = :localita"
		}
		if {![string equal $cod_via ""]} {
		    append where_indirizzo " and cod_via = :cod_via"
		}
		if {![string equal $toponimo ""]} {
		    append where_indirizzo " and toponimo = :toponimo"
		}
		if {![string equal $indirizzo ""]} {
		    append where_indirizzo " and indirizzo = :indirizzo"
		}
		if {![string equal $numero ""]} {
		    append where_indirizzo " and numero = :numero"
		}
		if {![string equal $cod_comune ""]} {
		    append where_indirizzo " and cod_comune = :cod_comune"
		}
		if {![string equal $cod_provincia ""]} {
		    append where_indirizzo " and cod_provincia = :cod_provincia"
		}
		if {![string equal $cap ""]} {
		    append where_indirizzo " and cap = :cap"
		}
		
		if {![string equal $ws_cod_impianto_est ""] } {
		    db_1row sel_aimp_cod_est_check ""
		    if {$ctr_aimp == 0} {
			db_1row sel_aimp_check ""
		    }
		} else {
		    db_1row sel_aimp_check ""
		}
		
		if {$ctr_aimp > 0} {
		    set carica        "N"
		    set motivo_scarto "Impianto gia esistente codice: $cod_impianto_es" 
		    set out_cod_inco ""
		} else {
		    db_dml ins_aimp ""
		    incr ctr_ins_aimp
		    
		    set out_cod_impianto   $cod_impianto
		    set gen_prog         1
		    set descrizione      ""
		    set matricola        $ws_matricola
		    set modello          $ws_modello
		    set cod_cost         $ws_cod_cost
		    set matricola_bruc   ""
		    set modello_bruc     ""
		    set cod_cost_bruc    ""
		    set tipo_foco        ""
		    set mod_funz         ""
		    set cod_utgi         ""
		    set tipo_bruciatore  ""
		    set tiraggio         ""
		    set locale           ""
		    set cod_emissione    ""
		    set cod_combustibile $cod_combustibile
		    set data_rottamaz    ""
		    set pot_focolare_lib 0
		    set pot_utile_lib    0
		    set pot_focolare_nom $ws_potenza_nom
		    set pot_utile_nom    $ws_potenza_util
		    set flag_attivo      "S"
		    set note             ""
		    set data_ins         $data_corrente
		    set data_mod         ""
		    set utente           $id_utente
		    set gen_prog_est     1
                  set data_costruz_gen $ws_data_costruzione

		    
		    db_dml ins_gend ""
		    incr ctr_ins_gend
		    
		    set out_gen_prog     $gen_prog
		    

		}
	    }
	    
	    set file_out_col_list ""
	    set ind 0
	    foreach column_name $file_cols {
		lappend file_out_col_list [set $column_name]
		incr ind
	    }
	    
	    if {$carica == "S"} {
		lappend file_out_col_list $out_cod_cittadino
		lappend file_out_col_list $out_cod_impianto
		lappend file_out_col_list $out_gen_prog
				
		iter_put_csv $file_out_id file_out_col_list
		incr ctr_out
	    } else {
		lappend file_out_col_list $motivo_scarto
		iter_put_csv $file_err_id file_out_col_list
		incr ctr_err
		
		if {![info exists ctr_scarto($motivo_scarto)]} {
		    set ctr_scarto($motivo_scarto) 1 			    
		} else {
		    incr ctr_scarto($motivo_scarto)
		}	    
	    }
  
	    
ns_log notice "prova dob leggo record successivo"

	    iter_get_csv $file_inp_id file_inp_col_list
	}
	
ns_log notice "prova dob finito ciclo"
	
	
	# scrivo la pagina di esito
	set page_title "Esito caricamento schede impianti da file esterno"
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
	    
	    <tr><td valign=top class=form_title>Letti Controlli/Impianti:</td>
	    <td valign=top class=form_title>$ctr_inp</td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	    </tr>
	    
	    <tr><td colspan=4>&nbsp;</td>
	    
	    <tr><td valign=top class=form_title>Caricati Schede Impianti:</td>
	    <td valign=top class=form_title>$ctr_out</td>
	    <td>&nbsp;</td>
	    <td valign=top class=form_title><a target="Schede Impianti caricati" href="$file_out_url">Scarica il file csv delle schede/impianti caricati</a></td>
	    </tr>
	    
	    <tr><td valign=top class=form_title colspan=2>&nbsp;&nbsp;&nbsp;Inseriti nuovi Soggetti:</td>
	    <td valign=top class=form_title>$ctr_ins_citt</td>
	    <td>&nbsp;</td>
	    </tr>
	    
	    <tr><td valign=top class=form_title colspan=2>&nbsp;&nbsp;&nbsp;Inseriti nuovi Impianti:</td>
	    <td valign=top class=form_title>$ctr_ins_aimp</td>
	    <td>&nbsp;</td>
	    </tr>
	    
	    <tr><td valign=top class=form_title colspan=2>&nbsp;&nbsp;&nbsp;Inseriti nuovi Generatori:</td>
	    <td valign=top class=form_title>$ctr_ins_gend</td>
	    <td>&nbsp;</td>
	    </tr>
	    
	        
	    <tr><td colspan=4>&nbsp;</td>
	    
	    <tr><td valign=top class=form_title>Scartate Schede/Impianti:</td>
	    <td valign=top class=form_title>$ctr_err</td>
	    <td>&nbsp;</td>
	    <td valign=top class=form_title><a target="Controlli/Impianti scartati" href="$file_err_url">Scarica il file csv delle schede/impianti scartati</a></td>
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
	    
	    <tr><td valign=top colspan=4 class=form_title>
	    Da questa pagina &egrave; possibile scaricare il file dei
	    controlli/impianti caricati ed il file dei controlli/impianti
	    scartati.<br>
	    Per scaricare il file, fare click col tasto destro del mouse
	    sul link corrispondente e selezionare "salva oggetto con nome".
	    <p>
	    E' possibile modificare il file dei controlli/impianti
	    scartati per sistemare gli errori e provare a caricarli
	    nuovamente.<br>
	    Per fare questo, aprire Excel, selezionare file, apri,
	    selezionare "File di Testo" nella casella "Tipo file" ed
	    aprire il file precedentemente salvato.<br>
	    Ora scegliere l'opzione Tipo di file "Delimitati" e fare click
	    su "Avanti".<br>
	    Selezionare "Punto e virgola" come "Delimitatore" e fare click
	    su "Avanti".<br>
	    Selezionare tutte le colonne e scegliere "Testo" come
	    "formato dati per colonna".<br>
	    Se non si facesse cos&igrave; excel troncherebbe gli zeri del
	    prefisso e del numero telefonico e trasformerebbe alcuni civici
	    in date (es: 8/10 diventerebbe 8-ott).
	    <p>
	    Una volta aperto il file, nel caso in cui apportino delle
	    modifiche, ricordarsi di salvarlo come "CSV".
	    </td>
	    </tr>
	    </table>
	    </center>
	}]
	
	puts $file_esi_id $pagina_esi
	
	close $file_inp_id
	close $file_esi_id
	close $file_out_id
	close $file_err_id
	
	# inserisco i link ai file di esito sulla tabella degli esiti	    # ed aggiorno lo stato del batch a 'Terminato'
	set     esit_list ""
	lappend esit_list [list "Esito caricamento"  $file_esi_url $file_esi]
	iter_batch_upd_flg_sta -fine $cod_batc $esit_list
    }    
    # fine db_transaction ed ora fine with_catch
    
    return
    
}

