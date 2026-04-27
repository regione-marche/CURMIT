ad_page_contract {
    Add/Edit/Delete  form per la tabella "iterprotdocu"
    @author          Paolo Formizzi Adhoc
    @creation-date   23/10/2003

    @cvs-id          iterprotdocu-gest.tcl
} {  
    {prot_id    ""}
    {id_documento      ""}
    {last_id_documento ""}
    {function         "V"}
    {caller       "index"}
    {extra_par         ""}
    {save_tipo_doc     ""}
    {last_cognome      ""}
    {extra_par_occu    ""}
    documento:trim,optional
    documento.tmpfile:tmpfile,optional
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}
set id_utente [auth::require_login]

# Controlla lo user
#set livello [tosa_set_livello $function]
#set utn_cde [tosa_check_login $livello]

# Personalizzo la pagina
set main_directory   [ad_conn package_url]
set link_list_script {[export_url_vars prot_id last_id_documento save_tipo_doc caller last_cognome extra_par_occu]}
set link_list        [subst $link_list_script]
set titolo           "Allegato"
switch $function {
    E {set button_label "Modifica" 
	set page_title   "Modifica $titolo"}
    I {set button_label "Inserisci"
	set page_title   "Inserimento $titolo"}
    V {set button_label "Torna alla lista"
	set page_title   "Visualizzazione $titolo"}
}

set context_bar  [iter_context_bar \
		      [list ${main_directory} "Home"] \
		      [list iterprotdocu-list?$link_list "Lista Allegati"] \
		      "$page_title"]

