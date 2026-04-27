ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimfatt"
    @author          Adhoc
    @creation-date   27/10/2005

    @cvs-id          coimfatt-gest.tcl

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    sim04  25/07/2017 Gestito nuovo campo flag_split_payment

    sim03  05/05/2016 Corretto bug su importo pagato nullo

    sim01  14/03/2016 Per ASET (CFANO) l'aliquota iva è 0.

    nic02  09/01/2014 Sistemato per segnalazione di Chiara Paravan di Ucit: nella context_bar
    nic02             compariva Gestione Amministrativa che andava in errore.
    nic02             Lo rendo coerente con la lista fatture e manutentori.

    nic01  02/01/2014 Corretta numerazione fatture: ad inizio 2014 continuava dall'ultima
                      dell'anno precedente

} {
    {ordboll_id       ""}
    {url_dimp         ""}
    {url_boll         ""}
    {cod_responsabile ""}
    {data_consegna    ""}
    {cod_manutentore  ""}
    {cod_sogg         ""}   
    {tipo_sogg        ""}
    {cod_fatt         ""}
    {last_cod_fatt    ""}
    {last_data_fatt   ""}
    {cod_bollini      ""} 
    {funzione        "V"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {extra_par        ""}
    {cod_impianto     ""}
    {riferimento_pag  ""}
    {spe_postali      ""}
    {spe_legali       ""}
    {f_cod_manu       ""}
    {f_num_fatt       ""}
    {f_da_data_fatt   ""}
    {f_a_data_fatt    ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
set id_utente [auth::require_login]

if {$ordboll_id ne "" && $funzione eq "I"} {
    # deve essere non fatturato
    if {[db_0or1row query "select cod_fatt from coimboll where ordboll_id = :ordboll_id and cod_fatt is not null limit 1"]} {
	ad_return_complaint 1 "Bollino gia' fatturato."
    }
}

set ritorna_gest ""
if {$extra_par ne ""} {
    set ritorna_gest [lindex $extra_par 1]
} else {
    if {$url_boll ne ""} {
	set ritorna_gest $url_boll
    }
    if {$url_dimp ne ""} {
	set ritorna_gest $url_dimp
    }
}

iter_get_coimtgen;#sim01
set ente $coimtgen(ente);#sim01

set link_gest [export_url_vars cod_sogg tipo_sogg cod_fatt last_cod_fatt last_data_fatt nome_funz nome_funz_caller extra_par caller f_cod_manu f_num_fatt f_da_data_fatt f_a_data_fatt]
set link_list_fatt [export_url_vars f_cod_manu f_num_fatt f_da_data_fatt f_a_data_fatt]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
# TODO: controllare impostazione della context_bar adattando come necessario
set link_list_script {[export_url_vars cod_sogg last_cod_fatt last_data_fatt cod_fatt tipo_sogg caller nome_funz_caller nome_funz f_cod_manu f_num_fatt f_da_data_fatt f_a_data_fatt]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

if {$url_boll ne "" || $url_dimp ne ""} {
    if {$url_boll ne ""} {     
	set extra_par [list url_boll $url_boll]
    }
    if {$url_dimp ne ""} {     
	set extra_par [list url_dimp $url_dimp]
    }
}

set titolo "Fattura"
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


if {$nome_funz_caller eq ""} {;#nic02
    set context_bar [iter_context_bar -nome_funz $nome_funz_caller \
                         [list / "Home"] \
                         [list /iter-portal "Portale dei Manutentori verso ITER"] \
			 [list coimfatt-filter?$link_list_fatt "Filtro Fatture"] \
			 [list coimfatt-list?$link_list "Lista Fatture"] \
			 "$page_title"]
    #set context_bar [iter_context_bar -nome_funz $nome_funz_caller]
} else {;#nic02
    set context_bar [iter_context_bar \
                         [list / "Home"] \
                         [list /iter-portal "Portale dei Manutentori verso ITER"] \
                         "$page_title"];#nic01
};#nic02

set form_name    "coimfatt"
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

if {$funzione eq "I"} {
#nic01 db_1row query "select max(data_fatt) as data_1 from coimfatt" 
    db_1row query "select coalesce(max(to_number(num_fatt,'9999999999')),0) as num_fatt
                     from coimfatt
                    where id_utente <> '1522'
         -- nic01     and to_char(data_fatt,'yyyy') > '2012'
                      and to_char(data_fatt,'yyyy') = to_char(current_date,'yyyy') -- nic01
                   "

    set num_fatt [expr $num_fatt + 1]
}

form create $form_name \
    -html    $onsubmit_cmd

element create $form_name data_fatt \
    -label   "data_fatt" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name num_fatt \
    -label   "num_fatt" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name manutentore \
    -label   "manutentore" \
    -widget   text \
    -datatype text \
    -html    "size 50 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name imponibile \
    -label   "imponibile" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name importo \
    -label   "importo" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name perc_iva \
    -label   "perc_iva" \
    -widget   text \
    -datatype text \
    -html    "size 6 maxlength 6 $readonly_fld {} class form_element" \
    -optional

element create $form_name spe_legali \
    -label   "spe_legali" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name spe_postali \
    -label   "spe_postali" \
    -widget   text \
    -datatype text \
    -html    "size 10  maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_pag_edit \
    -label   "data pagamento" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name importo_pag_edit \
    -label   "importo pagamento" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name flag_pag \
    -label   "flag_pag" \
    -widget   select \
    -datatype text \
    -html    "size 1 maxlength 1 $readonly_fld {} class form_element" \
    -optional \
    -options {{{} {}} {Si S} {No N}}

element create $form_name n_bollini1 \
    -label   "n_bollini" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name matr_da1 \
    -label   "matr_da" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name matr_a1 \
    -label   "matr_a" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name imp_pagato1 \
    -label   "importo pagato" \
    -widget   text \
    -datatype text \
    -html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
    -optional

element create $form_name n_bollini2 \
    -label   "n_bollini" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name matr_da2 \
    -label   "matr_da" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name matr_a2 \
    -label   "matr_a" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name imp_pagato2 \
    -label   "importo pagato" \
    -widget   text \
    -datatype text \
    -html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
    -optional

element create $form_name n_bollini3 \
    -label   "n_bollini" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name matr_da3 \
    -label   "matr_da" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name matr_a3 \
    -label   "matr_a" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name imp_pagato3 \
    -label   "importo pagato" \
    -widget   text \
    -datatype text \
    -html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
    -optional
element create $form_name n_bollini4 \
    -label   "n_bollini" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name matr_da4 \
    -label   "matr_da" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name matr_a4 \
    -label   "matr_a" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
    -optional

element create $form_name imp_pagato4 \
    -label   "importo pagato" \
    -widget   text \
    -datatype text \
    -html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
    -optional

element create $form_name n_bollini \
    -label   "n_bollini" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 readonly {} class form_element" \
    -optional

element create $form_name nota \
    -label   "nota" \
    -widget   textarea \
    -datatype text \
    -html    "cols 40 rows 5 $readonly_fld {} class form_element" \
    -optional

element create $form_name desc_fatt \
    -label   "desc_fatt" \
    -widget   textarea \
    -datatype text \
    -html    "cols 40 rows 3 $readonly_fld {} class form_element" \
    -optional

element create $form_name mod_pag \
    -label   "mod_pag" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 200 $readonly_fld {} class form_element" \
    -optional

element create $form_name flag_split_payment \
    -label   "Split payment" \
    -widget   select \
    -datatype text \
    -html    "size 1 maxlength 1 $readonly_fld {} class form_element" \
    -optional \
    -options {{{} {}} {Si S} {No N}}

element create $form_name cod_manutentore  -widget hidden -datatype text -optional
element create $form_name data_consegna    -widget hidden -datatype text -optional
element create $form_name ordboll_id       -widget hidden -datatype text -optional
element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par        -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_fatt    -widget hidden -datatype text -optional
element create $form_name last_data_fatt   -widget hidden -datatype text -optional
element create $form_name cod_fatt         -widget hidden -datatype text -optional
element create $form_name tipo_sogg        -widget hidden -datatype text -optional
element create $form_name cod_sogg         -widget hidden -datatype text -optional

set cerca_sogg ""
if {$funzione eq "I" || $funzione eq "M"} {  
    switch $tipo_sogg {
	"M" { set cerca_sogg [iter_search $form_name coimmanu-list [list dummy cod_sogg dummy manutentore dummy manutentore]] }
	"C" { set cerca_sogg [iter_search $form_name coimcitt-list [list dummy cod_sogg dummy manutentore dummy manutentore]] }
    }
}

if {[form is_request $form_name]} {

    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name ordboll_id       -value $ordboll_id
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_cod_fatt    -value $last_cod_fatt
    element set_properties $form_name last_data_fatt   -value $last_data_fatt
    element set_properties $form_name cod_fatt         -value $cod_fatt
    element set_properties $form_name tipo_sogg        -value $tipo_sogg

    if {$funzione eq "I"} {
	db_1row sel_date "select to_char(current_date, 'dd/mm/yyyy') as current_date"
        element set_properties $form_name data_fatt        -value $current_date	

        if {$ente eq "CFANO"} {#sim01: aggiunta if e suo contenuto
            element set_properties $form_name perc_iva     -value "0";#sim01
        } else {#sim01
            element set_properties $form_name perc_iva     -value "22"
        };#sim01

        element set_properties $form_name num_fatt         -value $num_fatt
	element set_properties $form_name spe_postali      -value $spe_postali
	element set_properties $form_name spe_legali       -value $spe_legali

	if { $tipo_sogg eq "C"} {
 	    element set_properties $form_name importo      -value "8"
	    element set_properties $form_name flag_pag     -value "S"
	    element set_properties $form_name n_bollini    -value "1"
	}

        if {[db_0or1row sel_boll {}]} {
            element set_properties $form_name tipo_sogg   -value "M"
            element set_properties $form_name cod_sogg    -value $cod_manutentore
	    element set_properties $form_name manutentore -value $manutentore
        }

        element set_properties $form_name cod_manutentore  -value $cod_manutentore
        element set_properties $form_name data_consegna    -value $data_consegna

        set flag_pagato "S"
        set tot_num_bol 0
        set totale 0

        db_foreach query "
            select nr_bollini as numero_bollini
                  ,matricola_da
                  ,matricola_a
          --sim03 ,imp_pagato
                  ,coalesce(imp_pagato,0) as imp_pagato --sim03
                  ,cod_tpbo
                  ,pagati
            from coimboll
            where cod_manutentore = :cod_manutentore
            and data_consegna     = :data_consegna
            and ordboll_id        = :ordboll_id
        " {
            switch $cod_tpbo {
                "1" {
                    element set_properties $form_name n_bollini1    -value $numero_bollini
                    element set_properties $form_name matr_da1      -value $matricola_da
                    element set_properties $form_name matr_a1       -value $matricola_a
                    set imp_pagatoed [iter_edit_num $imp_pagato 2]
                    element set_properties $form_name imp_pagato1   -value $imp_pagatoed
                }
                "2" {
                    element set_properties $form_name n_bollini2    -value $numero_bollini
                    element set_properties $form_name matr_da2      -value $matricola_da
                    element set_properties $form_name matr_a2       -value $matricola_a
                    set imp_pagatoed [iter_edit_num $imp_pagato 2]
                    element set_properties $form_name imp_pagato2   -value $imp_pagatoed
                }
                "3" {
                    element set_properties $form_name n_bollini3    -value $numero_bollini
                    element set_properties $form_name matr_da3      -value $matricola_da
                    element set_properties $form_name matr_a3       -value $matricola_a
                    set imp_pagatoed [iter_edit_num $imp_pagato 2]
                    element set_properties $form_name imp_pagato3   -value $imp_pagatoed
                }
                "4" {
                    element set_properties $form_name n_bollini4    -value $numero_bollini
                    element set_properties $form_name matr_da4      -value $matricola_da
                    element set_properties $form_name matr_a4       -value $matricola_a
                    set imp_pagatoed [iter_edit_num $imp_pagato 2]
                    element set_properties $form_name imp_pagato4   -value $imp_pagatoed
                }
            }
	    
            if {$pagati ne "S"} {
                set flag_pagato "N"
            }
            set totale [expr $totale + $imp_pagato]
            set tot_num_bol [expr $tot_num_bol + $numero_bollini]
        }

	if {$ente eq "CFANO"} {#sim01: aggiunta if e suo contenuto
	    #ASET ha aliquota iva 0% (escluso articolo 15)
	    set impon $totale
	} else {#sim01
	    set impon  [expr $totale * 100.00 / 122.00]
	};#sim01

	# set impon    [expr $totale * 100.00 / [expr $perc_iva + 100.00]]
        set imponibile [iter_edit_num $impon 2]
        set importo    [iter_edit_num $totale 2]
        set calc_bol   [iter_edit_num $tot_num_bol 0]

        element set_properties $form_name importo      -value $importo
        element set_properties $form_name n_bollini    -value $calc_bol
        element set_properties $form_name imponibile   -value $imponibile
        
        if {$flag_pagato eq "S"} {
            element set_properties $form_name flag_pag  -value "S"
            element set_properties $form_name mod_pag   -value "Pagato"
        } else {
            element set_properties $form_name flag_pag  -value "N"
            element set_properties $form_name mod_pag   -value "60 gg d.f.f.m."
        }
	
    } else {
	# leggo riga
        if {[db_0or1row sel_fatt {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

        db_foreach query "
            select nr_bollini, matricola_da, matricola_a, imp_pagato, cod_tpbo, pagati
            from coimboll
            where cod_fatt = :cod_fatt
        " {
            switch $cod_tpbo {
                "1" {
                    element set_properties $form_name n_bollini1    -value $nr_bollini
                    element set_properties $form_name matr_da1      -value $matricola_da
                    element set_properties $form_name matr_a1       -value $matricola_a
                    set imp_pagatoed [iter_edit_num $imp_pagato 2]
                    element set_properties $form_name imp_pagato1   -value $imp_pagatoed
                }
                "2" {
                    element set_properties $form_name n_bollini2    -value $nr_bollini
                    element set_properties $form_name matr_da2      -value $matricola_da
                    element set_properties $form_name matr_a2       -value $matricola_a
                    set imp_pagatoed [iter_edit_num $imp_pagato 2]
                    element set_properties $form_name imp_pagato2   -value $imp_pagatoed
                }
                "3" {
                    element set_properties $form_name n_bollini3    -value $nr_bollini
                    element set_properties $form_name matr_da3      -value $matricola_da
                    element set_properties $form_name matr_a3       -value $matricola_a
                    set imp_pagatoed [iter_edit_num $imp_pagato 2]
                    element set_properties $form_name imp_pagato3   -value $imp_pagatoed
                }
                "4" {
                    element set_properties $form_name n_bollini4    -value $nr_bollini
                    element set_properties $form_name matr_da4      -value $matricola_da
                    element set_properties $form_name matr_a4       -value $matricola_a
                    set imp_pagatoed [iter_edit_num $imp_pagato 2]
                    element set_properties $form_name imp_pagato4   -value $imp_pagatoed
                }
            }
        }

        element set_properties $form_name data_fatt        -value $data_fatt
        element set_properties $form_name num_fatt         -value $num_fatt
	element set_properties $form_name tipo_sogg        -value $tipo_sogg
        element set_properties $form_name data_pag_edit    -value $data_pag_edit
        element set_properties $form_name importo_pag_edit -value $importo_pag_edit
	element set_properties $form_name flag_split_payment -value $flag_split_payment;#sim04

	if {$tipo_sogg eq "M"} {
	    element set_properties $form_name manutentore  -value $manutentore_manu
	} else {
	    element set_properties $form_name manutentore  -value $manutentore_manu
	}
        element set_properties $form_name imponibile   -value $imponibile
        element set_properties $form_name importo      -value $importo
        element set_properties $form_name spe_legali   -value $spe_legali
        element set_properties $form_name spe_postali  -value $spe_postali
        element set_properties $form_name perc_iva     -value $perc_iva
        element set_properties $form_name flag_pag     -value $flag_pag
        element set_properties $form_name n_bollini    -value $n_bollini
        element set_properties $form_name mod_pag      -value $mod_pag
        element set_properties $form_name nota         -value $nota
        element set_properties $form_name cod_sogg     -value $cod_sogg
	#element set_properties $form_name desc_fatt    -value $desc_fatt
    }
}

if {$funzione ne "I"} {
    set link_stampa "nome_funz=[iter_get_nomefunz coimfatt-layout]&[export_url_vars cod_fatt cod_sogg tipo_sogg]"
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system

    set data_fatt        [element::get_value $form_name data_fatt]
    set num_fatt         [element::get_value $form_name num_fatt]
    set data_pag_edit    [element::get_value $form_name data_pag_edit]
    set importo_pag_edit [element::get_value $form_name importo_pag_edit]
    set manutentore      [element::get_value $form_name manutentore]
    set imponibile       [element::get_value $form_name imponibile]
    set importo          [element::get_value $form_name importo]
    set spe_legali       [element::get_value $form_name spe_legali]
    set spe_postali      [element::get_value $form_name spe_postali]
    set perc_iva         [element::get_value $form_name perc_iva]
    set flag_pag         [element::get_value $form_name flag_pag]
    set n_bollini        [element::get_value $form_name n_bollini]
    set mod_pag          [element::get_value $form_name mod_pag]
    set nota             [element::get_value $form_name nota]
    set desc_fatt        [element::get_value $form_name desc_fatt]
    set cod_sogg         [element::get_value $form_name cod_sogg]
    set matr_da          ""
    set matr_a           ""
    set flag_split_payment [element::get_value $form_name flag_split_payment];#sim04
    
    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione eq "I" || $funzione eq "M"} {

        if {[string equal $data_fatt ""]} {
            element::set_error $form_name data_fatt "Inserire data fattura"
            incr error_num
        } else {
            set data_fatt [iter_check_date $data_fatt]
            if {$data_fatt == 0} {
                element::set_error $form_name data_fatt "La data fattura deve essere una data"
                incr error_num
            }
        }

        if {[string equal $num_fatt ""]} {
            element::set_error $form_name num_fatt "Inserire numero fattura"
            incr error_num
        }

        if {[string equal $imponibile ""]} {
            element::set_error $form_name imponibile "Inserire imponibile"
            incr error_num
	} else {
            set imponibile [iter_check_num $imponibile 2]
            if {$imponibile eq "Error"} {
                element::set_error $form_name imponibile "L'imponibile deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $imponibile] >= [expr pow(10,6)] || [iter_set_double $imponibile] <= -[expr pow(10,6)]} {
                    element::set_error $form_name imponibile "L'imponibile deve essere inferiore di 1.000.000"
                    incr error_num
                }
            }
        }

        if {[string equal $importo ""]} {
            element::set_error $form_name importo "Inserire importo"
            incr error_num
	} else {
            set importo [iter_check_num $importo 2]
            if {$importo eq "Error"} {
                element::set_error $form_name importo "L'importo deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $importo] >= [expr pow(10,6)] || [iter_set_double $importo] <= -[expr pow(10,6)]} {
                    element::set_error $form_name importo "L'importo deve essere inferiore di 1.000.000"
                    incr error_num
                }
            }
        }

        if {![string equal $data_pag_edit ""]} {
            set data_pag [iter_check_date $data_pag_edit]
            if {$data_pag == 0} {
                element::set_error $form_name data_pag_edit "Deve essere una data"
                incr error_num
            }
        } else {
	    set data_pag ""
	}
        if {![string equal $importo_pag_edit ""]} {
            set importo_pag [iter_check_num $importo_pag_edit 2]
            if {$importo_pag eq "Error"} {
                element::set_error $form_name importo_pag_edit "L'importo deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
	    }
	} else {
	    set importo_pag ""
	}

	if {![string equal $spe_legali ""]} {
            set spe_legali [iter_check_num $spe_legali 2]
            if {$spe_legali eq "Error"} {
                element::set_error $form_name spe_legali "Spesa Legale deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $spe_legali] >= [expr pow(10,6)] || [iter_set_double $spe_legali] <= -[expr pow(10,6)]} {
                    element::set_error $form_name spe_legali "Spesa legale deve essere inferiore di 1.000.000"
                    incr error_num
                }
	    }
	}
	
        if {![string equal $spe_postali ""]} {
            set spe_postali [iter_check_num $spe_postali 2]
            if {$spe_postali eq "Error"} {
                element::set_error $form_name spe_postali "Spesa Postale deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $spe_postali] >= [expr pow(10,6)] || [iter_set_double $spe_postali] <= -[expr pow(10,6)]} {
                    element::set_error $form_name spe_postali "Spesa postale deve essere inferiore di 1.000.000"
                    incr error_num
                }
	    }
	}

        if {[string equal $perc_iva ""]} {
            element::set_error $form_name perc_iva "Inserire percentuale iva"
            incr error_num
	} else {
            set perc_iva [iter_check_num $perc_iva 2]
            if {$perc_iva eq "Error"} {
                element::set_error $form_name perc_iva "La percentuale iva deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $perc_iva] >= [expr pow(10,2)] || [iter_set_double $perc_iva] <= -[expr pow(10,2)]} {
                    element::set_error $form_name perc_iva "La percentuale iva deve essere inferiore di 100"
                    incr error_num
                }
            }
        }

	#routine generica per controllo codice manutentore
	set check_cod_sogg {
	    set chk_out_rc       0
	    set chk_out_msg      ""
	    set chk_out_cod_sogg ""
	    set ctr_sogg         0
	    if {[string equal $chk_inp_manutentore ""]} {
		set eq_manutentore "is null"
	    } else {
		set eq_manutentore "= upper(:chk_inp_manutentore)"
	    }
	    switch $tipo_sogg {
		"M" { db_foreach sel_sogg_manu "" {
		    incr ctr_sogg
		    if {$cod_sogg_db == $chk_inp_cod_sogg} {
			set chk_out_cod_sogg $cod_sogg_db
			set chk_out_rc       1
		    }
		}
		}
		"C" { db_foreach sel_sogg_citt "" {
		    incr ctr_sogg
		    if {$cod_sogg_db == $chk_inp_cod_sogg} {
			set chk_out_cod_sogg $cod_sogg_db
			set chk_out_rc       1
		    }
		}
		}
	    }

	    switch $ctr_sogg {
		0 { set chk_out_msg "Soggetto non trovato"}
		1 { set chk_out_cod_sogg $cod_sogg_db
		    set chk_out_rc       1 }
		default {
		    if {$chk_out_rc == 0} {
			set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		    }
		}
	    }
	}
	
	if {[string equal $manutentore ""]} {
	    set cod_sogg ""
	} else {
	    set chk_inp_cod_sogg $cod_sogg
	    set chk_inp_manutentore  $manutentore
	    eval $check_cod_sogg
	    set cod_sogg  $chk_out_cod_sogg
	    if {$chk_out_rc == 0} {
		element::set_error $form_name manutentore $chk_out_msg
		incr error_num
	    }
	}

	if {$funzione eq "M"} {
	    set where_mod " and cod_fatt <> :cod_fatt"
	} else {
	    set where_mod ""
	}
	if {[db_0or1row sel_num_check ""] == 1} {
	    element::set_error $form_name num_fatt "Il numero fattura &egrave gi&agrave presente nell'anno inserito"
	    incr error_num
	}
    }

    if {$funzione eq "I" && $error_num == 0 &&  [db_0or1row sel_fatt_check {}] == 1} {
	# controllo univocita'/protezione da double_click
        element::set_error $form_name cod_fatt "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    if {$funzione eq "I" || $funzione eq "M"} {
	# imposto la data di scadenza a 60 gg d.f.f.m.
	set data_scad_temp [db_string query "select to_char(:data_fatt::date + interval '2 months', 'yyyy-mm-dd')"]
	set data_scadenza  [ah::month_end $data_scad_temp]
    } else {
	set data_scadenza ""
    }

    set bollini [list]
    db_foreach query "
            select cod_bollini
            from coimboll
            where cod_manutentore = :cod_manutentore
            and data_consegna     = :data_consegna
            and ordboll_id        = :ordboll_id
    " {
	lappend  bollini $cod_bollini
    }

    db_transaction {
	switch $funzione {
	    I { db_1row sel_cod_fatt ""
		set dml_sql [db_map ins_fatt]
		db_dml query $dml_sql
		foreach cod_bollini $bollini {
		    db_dml query "update coimboll
                                     set cod_fatt = :cod_fatt
                                       , data_scadenza = :data_scadenza
                                   where cod_bollini = :cod_bollini"
		}
	    }
	    M {set dml_sql [db_map upd_fatt]
		db_dml query $dml_sql
	    }
	    D {set dml_sql [db_map del_fatt]
		db_dml query "update coimboll set cod_fatt = null where cod_fatt = :cod_fatt"
		db_dml query $dml_sql
	    }
	}
    }
    
    # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione eq "I"} {
        set last_cod_fatt $cod_fatt
	set last_data_fatt $data_fatt
    }

    set link_list [subst $link_list_script]
    set link_gest [export_url_vars cod_fatt cod_sogg tipo_sogg last_cod_fatt last_data_fatt nome_funz nome_funz_caller extra_par caller ordboll_id]

    switch $funzione {
	M {set return_url "coimfatt-gest?funzione=V&$link_gest"}
	D {set return_url "coimfatt-list?$link_list"}
	I {set return_url "coimfatt-gest?funzione=V&$link_gest"}
	V {set return_url "coimfatt-list?$link_list"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
