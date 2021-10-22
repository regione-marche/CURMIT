ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimaimp"
    @author          Adhoc
    @creation-date   18/03/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimaimp-gest.tcl
} {
    
   {cod_impianto      ""}
   {st_progressivo    ""}
   {st_data_validita  ""}
   {last_cod_impianto ""}
   {funzione         "V"}
   {caller       "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""}
   {extra_par         ""}
   {url_list_aimp2    ""}
   {url_list_aimp     ""}
   {url_aimp          ""}
   {flag_assegnazione ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# funzione = C --> copy
# funzione = A --> Assegnazione
switch $funzione {
    "V" {set lvl 1}
}

# Controlla lo user
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {[string equal $url_aimp ""]} {
    set url_aimp [list [ad_conn url]?[export_ns_set_vars url "url_list_aimp url_aimp url_list_aimp2"]]
}

if {![string equal $url_list_aimp2 ""]} {
    set url_list_aimp $url_list_aimp2
}

if {$nome_funz_caller == [iter_get_nomefunz coimmai2-filter]
&&  $url_list_aimp == ""
} {
    set url_list_aimp  [list coimmai2-filter?[export_ns_set_vars url "url_list_aimp url_aimp url_list_aimp2 nome_funz"]&nome_funz=[iter_get_nomefunz coimmai2-filter]]
}

set link_gest [export_url_vars cod_impianto st_progressivo st_data_validita last_cod_impianto nome_funz nome_funz_caller extra_par url_list_aimp url_aimp caller]

set link_mai2 [export_ns_set_vars url "url_list_aimp url_aimp url_list_aimp2 nome_funz"]&nome_funz=mai2

set link_tab [iter_links_st_form $cod_impianto $st_progressivo $nome_funz_caller $url_list_aimp $url_aimp $st_data_validita $extra_par]
set dett_tab [iter_tab_st_form $cod_impianto $st_progressivo]

set current_date      [iter_set_sysdate]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set link_dimp ""
set link_cimp ""
set link_resp ""
set link_ubic ""
set link_resp ""
set link_util ""

set classe           "func-menu"
set titolo           "Storico Impianto"
switch $funzione {
    V {set button_label "Torna alla lista"
       set page_title   "Visualizzazione $titolo"}
}

if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar  [iter_context_bar \
                     [list "javascript:window.close()" "Torna alla Gestione"] \
                     [list $url_list_aimp               "Lista Impianti"] \
                     "$page_title"]
}

iter_get_coimtgen
set valid_mod_h        $coimtgen(valid_mod_h)
set flag_cod_aimp_auto $coimtgen(flag_cod_aimp_auto)
set flag_codifica_reg  $coimtgen(flag_codifica_reg)

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimaimp"
set readonly_key "readonly"
set readonly_fld "readonly"
set readonly_cod "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
   "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
        if {$flag_cod_aimp_auto == "F"} {
	   set readonly_cod \{\}
        }
       }
   "M" {set readonly_fld \{\}
        set disabled_fld \{\}
       }
   "C" {set readonly_fld \{\}
        set disabled_fld \{\}
        if {$flag_cod_aimp_auto == "F"} {
	   set readonly_cod \{\}
        }
       }
}



form create $form_name \
-html    $onsubmit_cmd

# Valorizzo il titolo in una variabile.
# In visualizzazion verra' valorizzata con un link.
set imp_provenienza "Imp. provenienza"
element create $form_name cod_impianto_est \
-label   "cod_impianto_est" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 20 $readonly_cod {} class form_element" \
-optional

element create $form_name cod_impianto_est_prov \
-label   "cod impianto provenienza" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name provenienza_dati \
-label   "provenienza_dati" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimtppr cod_tppr descr_tppr]

element create $form_name stato \
-label   "stato" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimimst cod_imst descr_imst cod_imst]

element create $form_name cod_combustibile \
-label   "cod_combustibile" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimcomb cod_combustibile descr_comb] \

