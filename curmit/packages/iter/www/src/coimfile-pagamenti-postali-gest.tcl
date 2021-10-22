ad_page_contract {
    Caricamento      file ricevuto dalle poste contenente i pagamenti
    @author          Nicola Mortoni (copiando da tosapost-rica)
    @creation-date   16/10/2014

    @cvs-id          coimfile-pagamenti-postali-gest
} {
    {cod_file         ""}
    {last_cod_file    ""}
    {funzione        "I"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {extra_par        ""}

    file_name:trim,optional
    file_name.tmpfile:tmpfile,optional
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
switch $funzione {
    "I" {set lvl 2}
    #"V" {set lvl 1}
    #"M" {set lvl 3}
    #"D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_file caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set titolo           "File ricevuto dalle poste contenente i pagamenti"
switch $funzione {
    I {
       set button_label "Conferma"
       set page_title   "Carica $titolo"
    }
#   M {
#      set button_label "Conferma Modifica"
#      set page_title   "Modifica $titolo"
#   }
#   D {
#      set button_label "Conferma Cancellazione"
#      set page_title   "Cancellazione $titolo"
#   }
    V {
        set button_label "Torna alla lista"
        set page_title   "Visualizzazione $titolo"
    }
}

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimfile_pagamenti_postali"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd "enctype {multipart/form-data}"
if {$funzione eq "I"} {
    set readonly_key \{\}
    set readonly_fld \{\}
    set disabled_fld \{\}
#} elseif {$funzione eq "M"} {
#    set readonly_fld \{\}
#    set disabled_fld \{\}
}

form create $form_name \
    -html    $onsubmit_cmd

element create $form_name file_name \
    -label   "File da caricare" \
    -widget   file \
    -datatype text \
    -html    "$disabled_fld {} size 100 maxlength 200 class form_element" \
    -optional

element create $form_name cod_file         -widget hidden -datatype text -optional
element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par        -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_file    -widget hidden -datatype text -optional


set flag_elaborazione_terminata "N"

if {[form is_request $form_name]} {
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_cod_file    -value $last_cod_file
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    set file_name       [element::get_value $form_name file_name]

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    if {[string is space $file_name]} {
        element::set_error $form_name file_name "Selezionare un file da caricare"
        incr error_num
    } else {
        set extension [string tolower [file extension $file_name]]
        if {$extension ne ".txt"} {
            element::set_error $form_name file_name "Il file non ha estensione txt"
            incr error_num
        } else {
            set tmpfile ${file_name.tmpfile}
            if {![file exists $tmpfile]} {
                element::set_error $form_name file_name "File non trovato"
                incr error_num
            } else {
		if {[file size ${file_name.tmpfile}] == 0} {
		    element::set_error $form_name file_name "File non esistente oppure vuoto"
		    incr error_num
		}
	    }
        }
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    set file_inp       ${file_name.tmpfile}

    set spool_dir      [iter_set_spool_dir]
    set spool_dir_url  [iter_set_spool_dir_url]
    set file_out_name  "File-pagamenti-postali-caricati"
    set file_err_name  "File-pagamenti-postali-scartati"
    set file_out_name  [iter_temp_file_name $file_out_name]
    set file_err_name  [iter_temp_file_name $file_err_name]
    set file_out       "${spool_dir}/$file_out_name.txt"
    set file_err       "${spool_dir}/$file_err_name.txt"
    set file_out_url   "${spool_dir_url}/$file_out_name.txt"
    set file_err_url   "${spool_dir_url}/$file_err_name.txt"

    # apro il file in lettura e metto in file_inp_id l'identificativo del file
    # per poterlo leggere successivamente
    if {[catch {set file_inp_id [open $file_inp r]}]} {
        iter_return_complaint "File txt di input non aperto: $file_inp"
    }

    # dichiaro di leggere in formato iso West European e di utilizzare crlf come fine riga
    fconfigure $file_inp_id -encoding iso8859-1 -translation crlf

    # apro il file in scrittura e metto in file_out_id l'identificativo
    # del file per poterlo scrivere successivamente
    if {[catch {set file_out_id [open $file_out w]}]} {
        iter_return_complaint "File txt dei record caricati non aperto: $file_out"
    }
    # dichiaro di scrivere in formato iso West European
    fconfigure $file_out_id -encoding iso8859-1

    # apro il file in scrittura e metto in file_err_id l'identificativo
    # del file per poterlo scrivere successivamente
    if {[catch {set file_err_id [open $file_err w]}]} {
        iter_return_complaint "File txt dei record scartati non aperto: $file_err"
    }
    # dichiaro di scrivere in formato iso West European
    fconfigure $file_err_id -encoding iso8859-1

    # non definisco il tracciato record del file di input perchè è un txt senza ;
    # stesso discorso vale per i file dei record caricati e scartati

    set ctr_inp 0
    set ctr_out 0
    set ctr_err 0

    set totale_letti    0.0
    set totale_pagato   0.0
    set totale_scartato 0.0

    with_catch error_msg {
	db_transaction {
	    # Ciclo di lettura sul file di input 
	
	    # non uso la proc iter_get_csv perche' e' un file txt senza i ;
	    gets $file_inp_id file_inp_rec

	    while {![eof $file_inp_id]} {
		set salta_riga "N"
		if {[string is space $file_inp_rec]} {
		    set salta_riga "S"
		}

		if {$salta_riga eq "N"} {
		    set progressivo_caricamento          [string range $file_inp_rec  0  7]
		    set progressivo_selezione            [string range $file_inp_rec  8 14]
		    set numero_cc_beneficiario           [string range $file_inp_rec 15 26]
		    set data_accettazione                [string range $file_inp_rec 27 32]
		    set tipo_documento                   [string range $file_inp_rec 33 35]
		    set importo                          [string range $file_inp_rec 36 45]
		    set ufficio_e_sportello              [string range $file_inp_rec 46 53]
		    set divisa                           [string range $file_inp_rec 54 54]
		    set data_contabile_accredito         [string range $file_inp_rec 55 60]
		    set quinto_campo                     [string range $file_inp_rec 61 76]
		    set cin                              [string range $file_inp_rec 77 78]
		    set tipologia_accettazione_sportello [string range $file_inp_rec 79 80]
		    set bollettino_sostitutivo           [string range $file_inp_rec 81 81]
		    
		    if {$tipo_documento eq "999"} {
			#E' un record di riepilogo che quindi devo ignorare
			set salta_riga "S"
		    }
		}
		
		if {$salta_riga eq "N"} {
		    set carica     "S"
		    set importo_db 0.0;#serve per i totali
		    
		    # Controllo come prima cosa l'importo in modo che possa essere sommato
		    # anche in caso di scarto
		    if {$carica eq "S"} {
			db_1row query "select ltrim(:importo,'0') as importo_per_test"
			if {[string is space $importo_per_test]} {
			    set carica             "N"
			    set motivo_scarto_file "Importo mancante ($importo) per il bollettino con quinto campo = $quinto_campo"
			    set motivo_scarto_stat "Importo mancante"
			} else {
			    set importo_per_test [iter_check_num $importo_per_test]
			    if {$importo_per_test eq "Error"} {
				set carica             "N"
				set motivo_scarto_file "Importo $importo non corretto per il bollettino con quinto campo = $quinto_campo"
				set motivo_scarto_stat "Importo non corretto"
			    } else {
				set importo_db         [expr $importo_per_test / 100.0]
			    }
			}
		    }
		    
		    # Motivo scarto: bollettino non trovato
		    if {$carica eq "S"} {
			if {![db_0or1row query "
                             select cod_bpos
                                  , stato
                                  , importo_pagato as coimbpos_importo_pagato
                               from coimbpos
                              where quinto_campo = :quinto_campo"]
			} {
			    set carica             "N"
			    set motivo_scarto_file "Bollettino non trovato con quinto campo = $quinto_campo"
			    set motivo_scarto_stat "Bollettino non trovato"
			}
		    }
		    
		    if {$carica eq "S" && $stato eq "N"} {
			set carica             "N"
			set motivo_scarto_file "Bollettino con quinto campo = $quinto_campo annullato"
			set motivo_scarto_stat "Bollettino non trovato"
		    }
		    
		    if {$carica eq "S" && $coimbpos_importo_pagato > 0.0} {
			set carica             "N"
			set motivo_scarto_file "Bollettino con quinto campo = $quinto_campo già pagato"
			set motivo_scarto_stat "Bollettino già pagato"
		    }

		    if {$carica eq "S"} {
			if {[string is space $data_accettazione]} {
			    set carica             "N"
			    set motivo_scarto_file "Data accettazione mancante ($data_accettazione) per il bollettino con quinto campo = $quinto_campo"
			    set motivo_scarto_stat "Data accettazione mancante"
			} else {
			    #aggiungo il secolo e controllo la data che ora è in formato YYYYMMDD
			    set data_accettazione_db "20$data_accettazione"
			    if {[string length $data_accettazione_db] ne 8
			    ||  [iter_check_date -formato "YYYYMMDD" $data_accettazione_db] == 0
			    } {
				set carica             "N"
				set motivo_scarto_file "Data accettazione $data_accettazione non corretta per il bollettino con quinto campo = $quinto_campo"
				set motivo_scarto_stat "Data accettazione non corretta"
			    }
			}
		    }
	    
		    if {$carica eq "S"} {
			if {[string is space $data_contabile_accredito]} {
			    set carica             "N"
			    set motivo_scarto_file "Data contabile accredito mancante ($data_contabile_accredito) per il bollettino con quinto campo = $quinto_campo"
			    set motivo_scarto_stat "Data contabile accredito mancante"
			} else {
			    #aggiungo il secolo e controllo la data che ora è in formato YYYYMMDD
			    set data_contabile_accredito_db "20$data_contabile_accredito"
			    if {[string length $data_contabile_accredito_db] ne 8
			    ||  [iter_check_date -formato "YYYYMMDD" $data_contabile_accredito_db] == 0
			    } {
				set carica        "N"
				set motivo_scarto_file "Data contabile accredito $data_contabile_accredito non corretta per il bollettino con quinto campo = $quinto_campo"
				set motivo_scarto_stat "Data contabile accredito non corretta"
			    }
			}
		    }
		    
		    incr ctr_inp
		    set totale_letti [expr $totale_letti + $importo_db]
		    
		    if {$carica eq "N"} {
			incr ctr_err
			set totale_scartato [expr $totale_scartato + $importo_db]
			
			# scrivo il record di errore col motivo scarto
			puts $file_err_id "[string trimright $file_inp_rec]|$motivo_scarto_file"

			if {![info exists ctr_scarto($motivo_scarto_stat)]} {
			    set ctr_scarto($motivo_scarto_stat) 0
			}
			incr ctr_scarto($motivo_scarto_stat)
		    }
		    
		    if {$carica eq "S"} {
			db_dml query "
                        update coimbpos
                           set importo_pagato = :importo_db
                             , data_pagamento = :data_accettazione_db
                             , data_scarico   = :data_contabile_accredito_db
                             , data_mod       = current_date
                             , utente_mod     = :id_utente
                         where quinto_campo   = :quinto_campo
                        "

			incr ctr_out
			set totale_pagato [expr $totale_pagato + $importo_db]
			
			# scrivo il file di output
			puts $file_out_id $file_inp_rec
		    }
		}
		
		# lettura del record successivo
		gets $file_inp_id file_inp_rec

		# non incremento in questo punto il numero dei record di input perchè alcuni
		# devono essere saltati (es: il record riepilogativo e quello vuoto)
	    }

	    close $file_inp_id
	    close $file_out_id
	    close $file_err_id
	    
	    # salvo i dati del caricamento
	    db_1row query "
            select coalesce(max(cod_file),0) + 1 as cod_file
              from coimfile_pagamenti_postali"

	    db_dml query "
            insert
              into coimfile_pagamenti_postali
                 ( cod_file
                 , data_caricamento
                 , nome_file
                 , record_caricati
                 , importo_caricati
                 , record_scartati
                 , importo_scartati
                 , file_caricamento
                 , file_caricati
                 , file_scartati
                 , data_ins
                 , utente_ins
                 )
            values
                 (:cod_file
                 ,current_date    -- data_caricamento
                 ,:file_name
                 ,:ctr_out
                 ,:totale_pagato
                 ,:ctr_err
                 ,:totale_scartato
                 ,lo_import(:file_inp)
                 ,lo_import(:file_out)
                 ,lo_import(:file_err)
                 ,current_date    -- data_ins
                 ,:id_utente      -- utente_ins
                 )"
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }

    set totale_letti_pretty    [iter_edit_num $totale_letti    2]
    set totale_pagato_pretty   [iter_edit_num $totale_pagato   2]
    set totale_scartato_pretty [iter_edit_num $totale_scartato 2]
    
    multirow create multiple_scarti motivo_scarto ctr_scarto
    foreach motivo_scarto [lsort [array names ctr_scarto]] {
	set ws_mot_scarto $motivo_scarto
	multirow append multiple_scarti $ws_mot_scarto $ctr_scarto($motivo_scarto)
    }
    
    set flag_elaborazione_terminata "S"
}

ad_return_template