# leggo l'eventuale settore dell'utente
#set id_settore [tosa_user_settore -utn_cde $utn_cde]
set id_settore ""
if {$id_settore eq ""} {
    set update_p "t"
} else {
    if {![db_0or1row query "select 1 from tosatioc t, tosaoccu o, contatori_sett_tioc c where t.id_tipo_occupazione = o.id_tipo_occupazione and o.prot_id = :prot_id and c.id_tipo_occupazione = t.id_tipo_occupazione and c.id_settore in ([join $id_settore ,]) limit 1"]} {
	set update_p "f"
    } else {
	set update_p "t"
    }
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "iterprotdocu"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_key "disabled"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $function {
    "I" {set readonly_fld \{\}
        set disabled_key \{\}
        set disabled_fld \{\}
        set onsubmit_cmd "enctype {multipart/form-data}"
    }
    "E" {set readonly_fld \{\}
	set disabled_fld \{\}
	set onsubmit_cmd "enctype {multipart/form-data}"
    }
}

form create $form_name \
    -html    $onsubmit_cmd

if {$function eq "I"} {
    element create $form_name tipo_doc \
	-label   "Tipo" \
	-widget   select \
	-datatype text \
	-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
	-optional \
	-options {{{} {}} {"Generico dall'ufficio all'utente" 5} {"Generico dall'utente all'ufficio" 12}}
} else {
    element create $form_name tipo_doc \
	-label   "Tipo" \
	-widget   select \
	-datatype text \
	-html    "size 1 maxlength 1 $disabled_key {} class form_element" \
	-optional \
	-options {{{} {}} {"Determina" 1} {"Rifiuto" 2} {"Richiesta Adempimenti" 3} {"Revoca" 4} {"Generico dall'ufficio all'utente" 5} {"Richiesta Variazione Concessione" 6} {"Determina Variazione" 7} {"Richiesta per occupazione" 8} {"Rifiuto Variazione Concessione" 9} {"Invito al ritiro" 10} {"Relazioni e Pareri" 11} {"Generico dall'utente all'ufficio" 12} {"Disciplinare" 13} {"Sollecito di pagamento" 14} {"Autorizzazio Cantiere" 18} {"Nulla Osta" 19} {"Rinnovo" 20}} 
}

element create $form_name oggetto \
    -label   "Oggetto" \
    -widget   textarea \
    -datatype text \
    -html    "cols 50 rows 4 $readonly_fld {} class form_element" \
    -optional

element create $form_name invio_dt \
    -label   "Data invio" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name notifica_dt \
    -label   "Data notifica" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name id_num_protocollo \
    -label   "Protocollo" \
    -widget   text \
    -datatype text \
    -html    "size 25 maxlength 25 $readonly_fld {} class form_element" \
    -optional

element create $form_name protocollo_dt \
    -label   "Data protocollo" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name id_protocollo_scriv \
    -label   "Num. prot. scriv." \
    -widget   text \
    -datatype text \
    -html    "size 25 maxlength 25 $readonly_fld {} class form_element" \
    -optional

element create $form_name protocollo_scriv_dt \
    -label   "Data prot. scriv." \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name referente \
    -label   "Referente" \
    -widget   text \
    -datatype text \
    -html    "size 40 maxlength 50 $readonly_fld {} class form_element" \
    -optional

element create $form_name documento \
    -label   "Documento" \
    -widget   file \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional

element create $form_name id_documento      -widget hidden -datatype text -optional
element create $form_name prot_id    -widget hidden -datatype text -optional
element create $form_name function          -widget hidden -datatype text -optional
element create $form_name caller            -widget hidden -datatype text -optional
element create $form_name extra_par         -widget hidden -datatype text -optional
element create $form_name submit            -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_id_documento -widget hidden -datatype text -optional
element create $form_name save_tipo_doc     -widget hidden -datatype text -optional
element create $form_name last_cognome      -widget hidden -datatype text -optional
element create $form_name extra_par_occu    -widget hidden -datatype text -optional
element create $form_name update_p          -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name id_documento      -value $id_documento
    element set_properties $form_name prot_id    -value $prot_id
    element set_properties $form_name function          -value $function
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name extra_par         -value $extra_par
    element set_properties $form_name last_id_documento -value $last_id_documento
    element set_properties $form_name last_cognome      -value $last_cognome
    element set_properties $form_name extra_par_occu    -value $extra_par_occu
    element set_properties $form_name update_p          -value $update_p

    if {$function eq "I"} {
        set link_docu "" 
    } else {
	# leggo riga
        if {[db_0or1row get_current_values "
             select id_documento
                  , prot_id
                  , tipo_doc
                  , oggetto
                  , id_num_protocollo
                  , to_char(protocollo_dt, 'DD/MM/YYYY') as protocollo_dt
                  , referente
                  , documento
               from iterprotdocu
              where id_documento = :id_documento"] == 0} {
            tosa_return_complaint "Record non trovato"
	}

	#element set_properties $form_name id_documento        -value $id_documento
        element set_properties $form_name tipo_doc            -value $tipo_doc
        element set_properties $form_name oggetto             -value $oggetto
        element set_properties $form_name id_num_protocollo       -value $id_num_protocollo
        element set_properties $form_name protocollo_dt       -value $protocollo_dt
        element set_properties $form_name referente           -value $referente
        element set_properties $form_name documento           -value $documento

	set save_tipo_doc $tipo_doc
	element set_properties $form_name save_tipo_doc       -value $save_tipo_doc

	#if {![string equal $documento ""]} {
	set link_docu "<a href=\"allegati-view?[export_url_vars id_documento function]\" target=stampa>Visualizza allegato</a>"
	#} else {
	#    set link_docu ""
	#}
    }

    element set_properties $form_name prot_id    -value $prot_id
    
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system

    #set id_documento        [element::get_value $form_name id_documento]
    set prot_id      [element::get_value $form_name prot_id]
    set tipo_doc            [element::get_value $form_name tipo_doc]
    set oggetto             [element::get_value $form_name oggetto]
    set invio_dt            [element::get_value $form_name invio_dt]
    set notifica_dt         [element::get_value $form_name notifica_dt]
    set id_num_protocollo       [element::get_value $form_name id_num_protocollo]
    set protocollo_dt       [element::get_value $form_name protocollo_dt]
    set id_protocollo_scriv [element::get_value $form_name id_protocollo_scriv]
    set protocollo_scriv_dt [element::get_value $form_name protocollo_scriv_dt]
    set referente           [element::get_value $form_name referente]
    set documento           [element::get_value $form_name documento]
    set update_p            [element::get_value $form_name update_p]
    
    if {![string equal $save_tipo_doc ""]} {
	set tipo_doc $save_tipo_doc
    }
    
    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$function eq "I" || $function eq "E"} {
        if {[string equal $tipo_doc ""]} {
            element::set_error $form_name tipo_doc "Inserire Tipo"
            incr error_num
        }

        if {![string equal $invio_dt ""]} {
            set invio_dt [iter_check_date $invio_dt]
            if {$invio_dt == 0} {
                element::set_error $form_name invio_dt "Deve essere una data"
                incr error_num
            }
        }

        if {![string equal $notifica_dt ""]} {
            set notifica_dt [iter_check_date $notifica_dt]
            if {$notifica_dt == 0} {
                element::set_error $form_name notifica_dt "Deve essere una data"
                incr error_num
            }
        }

        if {![string equal $protocollo_dt ""]} {
            set protocollo_dt [iter_check_date $protocollo_dt]
            if {$protocollo_dt == 0} {
                element::set_error $form_name protocollo_dt "Deve essere una data"
                incr error_num
            }
        }

        if {![string equal $protocollo_scriv_dt ""]} {
            set protocollo_scriv_dt [iter_check_date $protocollo_scriv_dt]
            if {$protocollo_scriv_dt == 0} {
                element::set_error $form_name protocollo_scriv_dt "Deve essere una data"
                incr error_num
            }
        }
    }

    if {$function eq "I" || $function eq "E"} {
        if {$id_num_protocollo ne ""} {
	    if {$protocollo_dt ne ""} {
		set anno1 [string range $protocollo_dt 0 3]
		if {[db_0or1row sel_occu "
                select protocollo_dt as prot_dt
                  from iterprotdocu
                 where id_num_protocollo = :id_num_protocollo
                 limit 1"]} {
		    set prot_anno [string range $prot_dt 0 3]
		    if {$prot_anno == $anno1} {
			element::set_error $form_name id_num_protocollo "Protocollo gia' esistente nell'anno $prot_anno"
			incr error_num
		    }
		}
	    } else {
		if {[db_0or1row get_current_values "
                select id_num_protocollo
                  from iterprotdocu
                 where id_num_protocollo = :id_num_protocollo"]} {
		    element::set_error $form_name id_num_protocollo "Protocollo gia' esistente. Specificare la data"
		    incr error_num
		}
	    }
	}
    }

    if {$function eq "I" &&  $error_num == 0
	&&  [db_0or1row check_exists "select 1 from iterprotdocu where id_documento = :id_documento"]} {
	# controllo univocita'/protezione da double_click
        element::set_error $form_name id_documento "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    set link_docu ""
    if {$error_num > 0} {
	set link_docu ""
        ad_return_template
        return
    }

    db_transaction {
	switch $function {
	    I { db_1row query "select nextval('iterprotdocu_s') as id_documento"
		if {![info exists documento]} {
		    if {[string is space $documento] || ![info exists documento.tmpfile] || [file size ${documento.tmpfile}] == 0} {
			set sql_documento  "null"
			set estensione     ""
		    } else {
			set documento_tmpfile ${documento.tmpfile}
			set sql_documento     "lo_import(:documento_tmpfile)"
			set estensione        [ns_guesstype $documento]
		    }
		} else {
		    set documento_tmpfile ${documento.tmpfile}
		    set sql_documento     "lo_import(:documento_tmpfile)"
		    set estensione        [ns_guesstype $documento]
		}
		db_dml query "
                insert into iterprotdocu 
                     ( id_documento
                     , prot_id
                     , tipo_doc
                     , oggetto
                     , id_num_protocollo
                     , protocollo_dt
                     , referente
                     , documento
                     , data_ora_generazione
                     , estensione
                     , utente_inserimento
                     , data_inserimento  )
                values 
                     (:id_documento
                     ,:prot_id
                     ,:tipo_doc
                     ,:oggetto
                     ,:id_num_protocollo
                     ,:protocollo_dt
                     ,:referente
                     ,$sql_documento
                     ,current_timestamp
                     ,:estensione
                     ,:id_utente
                     ,current_date)"
	    }
	    E {	    
		if {[string is space $documento]} {
		    db_dml query "
                update iterprotdocu
                   set oggetto             = :oggetto
                     , id_num_protocollo       = :id_num_protocollo
                     , protocollo_dt       = :protocollo_dt
                     , referente           = :referente
                     , data_ultimamodifica = current_date
                 where id_documento        = :id_documento"
		} else {
		    set documento_tmpfile ${documento.tmpfile}
		    set sql_documento     "lo_import(:documento_tmpfile)"
		    set estensione        [ns_guesstype $documento]

		    db_dml query "
                update iterprotdocu
                   set oggetto             = :oggetto
                     , id_num_protocollo       = :id_num_protocollo
                     , protocollo_dt       = :protocollo_dt
                     , referente           = :referente
                     , documento           = $sql_documento
                     , estensione          = :estensione
                     , data_ultimamodifica = current_date
                 where id_documento        = :id_documento"

		}
	    }
	}
    }

    # dopo l'inserimento posiziono la lista sul record inserito
    if {$function eq "I"} {
	set last_id_documento $id_documento
    }
    set link_list [subst $link_list_script]
    set link_gest [export_url_vars prot_id id_documento last_id_documento extra_par caller last_cognome extra_par_occu]
    
    switch $function {
	E {set return_url "iterprotdocu-gest?function=V&$link_gest"}
	I {set return_url "iterprotdocu-gest?function=V&$link_gest"}
	V {set return_url "iterprotdocu-list?prot_id=$prot_id"}
    }
    
    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