element create $form_name potenza \
-label   "potenza" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name potenza_utile \
-label   "potenza_utile" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 12 $readonly_fld {} class form_element" \
-optional

if {$funzione != "M"} {
   element create $form_name descr_potenza \
   -label   "cod_potenza" \
   -widget   text \
   -datatype text \
   -html    "size 30 readonly {} class form_element" \
   -optional
} else {
   element create $form_name cod_potenza \
   -label   "cod_potenza" \
   -widget   select \
   -datatype text \
   -html    "$disabled_fld {} class form_element" \
   -optional \
   -options [iter_selbox_from_table coimpote cod_potenza descr_potenza potenza_min]
}
   
element create $form_name cod_tpim \
-label   "tipologia" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimtpim cod_tpim descr_tpim]

element create $form_name tariffa \
-label   "tariffa" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{ } {{Riscald. superiore 100 kW} 03} {{Riscald.autonomo e acqua calda} 04} {{Riscald. centralizzato} 05} {{Riscald.central.piccoli condomini} 07}}

element create $form_name stato_conformita \
-label   "stato_conformita" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N}}

element create $form_name cod_cted \
-label   "cod_cted" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimcted cod_cted "cod_cted||' '||descr_cted"] \

element create $form_name n_generatori \
-label   "n_generatori" \
-widget   text \
-datatype text \
-html    "size 2 maxlength 2 $readonly_fld {} class form_element" \
-optional

element create $form_name consumo_annuo \
-label   "consumo_annuo" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 11 $readonly_fld {} class form_element" \
-optional

element create $form_name data_installaz \
-label   "data_installaz" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional


element create $form_name data_rottamaz \
-label   "data_rottamaz" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name data_attivaz \
-label   "data_attivaz" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_dichiarato \
-label   "Flag dichiarazione" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options { {S&igrave; S} {No N} {N.C. C}}

element create $form_name data_prima_dich \
-label   "data prima dichiarazione" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name data_ultim_dich \
-label   "data prima dichiarazione" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name data_scad_dich \
-label   "data scadenza dichiarazione" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name note \
-label   "note" \
-widget   textarea \
-datatype text \
-html    "cols 80 rows 2 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_dpr412 \
-label   "dpr 412" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N}}

element create $form_name anno_costruzione \
-label   "anno costruzione" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name marc_effic_energ \
-label   "marcatura efficienza energetica" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
-optional

element create $form_name volimetria_risc \
-label   "Volimetria riscaldata" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_targa_stampata \
-label   "targa stampata" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{S&igrave; S} {No N}}

element create $form_name portata \
-label   "portata" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 12 $readonly_fld {} class form_element" \
-optional

element create $form_name adibito_a \
-label   "adibito_a" \
-widget   text \
-datatype text \
-html    "size 50 maxlenght 500 $disabled_fld {} class form_element" \
-optional 

element create $form_name cod_tipo_attivita \
-label   "tipo attivita" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coim_tp_att cod_attivita descr_attivita]

element create $form_name cod_impianto  -widget hidden -datatype text -optional
element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_impianto -widget hidden -datatype text -optional
element create $form_name url_aimp      -widget hidden -datatype text -optional
element create $form_name url_list_aimp -widget hidden -datatype text -optional
element create $form_name scaduto       -widget hidden -datatype text -optional
element create $form_name dpr412        -widget hidden -datatype text -optional
element create $form_name desc_conf     -widget hidden -datatype text -optional
if {$funzione != "M"} {
   element create $form_name cod_potenza  -widget hidden -datatype text -optional
}
if {$funzione != "I"} {
    if {[db_0or1row sel_aimp_stato ""] == 0} {
	set stato ""
    }
    switch $stato {
	"A" {set color "green"}
	"D" {set color "yellow"}
	"L" {set color "red"}
	"N" {set color "black"}
	"R" {set color "black"}
	default {set color "gainsboro"}
    }
} else {
    set color "gainsboro"
}


