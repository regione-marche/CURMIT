ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimvasi_espa_aimp"
    @author          Gabriele Lo Vaglio - clonato da coimaimp-tratt-acqua-gest
    @creation-date   14/07/2016
    
    @param funzione  I=insert M=edit D=delete V=view
    
    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz_caller identifica l'entrata di menu, serve per la 
    @                navigazione con navigation bar
   
    @param extra_par Variabili extra da restituire alla lista
    
    @cvs-id          coimvasi_espa_aimp-gest.tcl
    
    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    rom01 08/11/2018 Cambiato return_url per tornare al programma dei "Sistemi di distribuzione"
    rom01            con la funzione in cui si era prima.

    gab01 16/08/2016 Cambiato return_url per tornare al programma dei "Sistemi di distribuzione"
} {
    {cod_vasi_espa_aimp     ""}
    {cod_impianto           ""}
    {funzione              "V"}
    {caller            "index"}
    {nome_funz              ""}
    {nome_funz_caller       ""}
    {extra_par              ""}
    {url_list_aimp          ""}
    {url_aimp               ""}
    {funzione_caller        ""}
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

set link_gest [export_url_vars cod_vasi_espa_aimp cod_impianto nome_funz nome_funz_caller url_list_aimp url_aimp extra_par caller]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}
set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars cod_vasi_espa_aimp cod_impianto caller nome_funz_caller nome_funz url_list_aimp url_aimp]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

set current_date     [iter_set_sysdate]

set titolo              "Vaso di Espansione"
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
set form_name    "coimvasi_espa_aimp"
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

element create $form_name num_vx \
    -label   "Numero" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 readonly {} class form_element" \
    -optional

element create $form_name capacita \
    -label   "Capacit&agrave;" \
    -widget   text \
    -datatype text \
    -html    "size 12 maxlength 12 $readonly_fld {} class form_element" \
    -optional

element create $form_name flag_aperto \
    -label   "Aperto?" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{} {Aperto A} {Chiuso C}}
     
element create $form_name pressione \
    -label   "Pressione" \
    -widget   text \
    -datatype text \
    -optional \
    -html    "size 12 maxlength 12 $readonly_fld {} class form_element"


element create $form_name cod_vasi_espa_aimp  -widget hidden -datatype text -optional
element create $form_name funzione            -widget hidden -datatype text -optional
element create $form_name caller              -widget hidden -datatype text -optional
element create $form_name nome_funz           -widget hidden -datatype text -optional
element create $form_name nome_funz_caller    -widget hidden -datatype text -optional
element create $form_name extra_par           -widget hidden -datatype text -optional
element create $form_name cod_impianto        -widget hidden -datatype text -optional
element create $form_name url_list_aimp       -widget hidden -datatype text -optional
element create $form_name url_aimp            -widget hidden -datatype text -optional
element create $form_name funzione_caller     -widget hidden -datatype text -optional;#rom01


element create $form_name submit              -widget submit -datatype text -label "$button_label" -html "class form_submit"


