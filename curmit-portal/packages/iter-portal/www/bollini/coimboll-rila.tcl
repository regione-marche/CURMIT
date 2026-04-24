ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimboll"
    @creation-date   04.06.2012

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimboll-rila.tcl

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    nic02  10/01/2014 Rafforzo il controllo sul doppio click visto che è capitato oggi.

    nic01  09/01/2014 Sistemato per segnalazione di Chiara Paravan di Ucit: nella context_bar
                      compariva Gestione Amministrativa che andava in errore.
                      Lo rendo coerente con la lista fatture e manutentori.
} {   
    {ordboll_id          ""}
    {is_admin_p          ""}
    {cod_bollini         ""}
    {last_order          ""}
    {funzione           "V"}
    {caller         "index"}
    {nome_funz           ""}
    {nome_funz_caller    ""}
    {extra_par           ""}
    {cod_manutentore     ""}
    {flag_attivo         ""}
    {f_manutentore       ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

if {$is_admin_p eq "t"} {
    set maintainer_id [auth::require_login]
} else {
    set maintainer_id [iter::script_init]
    if {[string equal $maintainer_id "0"]} {
	ad_returnredirect services
    }
    db_1row query "select name as manutentore, validated_p, approved_p from iter_maintainers where maintainer_id = :maintainer_id"
}
set id_utente $maintainer_id

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
                 -no_login \
                 -object_id [ad_conn package_id] \
                 -privilege admin
	    ]

if {$ordboll_id eq ""} {
    ad_return_complaint 1 "Selezionare almeno una riga."
} else {
    # deve essere ancora inevaso
    db_1row query "select flag_evaso from iter_ordboll where ordboll_id = :ordboll_id"
    if {$flag_evaso eq "t"} {
  	ad_return_complaint 1 "Ordine bollini già evaso."
    }
}

set current_date [iter_set_sysdate]
set link_gest [export_url_vars cod_bollini last_order nome_funz nome_funz_caller extra_par caller flag_attivo is_admin_p]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

iter_get_coimtgen
set flag_ente  $coimtgen(flag_ente)
set sigla_prov $coimtgen(sigla_prov)
set cod_comu   $coimtgen(cod_comu)

set link_list_script {[export_url_vars cod_manutentore flag_attivo last_order caller nome_funz nome_funz_caller]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

if {$nome_funz eq "boll-rila"} {
    set link_ritorna ""
} else {
    set link_ritorna "coimboll-list?$link_list"
}

set url_boll [list [ad_conn url]?[export_ns_set_vars url]]
set url_boll [export_url_vars url_boll]

if {$funzione ne "I"} {
    set link_prnt "nome_funz=[iter_get_nomefunz coimboll-layout]&[export_url_vars cod_bollini]"
    set link_rfis "nome_funz=[iter_get_nomefunz coimrfis-gest]&url_boll=$url_boll&[export_url_vars cod_bollini]&funzione=I"
    set link_fatt "nome_funz=[iter_get_nomefunz coimfatt-gest]&$url_boll&[export_url_vars cod_bollini]&funzione=I"
}

if {$nome_funz_caller eq $nome_funz} {
    set titolo "Bollini"
} else {
    set titolo "Bollini di $manutentore"
}

switch $funzione {
    M {set button_label "Conferma Modifica" 
	set page_title   "Modifica $titolo"}
    D {set button_label "Conferma Cancellazione"
	set page_title   "Cancellazione $titolo"}
    I {set button_label "Conferma Inserimento"
	set page_title   "Rilascio $titolo"}
    V {set button_label "Torna alla lista"
	set page_title   "Visualizzazione $titolo"}
}

if {$caller eq "index"} {
#nic01 set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
    set context_bar [iter_context_bar \
                         [list / "Home"] \
                         [list /iter-portal "Portale dei Manutentori verso ITER"] \
                         "$page_title"];#nic01
} else {
    set context_bar  [iter_context_bar \
			  [list "javascript:window.close()" "Torna alla Gestione"] \
			  [list coimboll-list?$link_list "Lista Bollini $manutentore"] \
			  "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimboll"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

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

element create $form_name data_consegna \
    -label   "data consegna" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name f_manutentore \
    -label   "Manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 40 maxlength 100 readonly {} class form_element tabindex 10" \
    -optional

element create $form_name nr_bollini1 \
    -label   "nr bollini" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional 

element create $form_name matricola_da1 \
    -label   "matricola da" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name matricola_a1 \
    -label   "matricola a" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name costo_unitario1 \
    -label   "costo unitario" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 readonly {} class form_element" \
    -optional

element create $form_name imp_pagato1 \
    -label   "importo pagato" \
    -widget   text \
    -datatype text \
    -html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
    -optional

element create $form_name pagati1 \
    -label   "pagati" \
    -widget   select \
    -datatype text \
    -html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
    -optional \
    -options  {{{} {}} {S&igrave; S} {No N}}

element create $form_name nr_bollini2 \
    -label   "nr bollini" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional   

element create $form_name matricola_da2 \
    -label   "matricola da" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name matricola_a2 \
    -label   "matricola a" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name costo_unitario2 \
    -label   "costo unitario" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 readonly {} class form_element" \
    -optional

element create $form_name imp_pagato2 \
    -label   "importo pagato" \
    -widget   text \
    -datatype text \
    -html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
    -optional

element create $form_name pagati2 \
    -label   "pagati" \
    -widget   select \
    -datatype text \
    -html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
    -optional \
    -options  {{{} {}} {S&igrave; S} {No N}}

element create $form_name nr_bollini3 \
    -label   "nr bollini" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name matricola_da3 \
    -label   "matricola da" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name matricola_a3 \
    -label   "matricola a" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name costo_unitario3 \
    -label   "costo unitario" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 readonly {} class form_element" \
    -optional

element create $form_name imp_pagato3 \
    -label   "importo pagato" \
    -widget   text \
    -datatype text \
    -html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
    -optional

element create $form_name pagati3 \
    -label   "pagati" \
    -widget   select \
    -datatype text \
    -html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
    -optional \
    -options  {{{} {}} {S&igrave; S} {No N}}

element create $form_name nr_bollini4 \
    -label   "nr bollini" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional \

element create $form_name matricola_da4 \
    -label   "matricola da" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name matricola_a4 \
    -label   "matricola a" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name costo_unitario4 \
    -label   "costo unitario" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 readonly {} class form_element" \
    -optional

element create $form_name imp_pagato4 \
    -label   "importo pagato" \
    -widget   text \
    -datatype text \
    -html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
    -optional

element create $form_name pagati4 \
    -label   "pagati" \
    -widget   select \
    -datatype text \
    -html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
    -optional \
    -options  {{{} {}} {S&igrave; S} {No N}}

element create $form_name data_scadenza \
    -label   "data scadenza" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlenght 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name imp_sconto \
    -label   "importo sconto" \
    -widget   text \
    -datatype text \
    -html    "size 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name note \
    -label   "note" \
    -widget   textarea \
    -datatype text \
    -html    "cols 40 rows 4 $readonly_fld {} class form_element" \
    -optional

element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name cod_bollini      -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name flag_attivo      -widget hidden -datatype text -optional
element create $form_name extra_par        -widget hidden -datatype text -optional
element create $form_name dummy		   -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_order       -widget hidden -datatype text -optional
element create $form_name cod_manutentore  -widget hidden -datatype text -optional
element create $form_name is_admin_p       -widget hidden -datatype text -optional
element create $form_name ordboll_id       -widget hidden -datatype text -optional

set link_fattura "Stampa fattura"

if {[form is_request $form_name]} {
    
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_order       -value $last_order
    element set_properties $form_name is_admin_p       -value $is_admin_p
    element set_properties $form_name ordboll_id       -value $ordboll_id
    
    set current_date [iter_set_sysdate]
    set tipo_costo    1

    if {[db_0or1row query "
        select num_boll_g, num_boll_f1, num_boll_f2, num_boll_e, m.name as f_manutentore, m.iter_code as cod_manutentore
          from iter_ordboll o, iter_maintainers m
         where o.maintainer_id = m.maintainer_id
           and ordboll_id = :ordboll_id"]} {
	element set_properties $form_name nr_bollini1     -value $num_boll_g
	element set_properties $form_name nr_bollini2     -value $num_boll_f1
	element set_properties $form_name nr_bollini3     -value $num_boll_f2
	element set_properties $form_name nr_bollini4     -value $num_boll_e
	element set_properties $form_name f_manutentore   -value $f_manutentore
	element set_properties $form_name cod_manutentore -value $cod_manutentore
    }
    
    #set cod_potenza  [db_string sel_pote_cod_min_35 ""]
    set cod_potenza  "B"
    if {[db_0or1row query "
        select iter_edit_num(importo ,2) as importo
          from coimtari 
         where tipo_costo  = :tipo_costo
           and cod_potenza = :cod_potenza
           and data_inizio = (select max(data_inizio) 
                                from coimtari 
                               where tipo_costo   = :tipo_costo
                                 and cod_potenza  = :cod_potenza
                                 and data_inizio <= :current_date)"]} {
	element set_properties $form_name costo_unitario1   -value $importo
    }
    
    set cod_potenza  "C" 
    if {[db_0or1row query "
        select iter_edit_num(importo ,2) as importo
          from coimtari 
         where tipo_costo  = :tipo_costo
           and cod_potenza = :cod_potenza
           and data_inizio = (select max(data_inizio) 
                                from coimtari 
                               where tipo_costo   = :tipo_costo
                                 and cod_potenza  = :cod_potenza
                                 and data_inizio <= :current_date)"]} {
	element set_properties $form_name costo_unitario2   -value $importo
    }
    
    set cod_potenza  "A"
    if {[db_0or1row query "
        select iter_edit_num(importo ,2) as importo
          from coimtari 
         where tipo_costo  = :tipo_costo
           and cod_potenza = :cod_potenza
           and data_inizio = (select max(data_inizio) 
                                from coimtari 
                               where tipo_costo   = :tipo_costo
                                 and cod_potenza  = :cod_potenza
                                 and data_inizio <= :current_date)"]} {
	element set_properties $form_name costo_unitario3   -value $importo
    }
    
    set cod_potenza  "D"
    if {[db_0or1row query "
        select iter_edit_num(importo ,2) as importo
          from coimtari 
         where tipo_costo  = :tipo_costo
           and cod_potenza = :cod_potenza
           and data_inizio = (select max(data_inizio) 
                                from coimtari 
                               where tipo_costo   = :tipo_costo
                                 and cod_potenza  = :cod_potenza
                                 and data_inizio <= :current_date)"]} {
	element set_properties $form_name costo_unitario4   -value $importo
    }
    
    set data_consegna [iter_edit_date $current_date]
    element set_properties $form_name data_consegna -value $data_consegna

    # imposto il valore iniziale della matricola
    set cod_tpbo "1"
    if {$num_boll_g > 0} {
	db_1row query "select coalesce(ultima_matricola, 0) +1 as matricola_da1 from coimtpbo where cod_tpbo = :cod_tpbo"
	set matricola_a1 [expr $matricola_da1 + $num_boll_g -1]
    } else {
	set matricola_da1 ""
	set matricola_a1  ""
    }
    element set_properties $form_name matricola_da1 -value $matricola_da1
    element set_properties $form_name matricola_a1 -value $matricola_a1
    # imposto il valore iniziale della matricola
    set cod_tpbo "2"
    if {$num_boll_f1 > 0} {
	db_1row query "select coalesce(ultima_matricola, 0) +1 as matricola_da2 from coimtpbo where cod_tpbo = :cod_tpbo"
	set matricola_a2 [expr $matricola_da2 + $num_boll_f1 -1]
    } else {
	set matricola_da2 ""
	set matricola_a2  ""
    }
    element set_properties $form_name matricola_da2 -value $matricola_da2
    element set_properties $form_name matricola_a2 -value $matricola_a2
    # imposto il valore iniziale della matricola
    set cod_tpbo "3"
    if {$num_boll_f2 > 0} {
	db_1row query "select coalesce(ultima_matricola, 0) +1 as matricola_da3 from coimtpbo where cod_tpbo = :cod_tpbo"
	set matricola_a3 [expr $matricola_da3 + $num_boll_f2 -1]
    } else {
	set matricola_da3 ""
	set matricola_a3  ""
    }
    element set_properties $form_name matricola_da3 -value $matricola_da3
    element set_properties $form_name matricola_a3 -value $matricola_a3
    # imposto il valore iniziale della matricola
    set cod_tpbo "4"
    if {$num_boll_e > 0} {
	db_1row query "select coalesce(ultima_matricola, 0) +1 as matricola_da4 from coimtpbo where cod_tpbo = :cod_tpbo"
	set matricola_a4 [expr $matricola_da4 + $num_boll_e -1]
ns_log notice "serena1|$matricola_da4 + $num_boll_e -1=$matricola_a4|"
    } else {
	set matricola_da4 ""
	set matricola_a4  ""
    }
    element set_properties $form_name matricola_da4 -value $matricola_da4
    element set_properties $form_name matricola_a4 -value $matricola_a4
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set cod_bollini         [element::get_value $form_name cod_bollini]
    set data_consegna       [element::get_value $form_name data_consegna]
    set cod_manutentore     [string trim [element::get_value $form_name cod_manutentore]]
    set f_manutentore       [string trim [element::get_value $form_name f_manutentore]]

    set nr_bollini1         [element::get_value $form_name nr_bollini1]
    set matricola_da1       [element::get_value $form_name matricola_da1]
    set matricola_a1        [element::get_value $form_name matricola_a1]
    set costo_unitario1     [element::get_value $form_name costo_unitario1]
    set imp_pagato1         [element::get_value $form_name imp_pagato1]
    set pagati1             [element::get_value $form_name pagati1]

    set nr_bollini2         [element::get_value $form_name nr_bollini2]
    set matricola_da2       [element::get_value $form_name matricola_da2]
    set matricola_a2        [element::get_value $form_name matricola_a2]
    set costo_unitario2     [element::get_value $form_name costo_unitario2]
    set imp_pagato2         [element::get_value $form_name imp_pagato2]    
    set pagati2             [element::get_value $form_name pagati2]
    
    set nr_bollini3         [element::get_value $form_name nr_bollini3]
    set matricola_da3       [element::get_value $form_name matricola_da3]
    set matricola_a3        [element::get_value $form_name matricola_a3]
    set costo_unitario3     [element::get_value $form_name costo_unitario3]
    set imp_pagato3         [element::get_value $form_name imp_pagato3]
    set pagati3             [element::get_value $form_name pagati3]
    
    set nr_bollini4         [element::get_value $form_name nr_bollini4]
    set matricola_da4       [element::get_value $form_name matricola_da4]
    set matricola_a4        [element::get_value $form_name matricola_a4]
    set costo_unitario4     [element::get_value $form_name costo_unitario4]
    set imp_pagato4         [element::get_value $form_name imp_pagato4]
    set pagati4             [element::get_value $form_name pagati4]
    
    set data_scadenza       [element::get_value $form_name data_scadenza]
    set imp_sconto          [element::get_value $form_name imp_sconto]
    set note                [element::get_value $form_name note]
    
    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    # il manutentore deve essere stato convalidato
    if {$cod_manutentore eq ""} {
	element::set_error $form_name f_manutentore "Il manutentore deve essere stato approvato"
	incr error_num
    }

    #data consegna obbligatoria 
    if {[string equal $data_consegna ""]} {
	element::set_error $form_name data_consegna "Campo obbligatorio"
	incr error_num
    } else {
	set data_consegna [iter_check_date $data_consegna]
	if {$data_consegna == 0} {
	    element::set_error $form_name data_consegna "Data non corretta"
	    incr error_num
	} else {
	    if {$data_consegna > $current_date} {
		element::set_error $form_name data_consegna "Data deve essere anteriore alla data odierna"
		incr error_num
	    }
	}
    }
    
    # data scadenza
    if {![string equal $data_scadenza ""]} {
	set data_scadenza [iter_check_date $data_scadenza]
	if {$data_scadenza == 0} {
	    element::set_error $form_name data_scadenza "Data non corretta"
	    incr error_num
	}
    }
    
    if {[string equal $f_manutentore ""]} {
	element::set_error $form_name f_manutentore "Inserire manutentore"
	incr error_num
    }
    
    #-------- Check riga 1 -----------------------------  
    #controllo valorizzazioni matricola_da / matricola_a
    set sw_nr_bollini_ok    "f"    
    set sw_matricola_da_ok  "f"
    set sw_matricola_a_ok   "f"
    set cod_tpbo "1"

    if {![string equal $nr_bollini1 ""]} {
	set nr_bollini1 [iter_check_num $nr_bollini1 0]
        set sw_nr_bollini_ok "t"
	if {$nr_bollini1 eq "Error"} {
	    element::set_error $form_name nr_bollini1 "Deve essere un numero intero"
	    incr error_num
	    set sw_nr_bollini_ok "f"
	} else {
	    if {[iter_set_double $nr_bollini1] >= [expr pow(10,8)] || [iter_set_double $nr_bollini1] <= -[expr pow(10,8)]} {
		element::set_error $form_name nr_bollini1 "Deve essere inferiore di 100.000.000"
		incr error_num
		set sw_nr_bollini_ok "f"
	    }
	}
    }
    
    # imposto automaticamente anche quella finale
    element set_properties $form_name matricola_da1 -value $matricola_da1
    element set_properties $form_name matricola_a1 -value $matricola_a1
    
    set sw_matricola_da_ok "t"
    set sw_matricola_a_ok  "t"
    set sw_nr_bollini_ok   "t"
    # Se le matricole sono corrette ed il numero di bollini corrisponde controllo che
    # non vi siano dei blocchetti gia' rilasciati nell'intervallo di matricole indicate.
    # Per fare questo controllo (una between tra varchar) devo accertarmi
    # che le matricole di inizio e di fine abbiano la stessa lunghezza
    # altrimenti potrebbero mettermi 1 999 al posto di 0001 e 0999.

    if {$sw_matricola_da_ok eq "t" &&  $sw_matricola_a_ok  eq "t" && $sw_nr_bollini_ok   eq "t"} {
    #	if {[string length $matricola_da1] !=  [string length $matricola_a1]} {
    #	    element::set_error $form_name matricola_da1 "Le due matricole devono avere la stessa lunghezza"
    #	    incr error_num
    #	    set sw_matricola_da_ok "f"
    #	    set sw_matricola_a_ok  "f"
    #	}

	# se e' valorizzato prendo imp pagato altrimenti lo ricavo moltiplicando costo unitario per nr bollini
	set costo_unitario1 [iter_check_num $costo_unitario1 2]
    
	if {![string equal $imp_pagato1 ""]} {
	    set imp_pagato1 [iter_check_num $imp_pagato1 2]
	    if {$imp_pagato1 eq "Error"} {
		element::set_error $form_name imp_pagato1 "Importo pagato deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num
		
	    }
	} else {
	    set imp_pagato1 [expr $nr_bollini1 * $costo_unitario1]
	}
    }
    
    #-------- Check riga 2 -----------------------------
    #controllo valorizzazioni matricola_da / matricola_a
    set sw_nr_bollini_ok    "f"
    set sw_matricola_da_ok  "f"
    set sw_matricola_a_ok   "f"
    set cod_tpbo "2"

    if {$nr_bollini2 ne "" && $nr_bollini2 > 0} {
	set nr_bollini2 [iter_check_num $nr_bollini2 0]
        set sw_nr_bollini_ok "t"
	if {$nr_bollini2 eq "Error"} {
	    element::set_error $form_name nr_bollini2 "Deve essere un numero intero"
	    incr error_num
	    set sw_nr_bollini_ok "f"
	} else {
	    if {[iter_set_double $nr_bollini2] >=  [expr pow(10,8)] || [iter_set_double $nr_bollini2] <= -[expr pow(10,8)]} {
		element::set_error $form_name nr_bollini2 "Deve essere inferiore di 100.000.000"
		incr error_num
		set sw_nr_bollini_ok "f"
	    }
	}
    }

    # imposto automaticamente anche quella finale
    element set_properties $form_name matricola_da2 -value $matricola_da2
    set matricola_a2 [expr $matricola_da2 + $nr_bollini2 -1]
    element set_properties $form_name matricola_a2 -value $matricola_a2
    
    set sw_matricola_da_ok "t"	
    set sw_matricola_a_ok  "t"
    set sw_nr_bollini_ok   "t"
    # Se le matricole sono corrette ed il numero di bollini corrisponde controllo che
    # non vi siano dei blocchetti gia' rilasciati nell'intervallo di matricole indicate.
    # Per fare questo controllo (una between tra varchar) devo accertarmi
    # che le matricole di inizio e di fine abbiano la stessa lunghezza
    # altrimenti potrebbero mettermi 1 999 al posto di 0001 e 0999.
    if {$sw_matricola_da_ok eq "t" && $sw_matricola_a_ok eq "t" &&  $sw_nr_bollini_ok eq "t"} {
#	if {[string length $matricola_da2]  !=  [string length $matricola_a2]} {
#	    element::set_error $form_name matricola_da2 "Le due matricole devono avere la stessa lunghezza"
#	    incr error_num
#	    set sw_matricola_da_ok "f"
#	    set sw_matricola_a_ok  "f"
#	}

	#se e' valorizzato prendo imp pagato altrimenti lo ricavo moltiplicando costo unitario per nr bollini
        set costo_unitario2 [iter_check_num $costo_unitario2 2]

	if {![string equal $imp_pagato2 ""]} {
	    set imp_pagato2 [iter_check_num $imp_pagato2 2]
	    if {$imp_pagato2 eq "Error"} {
		element::set_error $form_name imp_pagato2 "Importo pagato deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num
	    }
        } else {
            set imp_pagato2 [expr $nr_bollini2 * $costo_unitario2]
	}
    }
    
    #-------- Check riga 3 -----------------------------
    #controllo valorizzazioni matricola_da / matricola_a
    set sw_nr_bollini_ok    "f"
    set sw_matricola_da_ok  "f"
    set sw_matricola_a_ok   "f"
    set cod_tpbo "3"

    if {$nr_bollini3 ne "" && $nr_bollini3 > 0} {
	set nr_bollini3 [iter_check_num $nr_bollini3 0]
        set sw_nr_bollini_ok "t"
	if {$nr_bollini3 eq "Error"} {
	    element::set_error $form_name nr_bollini3 "Deve essere un numero intero"
	    incr error_num
	    set sw_nr_bollini_ok "f"
	} else {
	    if {[iter_set_double $nr_bollini3] >=  [expr pow(10,8)] || [iter_set_double $nr_bollini3] <= -[expr pow(10,8)]} {
		element::set_error $form_name nr_bollini3 "Deve essere inferiore di 100.000.000"
		incr error_num
		set sw_nr_bollini_ok "f"
	    }
	}    
    }

    # imposto automaticamente anche quella finale
    element set_properties $form_name matricola_da3 -value $matricola_da3
    set matricola_a3 [expr $matricola_da3 + $nr_bollini3 -1]
    element set_properties $form_name matricola_a3 -value $matricola_a3

    set sw_matricola_da_ok "t"	
    set sw_matricola_a_ok  "t"
    set sw_nr_bollini_ok   "t"
    # Se le matricole sono corrette ed il numero di bollini corrisponde controllo che
    # non vi siano dei blocchetti gia' rilasciati nell'intervallo di matricole indicate.
    # Per fare questo controllo (una between tra varchar) devo accertarmi
    # che le matricole di inizio e di fine abbiano la stessa lunghezza
    # altrimenti potrebbero mettermi 1 999 al posto di 0001 e 0999.
    if {$sw_matricola_da_ok eq "t" && $sw_matricola_a_ok eq "t" && $sw_nr_bollini_ok eq "t"} {
	#	if {[string length $matricola_da3] !=  [string length $matricola_a3]} {
	#	    element::set_error $form_name matricola_da3 "Le due matricole devono avere la stessa lunghezza"
	#	    incr error_num
	##	    set sw_matricola_da_ok "f"
#	    set sw_matricola_a_ok  "f"
	#	}
	
	# se e' valorizzato prendo imp pagato altrimenti lo ricavo moltiplicando costo unitario per nr bollini
        set costo_unitario3 [iter_check_num $costo_unitario3 2]
	
	if {![string equal $imp_pagato3 ""]} {
	    set imp_pagato3 [iter_check_num $imp_pagato3 2]
	    if {$imp_pagato3 eq "Error"} {
		element::set_error $form_name imp_pagato3 "Importo pagato deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num
	    }
        } else {
            set imp_pagato3 [expr $nr_bollini3 * $costo_unitario3]
	}
    }

    #-------- Check riga 4 -----------------------------
    #controllo valorizzazioni matricola_da / matricola_a
    set sw_nr_bollini_ok   "f"
    set sw_matricola_da_ok "f"
    set sw_matricola_a_ok  "f"
    set cod_tpbo           "4"

    if {$nr_bollini4 ne "" && $nr_bollini4 > 0} {
	set nr_bollini4 [iter_check_num $nr_bollini4 0]
        set sw_nr_bollini_ok "t"
	if {$nr_bollini4 eq "Error"} {
	    element::set_error $form_name nr_bollini4 "Deve essere un numero intero"
	    incr error_num
	    set sw_nr_bollini_ok "f"
	} else {
	    if {[iter_set_double $nr_bollini4] >= [expr pow(10,8)] || [iter_set_double $nr_bollini4] <= -[expr pow(10,8)]} {
		element::set_error $form_name nr_bollini4 "Deve essere inferiore di 100.000.000"
		incr error_num
		set sw_nr_bollini_ok "f"
	    }
	}
    }

    # imposto automaticamente anche quella finale
    element set_properties $form_name matricola_da4 -value $matricola_da4
    set matricola_a4 [expr $matricola_da4 + $nr_bollini4 -1]
    element set_properties $form_name matricola_a4 -value $matricola_a4
    
    set sw_matricola_da_ok "t"	
    set sw_matricola_a_ok  "t"
    set sw_nr_bollini_ok   "t"
    # Se le matricole sono corrette ed il numero di bollini corrisponde controllo che
    # non vi siano dei blocchetti gia' rilasciati nell'intervallo di matricole indicate.
    # Per fare questo controllo (una between tra varchar) devo accertarmi
    # che le matricole di inizio e di fine abbiano la stessa lunghezza
    # altrimenti potrebbero mettermi 1 999 al posto di 0001 e 0999.
    if {$sw_matricola_da_ok eq "t" && $sw_matricola_a_ok  eq "t" && $sw_nr_bollini_ok   eq "t"} {
#	if {[string length $matricola_da4] != [string length $matricola_a4]} {
#	    element::set_error $form_name matricola_da4 "Le due matricole devono avere la stessa lunghezza"
#	    incr error_num
#	    set sw_matricola_da_ok "f"
#	    set sw_matricola_a_ok  "f"
#	}
	
        # se e' valorizzato prendo imp pagato altrimenti lo ricavo moltiplicando costo unitario per nr bollini
        set costo_unitario4 [iter_check_num $costo_unitario4 2]

	if {![string equal $imp_pagato4 ""]} {
	    set imp_pagato4 [iter_check_num $imp_pagato4 2]
	    if {$imp_pagato4 eq "Error"} {
		element::set_error $form_name imp_pagato4 "Importo pagato deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num
	    }
        } else {
            set imp_pagato4 [expr $nr_bollini4 * $costo_unitario4]
	}
    }   
    #-------- Fine check delle righe bollini -----------

    if {[string equal $nr_bollini1 ""] && [string equal $nr_bollini2 ""]
	&& [string equal $nr_bollini3 ""] && [string equal $nr_bollini4 ""]} {
	element::set_error $form_name nr_bollini1 "Inserire almeno un Nr bollini"
	incr error_num
    }

    if {![string equal $imp_sconto ""]} {
	set imp_sconto [iter_check_num $imp_sconto 2]
	if {$imp_sconto eq "Error"} {
	    element::set_error $form_name imp_sconto "Lo sconto deve essere numerico e pu&ograve; avere al massimo 2 decimali"
	    incr error_num
	} else {
	    if {[iter_set_double $imp_sconto] >= [expr pow(10,8)] || [iter_set_double $imp_sconto] <= -[expr pow(10,8)]} {
		element::set_error $form_name imp_sconto "Lo sconto deve essere inferiore di 100.000.000"
		incr error_num
	    } else {
		if {[string equal $note ""]} {
		    set note "Sconto per autocertificazioni inserite"
		}
	    }
	}
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    db_transaction {
	#nic02 Rifaccio questo controllo in questo punto per evitare doppi click
	db_1row query "select flag_evaso from iter_ordboll where ordboll_id = :ordboll_id";#nic02
	if {$flag_evaso eq "t"} {;#nic02
	    ad_return_complaint 1 "Ordine bollini già evaso.";#nic02
	};#nic02

	# aggiorno subito il flag_evaso sull'ordine bollini per evitare doppi click
	db_dml query "update iter_ordboll set flag_evaso = 't' where ordboll_id = :ordboll_id"

	set nr_bollini_resi ""
	set cod_tpbl "" 

	if {$nr_bollini1 ne "" && $nr_bollini1 > 0} {
	    set nr_bollini     $nr_bollini1
	    set matricola_da   $matricola_da1
	    set matricola_a    $matricola_a1
	    set costo_unitario $costo_unitario1  
	    set imp_pagato     $imp_pagato1
	    set pagati         $pagati1
	    set cod_tpbo       "1"
	    db_1row query "select nextval('coimboll_s') as cod_bollini"
	    set dml_sql [db_map ins_boll]
	    db_dml dml_coimboll $dml_sql
	    if {$nr_bollini1 > 0} {
		db_dml query "update coimtpbo set ultima_matricola = :matricola_a1 where cod_tpbo = :cod_tpbo"
	    }
	}
	if {$nr_bollini2 ne "" && $nr_bollini2 > 0} {
	    set nr_bollini     $nr_bollini2
	    set matricola_da   $matricola_da2
	    set matricola_a    $matricola_a2
	    set costo_unitario $costo_unitario2  
	    set imp_pagato     $imp_pagato2
	    set pagati         $pagati2
	    set cod_tpbo       "2"	
	    db_1row query "select nextval('coimboll_s') as cod_bollini"
	    set dml_sql [db_map ins_boll]
	    db_dml dml_coimboll $dml_sql
	    if {$nr_bollini2 > 0} {
		db_dml query "update coimtpbo set ultima_matricola = :matricola_a2 where cod_tpbo = :cod_tpbo"
	    }
	}
	if {$nr_bollini3 ne "" && $nr_bollini3 > 0} {
	    set nr_bollini     $nr_bollini3
	    set matricola_da   $matricola_da3
	    set matricola_a    $matricola_a3
	    set costo_unitario $costo_unitario3  
	    set imp_pagato     $imp_pagato3
	    set pagati         $pagati3
	    set cod_tpbo       "3"
	    db_1row query "select nextval('coimboll_s') as cod_bollini"
	    set dml_sql [db_map ins_boll]
	    db_dml dml_coimboll $dml_sql
	    if {$nr_bollini3 > 0} {
		db_dml query "update coimtpbo set ultima_matricola = :matricola_a3 where cod_tpbo = :cod_tpbo"
	    }
	}
	if {$nr_bollini4 ne "" && $nr_bollini4 > 0} {
	    set nr_bollini     $nr_bollini4
	    set matricola_da   $matricola_da4
	    set matricola_a    $matricola_a4
	    set costo_unitario $costo_unitario4  
	    set imp_pagato     $imp_pagato4
	    set pagati         $pagati4
	    set cod_tpbo       "4"
	    db_1row query "select nextval('coimboll_s') as cod_bollini"
	    set dml_sql [db_map ins_boll]
	    db_dml dml_coimboll $dml_sql
	    if {$nr_bollini4 > 0} {
		db_dml query "update coimtpbo set ultima_matricola = :matricola_a4 where cod_tpbo = :cod_tpbo"
	    }
	}
    }
    
    # dopo l'inserimento posiziono la lista sul record inserito
#    set last_order [list  $data_consegna $cod_bollini]
    set last_order ""   
    ad_returnredirect "coimboll-list?f_cod_manu=$cod_manutentore&last_order=$last_order&caller=index&funzione=V&nome%5ffunz=bollini&nome%5ffunz%5fcaller=bollini"
    ad_script_abort
}

ad_return_template