if {[form is_request $form_name]} {
    element set_properties $form_name cod_impianto  -value $cod_impianto
    element set_properties $form_name funzione      -value $funzione
    element set_properties $form_name caller        -value $caller
    element set_properties $form_name nome_funz     -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par     -value $extra_par
    element set_properties $form_name last_cod_impianto -value $last_cod_impianto
    element set_properties $form_name url_aimp      -value $url_aimp
    element set_properties $form_name url_list_aimp -value $url_list_aimp

    if {$funzione == "I"} {
      # TODO: settare eventuali default!!
        set scaduto ""
    } else {
      # leggo riga
        if {[db_0or1row sel_aimp_st {}] == 0} {
            iter_return_complaint "Record non trovato"
	}



	if {$funzione == "C"} {
	    # nella funzione di copia, metto codice impianto vecchio in
	    # codice impianto di provenienza
	    set cod_impianto_prov $cod_impianto
	}

	if {[db_0or1row sel_aimp_prov ""] == 0} {
	    set cod_impianto_est_prov ""
	} else {
	    if {$funzione == "V"} {
		# se trovo l'impianto di provenienza, metto nel suo titolo
		# il link alla visualizzazione.
		# non passo il parametro url_aimp perche' conterrebbe
		# il link di ritorno alla visualizzazione dell'impianto nuovo.
		# uso javascript per posizionare e dimensionare la finestra
		set imp_provenienza "<a href=\"#\" onclick=\"javascript:window.open('coimaimp-gest?cod_impianto=$cod_impianto_prov&[export_url_vars last_cod_impianto nome_funz nome_funz_caller extra_par caller url_list_aimp]', 'Impianto_di_provenienza', 'scrollbars=yes, resizable=yes, width=760, height=500').moveTo(12,1)\">Imp. provenienza</a>"
		# questo era il link senza javascript di giulio
		# set imp_provenienza "<a href=\"coimaimp-gest?cod_impianto=$cod_impianto_prov&[export_url_vars last_cod_impianto nome_funz nome_funz_caller extra_par caller url_list_aimp]\" target=\"Impianto di provenienza\">Imp.provenienza</a>"
	    }
	}

	# reperisco il numero dei generatori, la somma della potenza focolare
        # nominael e la somma della potenza utile nominale dai generatori e se 
        # non corrispondono a quelle inseriti visualizzo un messaggio di errore
	db_1row sel_count_generatori ""

	if {$count_generatori != $n_generatori} {
	    element::set_error $form_name n_generatori "<font color=red><b>Incongruenza generatori ($count_generatori)</b></font>"
	} 
	if {[iter_check_num $potenza 2] != $tot_pot_focolare_nom} {
	    element::set_error $form_name potenza "Incongruenza generatori (kW [iter_edit_num $tot_pot_focolare_nom 2])"
	} 
	if {[iter_check_num $potenza_utile 2] != $tot_pot_utile_nom} {
	    element::set_error $form_name potenza_utile "Incongruenza generatori (kW [iter_edit_num $tot_pot_utile_nom 2])"
	}

	if {$flag_dichiarato == "S"} {
	    if {[iter_check_date $data_scad_dich] < [iter_set_sysdate]
                && ![string equal $data_scad_dich ""]} {
		set scaduto "<font color=red><b>Scaduto</b></font>"
	    } else {
		set scaduto ""
	    }
	} else {
	    set scaduto ""
	}

	if {$stato_conformita == "N"} {
	    set desc_conf "<font color=red><b>Conformit&agrave;</b></font>"
	} else {
	    set desc_conf "Conformit&agrave;"
	}

	switch $flag_dpr412 {
	    "S" {set dpr412 "<font color=green><b>Sottopon. D.P.R. 412</b></font>" }
	    "N" {set dpr412 "<font color=red><b>Sottopon. D.P.R. 412</b></font>" }
	    default {set dpr412 "<font color=black><b>Sottopon. D.P.R. 412</b></font>" }
	}

	if {$funzione == "C"} {
	    if {$flag_cod_aimp_auto == "F"} {
		db_1row sel_cod_aimp_est ""
	    } else {
		set cod_impianto_est ""
	    }
	    set stato "A"
	    if {![string equal $data_rottamaz ""]} {
		set data_installaz $data_rottamaz
	    }
	    set data_rottamaz ""
	}

	element set_properties $form_name data_rottamaz    -value $data_rottamaz
	element set_properties $form_name stato            -value $stato
	element set_properties $form_name desc_conf        -value $desc_conf
        element set_properties $form_name scaduto          -value $scaduto
        element set_properties $form_name dpr412           -value $dpr412
	element set_properties $form_name cod_impianto_est -value $cod_impianto_est
	
        element set_properties $form_name cod_impianto_est_prov -value $cod_impianto_est_prov
        element set_properties $form_name cod_impianto     -value $cod_impianto
        element set_properties $form_name provenienza_dati -value $provenienza_dati
        element set_properties $form_name cod_combustibile -value $cod_combustibile
        element set_properties $form_name potenza          -value $potenza
        element set_properties $form_name potenza_utile    -value $potenza_utile
        element set_properties $form_name portata          -value $portata
        if {$funzione != "M"} {
           element set_properties $form_name descr_potenza -value $descr_potenza
        }
        element set_properties $form_name cod_potenza      -value $cod_potenza
        element set_properties $form_name cod_tpim        -value $cod_tpim

        element set_properties $form_name tariffa          -value $tariffa
        element set_properties $form_name stato_conformita -value $stato_conformita
        element set_properties $form_name cod_cted         -value $cod_cted
        element set_properties $form_name n_generatori     -value $n_generatori
        element set_properties $form_name consumo_annuo    -value $consumo_annuo
        element set_properties $form_name data_installaz   -value $data_installaz

        element set_properties $form_name data_attivaz     -value $data_attivaz
        element set_properties $form_name flag_dichiarato  -value $flag_dichiarato
        element set_properties $form_name data_prima_dich  -value $data_prima_dich
        element set_properties $form_name data_ultim_dich  -value $data_ultim_dich
        element set_properties $form_name data_scad_dich   -value $data_scad_dich
        element set_properties $form_name note             -value $note
        element set_properties $form_name flag_dpr412      -value $flag_dpr412
	element set_properties $form_name anno_costruzione -value $anno_costruzione
	element set_properties $form_name marc_effic_energ -value $marc_effic_energ
        element set_properties $form_name volimetria_risc  -value $volimetria_risc
        element set_properties $form_name flag_targa_stampata  -value $flag_targa_stampata
        element set_properties $form_name adibito_a  -value $adibito_a
        element set_properties $form_name cod_tipo_attivita  -value $cod_tipo_attivita

    }
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system


    set cod_impianto_est [string trim [element::get_value $form_name cod_impianto_est]]
    set cod_impianto     [string trim [element::get_value $form_name cod_impianto]]
    set cod_impianto_est_prov [string trim [element::get_value $form_name cod_impianto_est_prov]]
    set provenienza_dati [string trim [element::get_value $form_name provenienza_dati]]
    set stato            [string trim [element::get_value $form_name stato]]
    set cod_tpim         [string trim [element::get_value $form_name cod_tpim]]
    set tariffa          [string trim [element::get_value $form_name tariffa]]
    set stato_conformita [string trim [element::get_value $form_name stato_conformita]]
    set cod_cted         [string trim [element::get_value $form_name cod_cted]]
    set n_generatori     [string trim [element::get_value $form_name n_generatori]]
    set consumo_annuo    [string trim [element::get_value $form_name consumo_annuo]]
    set cod_combustibile [string trim [element::get_value $form_name cod_combustibile]]
    set potenza          [string trim [element::get_value $form_name potenza]]
    set potenza_utile    [string trim [element::get_value $form_name potenza_utile]]
    set portata          [string trim [element::get_value $form_name portata]]
    if {$funzione != "M"} {
	set descr_potenza [string trim [element::get_value $form_name descr_potenza]]
    }
    set cod_potenza      [string trim [element::get_value $form_name cod_potenza]]
    set data_installaz   [string trim [element::get_value $form_name data_installaz]]
    set data_rottamaz    [string trim [element::get_value $form_name data_rottamaz]]
    set data_attivaz     [string trim [element::get_value $form_name data_attivaz]]
    set flag_dichiarato  [string trim [element::get_value $form_name flag_dichiarato]]
    set data_prima_dich  [string trim [element::get_value $form_name data_prima_dich]]
    set data_ultim_dich  [string trim [element::get_value $form_name data_ultim_dich]]
    set data_scad_dich   [string trim [element::get_value $form_name data_scad_dich]]
    set note             [string trim [element::get_value $form_name note]]
    set scaduto          [string trim [element::get_value $form_name scaduto]]
    set dpr412           [string trim [element::get_value $form_name dpr412]]
    set desc_conf        [string trim [element::get_value $form_name desc_conf]]
    set flag_dpr412      [string trim [element::get_value $form_name flag_dpr412]]
    # controlli standard su numeri e date, per Ins ed Upd
    set anno_costruzione [string trim [element::get_value $form_name anno_costruzione]]
    set marc_effic_energ [string trim [element::get_value $form_name marc_effic_energ]]
    set volimetria_risc  [string trim [element::get_value $form_name volimetria_risc]]
    set flag_targa_stampata  [string trim [element::get_value $form_name flag_targa_stampata]]
    set adibito_a  [string trim [element::get_value $form_name adibito_a]]
    set cod_tipo_attivita  [string trim [element::get_value $form_name cod_tipo_attivita]]

    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    ||  $funzione == "C"
    } {

	if {[string equal $flag_dpr412 ""]} {
	    element::set_error $form_name flag_dpr412 "Inserire"
	    incr error_num	    
	}

	if {$flag_cod_aimp_auto == "F"} {
	    if {[string equal $cod_impianto_est ""]} {
		element::set_error $form_name cod_impianto_est "Inserire il codice impianto"
		incr error_num
	    } else {
		if {[db_0or1row check_aimp ""] == 1} {
		    element::set_error $form_name cod_impianto_est "Esiste gi&agrave; un altro impianto con questo codice"
		    incr error_num
		}
	    }
	}

        if {[string equal $data_installaz ""]} {
	    element::set_error $form_name data_installaz "Inserire Data inst."
	    incr error_num
	} else {
            set data_installaz [iter_check_date $data_installaz]
            if {$data_installaz == 0} {
                element::set_error $form_name data_installaz "Data installazione deve essere una data"
                incr error_num
            } else {
		if {$data_installaz > $current_date} {
		    element::set_error $form_name data_installaz "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {![string equal $data_rottamaz ""]} {
            set data_rottamaz [iter_check_date $data_rottamaz]
            if {$data_rottamaz == 0} {
                element::set_error $form_name data_rottamaz "Data rottamazione deve essere una data"
                incr error_num
            } else {
		if {$data_rottamaz > $current_date} {
		    element::set_error $form_name data_rottamaz "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
	    set stato "R"
        }
     
        set flag_potenza_ok "f"
        if {![string equal $potenza ""]} {
            set potenza [iter_check_num $potenza 2]
            if {$potenza == "Error"} {
                element::set_error $form_name potenza "numerico con al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $potenza] >=  [expr pow(10,7)]
                ||  [iter_set_double $potenza] <= -[expr pow(10,7)]} {
                    element::set_error $form_name potenza "deve essere < di 10.000.000"
                    incr error_num
                } else {
		    set flag_potenza_ok "t"
		}
                set potenza_tot $potenza
		if {$flag_potenza_ok == "t"
 		&&  [db_0or1row check_fascia_pote ""]== 0} {
		    element::set_error $form_name potenza "non &egrave; compresa in nessuna fascia"
		    incr error_num
		}           
            }
        }

        set flag_potenza_ok "f"
        if {[string equal $potenza_utile ""]} {
	    set potenza_utile 0
	} else {
            set potenza_utile [iter_check_num $potenza_utile 2]
            if {$potenza_utile == "Error"} {
                element::set_error $form_name potenza_utile "numerico con al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $potenza_utile] >=  [expr pow(10,7)]
                ||  [iter_set_double $potenza_utile] <= -[expr pow(10,7)]} {
                    element::set_error $form_name potenza_utile "deve essere < di 10.000.000"
                    incr error_num
                } else {
		    set flag_potenza_ok "t"
		}
                set potenza_tot $potenza_utile
		if {$flag_potenza_ok == "t"
 		&&  [db_0or1row check_fascia_pote ""]== 0} {
		    element::set_error $form_name potenza_utile "non &egrave; compresa in nessuna fascia"
		    incr error_num
		}           
            }
        }

        if {[string equal $portata ""]} {
	    set portata 0
	} else {
            set portata [iter_check_num $portata 2]
            if {$portata == "Error"} {
                element::set_error $form_name portata "numerico con al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $portata] >=  [expr pow(10,7)]
                ||  [iter_set_double $portata] <= -[expr pow(10,7)]} {
                    element::set_error $form_name portata "deve essere < di 10.000.000"
                    incr error_num
                }
            }
        }

        if {![string equal $potenza ""]
	    && $potenza != "Error"} {
	    set potenza_tot $potenza
	    if {![string equal $cod_potenza ""]} {
               if {[db_0or1row check_fascia_pote2 ""]== 0} {
		    element::set_error $form_name potenza "non compresa nella fascia di potenza"
		    incr error_num
	       }
	    } else {
		if {[db_0or1row assegna_fascia ""]==0} {
		    element::set_error $form_name potenza "nessuna fascia disponibile"
		    incr error_num		
		}
	    }
	} else {
	    if {[string equal $cod_potenza ""]} {
	       element::set_error $form_name potenza "inserire potenza o fascia"
	       incr error_num
	    }

	}

	if {![string equal $cod_potenza ""]
	    && [string equal $potenza ""]} {
	    if {[db_0or1row sel_pote ""] == 0} {
		set potenza 0
	    }
	}

        if {![string equal $n_generatori ""]} {
            set n_generatori [iter_check_num $n_generatori 0]
            if {$n_generatori == "Error"} {
                element::set_error $form_name n_generatori "deve essere numerico"
                incr error_num
	    }
	}

        if {[string equal $consumo_annuo ""]} {
	    set consumo_annuo 0
	} else {
            set consumo_annuo [iter_check_num $consumo_annuo 2]
            if {$consumo_annuo == "Error"} {
                element::set_error $form_name consumo_annuo "numerico con al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $consumo_annuo] >=  [expr pow(10,7)]
                ||  [iter_set_double $consumo_annuo] <= -[expr pow(10,7)]} {
                    element::set_error $form_name consumo_annuo "deve essere < di 10.000.000"
                    incr error_num
		}
            }
        }

        if {![string equal $data_attivaz ""]} {
            set data_attivaz [iter_check_date $data_attivaz]
            if {$data_attivaz == 0} {
                element::set_error $form_name data_attivaz "Data attivazione deve essere una data"
                incr error_num
            } else {
		if {$data_attivaz > $current_date} {
		    element::set_error $form_name data_attivaz "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

	set flag_data "S"
        if {[string equal $data_prima_dich ""]
          &&[string equal $flag_dichiarato "S"]} {
            element::set_error $form_name data_prima_dich "Inserire data"
            incr error_num
	    set flag_data "N"
	}

#        if {![string equal $data_prima_dich ""]
#          &&[string equal $flag_dichiarato "N"]} {
#            element::set_error $form_name data_prima_dich "Non inserire"
#            incr error_num
#	    set flag_data "N"
#	}

        if {[string equal $data_ultim_dich ""]
          &&[string equal $flag_dichiarato "S"]} {
            element::set_error $form_name data_ultim_dich "Inserire data"
            incr error_num
	}

#        if {![string equal $data_ultim_dich ""]
#          &&[string equal $flag_dichiarato "N"]} {
#            element::set_error $form_name data_ultim_dich "Non inserire"
#            incr error_num
#	}

        if {[string equal $data_scad_dich ""]
          &&[string equal $flag_dichiarato "S"]} {
            element::set_error $form_name data_scad_dich "Inserire data"
            incr error_num
	}

        if {![string equal $data_prima_dich ""]} {
            set data_prima_dich [iter_check_date $data_prima_dich]
            if {$data_prima_dich == 0} {
                element::set_error $form_name data_prima_dich "Data non corretta"
                incr error_num
		set flag_data "N"
            } else {
		if {$data_prima_dich > $current_date} {
		    element::set_error $form_name data_prima_dich "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {![string equal $data_ultim_dich ""]} {
            set data_ultim_dich [iter_check_date $data_ultim_dich]
            if {$data_ultim_dich == 0} {
                element::set_error $form_name data_ultim_dich "Data non corretta"
                incr error_num
            } else {
		if {$data_ultim_dich > $current_date} {
		    element::set_error $form_name data_ultim_dich "Data deve essere anteriore alla data odierna"
		    incr error_num
		} else {
		    if {$flag_data == "S"
			&& $data_prima_dich > $data_ultim_dich} {
			element::set_error $form_name data_ultim_dich "Non minore di data inizio"
			incr error_num
		    }
		}
	    }
        }

        if {![string equal $data_scad_dich ""]} {
            set data_scad_dich [iter_check_date $data_scad_dich]
            if {$data_scad_dich == 0} {
                element::set_error $form_name data_scad_dich "Data non corretta"
                incr error_num
            }
        }

	if {![string equal $cod_impianto_est_prov ""]} {
            if {$cod_impianto_est == $cod_impianto_est_prov} {
		element::set_error $form_name cod_impianto_est_prov "Impianto di provenienza non pu&ograve; essere lo stesso impianto"
                incr error_num
	    } else {
		# oltre al controllo con questa query preparo la variabile
		# cod_impianto_prov che verra' inserita
		if {[db_0or1row check_aimp_prov ""] == 0} {
		    element::set_error $form_name cod_impianto_est_prov "Impianto inesistente"
		    incr error_num
		}
	    }
	} else {
	    set cod_impianto_prov ""
	}

        if {![string equal $anno_costruzione ""]} {
            set anno_costruzione [iter_check_date $anno_costruzione]
            if {$anno_costruzione == 0} {
                element::set_error $form_name anno_costruzione "Data non corretta"
                incr error_num
            } else {
		if {$anno_costruzione > $current_date} {
		    element::set_error $form_name anno_costruzione "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {[string equal $volimetria_risc ""]} {
	    set volimetria_risc 0
	} else {
            set volimetria_risc [iter_check_num $volimetria_risc 2]
            if {$volimetria_risc == "Error"} {
                element::set_error $form_name volimetria_risc "numerico con al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $volimetria_risc] >=  [expr pow(10,7)]
                ||  [iter_set_double $volimetria_risc] <= -[expr pow(10,7)]} {
                    element::set_error $form_name volimetria_risc "deve essere < di 10.000.000"
                    incr error_num
		}
            }
        }
    }

    if {$funzione == "D"} {
        set message ""
	db_1row sel_count_dimp ""
	if {$count_dimp > 0} {
	    append message "<br>dei modelli H correlati;"
            incr error_num
	}

	db_1row sel_count_cimp ""
	if {$count_cimp > 0} {
	    append message "<br>dei rapporti di verifica correlati;"
            incr error_num
	}

	db_1row sel_count_gend ""
	if {$count_gend > 0} {
	    append message "<br>dei generatori correlati;"            
	    incr error_num
	}

	db_1row sel_count_inco ""
	if {$count_inco > 0} {
	    append message "<br>degli appuntamenti predisposti;"
            incr error_num
	}
	db_1row sel_count_prvv ""
	if {$count_prvv > 0} {
	    append message "<br>dei provvedimenti correlati;"
            incr error_num
	}
	db_1row sel_count_movi ""
	if {$count_movi > 0} {
	    append message "<br>dei pagamenti correlati;"
            incr error_num
	}

	db_1row sel_count_todo ""
	if {$count_todo > 0} {
	    append message "<br>delle attivit&agrave; sospese correlate"
            incr error_num
	}

	db_1row sel_count_docu ""
	if {$count_docu > 0} {
	    append message "<br>dei documenti correlati"
	}

	if {![string equal $message ""]} {
	    set message "L'impianto non si pu&ograve; cancellare, sono presenti: $message"
	    element::set_error $form_name note $message
	}
    }

    # se sono in assegnazione dell'impianto (funzione per manutentori) 
    # aggiorno il manutentore e aggiorno lo storico dei soggetti
    if {$error_num > 0} {
        ad_return_template
        return
    }

    switch $funzione {
        M { if {$flag_cod_aimp_auto == "F"} {
	        set cod_aimp_est [db_map udp_aimp_est]
	    } else {
		set cod_aimp_est ""
            }
	    set dml_sql  [db_map upd_aimp]}
        D {set dml_sql  [db_map del_aimp]}
        C {
	   if {$flag_cod_aimp_auto == "T"} {
	       if {$flag_codifica_reg == "T"} {
		   db_1row sel_dati_codifica ""
		   if {![string equal $potenza "0.00"]} {
		       if {$potenza < 35} {
			   set tipologia "IN"
		       } else {
			   set tipologia "CT"
		       }
		       set cod_impianto_est "$cod_istat$tipologia$progressivo"
		       set dml_comu [db_map upd_prog_comu]
		   } else {
		       if {![string equal $cod_potenza "0"]
			&& ![string equal $cod_potenza ""]} { 
			   switch $cod_potenza {
			       "B"  {set tipologia "IN"}
			       "A"  {set tipologia "CT"}
			       "MA" {set tipologia "CT"}
			       "MB" {set tipologia "CT"}
			   }

			   set cod_impianto_est "$cod_istat$tipologia$progressivo"
			   set dml_comu [db_map upd_prog_comu]
		       } else {
			   set cod_impianto_est ""
		       }
		   }
	       } else {
		   db_1row get_cod_impianto_est ""
	       }
	   }
	   db_1row sel_cod_aimp     ""
           set dml_sql  [db_map ins_aimp]
	   set dml_gend [db_map ins_gend]
	}

    }

  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {
        with_catch error_msg {
            db_transaction {
                db_dml dml_coimaimp $dml_sql
                if {[info exists dml_gend]} {
		    db_dml dml_coimaimp $dml_gend
		}
                if {[info exists dml_comu]} {
		    db_dml dml_coimcomu $dml_comu
		}
            }
        } {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
 	}
    }

    set link_gest [export_url_vars cod_impianto last_cod_impianto nome_funz nome_funz_caller extra_par url_list_aimp url_aimp caller]


    if {$nome_funz_caller != [iter_get_nomefunz coimaimp-isrt-veloce]} {
	set link_del $url_list_aimp
    } else {
        set link_del "coimaimp-isrt-veloce?nome_funz=$nome_funz_caller"
    }

    switch $funzione {
        M {set return_url   "coimaimp-gest?funzione=V&$link_gest"}
        D {set return_url   $link_del}
        I {set return_url   "coimaimp-gest?funzione=V&$link_gest"}
        C {set cod_impianto $cod_aimp
	   set link_copy [export_url_vars cod_impianto nome_funz_caller nome_funz last_cod_impianto  extra_par url_list_aimp]
           set return_url   "coimaimp-gest?funzione=V&$link_copy"} 
        V {set return_url   $url_list_aimp}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