if {[form is_request $form_name]} {    
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name funzione_caller  -value $funzione_caller;#rom01
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name cod_impianto     -value $cod_impianto
    element set_properties $form_name url_list_aimp    -value $url_list_aimp
    element set_properties $form_name url_aimp         -value $url_aimp
    
    if {$funzione == "I"} {
	# propongo il numero del nuovo vaso con il max + 1
        db_1row query "
        select coalesce(max(num_vx),0) + 1 as num_vx 
          from coimvasi_espa_aimp
         where cod_impianto = :cod_impianto"

        element set_properties $form_name num_vx -value $num_vx

	db_1row query "select nextval('coimvasi_espa_aimp_s') as cod_vasi_espa_aimp"
	
	element set_properties $form_name cod_vasi_espa_aimp -value $cod_vasi_espa_aimp
	
    } else {

	# leggo riga
	if {[db_0or1row query "
             select a.cod_impianto
                  , a.num_vx
                  , iter_edit_num(a.capacita, 2) as capacita
                  , a.flag_aperto
                  , iter_edit_num(a.pressione, 2) as pressione
               from coimvasi_espa_aimp a
              where a.cod_vasi_espa_aimp = :cod_vasi_espa_aimp
        "] == 0
        } {
	    iter_return_complaint "Record non trovato"
	}

	element set_properties $form_name cod_vasi_espa_aimp  -value $cod_vasi_espa_aimp
	element set_properties $form_name cod_impianto        -value $cod_impianto
	element set_properties $form_name num_vx              -value $num_vx
        element set_properties $form_name capacita            -value $capacita
	element set_properties $form_name flag_aperto         -value $flag_aperto
	element set_properties $form_name pressione           -value $pressione
	
    }
}

if {[form is_valid $form_name]} {
 
    set cod_vasi_espa_aimp   [element::get_value $form_name cod_vasi_espa_aimp]
    set cod_impianto         [element::get_value $form_name cod_impianto]
    set num_vx               [element::get_value $form_name num_vx]
    set capacita             [element::get_value $form_name capacita]
    set flag_aperto          [element::get_value $form_name flag_aperto]
    set pressione            [element::get_value $form_name pressione]
   
    
    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    
    if {$funzione == "I" || $funzione == "M"} {   
		
	if {[string is space $capacita]} {
            element::set_error $form_name capacita "Inserire capacit&agrave"
            incr error_num
        } else {
            set capacita [iter_check_num $capacita 2]
            if {$capacita == "Error"} {
                element::set_error $form_name capacita "Deve essere numerico, max 2 dec"
                incr error_num
            } elseif {$capacita < 0.01} {
                element::set_error $form_name capacita "Deve essere > di 0,00"
                incr error_num
            } elseif {[iter_set_double $capacita] >=  [expr pow(10,7)]
		  ||  [iter_set_double $capacita] <= -[expr pow(10,7)]
                  } {
                element::set_error $form_name capacita "Deve essere < di 10.000.000"
                incr error_num
            }
        }

	if {[string is space $flag_aperto]} {
            element::set_error $form_name flag_aperto "Indicare se &egrave; Aperto o Chiuso"
            incr error_num
        }
     
	if {$pressione ne ""} {
            set pressione [iter_check_num $pressione 2]
            if {$pressione == "Error"} {
                element::set_error $form_name pressione "Deve essere numerico, max 2 dec"
                incr error_num
            } elseif {$pressione < 0.01} {
                element::set_error $form_name pressione "Deve essere > di 0,00"
                incr error_num
            } elseif {[iter_set_double $pressione] >=  [expr pow(10,7)]
		      ||  [iter_set_double $pressione] <= -[expr pow(10,7)]
                  } {
                element::set_error $form_name pressione "Deve essere < di 10.000.000"
                incr error_num
            }
        }
	
    }

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
		    db_dml query "
                    insert
                      into coimvasi_espa_aimp 
                         ( cod_vasi_espa_aimp
                         , cod_impianto
                         , num_vx
                         , capacita
                         , flag_aperto
                         , pressione
                         , data_ins
                         , utente_ins
                        )
                   values 
                        ( :cod_vasi_espa_aimp
                         ,:cod_impianto
                         ,:num_vx
                         ,:capacita
                         ,:flag_aperto
                         ,:pressione
                         ,:current_date
                         ,:id_utente
                      )"
		}
		M {
		    db_dml query "
                    update coimvasi_espa_aimp
                       set capacita         = :capacita
                         , flag_aperto      = :flag_aperto
                         , pressione        = :pressione
                         , data_mod         = current_date
                         , utente_mod       = :id_utente
                     where cod_vasi_espa_aimp = :cod_vasi_espa_aimp"
		}
		D {
		    db_dml query "
                    delete 
                      from coimvasi_espa_aimp
                     where cod_vasi_espa_aimp = :cod_vasi_espa_aimp"
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
    set link_gest      [export_url_vars cod_impianto cod_vasi_espa_aimp nome_funz nome_funz_caller url_list_aimp url_aimp ]
   
    #gab01 cambiato return_url per tornare al programma dei "Sistemi di distribuzione"
    #rom01 cambiato return_url per tornare al programma dei "Sistemi di distribuzione" con la funzione in cui si era prima.
    switch $funzione {
	I {set return_url   "coimaimp-sist-distribuz-gest?funzione=$funzione_caller&$link_gest"}
        V {set return_url   "coimaimp-sist-distribuz-gest?$link_list"}
        M {set return_url   "coimaimp-sist-distribuz-gest?funzione=$funzione_caller&$link_gest"}
	D {set return_url   "coimaimp-sist-distribuz-gest?funzione=$funzione_caller&$link_list"}
    }
    
    ad_returnredirect $return_url
    ad_script_abort
    
}
ad_return_template

