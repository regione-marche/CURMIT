ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimaimp_valvole_regolazione"
    @author          Romitti Luca - clonato da "coimvasi_espa_aimp"
    @creation-date   13/11/2018
    
    @param funzione  I=insert M=edit D=delete V=view
    
    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz_caller identifica l'entrata di menu, serve per la 
    @                navigazione con navigation bar
   
    @param extra_par Variabili extra da restituire alla lista
    
    @cvs-id          coimaimp-sistemi-regolazione.tcl
    
    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    sim01 18/09/2020 Aggiunto controllo per evitare che un valvola venga inserita due volte

    rom01 21/12/2018 Aggiunto campo num_vr_sostituente
} {
    {cod_valvola_regolazione_aimp ""}
    {cod_impianto             ""}
    {funzione                "V"}
    {caller              "index"}
    {nome_funz                ""}
    {nome_funz_caller         ""}
    {extra_par                ""}
    {url_list_aimp            ""}
    {url_aimp                 ""}
    {funzione_caller          ""}
    {num_vr                   ""}
} -properties {    
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
    focus_field:onevalue
}

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}  
    "M" {set lvl 3}   
    "D" {set lvl 4}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set link_gest [export_url_vars cod_sistema_regolazione_aimp num_vr cod_impianto nome_funz nome_funz_caller url_list_aimp url_aimp extra_par caller]

if {($funzione eq "I" && [db_0or1row q "select 1
                                          from coimaimp 
                                         where cod_impianto = :cod_impianto 
                                           and regol_valv_ind_num_vr is null "])
    || $num_vr eq "1"} {
    set valv_reg_num_1 "t"
} else {
    set valv_reg_num_1 "f"
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}
set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars cod_impianto caller nome_funz_caller nome_funz url_list_aimp url_aimp]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

set current_date     [iter_set_sysdate]

set titolo              "Valvole di Regolazione"
switch $funzione {
    M {set button_label "Conferma Modifica" 
	set page_title   "Modifica $titolo"}
    D {set button_label "Conferma Cancellazione"
	set page_title   "Cancellazione $titolo"}
    I {set button_label "Conferma Inserimento"
	set page_title   "Inserimento $titolo"}
    V {set button_label "Torna alla lista"
	set page_title   "Visualizzazione $titolo"}
}

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimaimp-val-reg"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
    "I" {
	set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
    }
    "M" {
	set readonly_fld \{\}
        set disabled_fld \{\}
    }
}

form create $form_name \
    -html    $onsubmit_cmd

element create $form_name num_vr \
    -label   "Numero" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 readonly {} class form_element" \
    -optional
#rom01
element create $form_name num_vr_sostituente \
    -label   "VR sostituente" \
    -widget   text \
    -datatype text \
    -html    "size 3 maxlength 3 $readonly_fld {} class form_element" \
    -optional

element create $form_name flag_sostituito \
    -label   "Sostituito?" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{No f} {S&igrave; t}}

element create $form_name data_installazione \
    -label   "data installazione" \
    -widget   text \
    -datatype text \
    -optional \
    -html    "size 12 maxlength 10 $readonly_fld {} class form_element"

element create $form_name data_dismissione \
    -label   "data dismissione" \
    -widget   text \
    -datatype text \
    -optional \
    -html    "size 12 maxlength 10 $readonly_fld {} class form_element"

element create $form_name fabbricante \
    -label   "Fabbricante" \
    -widget   text \
    -datatype text \
    -optional \
    -html    "size 12 maxlength 30 $readonly_fld {} class form_element"

element create $form_name modello \
    -label   "Modello" \
    -widget   text \
    -datatype text \
    -optional \
    -html    "size 12 maxlength 30 $readonly_fld {} class form_element"

element create $form_name numero_vie \
    -label   "N° vie" \
    -widget   text \
    -datatype text \
    -optional \
    -html    "size 12 maxlength 20 $readonly_fld {} class form_element"

element create $form_name servomotore \
    -label   "Servomotore" \
    -widget   text \
    -datatype text \
    -optional \
    -html    "size 12 maxlength 20 $readonly_fld {} class form_element"

element create $form_name cod_valvola_regolazione_aimp  -widget hidden -datatype text -optional
element create $form_name funzione                      -widget hidden -datatype text -optional
element create $form_name caller                        -widget hidden -datatype text -optional
element create $form_name nome_funz                     -widget hidden -datatype text -optional
element create $form_name nome_funz_caller              -widget hidden -datatype text -optional
element create $form_name extra_par                     -widget hidden -datatype text -optional
element create $form_name cod_impianto                  -widget hidden -datatype text -optional
element create $form_name url_list_aimp                 -widget hidden -datatype text -optional
element create $form_name url_aimp                      -widget hidden -datatype text -optional
element create $form_name funzione_caller               -widget hidden -datatype text -optional

