ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimfatt"
    @author          Adhoc
    @creation-date   27/10/2005

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimfatt-gest.tcl

    USER   DATA         MODIFICHE
    ====   ==========  ===========================================================
    gab02  15/03/2017  Rimesse le spese postali presenti nel programma standard.

    gab01  24/02/2017  Modifiche per gestione doppia IVA vendita bollini.
    gab01              Sui record dei bollini è presente la nuova variabile che contiene 
    gab01              la percentuale iva da utilizzare.
    gab01              Il programma è stato diviso in due sezioni: una per i bollini 
    gab01              con iva 10% e l'altra con quelli a iva 22%.
   
    
} {
   {url_dimp ""}
   {url_boll ""}
   {cod_responsabile ""}
   {cod_manutentore ""}
   {data_consegna ""}
   {cod_sogg ""}   
   {tipo_sogg ""}
   {cod_fatt ""}
   {last_cod_fatt ""}
   {last_data_fatt ""}
   {cod_bollini ""} 
   {funzione  "V"}
   {caller    "index"}
   {nome_funz ""}
   {nome_funz_caller ""}
   {extra_par ""}
   {cod_impianto ""}
   {riferimento_pag ""}
    {spe_postali ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}
set pippo "pippo"
# Controlla lo user
# TODO: controllare il livello richiesto,
# Se il programma e' 'delicato', mettere livello 5 (amministratore).
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set ritorna_gest ""
if {$extra_par != ""} {
    set ritorna_gest [lindex $extra_par 1]
} else {
    if {$url_boll != ""} {
	set ritorna_gest $url_boll
    }
    if {$url_dimp != ""} {
	set ritorna_gest $url_dimp
    }
}
#ns_return 200 text/html "-$url_dimp-<br>-$url_boll-<br>-$ritorna_boll-"; return
set link_gest [export_url_vars cod_sogg tipo_sogg cod_fatt last_cod_fatt last_data_fatt nome_funz nome_funz_caller extra_par caller]


# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
# TODO: controllare impostazione della context_bar adattando come necessario
set link_list_script {[export_url_vars cod_sogg last_cod_fatt last_data_fatt cod_fatt tipo_sogg caller nome_funz_caller nome_funz]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
if {$url_boll != ""
    || $url_dimp != ""} {
    if {$url_boll != ""} {     
	set extra_par       [list url_boll        $url_boll]
    }
    if {$url_dimp != ""} {     
	set extra_par       [list url_dimp        $url_dimp]
    }
}

set titolo           "fattura"
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

# TODO: se la lista che richiama questo programma e' un pgm di zoom
#       attivare la seguente if

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

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

if {$funzione == "I"} {
    db_1row query "select max(to_number(num_fatt,'9999999999')) as num_fatt
                     from coimfatt
                    where to_char(data_fatt,'yyyy') = to_char(current_date,'yyyy')"
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

element create $form_name cognome \
-label   "cognome" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name nome \
-label   "nome" \
-widget   text \
-datatype text \
-html    "size 30 maxlength 40 $readonly_fld {} class form_element" \
-optional

#gab01 sezione con iva 10%
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

element create $form_name n_bollini5 \
-label   "n_bollini" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_da5 \
-label   "matr_da" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_a5 \
-label   "matr_a" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name imp_pagato5 \
-label   "importo pagato" \
-widget   text \
-datatype text \
-html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
-optional

element create $form_name n_bollini6 \
-label   "n_bollini" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_da6 \
-label   "matr_da" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_a6 \
-label   "matr_a" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name imp_pagato6 \
-label   "importo pagato" \
-widget   text \
-datatype text \
-html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
-optional


element create $form_name n_bollini7 \
-label   "n_bollini" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_da7 \
-label   "matr_da" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_a7 \
-label   "matr_a" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name imp_pagato7 \
-label   "importo pagato" \
-widget   text \
-datatype text \
-html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
-optional

#gab01 sezione con iva 22%
#gab01 ------inizio---------
element create $form_name n_bollini1_sec_iva \
-label   "n_bollini" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_da1_sec_iva \
-label   "matr_da" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_a1_sec_iva \
-label   "matr_a" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name imp_pagato1_sec_iva \
-label   "importo pagato" \
-widget   text \
-datatype text \
-html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
-optional

element create $form_name n_bollini2_sec_iva \
-label   "n_bollini" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_da2_sec_iva \
-label   "matr_da" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_a2_sec_iva \
-label   "matr_a" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name imp_pagato2_sec_iva \
-label   "importo pagato" \
-widget   text \
-datatype text \
-html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
-optional

element create $form_name n_bollini3_sec_iva \
-label   "n_bollini" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_da3_sec_iva \
-label   "matr_da" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_a3_sec_iva \
-label   "matr_a" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name imp_pagato3_sec_iva \
-label   "importo pagato" \
-widget   text \
-datatype text \
-html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
-optional
element create $form_name n_bollini4_sec_iva \
-label   "n_bollini" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_da4_sec_iva \
-label   "matr_da" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_a4_sec_iva \
-label   "matr_a" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name imp_pagato4_sec_iva \
-label   "importo pagato" \
-widget   text \
-datatype text \
-html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
-optional

element create $form_name n_bollini5_sec_iva \
-label   "n_bollini" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_da5_sec_iva \
-label   "matr_da" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_a5_sec_iva \
-label   "matr_a" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name imp_pagato5_sec_iva \
-label   "importo pagato" \
-widget   text \
-datatype text \
-html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
-optional

element create $form_name n_bollini6_sec_iva \
-label   "n_bollini" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name n_bollini7_sec_iva \
-label   "n_bollini" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_da7_sec_iva \
-label   "matr_da" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name matr_a7_sec_iva \
-label   "matr_a" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 20 $readonly_fld {} class form_element" \
-optional

element create $form_name imp_pagato7_sec_iva \
-label   "importo pagato" \
-widget   text \
-datatype text \
-html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
-optional

#gab01 -----fine------

element create $form_name n_bollini \
-label   "n_bollini" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 readonly {} class form_element" \
-optional

element create $form_name imponibile \
-label   "imponibile" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 readonly {} class form_element" \
-optional

#gab01 tolto il campo perc_iva
#element create $form_name perc_iva \
#-label   "perc_iva" \
#-widget   text \
#-datatype text \
#-html    "size 6 maxlength 6 $readonly_fld {} class form_element" \
#-optional

#gab02
element create $form_name spe_postali \
-label   "spe_postali" \
-widget   text \
-datatype text \
-html    "size 10  maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name flag_pag \
-label   "flag_pag" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $readonly_fld {} class form_element" \
-optional \
-options {{{} {}} {Si S} {No N}}

#gab01 trasformo il campo mod_pag in una combo con i campi della tabella coimtp_pag 
element create $form_name mod_pag \
-label   "Modalità di pagamento" \
-widget   select \
-datatype text \
-html    "$readonly_fld {} class form_element" \
-options [iter_selbox_from_table coimtp_pag descrizione descrizione] 

element create $form_name nota \
-label   "nota" \
-widget   textarea \
-datatype text \
-html    "cols 40 rows 5 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_manutentore  -widget hidden -datatype text -optional
element create $form_name data_consegna  -widget hidden -datatype text -optional
element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_fatt -widget hidden -datatype text -optional
element create $form_name last_data_fatt -widget hidden -datatype text -optional
element create $form_name cod_fatt  -widget hidden -datatype text -optional
element create $form_name tipo_sogg -widget hidden -datatype text -optional
element create $form_name cod_sogg  -widget hidden -datatype text -optional

set cerca_sogg ""

if {$funzione == "I"
||  $funzione == "M"
} {  
    switch $tipo_sogg {
	"M" { set cerca_sogg [iter_search $form_name coimmanu-list [list dummy cod_sogg dummy cognome dummy nome]] 
	}
	"C" { set cerca_sogg [iter_search $form_name coimcitt-list [list dummy cod_sogg dummy cognome dummy nome]] 
	}
    }
} 


if {[form is_request $form_name]} {

    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_cod_fatt    -value $last_cod_fatt
    element set_properties $form_name last_data_fatt   -value $last_data_fatt
    element set_properties $form_name cod_fatt         -value $cod_fatt
    element set_properties $form_name tipo_sogg        -value $tipo_sogg

    if {$funzione == "I"} {
      # TODO: settare eventuali default!!
	db_1row sel_date "select to_char(current_date, 'dd/mm/yyyy') as current_date"
        element set_properties $form_name data_fatt      -value $current_date
        db_1row q "select max(num_fatt::integer + 1) as num_fatt from coimfatt" ;#gab01 il numero fattura si compila automaticamnete in fase di inserimento
        element set_properties $form_name num_fatt      -value $num_fatt ;#gab01	
	#gab01 deve essere usata la perc_iva della tabella coimboll
        #element set_properties $form_name perc_iva       -value "10"
        element set_properties $form_name spe_postali   -value $spe_postali;#gab02

	if {[db_0or1row sel_boll {}] == 1} {
      	    element set_properties $form_name tipo_sogg    -value "M"
	    element set_properties $form_name cod_sogg     -value $cod_manutentore
	    element set_properties $form_name cognome      -value $cognome_manu
	    element set_properties $form_name nome         -value $nome_manu
            element set_properties $form_name spe_postali  -value $spe_postali;#gab02
	}
	
	set flag_pagato "S"	
	set tot_imp 0
	set tot_num_bol 0
	
	element set_properties $form_name cod_manutentore  -value $cod_manutentore
	element set_properties $form_name data_consegna    -value $data_consegna

	db_foreach query { 
	    select nr_bollini  
                   ,matricola_da 
                   ,matricola_a 
                   ,imp_pagato 
	           ,cod_tpbo  
                   ,pagati
                   ,perc_iva --gab01
	    from coimboll
	    where cod_manutentore = :cod_manutentore
	    and data_consegna     = :data_consegna
            and cod_fatt is null --gab01
            and cod_tpbo is not null
	} {
	    switch $cod_tpbo {
		"1" {
                    if {$perc_iva == 10} {;#gab01 aggiunta if
			element set_properties $form_name n_bollini1    -value $nr_bollini
			element set_properties $form_name matr_da1      -value $matricola_da
			element set_properties $form_name matr_a1       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato1   -value $imp_pagatoed
                    } elseif {$perc_iva == 22} {;#gab01 aggiunto elseif e contenuto
			element set_properties $form_name n_bollini1_sec_iva    -value $nr_bollini
			element set_properties $form_name matr_da1_sec_iva      -value $matricola_da
			element set_properties $form_name matr_a1_sec_iva       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato1_sec_iva   -value $imp_pagatoed
		    }
		}
		"2" {
                    if {$perc_iva == 10} {;#gab01 aggiunta if 
			element set_properties $form_name n_bollini2    -value $nr_bollini
			element set_properties $form_name matr_da2      -value $matricola_da
			element set_properties $form_name matr_a2       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato2   -value $imp_pagatoed
                    } elseif {$perc_iva == 22} {;#gab01 aggiunto elseif e contenuto
			element set_properties $form_name n_bollini2_sec_iva    -value $nr_bollini
			element set_properties $form_name matr_da2_sec_iva      -value $matricola_da
			element set_properties $form_name matr_a2_sec_iva       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato2_sec_iva   -value $imp_pagatoed	
		    }
		}
		"3" {
		    if {$perc_iva == 10} {;#gab01 aggiunta if 
			element set_properties $form_name n_bollini3    -value $nr_bollini
			element set_properties $form_name matr_da3      -value $matricola_da
			element set_properties $form_name matr_a3       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato3   -value $imp_pagatoed
		    } elseif {$perc_iva == 22} {;#gab01 aggiunto elseif e contenuto
                        element set_properties $form_name n_bollini3_sec_iva    -value $nr_bollini
                        element set_properties $form_name matr_da3_sec_iva      -value $matricola_da
                        element set_properties $form_name matr_a3_sec_iva       -value $matricola_a
                        set imp_pagatoed [iter_edit_num $imp_pagato 2]
                        element set_properties $form_name imp_pagato3_sec_iva   -value $imp_pagatoed
                    }
		}
                "4" {
                    if {$perc_iva == 10} {;#gab01 aggiunta if
			element set_properties $form_name n_bollini4    -value $nr_bollini
			element set_properties $form_name matr_da4      -value $matricola_da
			element set_properties $form_name matr_a4       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato4   -value $imp_pagatoed
		    } elseif {$perc_iva == 22} {;#gab01 aggiunto elseif e contenuto
                        element set_properties $form_name n_bollini4_sec_iva    -value $nr_bollini
                        element set_properties $form_name matr_da4_sec_iva      -value $matricola_da
                        element set_properties $form_name matr_a4_sec_iva       -value $matricola_a
                        set imp_pagatoed [iter_edit_num $imp_pagato 2]
                        element set_properties $form_name imp_pagato4_sec_iva   -value $imp_pagatoed
                    }
		}
		"5" {
                    if {$perc_iva == 10} {;#gab01 aggiunta if
			element set_properties $form_name n_bollini5    -value $nr_bollini
			element set_properties $form_name matr_da5      -value $matricola_da
			element set_properties $form_name matr_a5       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato5   -value $imp_pagatoed
		    } elseif {$perc_iva == 22} {;#gab01 aggiunto elseif e contenuto
                        element set_properties $form_name n_bollini5_sec_iva    -value $nr_bollini
                        element set_properties $form_name matr_da5_sec_iva      -value $matricola_da
                        element set_properties $form_name matr_a5_sec_iva       -value $matricola_a
                        set imp_pagatoed [iter_edit_num $imp_pagato 2]
                        element set_properties $form_name imp_pagato5_sec_iva   -value $imp_pagatoed
                    }
		}		
		"6" {
		    element set_properties $form_name n_bollini6    -value $nr_bollini
		    element set_properties $form_name matr_da6      -value $matricola_da
		    element set_properties $form_name matr_a6       -value $matricola_a
		    set imp_pagatoed [iter_edit_num $imp_pagato 2]
                    element set_properties $form_name imp_pagato6   -value $imp_pagatoed
		}
		"7" {
                    if {$perc_iva == 10} {;#gab01 aggiunta if
			element set_properties $form_name n_bollini7    -value $nr_bollini
			element set_properties $form_name matr_da7      -value $matricola_da
			element set_properties $form_name matr_a7       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato7   -value $imp_pagatoed
		    } elseif {$perc_iva == 22} {;#gab01 aggiunto elseif e contenuto
                        element set_properties $form_name n_bollini7_sec_iva    -value $nr_bollini
                        element set_properties $form_name matr_da7_sec_iva      -value $matricola_da
                        element set_properties $form_name matr_a7_sec_iva       -value $matricola_a
                        set imp_pagatoed [iter_edit_num $imp_pagato 2]
                        element set_properties $form_name imp_pagato7_sec_iva   -value $imp_pagatoed
                    }
		}
	    }
	
           if {$imp_pagato  == ""} {
             set imp_pagato  0
           }

	    if {$pagati != "S"
	    } {
		set flag_pagato "N"
	    }
            set tot_imp [expr $tot_imp + $imp_pagato]
            set tot_num_bol [expr $tot_num_bol + $nr_bollini]
   
	}

	
	set calc_imp [iter_edit_num $tot_imp 2]
	set calc_bol [iter_edit_num $tot_num_bol 0]
        element set_properties $form_name imponibile   -value $calc_imp
        element set_properties $form_name n_bollini    -value $calc_bol

	if {$flag_pagato == "S"
	} {
            element set_properties $form_name flag_pag   -value "S"
            #gab01 element set_properties $form_name mod_pag    -value "Pagato"
	} else {
	    element set_properties $form_name flag_pag   -value "N"
            #gab01 element set_properties $form_name mod_pag    -value "Pagamento alla trasmissione del RCEE come previsto dal Regolamento Regionale"
	}

    } else {

      # leggo riga
        if {[db_0or1row sel_fatt {}] == 0} {
            iter_return_complaint "Record non trovato"
	}

	db_foreach query { 
	    select nr_bollini  
                   ,matricola_da
                   ,matricola_a 
                   ,imp_pagato   
	           ,cod_tpbo    
                   ,pagati
                   ,perc_iva --gab01     
	    from coimboll
	    where cod_fatt = :cod_fatt
              and cod_tpbo is not null 
        } {
	    switch $cod_tpbo {
		"1" {
                    if {$perc_iva == 10} {;#gab01 aggiunta if
			element set_properties $form_name n_bollini1    -value $nr_bollini
			element set_properties $form_name matr_da1      -value $matricola_da
			element set_properties $form_name matr_a1       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato1   -value $imp_pagatoed
		    } elseif {$perc_iva == 22} {;#gab01 aggiunto elseif e contenuto
                        element set_properties $form_name n_bollini1_sec_iva    -value $nr_bollini
                        element set_properties $form_name matr_da1_sec_iva      -value $matricola_da
                        element set_properties $form_name matr_a1_sec_iva       -value $matricola_a
                        set imp_pagatoed [iter_edit_num $imp_pagato 2]
                        element set_properties $form_name imp_pagato1_sec_iva   -value $imp_pagatoed
                    }
                }
		"2" {
		    if {$perc_iva == 10} {;#gab01 aggiunta if 
			element set_properties $form_name n_bollini2    -value $nr_bollini
			element set_properties $form_name matr_da2      -value $matricola_da
			element set_properties $form_name matr_a2       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato2   -value $imp_pagatoed
                    } elseif {$perc_iva == 22} {;#gab01 aggiunto elseif e contenuto
                        element set_properties $form_name n_bollini2_sec_iva    -value $nr_bollini
                        element set_properties $form_name matr_da2_sec_iva      -value $matricola_da
                        element set_properties $form_name matr_a2_sec_iva       -value $matricola_a
                        set imp_pagatoed [iter_edit_num $imp_pagato 2]
                        element set_properties $form_name imp_pagato2_sec_iva   -value $imp_pagatoed
		    }
		}
		"3" {
                    if {$perc_iva == 10} {;#gab01 aggiunta if 
			element set_properties $form_name n_bollini3    -value $nr_bollini
			element set_properties $form_name matr_da3      -value $matricola_da
			element set_properties $form_name matr_a3       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato3   -value $imp_pagatoed
		    } elseif {$perc_iva == 22} {;#gab01 aggiunto elseif e contenuto
                        element set_properties $form_name n_bollini3_sec_iva    -value $nr_bollini
                        element set_properties $form_name matr_da3_sec_iva      -value $matricola_da
                        element set_properties $form_name matr_a3_sec_iva       -value $matricola_a
                        set imp_pagatoed [iter_edit_num $imp_pagato 2]
                        element set_properties $form_name imp_pagato3_sec_iva   -value $imp_pagatoed
                    }
                } 
                "4" {
		    if {$perc_iva == 10} {;#gab01 aggiunta if
			element set_properties $form_name n_bollini4    -value $nr_bollini
			element set_properties $form_name matr_da4      -value $matricola_da
			element set_properties $form_name matr_a4       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato4   -value $imp_pagatoed
		    } elseif {$perc_iva == 22} {;#gab01 aggiunto elseif e contenuto
                        element set_properties $form_name n_bollini4_sec_iva    -value $nr_bollini
                        element set_properties $form_name matr_da4_sec_iva      -value $matricola_da
                        element set_properties $form_name matr_a4_sec_iva       -value $matricola_a
                        set imp_pagatoed [iter_edit_num $imp_pagato 2]
                        element set_properties $form_name imp_pagato4_sec_iva   -value $imp_pagatoed
                    }
		}
		"5" {
                    if {$perc_iva == 10} {;#gab01 aggiunta if
			element set_properties $form_name n_bollini5    -value $nr_bollini
			element set_properties $form_name matr_da5      -value $matricola_da
			element set_properties $form_name matr_a5       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato5   -value $imp_pagatoed
		    } elseif {$perc_iva == 22} {;#gab01 aggiunto elseif e contenuto
                        element set_properties $form_name n_bollini5_sec_iva    -value $nr_bollini
                        element set_properties $form_name matr_da5_sec_iva      -value $matricola_da
                        element set_properties $form_name matr_a5_sec_iva       -value $matricola_a
                        set imp_pagatoed [iter_edit_num $imp_pagato 2]
                        element set_properties $form_name imp_pagato5_sec_iva   -value $imp_pagatoed
                    }
		}
		"6" {
		    element set_properties $form_name n_bollini6    -value $nr_bollini
		    element set_properties $form_name matr_da6      -value $matricola_da
		    element set_properties $form_name matr_a6       -value $matricola_a
		    set imp_pagatoed [iter_edit_num $imp_pagato 2]
                    element set_properties $form_name imp_pagato6   -value $imp_pagatoed
		}
		"7" {
                    if {$perc_iva == 10} {;#gab01 aggiunta if
			element set_properties $form_name n_bollini7    -value $nr_bollini
			element set_properties $form_name matr_da7      -value $matricola_da
			element set_properties $form_name matr_a7       -value $matricola_a
			set imp_pagatoed [iter_edit_num $imp_pagato 2]
			element set_properties $form_name imp_pagato7   -value $imp_pagatoed
		    } elseif {$perc_iva == 22} {;#gab01 aggiunto elseif e contenuto
                        element set_properties $form_name n_bollini7_sec_iva    -value $nr_bollini
                        element set_properties $form_name matr_da7_sec_iva      -value $matricola_da
                        element set_properties $form_name matr_a7_sec_iva       -value $matricola_a
                        set imp_pagatoed [iter_edit_num $imp_pagato 2]
                        element set_properties $form_name imp_pagato7_sec_iva   -value $imp_pagatoed
                    }
		}
	    }
	}
    
        element set_properties $form_name data_fatt  -value $data_fatt
        element set_properties $form_name num_fatt   -value $num_fatt
	element set_properties $form_name tipo_sogg  -value $tipo_sogg
        element set_properties $form_name spe_postali -value $spe_postali ;#gab02

	if {$tipo_sogg == "M"
	} {
	    element set_properties $form_name cognome    -value $cognome_manu
	    element set_properties $form_name nome       -value $nome_manu
	} else {
	    element set_properties $form_name cognome    -value $cognome_citt
	    element set_properties $form_name nome       -value $nome_citt
	}
        element set_properties $form_name imponibile -value $imponibile
        #gab01 element set_properties $form_name perc_iva   -value $perc_iva
        element set_properties $form_name flag_pag   -value $flag_pag
        element set_properties $form_name n_bollini  -value $n_bollini
        element set_properties $form_name mod_pag    -value $mod_pag
        element set_properties $form_name nota       -value $nota
        element set_properties $form_name cod_sogg   -value $cod_sogg
    }
}

if {$funzione != "I"} {
    set link_stampa "nome_funz=[iter_get_nomefunz coimfatt-layout]&[export_url_vars cod_fatt cod_sogg tipo_sogg]"
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cod_manutentore [element::get_value $form_name cod_manutentore]
    set data_consegna   [element::get_value $form_name data_consegna]
    set data_fatt  [element::get_value $form_name data_fatt]
    set num_fatt   [element::get_value $form_name num_fatt]
    set cognome    [element::get_value $form_name cognome]
    set nome       [element::get_value $form_name nome]
    set imponibile [element::get_value $form_name imponibile]
    set spe_postali [element::get_value $form_name spe_postali];#gab02
    #gab01 set perc_iva   [element::get_value $form_name perc_iva]
    set flag_pag   [element::get_value $form_name flag_pag]
    set matr_da    ""
    set matr_a     ""
    set n_bollini  [element::get_value $form_name n_bollini]
    set mod_pag    [element::get_value $form_name mod_pag]
    set nota       [element::get_value $form_name nota]
    set cod_sogg   [element::get_value $form_name cod_sogg]
 
  # controlli standard su numeri e date, per Ins ed Upd

    #gab01
    #  if {$flag_pag == "S"
    #} {
    #	set mod_pag "Pagato"
    #} else {
    #	set mod_pag "Pagamento alla trasmissione del RCEE come previsto dal Regolamento Regionale Art.13 comma 3"
    #}

    set error_num 0
    if {$funzione == "I"
    ||  $funzione == "M"
    } {

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
            if {$imponibile == "Error"} {
                element::set_error $form_name imponibile "L'imponibile deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {
                if {[iter_set_double $imponibile] >=  [expr pow(10,6)]
                ||  [iter_set_double $imponibile] <= -[expr pow(10,6)]} {
                    element::set_error $form_name imponibile "L'imponibile deve essere inferiore di 1.000.000"
                    incr error_num
                }
            }
        }

	if {![string equal $spe_postali ""]} {;#gab02 if e contenuto
            set spe_postali [iter_check_num $spe_postali 2]
            if {$spe_postali == "Error"} {
                element::set_error $form_name spe_postali "Spesa Postale deve essere numerico e pu&ograve; avere al massimo 2 decimali"
                incr error_num
            } else {;#gab02 else e contenuto
                if {[iter_set_double $spe_postali] >=  [expr pow(10,6)]
		    ||  [iter_set_double $spe_postali] <= -[expr pow(10,6)]} {
                    element::set_error $form_name spe_postali "Spesa postale deve essere inferiore di 1.000.000"
                    incr error_num
                }
	    }
	}

        #if {[string equal $perc_iva ""]} {
        #    element::set_error $form_name perc_iva "Inserire percentuale iva"
        #    incr error_num
	#} else {
        #    set perc_iva [iter_check_num $perc_iva 2]
        #    if {$perc_iva == "Error"} {
        #        element::set_error $form_name perc_iva "La percentuale iva deve essere numerico e pu&ograve; avere al massimo 2 decimali"
        #        incr error_num
        #    } else {
        #        if {[iter_set_double $perc_iva] >=  [expr pow(10,2)]
        #        ||  [iter_set_double $perc_iva] <= -[expr pow(10,2)]} {
        #            element::set_error $form_name perc_iva "La percentuale iva deve essere inferiore a 100"
        #            incr error_num
        #        }
        #    }
        #}

	#routine generica per controllo codice manutentore
	set check_cod_sogg {
	    set chk_out_rc       0
	    set chk_out_msg      ""
	    set chk_out_cod_sogg ""
	    set ctr_sogg         0
	    if {[string equal $chk_inp_cognome ""]} {
		set eq_cognome "is null"
	    } else {
		set eq_cognome "= upper(:chk_inp_cognome)"
	    }
	    if {[string equal $chk_inp_nome ""]} {
		set eq_nome    "is null"
	    } else {
		set eq_nome    "= upper(:chk_inp_nome)"
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
    
	if {[string equal $cognome ""]
	&&  [string equal $nome ""]
	} {
	    set cod_sogg ""
	} else {
	    set chk_inp_cod_sogg $cod_sogg
	    set chk_inp_cognome  $cognome
	    set chk_inp_nome     $nome
	    eval $check_cod_sogg
	    set cod_sogg  $chk_out_cod_sogg
	    if {$chk_out_rc == 0} {
		element::set_error $form_name cognome $chk_out_msg
		incr error_num
	    }
	}


	
	if {$funzione == "M"} {
	    set where_mod " and cod_fatt <> :cod_fatt"
	} else {
	    set where_mod ""
	}
	if {[db_0or1row sel_num_check ""] == 1} {
	    element::set_error $form_name num_fatt "Il numero fattura &egrave gi&agrave presente nell'anno inserito"
	    incr error_num
	}
    }

    if {$funzione == "I"
    &&  $error_num == 0
    &&  [db_0or1row sel_fatt_check {}] == 1
    } {
      # controllo univocita'/protezione da double_click
        element::set_error $form_name cod_fatt "Il record che stai tentando di inserire &egrave; gi&agrave; esistente nel Data Base."
        incr error_num
    }

     if {$error_num > 0} {
        ad_return_template
        return
     }
    set perc_iva "";#gab01 temporaneo 
    switch $funzione {
        I { db_1row sel_cod_fatt ""
           set dml_sql [db_map ins_fatt]}
        M {set dml_sql [db_map upd_fatt]}
        D {set dml_sql [db_map del_fatt]}
    }


  # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql]} {

	set bollini [list]
	db_foreach query { 
	    select cod_bollini
	    from coimboll
	    where cod_manutentore = :cod_manutentore
	    and data_consegna     = :data_consegna 
            and cod_fatt is null
	} {
	    lappend  bollini $cod_bollini    
	}
        with_catch error_msg {
            db_transaction {
                set n_bollini [iter_check_num $n_bollini 2]
                db_dml dml_coimboll $dml_sql
		foreach cod_bollini $bollini { 
		    db_dml query "update coimboll set cod_fatt = :cod_fatt where cod_bollini = :cod_bollini"    
		}
	    }
	} {
            iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
	}
    }
    
    # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione == "I"} {
        set last_cod_fatt $cod_fatt
	set last_data_fatt $data_fatt
    }

    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_fatt cod_sogg tipo_sogg last_cod_fatt last_data_fatt nome_funz nome_funz_caller extra_par caller]

	switch $funzione {
	    M {set return_url   "coimfatt-gest?funzione=V&$link_gest"}
	    D {set return_url   "coimfatt-list?$link_list"}
	    I {set return_url   "coimfatt-gest?funzione=V&$link_gest"}
	    V {set return_url   "coimfatt-list?$link_list"}
	}

    ad_returnredirect $return_url
    ad_script_abort

}

ad_return_template
