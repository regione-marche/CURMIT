ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimtarg"
    @creation-date   04.06.2012

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimtarg-rila.tcl

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================================================
    gab01  21/12/2016 Cambiato il funzionamento del programma.
    gab01             Adesso viene chiamato dal programma coimplic-rila e non più dalla lista ordini delle targhe e 
    gab01             successivamente estrae dalla nuova tabella ordplic i plichi selezionati dall'utente.
                      

    nic02  10/01/2014 Rafforzo il controllo sul doppio click visto che è capitato oggi.
} {
    {ordtarg_id          ""}
    {is_admin_p          ""}
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
    db_1row query "select name as manutentore
                        , validated_p
                        , approved_p 
                     from iter_maintainers 
                    where maintainer_id = :maintainer_id"
}
set id_utente $maintainer_id

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
                 -no_login \
                 -object_id [ad_conn package_id] \
                 -privilege admin
	    ]

#gab01
set plico_id [db_list query "select distinct plico_id 
                               from ordplic
                              where ordtarg_id = :ordtarg_id"]



set current_date [iter_set_sysdate]
set link_gest [export_url_vars last_order nome_funz nome_funz_caller extra_par caller flag_attivo is_admin_p]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

#iter_get_coimtgen
#set flag_ente  $coimtgen(flag_ente)
#set sigla_prov $coimtgen(sigla_prov)
#set cod_comu   $coimtgen(cod_comu)

set link_list_script {[export_url_vars cod_manutentore flag_attivo last_order caller nome_funz nome_funz_caller ordtarg_id is_admin_p funzione]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

set link_ritorna "coimplic-rila?$link_list"

set url_boll [list [ad_conn url]?[export_ns_set_vars url]]
set url_boll [export_url_vars url_boll]

if {$funzione ne "I"} {
    set link_prnt "nome_funz=[iter_get_nomefunz coimtarg-layout]&[export_url_vars ]"
    set link_rfis "nome_funz=[iter_get_nomefunz coimrfis-gest]&url_boll=$url_boll&funzione=I"
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
    set context_bar [iter_context_bar \
                         [list / "Home"] \
                         [list /iter-portal "Portale dei Manutentori verso ITER"] \
                         "$page_title"]
} else {
    set context_bar  [iter_context_bar \
			  [list "javascript:window.close()" "Torna alla Gestione"] \
			  [list coimplic-list?$link_list "Lista Bollini $manutentore"] \
			  "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimtarg"
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

element create $form_name num_targhe \
    -label   "num targhe" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional 

element create $form_name data_scadenza \
    -label   "data scadenza" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlenght 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name note \
    -label   "note" \
    -widget   textarea \
    -datatype text \
    -html    "cols 40 rows 4 $readonly_fld {} class form_element" \
    -optional

element create $form_name funzione         -widget hidden -datatype text -optional
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
element create $form_name ordtarg_id       -widget hidden -datatype text -optional
element create $form_name plico_id         -widget hidden -datatype text -optional ;#gab01
element create $form_name cod_prenotazione -widget hidden -datatype text -optional ;#gab01

if {[form is_request $form_name]} {
    
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_order       -value $last_order
    element set_properties $form_name is_admin_p       -value $is_admin_p
    element set_properties $form_name ordtarg_id       -value $ordtarg_id
    element set_properties $form_name plico_id         -value $plico_id ;#gab01    

    set current_date [iter_set_sysdate]
    set tipo_costo    1

    if {[db_0or1row query "
        select o.num_targhe
             , m.name as f_manutentore
             , m.iter_code as cod_manutentore
             , o.cod_prenotazione --gab01
          from iter_ordtarg o
             , iter_maintainers m
         where o.maintainer_id = m.maintainer_id
           and ordtarg_id = :ordtarg_id"]} {
	element set_properties $form_name num_targhe       -value $num_targhe
	element set_properties $form_name f_manutentore    -value $f_manutentore
	element set_properties $form_name cod_manutentore  -value $cod_manutentore
        element set_properties $form_name cod_prenotazione -value $cod_prenotazione ;#gab01
    }
    
    #gab01 controllo che il numero di taghe ordinate sia inferiore a quello dei plichi selezionati
    set targhe_per_plico [parameter::get_from_package_key -package_key iter-portal -parameter targhe_per_plico]
    set num_plichi [llength $plico_id]
    set targhe_tot [expr $targhe_per_plico * $num_plichi]
    
    if {$targhe_tot eq "0"} {#gab01
       ad_return_complaint 1 "Non hai selezionato nessun plico"
    }

    set data_consegna [iter_edit_date $current_date]
    element set_properties $form_name data_consegna -value $data_consegna
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system
    
    set data_consegna       [element::get_value $form_name data_consegna]
    set cod_manutentore     [string trim [element::get_value $form_name cod_manutentore]]
    set f_manutentore       [string trim [element::get_value $form_name f_manutentore]]
    set num_targhe          [element::get_value $form_name num_targhe]
    set data_scadenza       [element::get_value $form_name data_scadenza]
    set note                [element::get_value $form_name note]
    set cod_prenotazione    [element::get_value $form_name cod_prenotazione]    

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
    
    if {![string equal $num_targhe ""]} {
	set num_targhe  [iter_check_num $num_targhe 0]
	if {$num_targhe eq "Error"} {
	    element::set_error $form_name num_targhe "Deve essere un numero intero"
	    incr error_num
	} else {
	    if {[iter_set_double $num_targhe] >= [expr pow(10,8)] || [iter_set_double $num_targhe] <= -[expr pow(10,8)]} {
		element::set_error $form_name num_targhe "Deve essere inferiore di 100.000.000"
		incr error_num
	    }
	}
    }
    
    if {[string equal $num_targhe ""]} {
	element::set_error $form_name num_targhe "Inserire almeno un Num targhe"
	incr error_num
    }
    
    
    if {$error_num > 0} {
        ad_return_template
        return
    }
    
    db_transaction {
	
	#nic02 Rifaccio questo controllo in questo punto per evitare doppi click
	db_1row query "select flag_evaso 
                         from iter_ordtarg 
                        where ordtarg_id = :ordtarg_id";#nic02
	if {$flag_evaso eq "t"} {;#nic02
	    ad_return_complaint 1 "Ordine targhe già evaso.";#nic02
	};#nic02
	
        #gab01 Controllo che i plichi siano ancora disponibili
	set plichi_not_disp [db_list query "select 'matrice ' || matrice_fissa ||' da '|| matrice_da||' a '|| matrice_a as mat 
                                          from coimplic
                                         where plico_id in ([join $plico_id , ])
                                           and ordtarg_id is not null"]
	
	if {[llength $plichi_not_disp]  > 0} {;#gab01
	    set msg_gia_usati "I seguenti plichi selezionati sono già stati utilizzati:<br>"
	    
	    foreach plico_usato $plichi_not_disp {
		
		append msg_gia_usati "$plico_usato  <br>"
		
	    }
	    ad_return_complaint 1 $msg_gia_usati
	    return 
	}
	
	# aggiorno subito il flag_evaso sull'ordine bollini per evitare doppi click
	db_dml query "update iter_ordtarg 
                         set flag_evaso   = 't' 
                           , editing_user = :id_utente   --gab01
                           , editing_date = current_date --gab01
                       where ordtarg_id   = :ordtarg_id"
        
        #gab01 adesso i plichi vengono scelti dall'utente della coimplic-rila
	#associo al manutentore i plichi in ordine di lotto (dal più vecchio) e in ordine alfabetico
	#set cont_targhe $num_targhe
	
        
	db_1row q "select maintainer_id as maintainer_id_ordtarg
                         from iter_ordtarg
                        where ordtarg_id= :ordtarg_id"                  
	

	db_dml upd_plico "update coimplic
                                 set data_consegna = :data_consegna
                                   , maintainer_id = :maintainer_id_ordtarg
                                   , ordtarg_id    = :ordtarg_id
                               where plico_id      in ([join $plico_id , ])"

        #gab01 dopo aver evaso l'ordine cancello i record dalla tabella temporanea
        db_dml query "delete from ordplic
                       where ordtarg_id = :ordtarg_id"
    }
    
    
    
    # dopo l'inserimento posiziono la lista sul record inserito
    #    set last_order [list  $data_consegna $cod_bollini]
    set last_order ""   
    #gab01 passo anche il cod_penotazione
 
    ad_returnredirect "coimplic-list?f_cod_manu=$cod_manutentore&last_order=$last_order&caller=index&funzione=V&cod_prenotazione=$cod_prenotazione"
    ad_script_abort
}

ad_return_template
