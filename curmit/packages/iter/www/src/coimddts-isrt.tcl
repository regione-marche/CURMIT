ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimbatc"
    @author          Giulio Laurenzi
    @creation-date   03/09/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @cvs-id          coimacts-gest.tcl
} {
    {cod_batc         ""}
    {funzione        "I"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    file_name:trim,optional
    file_name.tmpfile:tmpfile,optional
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

#ns_return 200 text/html ${file_name.tmpfile}; return
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
}

#set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set link_gest [export_url_vars cod_batc nome_funz nome_funz_caller caller]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# preparo i link di testata della pagina per consultazione coda lavori
set nom       "Protocol. dic. distributori"
set link_head [iter_links_batc $nome_funz $nome_funz_caller $nom]

# Personalizzo la pagina
set titolo              "Protocollazione dichiarazioni distributori"
switch $funzione {
    I {set button_label "Conferma lancio"
       set page_title   "Lancio $titolo "}
    V {set button_label "Torna al menu"
       set page_title   "$titolo lanciato"}
}

set context_bar  ""

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name     "coimbatc"
set readonly_key  "readonly"
set readonly_fld  "readonly"
set disabled_fld  "disabled"
set onsubmit_cmd  "enctype {multipart/form-data}"
switch $funzione {
   "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
       }
   "M" {set readonly_fld \{\}
        set disabled_fld \{\}
       }
}

form create $form_name \
-html    $onsubmit_cmd

element create $form_name dat_prev \
-label   "Data partenza" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name ora_prev \
-label   "Ora partenza" \
-widget   text \
-datatype text \
-html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
-optional

element create $form_name intestatario \
-label   "Intestatario" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 80 class form_element" \
-optional

element create $form_name titolo \
-label   "Titolo" \
-widget   text \
-datatype text \
-html    "size 40 maxlength 40 class form_element" \
-optional

element create $form_name cod_distr \
-label   "Distributore" \
-widget   select \
-datatype text \
-html    "class form_element" \
-optional \
-options [iter_selbox_from_table coimdist cod_distr ragione_01]

element create $form_name data_rif \
-label   "Data riferimento archivio" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 class form_element" \
-optional

element create $form_name data_docu \
-label   "Data documento" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 class form_element" \
-optional

element create $form_name protocollo_01 \
-label   "Num. protocollo" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 20 class form_element" \
-optional

element create $form_name data_protocollo \
-label   "Data protocollo" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 class form_element" \
-optional

element create $form_name data_caric \
-label   "Data caricamento" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 class form_element" \
-optional

element create $form_name file_name \
-label   "File da importare" \
-widget   file \
-datatype text \
-html    "size 40 maxlength 50 class form_element" \
-optional

element create $form_name anno_competenza \
-label   "Anno competenza" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 class form_element" \
-optional

element create $form_name note \
-label   "note" \
-widget   textarea \
-datatype text \
-html    "cols 80 rows 2 $readonly_fld {} class form_element" \
-optional

