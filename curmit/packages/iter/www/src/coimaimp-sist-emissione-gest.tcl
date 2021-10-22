ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimaimp" - Libretto - 7. Sistema di emissione
    @author          Gabriele Lo Vaglio - clonato da coimaimp-sist-distribuz-gest
    @creation-date   17/08/2016
    
    @param funzione  M=edit V=view
    
    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz_caller identifica l'entrata di menu, serve per la 
    @                navigazione con navigation bar
    
    @param extra_par Variabili extra da restituire alla lista
    
    @cvs-id          coimaimp_sist_emissione-gest.tcl
    
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
} {
    {cod_impianto           ""}
    {last_cod_impianto      ""}
    {funzione              "V"}
    {caller            "index"}
    {nome_funz              ""}
    {nome_funz_caller       ""}
    {extra_par              ""}
    {url_list_aimp          ""}
    {url_aimp               ""}
} -properties {    
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
    list_head:onevalue
    table_result:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "M" {set lvl 3}   
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set link_gest [export_url_vars cod_impianto nome_funz nome_funz_caller url_list_aimp url_aimp last_cod_impianto extra_par caller]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}
set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set titolo           "Sistema di Emissione"
switch $funzione {
    M {set button_label "Conferma Modifica" 
       set page_title   "Modifica $titolo"}
    V {set button_label "Torna alla lista"
       set page_title   "Visualizzazione $titolo"}
}

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimaimp_sist_distribuz"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
    "M" {
	set readonly_fld \{\}
        set disabled_fld \{\}
    }
}

form create $form_name \
    -html    $onsubmit_cmd

element create $form_name sistem_emis_tipo \
    -label   "Tipo di Emissione" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {"Radiatori" R} {"Termoconvettori" T} {"Ventilconvettori" V} {"Pannelli Radianti" P} {"Bocchette" B} {"Strisce Radianti" S} {"Travi Fredde" F} {"Altro" A}}

element create $form_name sistem_emis_note_altro \
    -label   "Note altro" \
    -widget   textarea \
    -datatype text \
    -html    "cols 100 rows 3 $readonly_fld {} class form_element" \
    -optional
 
#rom01
element create $form_name sistem_emis_radiatore          \
    -label   "Radiatori" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld  {} class form_element" \
    -optional \
    -options {{{} {}} {"S&igrave;" S} {No N}}

#rom01
element create $form_name sistem_emis_termoconvettore    \
    -label   "Termoconvettori" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld  {} class form_element" \
    -optional \
    -options {{{} {}} {"S&igrave;" S} {No N}}
#rom01

element create $form_name sistem_emis_ventilconvettore   \
    -label   "Ventilconvettori" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld  {} class form_element" \
    -optional \
    -options {{{} {}} {"S&igrave;" S} {No N}}

#rom01
element create $form_name sistem_emis_pannello_radiante  \
    -label   "Pannelli Radianti" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld  {} class form_element" \
    -optional \
    -options {{{} {}} {"S&igrave;" S} {No N}}

#rom01
element create $form_name sistem_emis_bocchetta          \
    -label   "Bocchette" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld  {} class form_element" \
    -optional \
    -options {{{} {}} {"S&igrave;" S} {No N}}

#rom01
element create $form_name sistem_emis_striscia_radiante  \
    -label   "Strisce Radianti" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld  {} class form_element" \
    -optional \
    -options {{{} {}} {"S&igrave;" S} {No N}}

#rom01
element create $form_name sistem_emis_trave_fredda       \
    -label   "Travi Fredde" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld  {} class form_element" \
    -optional \
    -options {{{} {}} {"S&igrave;" S} {No N}}

#rom01
element create $form_name sistem_emis_altro              \
    -label   "Altro" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld  {} class form_element" \
    -optional \
    -options {{{} {}} {"S&igrave;" S} {No N}}

element create $form_name cod_impianto        -widget hidden -datatype text -optional
element create $form_name url_list_aimp       -widget hidden -datatype text -optional
element create $form_name url_aimp            -widget hidden -datatype text -optional
element create $form_name funzione            -widget hidden -datatype text -optional
element create $form_name caller              -widget hidden -datatype text -optional
element create $form_name nome_funz           -widget hidden -datatype text -optional
element create $form_name nome_funz_caller    -widget hidden -datatype text -optional
element create $form_name extra_par           -widget hidden -datatype text -optional
element create $form_name submit              -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_impianto   -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name url_list_aimp     -value $url_list_aimp
    element set_properties $form_name url_aimp          -value $url_aimp
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name nome_funz_caller  -value $nome_funz_caller
    element set_properties $form_name extra_par         -value $extra_par
    element set_properties $form_name last_cod_impianto -value $last_cod_impianto
    
    # leggo riga
    if {[db_0or1row query "
        select a.sistem_emis_tipo
             , a.sistem_emis_note_altro
             , a.sistem_emis_radiatore        
             , a.sistem_emis_termoconvettore  
             , a.sistem_emis_ventilconvettore 
             , a.sistem_emis_pannello_radiante
             , a.sistem_emis_bocchetta        
             , a.sistem_emis_striscia_radiante
             , a.sistem_emis_trave_fredda     
             , a.sistem_emis_altro            
          from coimaimp a
         where a.cod_impianto = :cod_impianto
        "] == 0
    } {
	iter_return_complaint "Record non trovato"
    }
    
    element set_properties $form_name cod_impianto                   -value $cod_impianto
    element set_properties $form_name sistem_emis_tipo               -value $sistem_emis_tipo
    element set_properties $form_name sistem_emis_note_altro         -value $sistem_emis_note_altro
    element set_properties $form_name sistem_emis_radiatore          -value $sistem_emis_radiatore        ;#rom01
    element set_properties $form_name sistem_emis_termoconvettore    -value $sistem_emis_termoconvettore  ;#rom01
    element set_properties $form_name sistem_emis_ventilconvettore   -value $sistem_emis_ventilconvettore ;#rom01
    element set_properties $form_name sistem_emis_pannello_radiante  -value $sistem_emis_pannello_radiante;#rom01
    element set_properties $form_name sistem_emis_bocchetta          -value $sistem_emis_bocchetta        ;#rom01
    element set_properties $form_name sistem_emis_striscia_radiante  -value $sistem_emis_striscia_radiante;#rom01
    element set_properties $form_name sistem_emis_trave_fredda       -value $sistem_emis_trave_fredda     ;#rom01
    element set_properties $form_name sistem_emis_altro              -value $sistem_emis_altro            ;#rom01
    
}

