ad_page_contract {
    Add              form per la tabella "coimbatc"
                     Lancio batch di caricamento controlli da file esterno
    @author          Nicola Mortoni
    @creation-date   15/07/2004

    @param funzione  I=insert V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @cvs-id          coimbatc-gest.tcl
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

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set link_gest [export_url_vars cod_batc nome_funz nome_funz_caller caller]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# preparo i link di testata della pagina per consultazione coda lavori
set nom       "Caricamento controlli"
set link_head [iter_links_batc $nome_funz $nome_funz_caller $nom]

# reperisco le colonne della tabella parametri (serve una variabile nell'adp)
iter_get_coimtgen

# Personalizzo la pagina
set titolo              "allineamento ispettori"
switch $funzione {
    I {set button_label "Conferma lancio"
       set page_title   "Lancio $titolo "}
    V {set button_label "Torna al menu"
       set page_title   "$titolo lanciato"}
}

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name     "coimbatc"
set readonly_key  "readonly"
set readonly_fld  "readonly"
set disabled_fld  "disabled"
set onsubmit_cmd  ""
switch $funzione {
   "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
        set onsubmit_cmd "enctype {multipart/form-data}"
       }
   "M" {set readonly_fld \{\}
        set disabled_fld \{\}
       }
}

form create $form_name \
-html    $onsubmit_cmd

# nel selbox preparo solo le campagne aperte
set cod_opve_options [db_list_of_lists sel_opve ""]
element create $form_name cod_opve \
-label   "Nella campagna" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options $cod_opve_options

if {$funzione == "I"} {
    element create $form_name file_name \
    -label   "File da importare" \
    -widget   file \
    -datatype text \
    -html    "size 40 class form_element" \
    -optional
} else {
    element create $form_name file_name \
    -label   "File da importare" \
    -widget   text \
    -datatype text \
    -html    "size 40 readonly {} class form_element" \
    -optional
}

element create $form_name funzione     -widget hidden -datatype text -optional
element create $form_name caller       -widget hidden -datatype text -optional
element create $form_name nome_funz    -widget hidden -datatype text -optional
element create $form_name submit       -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {
    element set_properties $form_name funzione       -value $funzione
    element set_properties $form_name caller         -value $caller
    element set_properties $form_name nome_funz      -value $nome_funz

    if {$funzione == "I"} {

   } else {
      # leggo riga
        if {[db_0or1row sel_batc {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

	foreach {key value} $par {
	    set $key $value
	}

	# visualizzo solo il nome del file senza le directory
	set file_name         [file tail $file_name]

        element set_properties $form_name cod_opve      -value $cod_opve
        element set_properties $form_name file_name     -value $file_name
    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_opve           [element::get_value $form_name cod_opve]
    set file_name          [element::get_value $form_name file_name]

  # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"} {

	if {[string equal $cod_opve ""]} {
	    element::set_error $form_name cod_opve "Non ci sono campagne aperte"
	    incr error_num
	}

	if {[string equal $file_name ""]} {
	    element::set_error $form_name file_name "Inserire Nome File"
	    incr error_num
	} else {
	    set extension [file extension $file_name]
	    if {$extension != ".csv"} {
		if {$extension != ".txt"} {
		    element::set_error $form_name file_name "Il file non ha estensione csv o txt"
		    incr error_num
		}
	    } else {
		set tmpfile ${file_name.tmpfile}
		if {![file exists $tmpfile]} {
		    element::set_error $form_name file_name "File non trovato"
		    incr error_num
		}
	    }
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }
    set nome_estrazione "incontri"
    set count_fields 0
    db_foreach inco "" {
	#Creo la lista
	lappend incontri_file_cols $nome_colonna
	#Memorizzo in un array tutti i dati relativi ad un singoloo campo, necessari per la successiva analisi
	set incontri_fields($count_fields) [list $nome_colonna $tipo_dato $dimensione $obbligatorio $default_value $range_value]
	incr count_fields
    }

    db_1row cognome_opve ""
    # Setto le directory per la lettura dei file
    set spool_dir     [iter_set_spool_dir]
    set spool_dir_url [iter_set_spool_dir_url]


    #file di paragone
    set incontri_file [open $spool_dir/$cognome/$nome_estrazione.csv r]

    #Salto la prima riga di intestazione del file csv, andando a scrivere l'intestazione nei file in uscita 
    iter_get_csv $incontri_file incontri_file_cols_list |

    #Setto la variabile contenente il numero di elementi attesi nella lista
    set waited_length_file_list [llength $incontri_file_cols_list]

    ns_return 200 text/html "$waited_length_file_list - $count_fields"; return

    iter_get_csv $incontri_file incontri_file_cols_list |

    while {![eof $incontri_file]} {

    }











    #qua inserisco il controllo dei file

    set link_gest [export_url_vars nome_funz nome_funz_caller caller cod_opve file_name]

    switch $funzione {
        I {set return_url   "coimcari-inco?funzione=V&$link_gest"}
        V {set return_url   ""}
    }

    ns_return 200 text/html "Stop fine del file"; return

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
