ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimaimp" - Libretto - 6. Sistemi di distribuzione
    @author          Gabriele Lo Vaglio - clonato da coimaimp-tratt-acqua-gest
    @creation-date   11/07/2016
    
    @param funzione  M=edit V=view
    
    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz_caller identifica l'entrata di menu, serve per la 
    @                navigazione con navigation bar
    
    @param extra_par Variabili extra da restituire alla lista
    
    @cvs-id          coimaimp_sist_distribuz-gest.tcl
    
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom01 04/09/2018 Aggiunto campo flag_sostituito nella lista "Pompe di Calore"

    gab01 16/08/2016 Aggiunte liste "Vasi di Espansione" e "Pompe di Calore"
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
set url_vars_per_coimaimp_gest_e_list [export_url_vars cod_impianto nome_funz nome_funz_caller caller cod_impianto_url_aimp url_list_aimp];#gab01

set funzione_caller $funzione;#rom02
set gest_prog_1     "coimvasi-espa-aimp-gest";#gab01
set gest_prog_2     "coimpomp-circ-aimp-gest";#gab01
#rom02 aggiunto &funzione_caller=$funzione_caller
set link_aggiungi_1 "<a href=\"$gest_prog_1?funzione=I&funzione_caller=$funzione_caller&$url_vars_per_coimaimp_gest_e_list\">Aggiungi</a>";#gab01
#rom02 aggiunto &funzione_caller=$funzione_caller
set link_aggiungi_2 "<a href=\"$gest_prog_2?funzione=I&funzione_caller=$funzione_caller&$url_vars_per_coimaimp_gest_e_list\">Aggiungi</a>";#gab01

set link_1  "\[export_url_vars cod_vasi_espa_aimp\]&$url_vars_per_coimaimp_gest_e_list";#gab01
set link_2  "\[export_url_vars cod_pomp_circ_aimp\]&$url_vars_per_coimaimp_gest_e_list";#gab01
#rom02 aggiunto funzione_caller
set actions_1 "<td nowrap><a href=\"$gest_prog_1?funzione=V&funzione_caller=$funzione_caller&$link_1\">Selez.</a>";#gab01
#rom02 aggiunto funzione_caller
set actions_2 "<td nowrap><a href=\"$gest_prog_2?funzione=V&funzione_caller=$funzione_caller&$link_2\">Selez.</a>";#gab01

set table_def_1 [list \
                     [list actions_1            "Azioni"                    no_sort $actions_1] \
                     [list num_vx               "Num"                       no_sort {l}] \
                     [list flag_aperto          "Aperto?"                   no_sort {c}] \
                     [list capacita             "Capacit&agrave;"           no_sort {c}] \
                     [list pressione            "Pressione"                 no_sort {c}] \
		    ];#gab01

#rom01 aggiunto flag_sostituito
set table_def_2 [list \
                     [list actions_2            "Azioni"                    no_sort $actions_2] \
                     [list num_po               "Num"                       no_sort {l}] \
                     [list data_installaz       "Data Installazione"        no_sort {c}] \
                     [list data_dismissione     "Data Dismissione"          no_sort {c}] \
		     [list flag_sostituito      "Sostituito"                no_sort {c}] \
                     [list descr_cost           "Costruttore"               no_sort {l}] \
                     [list modello              "Modello"                   no_sort {l}] \
                     [list flag_giri_variabili  "Giri Variabili"            no_sort {c}] \
                     [list pot_nom              "Potenza Nominale"          no_sort {c}] \
		    ];#gab01

set sel_vasi_espa_aimp [db_map sel_vasi_espa_aimp];#gab01
set sel_pomp_circ_aimp [db_map sel_pomp_circ_aimp];#gab01

set table_result_1 [ad_table -Tmissing_text "Non &egrave; presente nessun Vaso di Espansione." -Textra_vars {cod_vasi_espa_aimp cod_impianto caller nome_funz nome_funz_caller url_list_aimp url_aimp } go $sel_vasi_espa_aimp $table_def_1];#gab01

set table_result_2 [ad_table -Tmissing_text "Non &egrave; presente nessuna Pompa di Circolazione " -Textra_vars {cod_pomp_circ_aimp cod_impianto caller nome_funz nome_funz_caller url_list_aimp url_aimp } go $sel_pomp_circ_aimp $table_def_2];#gab01

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}
set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set titolo           "Sistemi di Distribuzione"
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

element create $form_name sistem_dist_tipo \
    -label   "Tipo di Distribuzione" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {"Verticale a colonne montanti" V} {"Orizzontale a zone" O} {"Canali d'aria" C} {"Altro" A}}


element create $form_name sistem_dist_note_altro \
    -label   "Note altro" \
    -widget   textarea \
    -datatype text \
    -html    "cols 100 rows 2 $readonly_fld {} class form_element" \
    -optional

element create $form_name sistem_dist_coibentazione_flag \
    -label   "Coibentazione rete di distribuzione" \
    -widget   select \
    -datatype text \
    -html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
    -optional \
    -options {{"" ""} {Assente A} {Presente P}}

element create $form_name sistem_dist_note \
    -label   "Note" \
    -widget   textarea \
    -datatype text \
    -html    "cols 100 rows 3 $readonly_fld {} class form_element" \
    -optional
 
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
        select a.sistem_dist_tipo
             , a.sistem_dist_note_altro
             , a.sistem_dist_coibentazione_flag
             , a.sistem_dist_note
          from coimaimp a
         where a.cod_impianto = :cod_impianto
        "] == 0
    } {
	iter_return_complaint "Record non trovato"
    }
    
    element set_properties $form_name cod_impianto                   -value $cod_impianto
    element set_properties $form_name sistem_dist_tipo               -value $sistem_dist_tipo
    element set_properties $form_name sistem_dist_note_altro         -value $sistem_dist_note_altro
    element set_properties $form_name sistem_dist_coibentazione_flag -value $sistem_dist_coibentazione_flag
    element set_properties $form_name sistem_dist_note               -value $sistem_dist_note
    
}

if {[form is_valid $form_name]} {
    set cod_impianto                   [element::get_value $form_name cod_impianto]
    set sistem_dist_tipo               [element::get_value $form_name sistem_dist_tipo]
    set sistem_dist_note_altro         [string trim [element::get_value $form_name sistem_dist_note_altro]]
    set sistem_dist_coibentazione_flag [element::get_value $form_name sistem_dist_coibentazione_flag]
    set sistem_dist_note               [string trim [element::get_value $form_name sistem_dist_note]]
    
    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    
    if {$funzione == "M"} {   
	
	if {$sistem_dist_tipo eq "A" && [string is space $sistem_dist_note_altro]} {
	    template::form::set_error $form_name sistem_dist_note_altro "Compilare \"Note Altro\" specificando il tipo di distribuzione alternativo"
	    incr error_num
	} 
	
	if {$sistem_dist_tipo ne "A" && ![string is space $sistem_dist_note_altro]} {
            template::form::set_error $form_name sistem_dist_note_altro "Compilare solo in caso di tipo distribuzione = \"Altro\""
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
                       set sistem_dist_tipo               = :sistem_dist_tipo
                         , sistem_dist_note_altro         = :sistem_dist_note_altro
                         , sistem_dist_coibentazione_flag = :sistem_dist_coibentazione_flag
                         , sistem_dist_note               = :sistem_dist_note
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
	M {set return_url   "coimaimp-sist-distribuz-gest?funzione=V&$link_gest"}
    }
    
    ad_returnredirect $return_url
    ad_script_abort
    
}
ad_return_template