if {[form is_valid $form_name]} {
    set cod_impianto                   [element::get_value $form_name cod_impianto]
    set sistem_emis_tipo               [element::get_value $form_name sistem_emis_tipo]
    set sistem_emis_note_altro         [string trim [element::get_value $form_name sistem_emis_note_altro]]
    set sistem_emis_radiatore          [element::get_value $form_name sistem_emis_radiatore        ];#rom01
    set sistem_emis_termoconvettore    [element::get_value $form_name sistem_emis_termoconvettore  ];#rom01
    set sistem_emis_ventilconvettore   [element::get_value $form_name sistem_emis_ventilconvettore ];#rom01
    set sistem_emis_pannello_radiante  [element::get_value $form_name sistem_emis_pannello_radiante];#rom01
    set sistem_emis_bocchetta          [element::get_value $form_name sistem_emis_bocchetta        ];#rom01
    set sistem_emis_striscia_radiante  [element::get_value $form_name sistem_emis_striscia_radiante];#rom01
    set sistem_emis_trave_fredda       [element::get_value $form_name sistem_emis_trave_fredda     ];#rom01
    set sistem_emis_altro              [element::get_value $form_name sistem_emis_altro            ];#rom01

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    
    if {$funzione == "M"} {   
	
#rom01	if {$sistem_emis_tipo eq "A" && [string is space $sistem_emis_note_altro]} {
#	    template::form::set_error $form_name sistem_emis_note_altro "Compilare \"Note Altro\" specificando il tipo di emissione alternati#vo"
#	    incr error_num
#       }
#	if {$sistem_emis_tipo ne "A" && ![string is space $sistem_emis_note_altro]} {
#            template::form::set_error $form_name sistem_emis_note_altro "Compilare solo in caso di tipo emissione = \"Altro\""
#            incr error_num
#        }
#rom01	 
    
	if {$sistem_emis_altro eq "S" && [string is space $sistem_emis_note_altro]} {#rom01 if e contenuto
	    template::form::set_error $form_name sistem_emis_note_altro "Compilare \"Note Altro\" specificando il tipo di emissione alternativo"
	    incr error_num
	}
		
	if {$sistem_emis_altro ne "S" &&![string is space $sistem_emis_note_altro]} {#rom01 if e contenuto
	    template::form::set_error $form_name sistem_emis_note_altro "Compilare solo in caso di tipo emissione = \"Altro\""
	    incr error_num
	}

    }
    if {$error_num > 0} {
	ad_return_template
	return
    }


    # Lancio la query di manipolazione dati contenuta in dml_sql
    
    # with_catch error_msg serve a verificare che non ci siano errori nella db_transaction
    with_catch error_msg {
	db_transaction {
	    switch $funzione {
		M {
		    db_dml query "
                    update coimaimp
                       set sistem_emis_tipo               = :sistem_emis_tipo
                         , sistem_emis_note_altro         = :sistem_emis_note_altro
                         , sistem_emis_radiatore          = :sistem_emis_radiatore         --rom01
                         , sistem_emis_termoconvettore    = :sistem_emis_termoconvettore   --rom01
                         , sistem_emis_ventilconvettore   = :sistem_emis_ventilconvettore  --rom01
                         , sistem_emis_pannello_radiante  = :sistem_emis_pannello_radiante --rom01
                         , sistem_emis_bocchetta          = :sistem_emis_bocchetta         --rom01
                         , sistem_emis_striscia_radiante  = :sistem_emis_striscia_radiante --rom01
                         , sistem_emis_trave_fredda       = :sistem_emis_trave_fredda      --rom01
                         , sistem_emis_altro              = :sistem_emis_altro             --rom01
                     where cod_impianto = :cod_impianto"
		}		
	    }	    
	}
    } {
        iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }
    
    set link_gest      [export_url_vars cod_impianto last_cod_impianto url_list_aimp url_aimp nome_funz nome_funz_caller extra_par caller]
    
    switch $funzione {
	M {set return_url   "coimaimp-sist-emissione-gest?funzione=V&$link_gest"}
    }
    
    ad_returnredirect $return_url
    ad_script_abort
    
}
ad_return_template