element create $form_name funzione     -widget hidden -datatype text -optional
element create $form_name caller       -widget hidden -datatype text -optional
element create $form_name nome_funz    -widget hidden -datatype text -optional
element create $form_name submit       -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name current_date -widget hidden -datatype text -optional
element create $form_name current_time -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name funzione       -value $funzione
    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz

    if {$funzione == "I"} {
	set current_date [iter_set_sysdate]
	set current_time [iter_set_systime]
	set dat_prev [iter_edit_date $current_date]
	set ora_prev $current_time

        element set_properties $form_name dat_prev     -value $dat_prev
        element set_properties $form_name ora_prev     -value $ora_prev
	element set_properties $form_name current_date -value $current_date
	element set_properties $form_name current_time -value $current_time
    } else {
      # leggo riga
        if {[db_0or1row sel_batc {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        element set_properties $form_name dat_prev           -value $dat_prev
        element set_properties $form_name ora_prev           -value $ora_prev

	foreach {key value} $par {
	    set $key $value
	}

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set current_date       [element::get_value $form_name current_date]
    set current_time       [element::get_value $form_name current_time]
    set dat_prev           [element::get_value $form_name dat_prev]
    set ora_prev           [element::get_value $form_name ora_prev]
    set intestatario       [element::get_value $form_name intestatario]
    set titolo             [element::get_value $form_name titolo]
    set data_rif           [element::get_value $form_name data_rif]
    set data_docu          [element::get_value $form_name data_docu]
    set protocollo_01      [element::get_value $form_name protocollo_01]
    set data_protocollo    [element::get_value $form_name data_protocollo]
    set data_caric         [element::get_value $form_name data_caric]
    set file_name          [element::get_value $form_name file_name] 
    set cod_distr          [element::get_value $form_name cod_distr]
    set anno_competenza    [element::get_value $form_name anno_competenza]
    set note               [element::get_value $form_name note]

    set data_corrente [iter_set_sysdate]
  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"} {

	set data_prev_ok "f"
	if {[string equal $dat_prev ""]} {
	    element::set_error $form_name dat_prev "Inserire data partenza"
	    incr error_num
	} else {
	    set dat_prev [iter_check_date $dat_prev]
	    if {$dat_prev == 0} {
		element::set_error $form_name dat_prev "Data partenza non corretta"
		incr error_num
	    } else {
		if {$dat_prev < $current_date} {
		    element::set_error $form_name dat_prev "Data partenza deve essere presente o futura"
		    incr error_num
		} else {
		    set data_prev_ok "t"
		}
	    }
	}

	if {[string equal $ora_prev ""]} {
	    element::set_error $form_name ora_prev "Inserire ora partenza"
	    incr error_num
	} else {
	    set ora_prev [iter_check_time $ora_prev]
	    if {$ora_prev == 0} {
		element::set_error $form_name ora_prev "Ora partenza non corretta"
		incr error_num
	    } else {
		if {$data_prev_ok == "t"
		&&  $dat_prev == $current_date
		&&  $ora_prev  < $current_time
		} {
		    element::set_error $form_name ora_prev "Ora partenza deve essere presente o futura"
		    incr error_num
		} else {
		    set ora_prev "$ora_prev:00"
		}
	    }
	}

	# controlli standard su numeri e date, per Ins ed Upd
	set error_num 0
	if {[string equal $intestatario ""]} {
	    element::set_error $form_name intestatario "Inserire Intestatario"
	    incr error_num
	}
	
	if {[string equal $titolo ""]} {
	    element::set_error $form_name titolo "Inserire Titolo"
	    incr error_num
	}
	
	if {[string equal $cod_distr ""]} {
	    element::set_error $form_name cod_distr "Inserire Distributore"
	    incr error_num
	} else {
	    # reperisco nome_dist
	    if {[db_0or1row sel_dist ""] == 0} {
		element::set_error $form_name cod_distr "Fornitore di energia non trovato"
		incr error_num
	    }
	}
	
	if {[string equal $data_rif ""]} {
	    element::set_error $form_name data_rif "Inserire Data Riferimento"
	    incr error_num
	} else {
	    set data_rif [iter_check_date $data_rif]
	    if {$data_rif == 0} {
		element::set_error $form_name data_rif "Data non corretta"
		incr error_num
	    }
	}
	
	if {[string equal $data_docu ""]} {
	    element::set_error $form_name data_docu "Inserire Data Documento"
	    incr error_num
	} else {
	    set data_docu [iter_check_date $data_docu]
	    if {$data_docu == 0} {
		element::set_error $form_name data_docu "Data non corretta"
		incr error_num
	    }
	}
	
	if {[string equal $protocollo_01 ""]} {
	    element::set_error $form_name protocollo_01 "Inserire Protocollo"
	    incr error_num
	}
	
	if {[string equal $data_protocollo ""]} {
	    element::set_error $form_name data_protocollo "Inserire Data Protocollo"
	    incr error_num
	} else {
	    set data_protocollo [iter_check_date $data_protocollo]
	    if {$data_protocollo == 0} {
		element::set_error $form_name data_protocollo "Data non corretta"
		incr error_num
	    }
	}
	
	if {[string equal $file_name ""]} {
	    element::set_error $form_name file_name "Inserire Nome File"
	    incr error_num
	}
	
	if {[string equal $data_caric ""]} {
	    element::set_error $form_name data_caric "Inserire Data Caricamento"
	    incr error_num
	} else {
	    set data_caric [iter_check_date $data_caric]
	    if {$data_caric == 0} {
		element::set_error $form_name data_caric "Data non corretta"
		incr error_num
	    } else {
		if {![string equal $cod_distr ""]} {
		    if {[db_0or1row sel_acts_2 ""] == 1} {
			element::set_error $form_name cod_distr "Esiste gi&agrave una consegna in questa data per questo fornitore d'energia"
			incr error_num
		    } else {
			if {[db_0or1row sel_acts_3 ""] == 0} {
			    set data_caric_ult "19000101"
			    set data_caric_edit "01/01/1900"
			}
			
			if {$data_caric_ult >= $data_caric} {
			    element::set_error $form_name data_caric "Deve essere maggiore dell'ultimo caricamento: $data_caric_edit"
			    incr error_num
			}
		    }
		}
	    }
	}
	if {[string equal $anno_competenza ""]} {
	    element::set_error $form_name anno_competenza  "Inserire anno competenza"
	    incr error_num
	} else {
	    if {[string length $anno_competenza] != 4} {
     		element::set_error $form_name anno_competenza  "Anno deve essere lungo 4 caratteri"
		incr error_num
	    } else {
		if {![string is integer $anno_competenza]} {
		    element::set_error $form_name anno_competenza  "Anno deve essere numerico"
		    incr error_num
		}
	    }
	}
    }
    if {$error_num > 0} {
        ad_return_template
        return
    }

    if {$funzione == "I"} {
	set data_docu_edit       [iter_edit_date $data_docu]
	set data_protocollo_edit [iter_edit_date $data_protocollo]
	set stampa ""
	append stampa "<table>
                         <tr>
                            <td>Il sottoscritto Sig. $intestatario</td>
                         </tr>
                         <tr>
                            <td>in qualit&agrave; di $titolo della Societ&agrave;/Ditta  $nome_dist</td>
                         </tr>
                         <tr>
                            <td align=left>Data $data_docu_edit</td>
                         </tr>
                         <tr>
                            <td>Protocollo $protocollo_01, Data $data_protocollo_edit</td>
                         </tr>
                   </table>"

	# caricamento documento
	# imposto la directory degli spool ed il loro nome.
	set spool_dir     [iter_set_spool_dir]
	set spool_dir_url [iter_set_spool_dir_url]
	set logo_dir      [iter_set_logo_dir]
	
	# imposto il nome dei file
	set nome_file        "acts"
	set nome_file        [iter_temp_file_name $nome_file]
	set file_html        "$spool_dir/$nome_file.html"
	set file_pdf         "$spool_dir/$nome_file.pdf"
	set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

	set file_id   [open $file_html w]
	fconfigure $file_id -encoding iso8859-1
	puts $file_id $stampa
	close $file_id

	# lo trasformo in PDF
	iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --bottom 0cm -f $file_pdf $file_html]
	
	# Controllo se il Database e' Oracle o Postgres
	set id_db     [iter_get_parameter database]

	set sql_contenuto  "lo_import(:file_html)"
	set tipo_contenuto [ns_guesstype $file_pdf]
	set contenuto_tmpfile  $file_pdf

	db_1row sel_docu      ""
	set tipo_documento    "CD"
	set tipo_soggetto     "D"
	set cod_soggetto      $cod_distr
	set cod_impianto      ""
	set data_stampa       ""
	set data_documento    $data_rif
	set protocollo_02     ""
	set data_prot_01      $data_protocollo
	set data_prot_02      ""
	set descrizione       ""
	set flag_notifica     ""
	set data_ins          $data_corrente
	set utente            $id_utente
	set dml_ins_docu [db_map ins_docu]
	

	#caricamento testata impianti potenziali
	set tmpfile_d ${file_name.tmpfile}

	set leggifile [open $tmpfile_d r]
	fconfigure $leggifile -encoding iso8859-1 -translation auto

	set nome_file "acts-$cod_distr-$data_caric.dat"
	set permanenti_dir [iter_set_permanenti_dir]
	set nome_file_n "$permanenti_dir/acts-$cod_distr-$data_caric.dat"
	exec cp $tmpfile_d $nome_file_n

	db_1row get_cod_acts   ""
	set caricati       0
	set scartati       0
	
	set percorso_file  $nome_file
	set data_ins       $data_corrente
	set utente         $id_utente
	set dml_ins_acts [db_map ins_acts]
       
        ####

	# set cod_batc
	db_1row sel_batc_next ""
	set flg_stat     "A"
	set cod_uten_sch $id_utente
	set nom_prog     "iter_car_aces"
	set par          ""
	lappend par       cod_acts
	lappend par      $cod_acts
	lappend par       nome_file_n
	lappend par      $nome_file_n
        lappend par       id_utente
        lappend par      $id_utente
	set note          ""

	set dml_sql      [db_map ins_batc]
    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimbatc $dml_sql
		if {[info exists dml_ins_docu]} {
		    db_dml dml_coimdocu $dml_ins_docu 
		}
		if {[info exists dml_ins_acts]} {
		    db_dml dml_coimacts $dml_ins_acts
		}
		if {$id_db == "postgres"} {
		    db_dml dml_coimdocu [db_map upd_docu_2] 
		} else {
		    db_dml dml_sql2 [db_map upd_docu_2] -blob_files [list $contenuto_tmpfile]
		}
		

            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

    set link_gest [export_url_vars cod_batc nome_funz nome_funz_caller caller]

    switch $funzione {
        I {set return_url   "coimacts-isrt?funzione=V&$link_gest"}
        V {set return_url   ../main}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