element create $form_name submit              -widget submit -datatype text -label "$button_label" -html "class form_submit"

if {[form is_request $form_name]} {    
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name funzione_caller  -value $funzione_caller
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name cod_impianto     -value $cod_impianto
    element set_properties $form_name url_list_aimp    -value $url_list_aimp
    element set_properties $form_name url_aimp         -value $url_aimp
    if {$funzione == "I"} {
	# propongo il numero della nuova valvola di regolazione con il max + 1:
	#se sto inserendo il primo devo salvare il record sulla coimaimp,
	#altrimenti salvo sulla tabella coimaimp_valvole_regolazione.
	if {$valv_reg_num_1 eq "t"} {
	    element set_properties $form_name num_vr -value "1"
	} else {
	db_1row query "
        select coalesce(max(numero_valvola_regolazione),1) + 1 as num_vr 
          from coimaimp_valvole_regolazione
         where cod_impianto = :cod_impianto"
	    
	    element set_properties $form_name num_vr -value $num_vr
	    
	    db_1row query "select coalesce(max(cod_valvola_regolazione_aimp),1) + 1 as cod_valvola_regolazione_aimp
                             from coimaimp_valvole_regolazione"
	    
	    element set_properties $form_name cod_valvola_regolazione_aimp -value $cod_valvola_regolazione_aimp        
	}
    } else {
	# leggo riga

	if {$valv_reg_num_1 eq "t"} {
	    if {[db_0or1row query "
                select a.cod_impianto
                     , a.regol_valv_ind_num_vr                    as num_vr
                     , a.regol_valv_ind_flag_sostituito           as flag_sostituito
                     , iter_edit_data(a.regol_valv_ind_iniz_data_inst) as data_installazione
                     , iter_edit_data(a.regol_valv_ind_iniz_data_dism) as data_dismissione
                     , a.regol_valv_ind_iniz_n_vie                     as numero_vie
                     , a.regol_valv_ind_iniz_servo_motore              as servomotore
                     , a.regol_valv_ind_iniz_fabbricante               as fabbricante
                     , a.regol_valv_ind_iniz_modello                   as modello
                     , a.num_vr_sostituente                            as num_vr_sostituente
                  from coimaimp a
                 where a.cod_impianto = :cod_impianto
               "] == 0} {
		iter_return_complaint "Record non trovato"
	    }
	} elseif {[db_0or1row query "
             select a.cod_impianto
                  , a.numero_valvola_regolazione         as num_vr
                  , a.flag_sostituito                    as flag_sostituito
                  , iter_edit_data(a.data_installazione) as data_installazione
                  , iter_edit_data(a.data_dismissione)   as data_dismissione
                  , a.numero_vie                         as numero_vie
                  , a.servomotore                        as servomotore
                  , a.fabbricante                        as fabbricante
                  , a.modello                            as modello
                  , a.num_vr_sostituente                 as num_vr_sostituente
               from coimaimp_valvole_regolazione a
              where a.cod_impianto = :cod_impianto
                and a.numero_valvola_regolazione = :num_vr
        "] == 0} {

	    iter_return_complaint "Record non trovato"
	}

	element set_properties $form_name cod_valvola_regolazione_aimp -value $cod_valvola_regolazione_aimp
	element set_properties $form_name cod_impianto                 -value $cod_impianto
	element set_properties $form_name num_vr                       -value $num_vr
	element set_properties $form_name flag_sostituito              -value $flag_sostituito
	element set_properties $form_name data_installazione           -value $data_installazione
	element set_properties $form_name data_dismissione             -value $data_dismissione
	element set_properties $form_name fabbricante                  -value $fabbricante
	element set_properties $form_name modello                      -value $modello
	element set_properties $form_name numero_vie                   -value $numero_vie
	element set_properties $form_name servomotore                  -value $servomotore
	element set_properties $form_name num_vr_sostituente           -value $num_vr_sostituente;#rom01
    }
}

if {[form is_valid $form_name]} {
 
    set cod_valvola_regolazione_aimp [element::get_value $form_name cod_valvola_regolazione_aimp]
    set cod_impianto                 [element::get_value $form_name cod_impianto]
    set num_vr                       [element::get_value $form_name num_vr]
    set flag_sostituito              [element::get_value $form_name flag_sostituito]
    set data_installazione           [element::get_value $form_name data_installazione]
    set data_dismissione             [element::get_value $form_name data_dismissione]
    set fabbricante                  [element::get_value $form_name fabbricante]
    set modello                      [element::get_value $form_name modello]
    set numero_vie                   [element::get_value $form_name numero_vie]
    set servomotore                  [element::get_value $form_name servomotore]
    set num_vr_sostituente           [element::get_value $form_name num_vr_sostituente];#rom01

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    
    if {$funzione == "I" || $funzione == "M"} {   

	if {[string equal $data_installazione ""]} {
	    element::set_error $form_name data_installazione "Inserire la Data installazione"
	    incr error_num
	} else {
	    set data_installazione [iter_check_date $data_installazione]
	    if {$data_installazione == 0} {
		element::set_error $form_name data_installazione "Data installazione deve essere una data"
		incr error_num
	    }
	}
	if {![string equal $data_dismissione ""]} {
	    set data_dismissione [iter_check_date $data_dismissione]
	    if {$data_dismissione  == 0} {
		element::set_error $form_name data_dismissione "Data dismissione deve essere una data"
		incr error_num
	    }
	    if {$flag_sostituito ne "t"} {
		element::set_error $form_name flag_sostituito "Selezionare \"S&igrave;\" se \"Data dismissione\" &egrave; compilata"
		incr error_num
	    }
	} elseif {[string equal $data_dismissione ""] && $flag_sostituito eq "t"} {
	    element::set_error $form_name flag_sostituito "Selezionare \"S&igrave;\" solo se\"Data dismissione\" &egrave; compilata"
	    incr error_num
	}
	if {![string is space $num_vr_sostituente]} {#rom01 if e contenuto
	    set num_vr_sostituente [iter_check_num $num_vr_sostituente 0]
	    if {$num_vr_sostituente == "Error" } {
		element::set_error $form_name num_vr_sostituente "Deve essere un numero intero diverso da 0 e da se stesso"
		incr error_num
	    }
	    if {$valv_reg_num_1 eq "t"&& [db_0or1row q "select 1 
                                                          from coimaimp 
                                                         where regol_valv_ind_num_vr = :num_vr
                                                           and cod_impianto = :cod_impianto
                                                           and regol_valv_ind_num_vr = :num_vr_sostituente
                                                            or :num_vr = :num_vr_sostituente
                                                            or :num_vr_sostituente = 0 limit 1"] == 1} {
			element::set_error $form_name num_vr_sostituente "Deve essere un numero intero diverso da 0 e da se stesso"
			incr error_num
	    }
	    if {$valv_reg_num_1 eq "f" && [db_0or1row q "select 1
                                                          from coimaimp_valvole_regolazione 
                                                         where numero_valvola_regolazione = :num_vr
                                                           and cod_impianto = :cod_impianto
                                                           and numero_valvola_regolazione = :num_vr_sostituente
                                                            or :num_vr = :num_vr_sostituente
                                                            or :num_vr_sostituente = 0 limit 1"] == 1} {
		element::set_error $form_name num_vr_sostituente "Deve essere un numero intero diverso da 0 e da se stesso"
		incr error_num
	    }
	};#rom01
	if { [string is space $num_vr_sostituente] && $flag_sostituito eq "t"} {#rom01 if, elseif e contenuto
	    element::set_error $form_name num_vr_sostituente "Inserire quale sarà l'VR sostituente"
	    incr error_num
	} elseif {![string is space $num_vr_sostituente] && $flag_sostituito ne "t"} {
	    element::set_error $form_name num_vr_sostituente "Inserire solo se si sostituisce l'VR"
	    incr error_num
	};#rom01

    };#fine controlli
    if {$error_num > 0} {
	ad_return_template
	return
    }
    
    
    # Lancio la query di manipolazione dati contenuta in dml_sql
    
    # with_catch error_msg serve a verificare che non ci siano errori nella db_translation
    with_catch error_msg {
	db_transaction {
	    switch $funzione {
		I {
		    if {$valv_reg_num_1 eq "t"} {
			db_dml query "
                        update coimaimp
                           set regol_valv_ind_num_vr               = :num_vr         
                             , regol_valv_ind_flag_sostituito      = :flag_sostituito         
                             , regol_valv_ind_iniz_data_inst       = :data_installazione      
                             , regol_valv_ind_iniz_data_dism       = :data_dismissione        
                             , regol_valv_ind_iniz_n_vie           = :numero_vie
                             , regol_valv_ind_iniz_servo_motore    = :servomotore  
                             , regol_valv_ind_iniz_fabbricante     = :fabbricante             
                             , regol_valv_ind_iniz_modello         = :modello                 
                             , num_vr_sostituente                  = :num_vr_sostituente --rom01
                         where cod_impianto = :cod_impianto"
		    } else {

			if {[db_0or1row q "
                           select 1 
                             from coimaimp_valvole_regolazione
                            where numero_valvola_regolazione=:num_vr
                              and cod_impianto = :cod_impianto"]} {#sim01 if e suo contenuto
			    ad_return_template
			    return			    
			}
	
			db_dml query "
                    insert
                      into coimaimp_valvole_regolazione
                      ( numero_valvola_regolazione
                      , cod_valvola_regolazione_aimp
                      , cod_impianto
                      , flag_sostituito           
                      , data_installazione        
                      , data_dismissione          
                      , numero_vie  
                      , servomotore    
                      , fabbricante               
                      , modello                   
                      , num_vr_sostituente --rom01
                      )
                      values
                      ( :num_vr
                      ,:cod_valvola_regolazione_aimp
                      ,:cod_impianto
                      ,:flag_sostituito           
                      ,:data_installazione        
                      ,:data_dismissione          
                      ,:numero_vie  
                      ,:servomotore    
                      ,:fabbricante               
                      ,:modello                   
                      ,:num_vr_sostituente --rom01
                      )"
		    }
		}
		M {
                    if {$valv_reg_num_1 eq "t"} {
                        db_dml query "
                    update coimaimp
                       set regol_valv_ind_num_vr             = :num_vr
                         , regol_valv_ind_flag_sostituito    = :flag_sostituito
                         , regol_valv_ind_iniz_data_inst     = :data_installazione
                         , regol_valv_ind_iniz_data_dism     = :data_dismissione
                         , regol_valv_ind_iniz_n_vie         = :numero_vie
                         , regol_valv_ind_iniz_servo_motore  = :servomotore
                         , regol_valv_ind_iniz_fabbricante   = :fabbricante
                         , regol_valv_ind_iniz_modello       = :modello
                         , num_vr_sostituente                = :num_vr_sostituente --rom01
                     where cod_impianto = :cod_impianto"
		    } else {
			db_dml query "
                    update coimaimp_valvole_regolazione
                       set flag_sostituito              = :flag_sostituito           
                         , data_installazione           = :data_installazione        
                         , data_dismissione             = :data_dismissione          
                         , numero_vie                   = :numero_vie  
                         , servomotore                  = :servomotore    
                         , fabbricante                  = :fabbricante               
                         , modello                      = :modello                   
                         , num_vr_sostituente            = :num_vr_sostituente --rom01
                     where numero_valvola_regolazione   = :num_vr
                       and cod_impianto                 = :cod_impianto"
		    }
		}
		D {
                    if {$valv_reg_num_1 eq "t"} {
                        db_dml query "
                    update coimaimp
                       set regol_valv_ind_num_vr            = null
                         , regol_valv_ind_flag_sostituito   = null
                         , regol_valv_ind_iniz_data_inst    = null
                         , regol_valv_ind_iniz_data_dism    = null
                         , regol_valv_ind_iniz_n_vie        = null
                         , regol_valv_ind_iniz_servo_motore = null
                         , regol_valv_ind_iniz_fabbricante  = null
                         , regol_valv_ind_iniz_modello      = null
                         , num_vr_sostituente               = null
                     where cod_impianto = :cod_impianto"
		    } else {
		    db_dml query "
                    delete 
                      from coimaimp_valvole_regolazione
                     where cod_impianto               = :cod_impianto
                       and numero_valvola_regolazione = :num_vr"
		    }
		}
	    }
	    
	} 
    } {
        iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_impianto num_vr cod_valvola_regolazione_aimp nome_funz nome_funz_caller url_list_aimp url_aimp ]
    
    switch $funzione {
	I {set return_url   "coimaimp-regol-contab-gest?funzione=$funzione_caller&$link_gest"}
        V {set return_url   "coimaimp-regol-contab-gest?$link_list"}
        M {set return_url   "coimaimp-regol-contab-gest?funzione=$funzione_caller&$link_gest"}
	D {set return_url   "coimaimp-regol-contab-gest?funzione=$funzione_caller&$link_list"}
    }
    ad_returnredirect $return_url
    ad_script_abort
}
ad_return_template

