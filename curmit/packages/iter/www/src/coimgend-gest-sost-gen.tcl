ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimgend-sost-gen"
    @author          Romitti Luca
    @creation-date   20/09/2018
    
    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.
    
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.
    
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
    @                navigazione con navigation bar
    
    @param extra_par Variabili extra da restituire alla lista
    
    @cvs-id          coimgend-gest-sost-gen.tcl
    
    USER  DATA       MODIFICHE
    ===== ========== =============================================================================
   
} {
    
    {cod_impianto     ""}
    {gen_prog         ""}
    {gen_prog_da_sost ""}
    {funzione        "S"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {extra_par        ""}
    {url_list_aimp    ""}
    {url_aimp         ""}
    {evidenzia_rend_ter ""}
} -properties {    
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
    focus_field:onevalue
}


# B80: RECUPERO LO USER - INTRUSIONE
set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente_loggato_vero [ad_get_client_property iter logged_user_id]
set session_id [ad_conn session_id]
set adsession [ad_get_cookie "ad_session_id"]
set referrer [ns_set get [ad_conn headers] Referer]
set clientip [lindex [ns_set iget [ns_conn headers] x-forwarded-for] end]
set cod_manutentore [iter_check_uten_manu $id_utente];#rom03

# Controlla lo user

switch $funzione {
    "S" {set lvl 1}
}
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

iter_get_coimtgen;

set link_gest [export_url_vars cod_impianto gen_prog last_gen_prog nome_funz nome_funz_caller url_list_aimp url_aimp extra_par caller]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

#proc per la navigazione 
set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

# Personalizzo la pagina
set link_list_script {[export_url_vars cod_impianto last_gen_prog caller nome_funz_caller nome_funz url_list_aimp url_aimp]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]

set current_date      [iter_set_sysdate]

set titolo              "Generatore"
switch $funzione {
    S {set button_label "Conferma Sostituzione"
	set page_title   "Sostituisci $titolo"}
}

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

if {$coimtgen(regione) eq "MARCHE"} {
    set label_tipo_foco "Camera di combustione"
    set label_tiraggio  "Evacuazione fumi"
} else {
    set label_tipo_foco "Tipo generatore"
    set label_tiraggio  "Tiraggio"
}


#gab02 ho spostato questa parte di codice dove viene estratto il flag_tipo_impianto qui perchè la variabile mi serve per settare where_cod_comb
if {![db_0or1row query "select flag_tipo_impianto
                          from coimaimp
                         where cod_impianto = :cod_impianto"]
} {;#dpr74
    iter_return_complaint "Impianto non trovato";#dpr74
};#dpr74

if {$flag_tipo_impianto eq "T"} {#gab02 aggiunta if, else e contenuto
    set where_cod_comb "and cod_combustibile = '7'"
} else {
    set where_cod_comb ""
}
if {$funzione eq "S" } {
    set tipo_comb_where ""
    if {[db_0or1row q "select coalesce(c.tipo, '&nbsp') as tipo_comb_where
                                      from coimcomb c
                                         , coimgend g
                                     where c.cod_combustibile = g.cod_combustibile
                                       and g.cod_impianto = :cod_impianto
                                     order by gen_prog
                                     limit 1"]} {
	set where_tipo_comb "and tipo = '$tipo_comb_where'"
    } else {
	
	#se sull'impianto ho cancellato tutti i generatori vado a prendere il tipo combustibile dal combustibile 
	#dell'impianto
	db_0or1row q "select coalesce(c.tipo, '&nbsp') as tipo_comb_where
                            from coimcomb c
                               , coimaimp i
                           where c.cod_combustibile = i.cod_combustibile
                             and i.cod_impianto = :cod_impianto
                            limit 1"
    }
    
    set where_tipo_comb "and tipo = '$tipo_comb_where'"
    
    
}


set ast "<font color=red>*</font>"
set ast_MARCHE ""
set ast_freddo ""
if {$coimtgen(regione) eq "MARCHE"} {
    set ast_MARCHE $ast
}
if {$flag_tipo_impianto eq "F"} {
    set ast_freddo $ast
};


# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimgend"
set focus_field  "";
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
switch $funzione {
    "S" {
	set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
    }
}


form create $form_name \
    -html    $onsubmit_cmd

element create $form_name gen_prog \
    -label   "numero" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional
if {$funzione eq "S" } {#rom07 if, else e loro contenuto
    set gen_prog_est [db_string q "select max(gen_prog_est + 1) from coimgend where cod_impianto = :cod_impianto"]
} else {
    set gen_prog_est [db_string q "select gen_prog_est from coimgend where cod_impianto = :cod_impianto"]
}
#rom07
element create $form_name gen_prog_est \
    -label   "numero gen" \
    -widget   inform \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional \
    -value $gen_prog_est

element create $form_name descrizione \
    -label   "descrizione" \
    -widget   text \
    -datatype text \
    -html    "size 56 maxlength 100 $readonly_fld {} class form_element" \
    -optional

element create $form_name cod_grup_term \
    -label   "tipo gruppo termico" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table coimtipo_grup_termico cod_grup_term desc_grup_term order_grup_term];#san01

if {$flag_tipo_impianto eq "R"} {#rom01 aggiunta if else e loro contenuto
    element create $form_name num_prove_fumi \
	-label   "Num. prove fumi" \
	-widget   text \
	-datatype text \
	-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
	-optional
} else {
    element create $form_name num_prove_fumi -widget hidden -datatype text -optional
}
set link_coimgend_pote "" ;#rom06

element create $form_name matricola \
    -label   "matricola" \
    -widget   text \
    -datatype text \
    -optional \
    -html    "size 20 maxlength 35 $readonly_fld {} class form_element"

if {$coimtgen(flag_gest_coimmode) eq "F"} {;#nic01
    element create $form_name modello \
	-label   "modello" \
	-widget   text \
	-datatype text \
	-optional \
	-html    "size 18 maxlength 40 $readonly_fld {} class form_element"

    element create $form_name cod_mode -widget hidden -datatype text -optional;#nic01

    set html_per_cod_cost "";#nic01
} else {;#nic01
    element create $form_name modello -widget hidden -datatype text -optional;#nic01

    element create $form_name cod_mode \
	    -label   "modello" \
	    -widget   select \
	    -datatype text \
	    -html    "$disabled_fld {} class form_element" \
	    -optional \
	    -options "";#nic01
    
    set html_per_cod_cost "onChange document.$form_name.__refreshing_p.value='1';document.$form_name.changed_field.value='cod_cost';document.$form_name.submit.click()";#nic01
};#nic01

element create $form_name cod_cost \
    -label   "costruttore" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element $html_per_cod_cost" \
    -optional \
    -options [iter_selbox_from_table coimcost cod_cost descr_cost] \

#rom02 modificato il valore {Chiuso C} con {Stagna C} solo per la Reg. Marche
if {($coimtgen(regione) eq "MARCHE")} {#rom02 if, else e loro contenuto
    element create $form_name tipo_foco \
	-label   "camera di Combustione" \
	-widget   select \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional \
	-options {{{} {}} {Aperta A} {Stagna C}}
} else {
    element create $form_name tipo_foco \
	-label   "Tipo Generatore" \
	-widget   select \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional \
	-options {{{} {}} {Aperto A} {Chiuso C}}
};#rom02

element create $form_name mod_funz \
    -label   "funzionamento" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table coimfuge cod_fuge descr_fuge cod_fuge] 
#rom04
element create $form_name altro_funz \
    -label   "Altro" \
    -widget   textarea \
    -datatype text \
    -html    "cols 20 rows 1 maxlength 20 $readonly_fld {} class form_element" \
    -optional

#gac04 aggiunta if else e contenuto di else 
if {$coimtgen(regione) ne "MARCHE"} {
    element create $form_name cod_utgi \
	-label   "cod_utgi" \
	-widget   select \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional \
	-options [iter_selbox_from_table_obblig coimutgi cod_utgi descr_utgi cod_utgi] 
} else {
    element create $form_name cod_utgi \
        -label   "cod_utgi" \
        -widget   select \
        -datatype text \
        -html    "$disabled_fld {} class form_element" \
        -optional \
        -options [iter_selbox_from_table_wherec coimutgi cod_utgi descr_utgi cod_utgi "where cod_utgi != '0'                                                                                                                          and cod_utgi != 'A'"]
}

element create $form_name tipo_bruciatore \
    -label   "tipo bruciatore" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {Atmosferico A} {Pressurizzato P} {Premiscelato M}}

element create $form_name tiraggio \
    -label   "tipo tiraggio" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {Forzato F} {Naturale N}}

element create $form_name matricola_bruc\
    -label   "matricola_bruc" \
    -widget   text \
    -datatype text \
    -html    "size 20 maxlength 35 $readonly_fld {} class form_element" \
    -optional

if {$coimtgen(flag_gest_coimmode) eq "F"} {;#nic01
    element create $form_name modello_bruc \
	-label   "modello_bruc" \
	-widget   text \
	-datatype text \
	-html    "size 18 maxlength 40 $readonly_fld {} class form_element" \
	-optional
    
    element create $form_name cod_mode_bruc -widget hidden -datatype text -optional;#nic01
    
    set html_per_cod_cost_bruc "";#nic01
} else {;#nic01
    element create $form_name modello_bruc -widget hidden -datatype text -optional;#nic01

    element create $form_name cod_mode_bruc \
	    -label   "modello bruc." \
	    -widget   select \
	    -datatype text \
	    -html    "$disabled_fld {} class form_element" \
	    -optional \
	    -options "";#nic01

    set html_per_cod_cost_bruc "onChange document.$form_name.__refreshing_p.value='1';document.$form_name.changed_field.value='cod_cost_bruc';document.$form_name.submit.click()";#nic01
};#nic01

element create $form_name cod_cost_bruc \
    -label   "costruttore_bruc" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element $html_per_cod_cost_bruc" \
    -optional \
    -options [iter_selbox_from_table coimcost cod_cost descr_cost] \

#rom02 tolta la tipologia {{Non noto} N} e modificato il tipo T da Tecnico a Locale ad uso esclusivo
if {($coimtgen(regione) eq "MARCHE")} { #rom02 if, else e loro contenuto
    element create $form_name locale \
	-label   "tipo locale" \
	-widget   select \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional \
	-options {{{} {}} {{Locale ad uso esclusivo} T} {Esterno E} {Interno I} }
} else {
    element create $form_name locale \
        -label   "tipo locale" \
        -widget   select \
        -datatype text \
        -html    "$disabled_fld {} class form_element" \
        -optional \
        -options {{{} {}} {Tecnico T} {Esterno E} {Interno I} {{Non noto} N}}
};#rom02
element create $form_name cod_emissione \
    -label   "cod_emissione combust." \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table_obblig coimtpem cod_emissione descr_emissione cod_emissione] 

#gab02 cambiate options, uso la proc con la condizione
#-options [iter_selbox_from_table coimcomb cod_combustibile descr_comb]
element create $form_name cod_combustibile \
    -label   "combustibile" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table_wherec coimcomb cod_combustibile descr_comb  "" "where 1 = 1 $where_cod_comb $where_tipo_comb"] \

element create $form_name data_installaz \
    -label   "data installaz" \
    -widget   text \
    -datatype text \
    -optional \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element"

element create $form_name data_rottamaz \
    -label   "data rottamaz" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name pot_focolare_lib \
    -label   "potenza focolare libretto" \
    -widget   text \
    -datatype text \
    -html    "size 9 maxlength 9 $readonly_fld {} class form_element" \
    -optional

element create $form_name pot_utile_lib \
    -label   "potenza utile libretto" \
    -widget   text \
    -datatype text \
    -html    "size 9 maxlength 9 $readonly_fld {} class form_element" \
    -optional

element create $form_name pot_focolare_nom \
    -label   "potenza focolare nomin" \
    -widget   text \
    -datatype text \
    -html    "size 9 maxlength 9 $readonly_fld {} class form_element" \
    -optional

element create $form_name pot_utile_nom \
    -label   "potenza utile nomin" \
    -widget   text \
    -datatype text \
    -html    "size 9 maxlength 9 $readonly_fld {} class form_element" \
    -optional

#sim04
element create $form_name pot_utile_nom_freddo \
    -label   "potenza utile nomin del freddo" \
    -widget   text \
    -datatype text \
    -html    "size 9 maxlength 9 $readonly_fld {} class form_element" \
    -optional

element create $form_name flag_attivo \
    -label   "flag attivo" \
    -widget   select \
    -datatype text \
    -html    "class form_element onChange document.$form_name.__refreshing_p.value='1';document.$form_name.changed_field.value='flag_attivo';document.$form_name.submit.click();" \
    -optional \
    -options {{Si S} {No N}}

element create $form_name note \
    -label   "note" \
    -widget   textarea \
    -datatype text \
    -html    "cols 110 rows 2 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_costruz_gen \
    -label   "data costruzione generatore" \
    -widget   text \
    -datatype text \
    -optional \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element"

element create $form_name data_costruz_bruc \
    -label   "data costruzione bruciatore" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_installaz_bruc \
    -label   "data installaz bruciatore" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name data_rottamaz_bruc \
    -label   "data rottamazione bruciatore" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

if {($coimtgen(regione) eq "MARCHE")} {

element create $form_name marc_effic_energ \
    -label   "marcatura efficenza energetica" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {{1 stella} {1*}} {{2 stelle} {2*}} {{3 stelle} {3*}} {{4 stelle} {4*}} {{5 stelle} {5*}}}

} else { 

element create $form_name marc_effic_energ \
    -label   "marcatura efficenza energetica" \
    -widget   text \
    -datatype text \
    -html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
    -optional
}

element create $form_name campo_funzion_max \
    -label   "Campo di funzionamento" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name campo_funzion_min \
    -label   "Campo di funzionamento" \
    -widget   text \
    -datatype text \
    -html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
    -optional

element create $form_name dpr_660_96 \
    -label   "Classificazione DPR 660/96" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {Standard S} {{A bassa temperatura} B} {{A gas a condensazione} G}}

element create $form_name cod_tpco \
    -label   "cod_tpco" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table coimtpco cod_tpco descr_tpco];#dpr74

element create $form_name cod_flre \
    -label   "cod_flre" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options [iter_selbox_from_table coimflre cod_flre sigla];#dpr74

element create $form_name carica_refrigerante \
    -label   "carica_refrigerante" \
    -widget   text \
    -datatype text \
    -html    "size 13 maxlength 13 $readonly_fld {} class form_element" \
    -optional;#dpr74

element create $form_name sigillatura_carica \
    -label   "sigillatura_carica" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{} {}} {No N} {S&igrave; S}};#dpr74

#sim08 aggiunti per e cop
if {$flag_tipo_impianto eq "F"} {#sim05: aggiunta if e suo contenuto
    element create $form_name num_circuiti \
	-label   "Numero circuiti" \
	-widget   text \
	-datatype text \
	-html    "size 4 $readonly_fld {} class form_element" \
	-optional

    element create $form_name per \
        -label   "EER (o GUE)" \
        -widget   text \
        -datatype text \
        -html    "size 7 maxlength 7 $readonly_fld {} class form_element" \
        -optional

    element create $form_name cop \
        -label   "COP" \
        -widget   text \
        -datatype text \
        -html    "size 7 maxlength 7 $readonly_fld {} class form_element" \
        -optional

} else {
    element create $form_name num_circuiti -widget hidden -datatype text -optional
    element create $form_name per -widget hidden -datatype text -optional
    element create $form_name cop -widget hidden -datatype text -optional
}

#gac02 gestiti nuovi campi cogeneratore
element create $form_name tipologia_cogenerazione \
    -label   "Tipologia Cogeneratore" \
    -widget   select \
    -datatype text \
    -html    "$disabled_fld {} class form_element" \
    -optional \
    -options {{{Altro} A} {{Motore Endotermico} M} {{Caldaia Cogenerativa} C} {{Turbogas} T}}

element create $form_name temp_h2o_uscita_min \
    -label   "Temperatura acqua in uscita minima" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name temp_h2o_uscita_max \
    -label   "Temperatura acqua in uscita massima" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name temp_h2o_ingresso_min \
    -label   "Temperatura acqua in ingresso mimima" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name temp_h2o_ingresso_max \
    -label   "Temperatura acqua in ingresso massima" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name temp_h2o_motore_min \
    -label   "Temperatura acqua motore minima" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name temp_h2o_motore_max \
    -label   "Temperatura acqua motore massima" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name temp_fumi_valle_min \
    -label   "Temperatura fumi valle minima" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name temp_fumi_valle_max \
    -label   "Temperatura fumi valle massima" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name temp_fumi_monte_min \
    -label   "Temperatura fumi monte minima" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name temp_fumi_monte_max \
    -label   "Temperatura fumi monte massima" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name emissioni_monossido_co_min \
    -label   "Emissioni monossido di carbonio minima" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

element create $form_name emissioni_monossido_co_max \
    -label   "Emissioni monossido di carbonio massima" \
    -widget   text \
    -datatype text \
    -html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
    -optional

#rom02 
if {($coimtgen(regione) eq "MARCHE")} {#rom02 if, else e loro contenuto
    
    element create $form_name funzione_grup_ter \
	-label   "Funzione del Gruppo Termico" \
	-widget   select \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional \
	-options {{{Produzione di Acqua calda sanitaria} P} {{Climatizzazione invernale} I} {{Climatizzazione estiva} E} {{Altro} A}}
    
    element create $form_name rif_uni_10389 \
        -label   "Riferimento" \
        -widget   select \
        -datatype text \
        -html    "$disabled_fld {} class form_element" \
        -optional \
        -options {{{norma UNI-10389-1} {U}} {{Altro} {A}}}

    element create $form_name altro_rif \
	-label   "Altro" \
	-widget   textarea \
	-datatype text \
	-html    "cols 20 rows 1 maxlength 20 $readonly_fld {} class form_element" \
	-optional

    element create $form_name funzione_grup_ter_note_altro \
	-label   "Note Funzione Gruppo Termico" \
	-widget   textarea \
	-datatype text \
	-html    "cols 20 rows 1 $readonly_fld {} class form_element" \
	-optional
    
    element create $form_name flag_caldaia_comb_liquid \
	-label   "Flag caldaia a condensazione che utilizza combustibile liquido" \
	-widget   select \
	-datatype text \
	-html    "$disabled_fld {} class form_element" \
	-optional \
	-options {{{} {}} {{Si} S} {{No} N}}

} else {
    element create $form_name funzione_grup_ter -widget hidden -datatype text -optional
    element create $form_name rif_uni_10389     -widget hidden -datatype text -optional;#gac03
    element create $form_name altro_rif         -widget hidden -datatype text -optional;#gac03
    element create $form_name funzione_grup_ter_note_altro -widget hidden -datatype text -optional
    element create $form_name flag_caldaia_comb_liquid -widget hidden -datatype text -optional
};#rom02

if {$flag_tipo_impianto eq "R" } {#rom02 if e suo contenuto
    element create $form_name rend_ter_max \
	-label   "rendimento termico massimo" \
	-widget   text \
	-datatype text \
	-html    "size 9 maxlength 9 $readonly_fld {} class form_element" \
	-optional
    
} else {;#rom02
    element create $form_name rend_ter_max -widget hidden -datatype text -optional
}

element create $form_name conferma_rend_ter     -widget hidden -datatype text -optional;#rom04

element create $form_name funzione         -widget hidden -datatype text -optional
element create $form_name caller           -widget hidden -datatype text -optional
element create $form_name nome_funz        -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par        -widget hidden -datatype text -optional
element create $form_name cod_impianto     -widget hidden -datatype text -optional
element create $form_name url_list_aimp    -widget hidden -datatype text -optional
element create $form_name url_aimp         -widget hidden -datatype text -optional
element create $form_name submit           -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_gen_prog    -widget hidden -datatype text -optional
element create $form_name gen_prog_old     -widget hidden -datatype text -optional
element create $form_name __refreshing_p   -widget hidden -datatype text -optional;#nic01
element create $form_name changed_field    -widget hidden -datatype text -optional;#nic01
element create $form_name evidenzia_rend_ter -widget hidden -datatype text -optional

#gab01
set cod_cost_asterisco ""
set data_installaz_asterisco ""
set data_costruz_gen_asterisco ""
set dpr_660_96_asterisco ""          
set tiraggio_asterisco ""
set tipo_foco_asterisco ""
set mod_funz_asterisco ""
set cod_utgi_asterisco ""
set locale_asterisco ""
set cod_combustibile_asterisco ""

if {[form is_request $form_name]} {


    element set_properties $form_name funzione          -value $funzione
    element set_properties $form_name caller            -value $caller
    element set_properties $form_name nome_funz         -value $nome_funz
    element set_properties $form_name nome_funz_caller  -value $nome_funz_caller
    element set_properties $form_name extra_par         -value $extra_par
    element set_properties $form_name cod_impianto      -value $cod_impianto
    element set_properties $form_name gen_prog          -value $gen_prog
    element set_properties $form_name url_list_aimp     -value $url_list_aimp
    element set_properties $form_name url_aimp          -value $url_aimp
    element set_properties $form_name last_gen_prog     -value $last_gen_prog
    element set_properties $form_name __refreshing_p    -value 0;#nic01
    element set_properties $form_name changed_field     -value "";#nic01
    element set_properties $form_name conferma_rend_ter -value "s";#rom04
    if {$funzione == "S"} {
	
	#set flag_attivo          "S";#[element::get_value $form_name flag_attivo]

	element set_properties $form_name flag_attivo    -value "S"
	set flag_attivo "S"


	# propongo il numero del nuovo generatore con il max + 1
        db_1row sel_gend_next_prog_x "select coalesce(max(gen_prog),0) + 1 as next_prog 
                                        from coimgend
                                       where cod_impianto = :cod_impianto"
        element set_properties $form_name gen_prog -value $next_prog

	if {$flag_tipo_impianto eq "F"} {#sim05: aggiunta if e suo contenuto
	    element set_properties $form_name num_circuiti        -value "1"
	}
	
	if {$flag_tipo_impianto eq "R"} {#rom01: aggiunta if e suo contenuto
            element set_properties $form_name num_prove_fumi      -value "1"
	}
	
	# Sandro, 30/06/2014. Imposto alcuni default per il Comune di Rimini
	if {$coimtgen(ente) eq "CRIMINI"} {
	    element set_properties $form_name cod_combustibile    -value "5"
	    element set_properties $form_name cod_emissione       -value "I"
	    element set_properties $form_name locale              -value "I"
	    element set_properties $form_name cod_utgi            -value "E"
	    element set_properties $form_name mod_funz            -value "1"
	}
 	
	
    } else {
	# leggo riga
        if {[db_0or1row sel_gend_x "select cod_impianto
                  , gen_prog
                  , descrizione
                  , matricola
                  , modello
                  , cod_cost
                  , matricola_bruc
                  , modello_bruc
                  , cod_cost_bruc
                  , tipo_foco
                  , mod_funz
                  , cod_utgi
                  , tipo_bruciatore
                  , tiraggio
                  , locale
                  , cod_emissione
                  , g.cod_combustibile
                  , iter_edit_data(data_installaz)     as data_installaz
                  , iter_edit_data(data_rottamaz)      as data_rottamaz
                  , iter_edit_num(pot_focolare_lib, 2) as pot_focolare_lib
                  , iter_edit_num(pot_utile_lib, 2)    as pot_utile_lib
                  , iter_edit_num(pot_focolare_nom, 2) as pot_focolare_nom
                  , iter_edit_num(pot_utile_nom, 2)    as pot_utile_nom
                  , iter_edit_num(pot_utile_nom_freddo, 2) as pot_utile_nom_freddo --sim04
                  , flag_attivo
                  , note
		  , gen_prog_est
                  , iter_edit_data(data_costruz_gen)   as data_costruz_gen
                  , iter_edit_data(data_costruz_bruc)  as data_costruz_bruc
                  , iter_edit_data(data_installaz_bruc) as data_installaz_bruc
                  , iter_edit_data(data_rottamaz_bruc) as data_rottamaz_bruc
                  , marc_effic_energ
                  , iter_edit_num(campo_funzion_max,2) as campo_funzion_max
                  , iter_edit_num(campo_funzion_min,2) as campo_funzion_min
                  , dpr_660_96
                  , cod_tpco            --dpr74
                  , cod_flre            --dpr74
                  , iter_edit_num(carica_refrigerante,2) as carica_refrigerante --dpr74
                  , sigillatura_carica  --dpr74
                  , cod_mode            -- nic01
                  , cod_mode_bruc       -- nic01
                  , cod_grup_term       -- san01
                  , num_circuiti        -- sim05
                  , num_prove_fumi      -- rom01
                  , iter_edit_num(per,2) as per  -- sim08
                  , iter_edit_num(cop,2) as cop  -- sim08
                  , tipologia_cogenerazione    --gac02
                  , iter_edit_num(temp_h2o_uscita_min,2)        as temp_h2o_uscita_min        --gac02
                  , iter_edit_num(temp_h2o_uscita_max,2)        as temp_h2o_uscita_max        --gac02
                  , iter_edit_num(temp_h2o_ingresso_min,2)      as temp_h2o_ingresso_min      --gac02
                  , iter_edit_num(temp_h2o_ingresso_max,2)      as temp_h2o_ingresso_max      --gac02
                  , iter_edit_num(temp_h2o_motore_min,2)        as temp_h2o_motore_min        --gac02
                  , iter_edit_num(temp_h2o_motore_max,2)        as temp_h2o_motore_max        --gac02
                  , iter_edit_num(temp_fumi_valle_min,2)        as temp_fumi_valle_min        --gac02
                  , iter_edit_num(temp_fumi_valle_max,2)        as temp_fumi_valle_max        --gac02
                  , iter_edit_num(temp_fumi_monte_min,2)        as temp_fumi_monte_min        --gac02
                  , iter_edit_num(temp_fumi_monte_max,2)        as temp_fumi_monte_max        --gac02
                  , iter_edit_num(emissioni_monossido_co_max,2) as emissioni_monossido_co_max --gac02
                  , iter_edit_num(emissioni_monossido_co_min,2) as emissioni_monossido_co_min --gac02
                  , funzione_grup_ter            --rom02
                  , funzione_grup_ter_note_altro --rom02
                  , flag_caldaia_comb_liquid     --rom02
                  , rif_uni_10389                --gac03
                  , altro_rif                    --gac03
                  , iter_edit_num(rend_ter_max,2) as rend_ter_max --rom02
                  , rend_ter_max as check_rend_ter_max
                  , altro_funz    --rom04
                  , c.tipo as tipo_comb
               from coimgend g
                  , coimcomb  c
              where cod_impianto = :cod_impianto
                and gen_prog     = :gen_prog
                and g.cod_combustibile = c.cod_combustibile"] == 0} {
            iter_return_complaint "Record non trovato"
	}

	set evidenzia_rend_ter "f"
	if {$coimtgen(regione) eq "MARCHE"} {#rom04 if e suo contenuto
	    if {$flag_tipo_impianto ne "F"} {#rom05 aggiunta if
		if {(($dpr_660_96 eq "B" || $dpr_660_96 eq "G") && ($check_rend_ter_max <= "85" || $check_rend_ter_max >= "120"))
		    ||  (($tipo_comb eq "L" || $tipo_comb eq "G") && $dpr_660_96 eq "S" && ($check_rend_ter_max <="78"  || $check_rend_ter_max >="100"))
		    || ($tipo_comb eq "S" && $dpr_660_96 eq "S" && ($check_rend_ter_max <="50" || $check_rend_ter_max >="100"))
		} {
		    set evidenzia_rend_ter "t" 
		} 
	    };#rom05
	};#rom04 
	if {[db_0or1row q "select 1 
                             from coimgend 
                            where cod_impianto   = :cod_impianto
                              and gen_prog       = :gen_prog
                              and :num_prove_fumi > 1"]} {#rom06 if, else e loro contenuto 
	    set  link_coimgend_pote "<a href=\"../src/coimgend-pote?nome_funz=$nome_funz&nome_funz_caller=$nome_funz_caller&cod_impianto=$cod_impianto&gen_prog=$gen_prog&caller=$caller\">Inserisci potenze singolo modulo</a>"
	} else {
	    set link_coimgend_pote ""
	};#rom06
	

        element set_properties $form_name gen_prog_old        -value $gen_prog
        element set_properties $form_name gen_prog            -value $gen_prog
        element set_properties $form_name descrizione         -value $descrizione
        element set_properties $form_name gen_prog_est        -value $gen_prog_est;#rom07
        element set_properties $form_name matricola           -value $matricola
        element set_properties $form_name modello             -value $modello
        element set_properties $form_name cod_cost            -value $cod_cost
        element set_properties $form_name tipo_foco           -value $tipo_foco
        element set_properties $form_name mod_funz            -value $mod_funz
        element set_properties $form_name cod_utgi            -value $cod_utgi
        element set_properties $form_name tipo_bruciatore     -value $tipo_bruciatore
        element set_properties $form_name tiraggio            -value $tiraggio
        element set_properties $form_name matricola_bruc      -value $matricola_bruc
        element set_properties $form_name modello_bruc        -value $modello_bruc
        element set_properties $form_name cod_cost_bruc       -value $cod_cost_bruc
        element set_properties $form_name locale              -value $locale
        element set_properties $form_name cod_emissione       -value $cod_emissione
        element set_properties $form_name cod_combustibile    -value $cod_combustibile
        element set_properties $form_name data_installaz      -value $data_installaz
        element set_properties $form_name data_rottamaz       -value $data_rottamaz
        element set_properties $form_name pot_focolare_lib    -value $pot_focolare_lib
        element set_properties $form_name pot_utile_lib       -value $pot_utile_lib
        element set_properties $form_name pot_focolare_nom    -value $pot_focolare_nom
        element set_properties $form_name pot_utile_nom       -value $pot_utile_nom
	element set_properties $form_name pot_utile_nom_freddo -value $pot_utile_nom_freddo;#sim04
        element set_properties $form_name flag_attivo         -value $flag_attivo
        element set_properties $form_name note                -value $note
	element set_properties $form_name data_costruz_gen    -value $data_costruz_gen
        element set_properties $form_name data_costruz_bruc   -value $data_costruz_bruc
        element set_properties $form_name data_installaz_bruc -value $data_installaz_bruc
        element set_properties $form_name data_rottamaz_bruc  -value $data_rottamaz_bruc
        element set_properties $form_name marc_effic_energ    -value $marc_effic_energ
        element set_properties $form_name campo_funzion_max   -value $campo_funzion_max
        element set_properties $form_name campo_funzion_min   -value $campo_funzion_min
        element set_properties $form_name dpr_660_96          -value $dpr_660_96
	element set_properties $form_name cod_tpco            -value $cod_tpco;#dpr74
	element set_properties $form_name cod_flre            -value $cod_flre;#dpr74
	element set_properties $form_name carica_refrigerante -value $carica_refrigerante;#dpr74
	element set_properties $form_name sigillatura_carica  -value $sigillatura_carica;#dpr74
        element set_properties $form_name cod_grup_term       -value $cod_grup_term;#san01
	element set_properties $form_name num_circuiti        -value $num_circuiti;#sim05
	element set_properties $form_name num_prove_fumi      -value $num_prove_fumi;#rom01
	element set_properties $form_name per                 -value $per;#sim08
	element set_properties $form_name cop                 -value $cop;#sim08
	element set_properties $form_name tipologia_cogenerazione     -value $tipologia_cogenerazione    ;#gac02
	element set_properties $form_name temp_h2o_uscita_min         -value $temp_h2o_uscita_min        ;#gac02
	element set_properties $form_name temp_h2o_uscita_max         -value $temp_h2o_uscita_max        ;#gac02
	element set_properties $form_name temp_h2o_ingresso_min       -value $temp_h2o_ingresso_min      ;#gac02
	element set_properties $form_name temp_h2o_ingresso_max       -value $temp_h2o_ingresso_max      ;#gac02
	element set_properties $form_name temp_h2o_motore_min         -value $temp_h2o_motore_min        ;#gac02
	element set_properties $form_name temp_h2o_motore_max         -value $temp_h2o_motore_max        ;#gac02
	element set_properties $form_name temp_fumi_valle_min         -value $temp_fumi_valle_min        ;#gac02
	element set_properties $form_name temp_fumi_valle_max         -value $temp_fumi_valle_max        ;#gac02
	element set_properties $form_name temp_fumi_monte_min         -value $temp_fumi_monte_min        ;#gac02
	element set_properties $form_name temp_fumi_monte_max         -value $temp_fumi_monte_max        ;#gac02
	element set_properties $form_name emissioni_monossido_co_max  -value $emissioni_monossido_co_max ;#gac02
	element set_properties $form_name emissioni_monossido_co_min  -value $emissioni_monossido_co_min ;#gac02
	element set_properties $form_name funzione_grup_ter            -value $funzione_grup_ter           ;#rom02
	element set_properties $form_name funzione_grup_ter_note_altro -value $funzione_grup_ter_note_altro;#rom02
	element set_properties $form_name flag_caldaia_comb_liquid     -value $flag_caldaia_comb_liquid    ;#rom02
	element set_properties $form_name rend_ter_max                 -value $rend_ter_max                ;#rom02
	element set_properties $form_name rif_uni_10389                -value $rif_uni_10389             ;#gac03
	element set_properties $form_name altro_rif                    -value $altro_rif                 ;#gac03
        element set_properties $form_name altro_funz                   -value $altro_funz                ;#rom04
	element set_properties $form_name evidenzia_rend_ter           -value $evidenzia_rend_ter
	# Imposto ora le options di cod_mode perchè solo adesso ho a disposiz. la var. cod_cost
	if {$cod_mode eq ""} {
	    set or_cod_mode ""
	} else {
	    # Devo esporre comunque il vecchio modello disattivato
	    set or_cod_mode "or cod_mode = $cod_mode"
	}
	element set_properties $form_name cod_mode            -options [iter_selbox_from_table "coimmode where cod_cost = '[db_quote $cod_cost]' and (flag_attivo <> 'N' $or_cod_mode)" cod_mode descr_mode];#nic01
        element set_properties $form_name cod_mode            -value $cod_mode;#nic01

	# Imposto ora le options di cod_mode_bruc perchè solo adesso ho a disposiz. la var. cod_cost_bruc
	if {$cod_mode_bruc eq ""} {
	    set or_cod_mode ""
	} else {
	    # Devo esporre comunque il vecchio modello disattivato
	    set or_cod_mode "or cod_mode = $cod_mode_bruc"
	}
	element set_properties $form_name cod_mode_bruc       -options [iter_selbox_from_table "coimmode where cod_cost = '[db_quote $cod_cost_bruc]' and (flag_attivo <> 'N' $or_cod_mode)" cod_mode descr_mode];#nic01
        element set_properties $form_name cod_mode_bruc       -value $cod_mode_bruc;#nic01

    }
    
    #gab01
    ############inizio controlli campi obbligatori
    if {$funzione ne "V"} {
	set flag_attivo          [element::get_value $form_name flag_attivo]
	#set flag_tipo_impianto   [element::get_value $form_name flag_tipo_impianto]   	

	if {$flag_attivo eq "S" } {
	    set cod_cost_asterisco "*"
	    set data_installaz_asterisco "*"
	    set data_costruz_gen_asterisco "*"
	    set dpr_660_96_asterisco "*"
	    set mod_funz_asterisco "*"
            set cod_utgi_asterisco "*"
            set locale_asterisco "*" 
            set cod_combustibile_asterisco "*" 
	    

	    if {$flag_tipo_impianto eq "R"} {
		set tiraggio_asterisco "*"
		set tipo_foco_asterisco "*"
	    }
          
	}    
    }
    
    #####################fine controlli campi obbligatori	
    
    
}

if {[form is_valid $form_name]} {
    # form valido dal punto di vista del templating system

    set __refreshing_p       [element::get_value $form_name __refreshing_p];#nic01
    set changed_field        [element::get_value $form_name changed_field];#nic01
    set cod_impianto         [element::get_value $form_name cod_impianto]
    set gen_prog             [element::get_value $form_name gen_prog]
    set gen_prog_est         [element::get_value $form_name gen_prog_est];#rom07
    set gen_prog_old         [element::get_value $form_name gen_prog_old]
    set descrizione          [element::get_value $form_name descrizione]
    set matricola            [element::get_value $form_name matricola]
    set modello              [element::get_value $form_name modello]
    set cod_cost             [element::get_value $form_name cod_cost]
    set tipo_foco            [element::get_value $form_name tipo_foco]
    set mod_funz             [element::get_value $form_name mod_funz]
    set cod_utgi             [element::get_value $form_name cod_utgi]
    set tipo_bruciatore      [element::get_value $form_name tipo_bruciatore]
    set tiraggio             [element::get_value $form_name tiraggio]
    set matricola_bruc       [element::get_value $form_name matricola_bruc]
    set modello_bruc         [element::get_value $form_name modello_bruc]
    set cod_cost_bruc        [element::get_value $form_name cod_cost_bruc]
    set locale               [element::get_value $form_name locale]
    set cod_emissione        [element::get_value $form_name cod_emissione]
    set cod_combustibile     [element::get_value $form_name cod_combustibile]
    set data_installaz       [element::get_value $form_name data_installaz]
    set data_rottamaz        [element::get_value $form_name data_rottamaz]
    set pot_focolare_lib     [element::get_value $form_name pot_focolare_lib]
    set pot_utile_lib        [element::get_value $form_name pot_utile_lib]
    set pot_focolare_nom     [element::get_value $form_name pot_focolare_nom]
    set pot_utile_nom        [element::get_value $form_name pot_utile_nom]
    set pot_utile_nom_freddo [element::get_value $form_name pot_utile_nom_freddo];#sim04
    set flag_attivo          [element::get_value $form_name flag_attivo]
    set note                 [element::get_value $form_name note]
    set data_costruz_gen     [element::get_value $form_name data_costruz_gen]
    set data_costruz_bruc    [element::get_value $form_name data_costruz_bruc]
    set data_installaz_bruc  [element::get_value $form_name data_installaz_bruc]
    set data_rottamaz_bruc   [element::get_value $form_name data_rottamaz_bruc]
    set marc_effic_energ     [element::get_value $form_name marc_effic_energ]
    set campo_funzion_max    [element::get_value $form_name campo_funzion_max]
    set campo_funzion_min    [element::get_value $form_name campo_funzion_min]
    set dpr_660_96           [element::get_value $form_name dpr_660_96]
    set cod_tpco             [element::get_value $form_name cod_tpco];#dpr74
    set cod_flre             [element::get_value $form_name cod_flre];#dpr74
    set carica_refrigerante  [element::get_value $form_name carica_refrigerante];#dpr74
    set sigillatura_carica   [element::get_value $form_name sigillatura_carica];#dpr74
    set cod_grup_term        [element::get_value $form_name cod_grup_term];#san01
    set num_circuiti         [element::get_value $form_name num_circuiti];#sim05
    set num_prove_fumi       [element::get_value $form_name num_prove_fumi];#rom01
    set per                  [element::get_value $form_name per];#sim08
    set cop                  [element::get_value $form_name cop];#sim08
    set tipologia_cogenerazione    [element::get_value $form_name tipologia_cogenerazione]    ;#gac02
    set temp_h2o_uscita_min        [element::get_value $form_name temp_h2o_uscita_min]        ;#gac02
    set temp_h2o_uscita_max        [element::get_value $form_name temp_h2o_uscita_max]        ;#gac02
    set temp_h2o_ingresso_min      [element::get_value $form_name temp_h2o_ingresso_min]      ;#gac02
    set temp_h2o_ingresso_max      [element::get_value $form_name temp_h2o_ingresso_max]      ;#gac02
    set temp_h2o_motore_min        [element::get_value $form_name temp_h2o_motore_min]        ;#gac02
    set temp_h2o_motore_max        [element::get_value $form_name temp_h2o_motore_max]        ;#gac02
    set temp_fumi_valle_min        [element::get_value $form_name temp_fumi_valle_min]        ;#gac02
    set temp_fumi_valle_max        [element::get_value $form_name temp_fumi_valle_max]        ;#gac02
    set temp_fumi_monte_min        [element::get_value $form_name temp_fumi_monte_min]        ;#gac02
    set temp_fumi_monte_max        [element::get_value $form_name temp_fumi_monte_max]        ;#gac02
    set emissioni_monossido_co_max [element::get_value $form_name emissioni_monossido_co_max] ;#gac02
    set emissioni_monossido_co_min [element::get_value $form_name emissioni_monossido_co_min] ;#gac02
    set funzione_grup_ter            [element::get_value $form_name funzione_grup_ter]           ;#rom02
    set funzione_grup_ter_note_altro [element::get_value $form_name funzione_grup_ter_note_altro];#rom02
    set flag_caldaia_comb_liquid     [element::get_value $form_name flag_caldaia_comb_liquid]    ;#rom02
    set rend_ter_max                 [element::get_value $form_name rend_ter_max]                ;#rom02
    set rif_uni_10389                [element::get_value $form_name rif_uni_10389]               ;#gac03
    set altro_rif                    [element::get_value $form_name altro_rif]                   ;#gac03
    set altro_funz                   [element::get_value $form_name altro_funz]                  ;#rom04
    set conferma_rend_ter            [element::get_value $form_name conferma_rend_ter]           ;#rom04
    set cod_mode             [element::get_value $form_name cod_mode];#nic01
    if {$cod_mode eq ""} {
	set or_cod_mode ""
    } else {
	# Devo esporre comunque il vecchio modello disattivato
	set or_cod_mode "or cod_mode = $cod_mode"
    }
    #Imposto ora le options di cod_mode perchè solo adesso ho a disposizione la var. cod_cost
    element set_properties $form_name cod_mode -options [iter_selbox_from_table "coimmode where cod_cost = '[db_quote $cod_cost]' and (flag_attivo <> 'N' $or_cod_mode)" cod_mode descr_mode];#nic01

    #Imposto ora le options di cod_mode_bruc perchè solo adesso ho a disposizione la var. cod_cost_bruc
    set cod_mode_bruc        [element::get_value $form_name cod_mode_bruc];#nic01
    if {$cod_mode_bruc eq ""} {
	set or_cod_mode ""
    } else {
	# Devo esporre comunque il vecchio modello disattivato
	set or_cod_mode "or cod_mode = $cod_mode_bruc"
    }
    element set_properties $form_name cod_mode_bruc -options [iter_selbox_from_table "coimmode where cod_cost = '[db_quote $cod_cost_bruc]' and (flag_attivo <> 'N' $or_cod_mode)" cod_mode descr_mode];#nic01


    if {$flag_attivo eq "S"} {;#gab01  
	set cod_cost_asterisco "*"
	set data_installaz_asterisco "*"
	set data_costruz_gen_asterisco "*"
	set dpr_660_96_asterisco "*"
        set mod_funz_asterisco "*"
	set cod_utgi_asterisco "*"
	set locale_asterisco "*" 
	set cod_combustibile_asterisco "*"     
    
    
    if {$flag_tipo_impianto eq "R"} {;#gab01
	set tiraggio_asterisco "*"
	set tipo_foco_asterisco "*"
    }
        
    }

    if {[string equal $__refreshing_p "1"]} {;#nic01
	if {$changed_field eq "cod_cost"} {;#nic01
	    set focus_field "$form_name.cod_mode";#nic01
	} elseif {$changed_field eq "cod_cost_bruc"} {;#nic01
	    set focus_field "$form_name.cod_mode_bruc";#nic01
	};#nic01


	element set_properties $form_name __refreshing_p -value 0;#nic01
	element set_properties $form_name changed_field  -value "";#nic01

	ad_return_template;#nic01
	return;#nic01
    };#nic01

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "S"} {

	set gen_prog [iter_check_num $gen_prog 0]
	if {$gen_prog == "Error"} {
	    element::set_error $form_name gen_prog "Deve essere un numero intero"
	    incr error_num
	}
	set data_insta [iter_check_date $data_installaz]
	if {[string equal $marc_effic_energ ""] && $coimtgen(regione) eq "MARCHE" && $flag_tipo_impianto ne "T" && $flag_tipo_impianto ne "C" && $data_insta > "2015-01-01"} {#gac05 aggiunto && $data_insta > "2015-01-01"
	    element::set_error $form_name marc_effic_energ "Inserire"
	    incr error_num
	}



	if {$flag_tipo_impianto eq "F"} {#sim05: aggiunta if e suo contenuto
	    set num_circuiti [iter_check_num $num_circuiti 0]
	    #sim06 aggiunto condizione num_circuiti < 1
	    if {$num_circuiti == "Error" || $num_circuiti < 1} {
		#sim06 element::set_error $form_name num_circuiti "Deve essere un numero intero"
		element::set_error $form_name num_circuiti "Deve essere un numero intero maggiore di 0";#sim06
		incr error_num
	    }

	    if {$coimtgen(regione) eq "MARCHE"} {#rom05 if e suo contenuto
		if {[string equal $per ""]} {
		    element::set_error $form_name per "Inserire"
                    incr error_num
                }
		if {[string equal $cop ""]} {
		    element::set_error $form_name cop "Inserire"
                    incr error_num
                }

	    };#rom05
		    
	    if {![string equal $per ""]} {#sim08 if e suo contenuto
		set per [iter_check_num $per 2]
		if {$per == "Error"} {
		    element::set_error $form_name per "Deve essere numerico, max 2 dec"
		    incr error_num
		}
	    }

	    if {![string equal $cop ""]} {#sim08 if e suo contenuto
		set cop [iter_check_num $cop 2]
		if {$cop == "Error"} {
		    element::set_error $form_name cop "Deve essere numerico, max 2 dec"
		    incr error_num
		}
	    }

	}
	
	if {$flag_tipo_impianto eq "R"} {#rom01: aggiunta if e suo contenuto        
	    set num_prove_fumi [iter_check_num $num_prove_fumi 0]
            if {$num_prove_fumi == "Error" || $num_prove_fumi < 1 || $num_prove_fumi>9} {
                element::set_error $form_name num_prove_fumi "Deve essere un numero intero maggiore di 0 e minonre di 9";#rom01
                incr error_num
            }

	    set conta_prove_fumi [db_string q  "select count(cod_pr_fumi) as conta_prove_fumi
                                                  from coimgend_pote
                                                 where cod_impianto      = :cod_impianto 
                                          and gen_prog          = :gen_prog"];#rom06
	    
	    if {($conta_prove_fumi ne "0") && ($conta_prove_fumi ne $num_prove_fumi) && ($num_prove_fumi ne "Error")} {#rom06 if e contenuto
		element::set_error $form_name num_prove_fumi "Esistono già le potenze dei singoli moduli col numero prove fumi indicato.<br>Dismettere il generatore e aggiungerne uno nuovo."
		incr error_num
	    };#rom06
	    if {$num_prove_fumi ne "Error"} {#rom06 if, else e loro contenuto
		if {[db_0or1row q "select 1 
                                 from coimgend 
                                where cod_impianto    = :cod_impianto
                                  and gen_prog        = :gen_prog
                                  and num_prove_fumi  > 1
                                  and :num_prove_fumi = num_prove_fumi"]} { 
		    set  link_coimgend_pote "<a href=\"../src/coimgend-pote?nome_funz=$nome_funz&nome_funz_caller=$nome_funz_caller&cod_impianto=$cod_impianto&gen_prog=$gen_prog&caller=$caller\">Inserisci potenze singolo modulo</a>"
		    
		} else {
		    set  link_coimgend_pote ""
		}
	    } else {

		set  link_coimgend_pote ""
	    };#rom06
	
	    #rom02 UCIT e Comune Trieste possono avere solo una prova fumi se sul generatore del caldo pot_focolare_nom 
	    #rom02 è < 35 
	    if {$coimtgen(ente) eq "PUD" || 
                $coimtgen(ente) eq "PGO" || 
                $coimtgen(ente) eq "PPN" || 
                $coimtgen(ente) eq "PTS" || 
                $coimtgen(ente) eq "CTRIESTE"
	    } {#rom02 if e suo contenuto
		if {$num_prove_fumi > 1 && $pot_focolare_nom < 35} {
		    element::set_error $form_name num_prove_fumi "Se Potenza nominale focolare è minore di 35 (kW) si può inserire solo 1 prova fumi"
                incr error_num
		} 
	    };#rom02
	}

	if {$matricola eq ""} {
	    element::set_error $form_name matricola "Campo obbligatorio"
	    incr error_num
	}
        
	if {$coimtgen(flag_gest_coimmode) eq "F"} {;#nic01
	    if {$modello eq ""} {
		element::set_error $form_name modello "Campo obbligatorio"
		incr error_num
	    }
	} else {;#nic011
	    if {$cod_mode eq ""} {;#nic01
		element::set_error $form_name cod_mode "Campo obbligatorio";#nic01
		incr error_num;#nic01
	    } else {;#nic01
		# Devo comunque valorizzare la colonna coimgend.modello
		if {![db_0or1row query "select descr_mode as modello
                                          from coimmode
                                         where cod_mode = :cod_mode"]
		} {;#nic01
		    element::set_error $form_name cod_mode "Modello non trovato in anagrafica";#nic01
		    incr error_num;#nic01
		};#nic01
	    };#nic01
	};#nic01
	
	set tipo_comb [db_string q "select tipo 
                                      from coimcomb 
                                     where cod_combustibile = :cod_combustibile" -default ""]

	if {$flag_attivo eq "S" } {#san04: ho aggiunto solo questa if ma non il suo contenuto
	    if {$cod_cost eq ""} {
		element::set_error $form_name cod_cost "Campo obbligatorio"
		incr error_num
	    }
	    if {$data_installaz eq ""} {
		element::set_error $form_name data_installaz "Campo obbligatorio"
		incr error_num
	    }
	    if {$data_costruz_gen eq ""} {
		element::set_error $form_name data_costruz_gen "Campo obbligatorio"
		incr error_num
	    }

	    if {$flag_tipo_impianto ne "T" && $flag_tipo_impianto ne "C"} {#gab02 aggiunta if
		if {$coimtgen(regione) eq "MARCHE" && $flag_tipo_impianto ne "F"} {#rom05 aggiunta if
		    if {$dpr_660_96 eq "" && $tipo_comb ne "S"} {#san03: aggiunta if e suo contenuto #gac05 aggiunto && $tipo_comb ne "S" 
			element::set_error $form_name dpr_660_96 "Campo obbligatorio"
			incr error_num
		    } 
		}
	    }
	    if {$flag_tipo_impianto eq "R"} {#san03: aggiunta if e suo contenuto 
		#Questi campi esistono solo per il caldo
		if {$tiraggio eq ""} {
		    element::set_error $form_name tiraggio "Campo obbligatorio"
		    incr error_num
		}
		if {$tipo_foco eq ""} {
		    element::set_error $form_name tipo_foco "Campo obbligatorio"
		    incr error_num
		}
	    } 
	    if {$flag_tipo_impianto ne "C"} {
		if {$mod_funz eq ""} {#san03: aggiunta if e suo contenuto
		    element::set_error $form_name mod_funz "Campo obbligatorio"
		    incr error_num
		}
		if {$mod_funz eq "3" && $altro_funz eq ""} {#rom04 aggiunta if e suo contenuto
		    element::set_error $form_name altro_funz "Compilare \"Altro\""
		    incr error_num
		};#rom04
	    }
	    if {$cod_utgi eq ""} {#san03: aggiunta if e suo contenuto
		element::set_error $form_name cod_utgi "Campo obbligatorio"
		incr error_num
	    }
            if {$flag_tipo_impianto ne "T" && $flag_tipo_impianto ne "C"} {#gab02 aggiunta if
		if {$locale eq ""} {#san03: aggiunta if e suo contenuto
		    element::set_error $form_name locale "Campo obbligatorio"
		    incr error_num
		}
	    }
	    if {$cod_combustibile eq ""} {#san03: aggiunta if e suo contenuto
		element::set_error $form_name cod_combustibile "Campo obbligatorio"
		incr error_num
	    }
	};#san04

	set cambiocodice "N"
	if {$gen_prog != $gen_prog_old} {
	    if {[db_0or1row query "select 1 
                                     from coimgend 
                                    where cod_impianto = :cod_impianto 
                                      and gen_prog     = :gen_prog"] == 1} {
		element::set_error $form_name gen_prog "Il codice risulta gia' presente"
		incr error_num
	    }
            set cambiocodice "S"
	}
    
        if {![string equal $data_installaz ""]} {
            set data_installaz [iter_check_date $data_installaz]
            if {$data_installaz == 0} {
                element::set_error $form_name data_installaz "Data installazione deve essere una data"
                incr error_num
            } else {
		if {$data_installaz > $current_date} {
		    element::set_error $form_name data_installaz  "Data deve essere anteriore alla data odierna"
		    incr error_num
		} else {#sim08 else e suo contenuto
		    
		    set cod_manu_inst ""
		    db_0or1row q "select cod_installatore as cod_manu_inst 
                                from coimaimp
                               where cod_impianto = :cod_impianto"
		    
		    if {$coimtgen(regione) eq "MARCHE" && $data_installaz >= "20180701" && $cod_manu_inst eq ""} {
			
			element::set_error $form_name data_installaz "Inserire installatore in Ditte/Tecnici"
			incr error_num
			
		    }
		    
		}
	    }  
        }
    
        if {![string equal $data_rottamaz ""]} {
            set data_rottamaz [iter_check_date $data_rottamaz]
            if {$data_rottamaz == 0} {
                element::set_error $form_name data_rottamaz "data rottamazione deve essere una data"
                incr error_num
            } else {
		if {$data_rottamaz > $current_date} {
		    element::set_error $form_name data_rottamaz  "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {![string equal $data_installaz ""]
	    && ![string equal $data_rottamaz ""]} {
            if {$data_rottamaz < $data_installaz} {
                element::set_error $form_name data_rottamaz "Data rottamazione deve essere > di data installazione"
                incr error_num
	    }
	}

        if {[string equal $flag_attivo "S"]
	    && ![string equal $data_rottamaz ""]} {
	    element::set_error $form_name data_rottamaz "Non rottamabile se &egrave; attivo"
            incr error_num
	}

	if {$coimtgen(flag_gest_coimmode) eq "T"} {;#nic01
	    # In questo caso, devo comunque valorizzare la colonna coimgend.modello_bruc
	    set modello_bruc ""

	    if {$cod_mode_bruc ne ""
            && ![db_0or1row query "select descr_mode as modello_bruc
                                     from coimmode
                                    where cod_mode = :cod_mode_bruc"]
	    } {;#nic01
		element::set_error $form_name cod_mode_bruc "Modello bruc. non trovato in anagrafica";#nic01
		incr error_num;#nic01
	    };#nic01
	};#nic01
	if {$flag_tipo_impianto eq "F"} {#rom06 if e contenuto
	    if {[string equal $pot_focolare_lib ""]} {
		element::set_error $form_name pot_focolare_lib "Inserire"
		incr error_num
	    }
	    if {[string equal $pot_utile_lib ""]} {
		element::set_error $form_name pot_utile_lib "Inserire"
                incr error_num
            }
	};#rom06
        if {![string equal $pot_focolare_lib ""]} {
            set pot_focolare_lib [iter_check_num $pot_focolare_lib 2]
            if {$pot_focolare_lib == "Error"} {
                element::set_error $form_name pot_focolare_lib "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $pot_focolare_lib] >=  [expr pow(10,5)]
		    ||  [iter_set_double $pot_focolare_lib] <= -[expr pow(10,5)]} {
                    element::set_error $form_name pot_focolare_lib "Deve essere inferiore di 100.000"
                    incr error_num
                }
            }
        }
        if {![string equal $pot_utile_lib ""]} {
            set pot_utile_lib [iter_check_num $pot_utile_lib 2]
            if {$pot_utile_lib == "Error"} {
                element::set_error $form_name pot_utile_lib "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $pot_utile_lib] >=  [expr pow(10,5)]
		    ||  [iter_set_double $pot_utile_lib] <= -[expr pow(10,5)]} {
                    element::set_error $form_name pot_utile_lib "Deve essere inferiore di 100.000"
                    incr error_num
                }
            }
        }

	set flag_pot_focolare_nom_ok "f"
        if {[string equal $pot_focolare_nom ""]} {
	    element::set_error $form_name pot_focolare_nom "Inserire"
	    incr error_num
	} else {
            set pot_focolare_nom [iter_check_num $pot_focolare_nom 2]
            if {$pot_focolare_nom == "Error"} {
                element::set_error $form_name pot_focolare_nom "Deve essere numerico, max 2 dec"
                incr error_num
            } elseif {$pot_focolare_nom <= 0} {
		element::set_error $form_name pot_focolare_nom "Deve essere > 0,00"
		incr error_num
	    } elseif {[iter_set_double $pot_focolare_nom] >= [expr pow(10,5)]} {
		element::set_error $form_name pot_focolare_nom "Deve essere inferiore di 100.000"
		incr error_num
	    } else {
		set flag_pot_focolare_nom_ok "t"
	    }
	}

	set flag_pot_utile_nom_ok "f"
	if {[string equal $pot_utile_nom ""]} {
	    element::set_error $form_name pot_utile_nom "Inserire"
	    incr error_num
	} else {
            set pot_utile_nom [iter_check_num $pot_utile_nom 2]
            if {$pot_utile_nom == "Error"} {
                element::set_error $form_name pot_utile_nom "Deve essere numerico, max 2 dec"
                incr error_num
            } elseif {$pot_utile_nom <= 0} {
		element::set_error $form_name pot_utile_nom "Deve essere > 0,00"
		incr error_num	
	    } elseif {[iter_set_double $pot_utile_nom] >= [expr pow(10,5)]} {
		element::set_error $form_name pot_utile_nom "Deve essere inferiore di 100.000"
		incr error_num
            } else {
		set flag_pot_utile_nom_ok "t"
	    }
	}

	if {$flag_tipo_impianto eq "F" } {#sim04 if e suo contenuto

	    set flag_pot_utile_nom_freddo_ok "f";#sim04
	if {[string equal $pot_utile_nom_freddo ""]} {#sim04 if else e loro contenuto
	    element::set_error $form_name pot_utile_nom_freddo "Inserire"
	    incr error_num
	} else {
            set pot_utile_nom_freddo [iter_check_num $pot_utile_nom_freddo 2]
            if {$pot_utile_nom_freddo == "Error"} {
                element::set_error $form_name pot_utile_nom_freddo "Deve essere numerico, max 2 dec"
                incr error_num
            } elseif {$pot_utile_nom_freddo <= 0} {
		element::set_error $form_name pot_utile_nom_freddo "Deve essere > 0,00"
		incr error_num	
	    } elseif {[iter_set_double $pot_utile_nom_freddo] >= [expr pow(10,5)]} {
		element::set_error $form_name pot_utile_nom_freddo "Deve essere inferiore di 100.000"
		incr error_num
            } else {
		set flag_pot_utile_nom_freddo_ok "t"
	    }
	}



	    if {$flag_pot_focolare_nom_ok eq "t" && $flag_pot_utile_nom_freddo_ok eq "t"} {
		if {$pot_utile_nom_freddo > $pot_focolare_nom} {
		    element::set_error $form_name pot_utile_nom_freddo "Potenza utile deve essere <= alla potenza nominale"
		    incr error_num
		    set flag_potenza_utile_ok "f"
		}
	    }	    

	} else {#sim04
	if {$flag_pot_focolare_nom_ok eq "t" && $flag_pot_utile_nom_ok eq "t"} {#san03: aggiunta if e suo contenuto
            if {$pot_utile_nom >= $pot_focolare_nom} { #gac04 modificato if e messaggio errore 
   	        element::set_error $form_name pot_utile_nom "Potenza utile deve essere < alla potenza nominale"
	        incr error_num
                set flag_potenza_utile_ok "f"
            }
	} 




    };#sim04


        if {![string equal $data_costruz_gen ""]} {
           if {[string length $data_costruz_gen] == 4} {
                 set data_costruz_gen "01/01/$data_costruz_gen"
           };#sandro07082018
            set data_costruz_gen [iter_check_date $data_costruz_gen]
            if {$data_costruz_gen == 0} {
                element::set_error $form_name data_costruz_gen "Inserire correttamente"
                incr error_num
            } else {
		if {$data_costruz_gen > $current_date} {
		    element::set_error $form_name data_costruz_gen "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {![string equal $data_costruz_bruc ""]} {
            set data_costruz_bruc [iter_check_date $data_costruz_bruc]
            if {$data_costruz_bruc == 0} {
                element::set_error $form_name data_costruz_bruc "Inserire correttamente"
                incr error_num
            } else {
		if {$data_costruz_bruc > $current_date} {
		    element::set_error $form_name data_costruz_bruc  "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

        if {![string equal $data_installaz_bruc ""]} {
            set data_installaz_bruc [iter_check_date $data_installaz_bruc]
            if {$data_installaz_bruc == 0} {
                element::set_error $form_name data_installaz_bruc "Inserire correttamente"
                incr error_num
            } else {
		if {$data_installaz_bruc > $current_date} {
		    element::set_error $form_name data_installaz_bruc  "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

	if {![string equal $data_costruz_bruc ""]
	    && ![string equal $data_installaz_bruc ""]} {
	    if {$data_costruz_bruc > $data_installaz_bruc} {
		element::set_error $form_name data_costruz_bruc  "Data deve essere anteriore alla data di installazione"
		incr error_num
	    }
	}

	if {![string equal $data_costruz_gen ""]
	    && ![string equal $data_installaz ""]} {
	    if {$data_costruz_gen > $data_installaz} {
		element::set_error $form_name data_costruz_gen  "Data deve essere anteriore alla data di installazione"
		incr error_num
	    }
	}
	if {($coimtgen(regione) eq "MARCHE") } {#rom02 if e suo contenuto
	    #rom02 se dpr_660_96 equivale a 'S'(Standard) , data_costruz_gen è successiva al 26/09/2015, 
	    #rom02 il combustibile è liquido o solido e tipo_foco non è 'A' (Aperta) do il messaggio di errore e blocco.
	    if {$flag_tipo_impianto ne "F"} {#rom05 aggiunta if
		if { $dpr_660_96 eq "S" && $data_costruz_gen >"20150906" && [db_0or1row q "select 1 
                                                                                             from coimcomb 
                                                                                            where cod_combustibile = :cod_combustibile 
                                                                                              and tipo in ('L' , 'G')"] && $tipo_foco ne "A" 
		 } {
		    element::set_error $form_name dpr_660_96 "In base alla Direttiva 2005/32/CE \"Ecodesign\" se<br>la 'data costruzione' è successiva al 26/09/2015 il campo<br>'Classif. DPR 660/96' può essere solo 'A gas a condensazione'.<br>A meno che alla voce 'Camera di combustione' non venga selezionata la tipologia  'Aperta'" 
		    incr error_num
		    
		}
		
		if {$dpr_660_96 eq "B" && $flag_caldaia_comb_liquid eq ""} {
		    element::set_error $form_name flag_caldaia_comb_liquid "Selezionare se si tratta di una caldaia a condensazione che utilizza combustibile liquido"
		    incr error_num
		}
		if {$dpr_660_96 ne "B" && $flag_caldaia_comb_liquid ne ""} {
		    element::set_error $form_name flag_caldaia_comb_liquid "Valorizzare solo per Classif. DPR 660/96 a bassa temperatura"
		    incr error_num
		}
	    };#rom05
	};#rom02
        if {![string equal $data_rottamaz_bruc ""]} {
            set data_rottamaz_bruc [iter_check_date $data_rottamaz_bruc]
            if {$data_rottamaz_bruc == 0} {
                element::set_error $form_name data_rottamaz_bruc "Inserire correttamente"
                incr error_num
            } else {
		if {$data_rottamaz_bruc > $current_date} {
		    element::set_error $form_name data_rottamaz_bruc  "Data deve essere anteriore alla data odierna"
		    incr error_num
		}
	    }
        }

	if {![string equal $campo_funzion_max ""]
	    && [string equal $campo_funzion_min ""]} {
	    element::set_error $form_name campo_funzion_min "Inserire anche il valore minimo"
	    incr error_num
	}

	if {![string equal $campo_funzion_min ""]
	    && [string equal $campo_funzion_max ""]} {
	    element::set_error $form_name campo_funzion_max "Inserire anche il valore massimo"
	    incr error_num
	}

        if {![string equal $campo_funzion_max ""]} {
            set campo_funzion_max [iter_check_num $campo_funzion_max 2]
            if {$campo_funzion_max == "Error"} {
                element::set_error $form_name campo_funzion_max "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $campo_funzion_max] >=  [expr pow(10,7)]
		    ||  [iter_set_double $campo_funzion_max] <= -[expr pow(10,7)]} {
                    element::set_error $form_name campo_funzion_max "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

        if {![string equal $campo_funzion_min ""]} {
            set campo_funzion_min [iter_check_num $campo_funzion_min 2]
            if {$campo_funzion_min == "Error"} {
                element::set_error $form_name campo_funzion_min "Deve essere numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $campo_funzion_min] >=  [expr pow(10,7)]
		    ||  [iter_set_double $campo_funzion_min] <= -[expr pow(10,7)]} {
                    element::set_error $form_name campo_funzion_min "Deve essere inferiore di 10.000.000"
                    incr error_num
                }
            }
        }

	if {![string equal $campo_funzion_min ""]
	    && ![string equal $campo_funzion_max ""]
	    && $campo_funzion_min > $campo_funzion_max} {
            element::set_error $form_name campo_funzion_min "Il val. min deve essere < del val. max"
	    incr error_num
        }

	if {![string equal $data_installaz_bruc ""]
	    && ![string equal $data_rottamaz_bruc ""]} {
            if {$data_rottamaz_bruc < $data_installaz_bruc} {
                element::set_error $form_name data_rottamaz_bruc "Data rottamazione bruc deve. essere > di data installazione bruc."
                incr error_num
	    }
	}

        if {![string equal $carica_refrigerante ""]} {;#dpr74: aggiunta if ed il suo contenuto
            set carica_refrigerante [iter_check_num $carica_refrigerante 2]
            if {$carica_refrigerante == "Error"} {
                element::set_error $form_name carica_refrigerante "numerico, max 2 dec"
                incr error_num
            } else {
		if {$carica_refrigerante < "0.01"} {
		    element::set_error $form_name carica_refrigerante "deve essere &gt; di 0,00"
		    incr error_num
		} else {
		    if {[iter_set_double $carica_refrigerante] >=  [expr pow(10,8)]
		    ||  [iter_set_double $carica_refrigerante] <= -[expr pow(10,8)]} {
			element::set_error $form_name carica_refrigerante "Deve essere < di 100.000.000"
			incr error_num
		    }
                }
            }
        }
	if {($coimtgen(regione) eq "MARCHE")} {#rom02 if e suo contenuto
	    if {$flag_tipo_impianto ne "F"} {#rom05 aggiunta if
		if {$funzione_grup_ter eq "A" && $funzione_grup_ter_note_altro eq ""} {
		    
		    element::set_error $form_name funzione_grup_ter_note_altro "Compilare \"Note Funzione GT\" specificando il tipo di funzione alternativo"
		    
		    #element::set_error $form_name funzione_grup_ter_note_altro "Specificare Altro"
		    incr error_num
		}
		if {$funzione_grup_ter ne "A" && $funzione_grup_ter_note_altro ne ""} {
		    
		    element::set_error $form_name funzione_grup_ter_note_altro "Compilare solo in caso di Funzione del GT = \"Altro\""
		    
		    #element::set_error $form_name funzione_grup_ter_note_altro "Per specificare le Note è necessario selezionare 'Altro' in 'Funzione del Gruppo Termico'"
		    incr error_num
		}
	    };#rom05
	    #gac03 aggiunta if e suo contenuto
	    if {$rif_uni_10389 eq "A" && $altro_rif eq ""} {#gac03
		element::set_error $form_name altro_rif "Compilare \"Altro\""
		incr error_num
	    };#gac03
	    if {$rif_uni_10389 ne "A" && $altro_rif ne ""} {#gac03
		element::set_error $form_name altro_rif "Compilare solo in caso di \"Riferimento = Altro\""
		incr error_num
            };#gac03
	};#rom02

	set cod_coimtpin ""
	set descrizione_tpin ""

	if {$coimtgen(regione) eq "MARCHE" && $flag_tipo_impianto ne "" && $cod_combustibile ne "" && $cod_manutentore ne ""} {#rom03 if e suo contenuto
	    
	    
	    if {[db_0or1row q "select 1
                             from coimtpin_abilitazioni
                            where flag_tipo_impianto = :flag_tipo_impianto
                              and tipo_combustibile is not null
                            limit 1"]} {
		
		db_0or1row q "select a.cod_coimtpin
                               , b.descrizione as descrizione_tpin
                            from coimtpin_abilitazioni a
                               , coimtpin b
                           where a.flag_tipo_impianto = :flag_tipo_impianto
                             and a.tipo_combustibile  = :tipo_comb
                             and a.cod_coimtpin       = b.cod_coimtpin"
		
	    } else {
		
		db_0or1row q "select a.cod_coimtpin
                               , b.descrizione as descrizione_tpin
                            from coimtpin_abilitazioni a
                               , coimtpin b
                           where a.flag_tipo_impianto = :flag_tipo_impianto
                             and a.cod_coimtpin = b.cod_coimtpin"
		
	    }                                 
	    
	    if {![db_0or1row q "select 1
                              from coimtpin_manu
                             where cod_coimtpin    = :cod_coimtpin
                               and cod_manutentore = :cod_manutentore"]} {
		
		element::set_error $form_name cod_combustibile "Utente non abilitato per l'inserimento<br>di \"$descrizione_tpin\""
		incr error_num
	    }
	    
	};#rom03
	if {$flag_tipo_impianto eq "R"} {#rom02 if e contenuto 
	    if {![string equal $rend_ter_max ""]} {#sim08 if e suo contenuto
		set rend_ter_max [iter_check_num $rend_ter_max 2]
		if {$rend_ter_max == "Error"} {
		    element::set_error $form_name rend_ter_max "Deve essere numerico, max 2 dec"
		    incr error_num
		}
	    }
	    if {[string equal $rend_ter_max ""]} {
		element::set_error $form_name rend_ter_max "Campo obbligatorio"
		incr error_num
	    }

	    set check_rend_ter_max $rend_ter_max
	    set evidenzia_rend_ter "f"
	    if {$coimtgen(regione) eq "MARCHE"} {#rom04 if e suo contenuto
		if {$flag_tipo_impianto ne "F"} {#rom05 aggiunta if
		    if {(($dpr_660_96 eq "B" || $dpr_660_96 eq "G") && ($check_rend_ter_max <= "85" || $check_rend_ter_max >= "120"))  
			|| (($tipo_comb eq "L" || $tipo_comb eq "G") && $dpr_660_96 eq "S" && ($check_rend_ter_max <= "78"  || $check_rend_ter_max >= "100") )
			|| ($tipo_comb eq "S" && $dpr_660_96 eq "S" && ($check_rend_ter_max <= "50" || $check_rend_ter_max >= "100"))
		    } {
			set evidenzia_rend_ter "t"

			if {$conferma_rend_ter == "s"} {
			    element::set_error $form_name dpr_660_96 "<big>Warning:</big> Valore del \"Rendimento termico utile a Pn max\" inserito nella Scheda 4.1 non congruo rispetto al tipo combustibile e al tipo \"Classif. DPR 660/96\" qui inserito: correggere il dato errato."
			    if {$error_num == 0} {
				element set_properties $form_name conferma_rend_ter -value "n"
			    }
			    incr error_num
			}
		    }
		};#rom05
	    };#rom04
	};#rom02
	element set_properties $form_name evidenzia_rend_ter           -value $evidenzia_rend_ter
    	
    }


    #sim07 inizio:dato che il controllo diventa bloccante ho spostato qui il pezzo di codice che prima
    #sim07 si trovava in fondo al programma. Eseguo il controllo solo se non ho nessun errore sulle variepotenze
    if {$error_num == 0} {
	
	# aggiorno l'impianto valorizzando il numero di generatori
	# le potenze e la fascia con la somma dei valori
	# corrispondenti di tutti i generatori attivi
	db_1row sel_gend_count_x "
                 select count(*)              as count_gend
                      , sum(pot_focolare_nom) as tot_pot_focolare_nom
                      , sum(pot_utile_nom)    as tot_pot_utile_nom
                      , sum(pot_utile_nom_freddo) as tot_pot_utile_nom_freddo --sim04
                      , sum(pot_focolare_lib) as tot_pot_focolare_lib --sim01 per il freddo è la potenza riscaldam. nominale
                      , sum(pot_utile_lib)    as tot_pot_utile_lib    --sim01 per il freddo è la potenza riscaldamento utile
                   from coimgend
                  where cod_impianto = :cod_impianto
                    and gen_prog != :gen_prog --sim07
                    and flag_attivo  = 'S'"
	    
	#sim09 aggiunto condizione su flag_attivo
	if {$funzione ne "D" && $flag_attivo eq  "S"} {#sim07 se sono in inserimento o modifica devo tener conto della potenza che sto aggiungendo o modificando
	    
	    set count_gend [expr $count_gend + 1]
	    
	    db_1row q "select coalesce(:tot_pot_focolare_nom,0.00) + coalesce(:pot_focolare_nom,0.00) as tot_pot_focolare_nom
                            , coalesce(:tot_pot_utile_nom,0.00)    + coalesce(:pot_utile_nom,0.00)    as tot_pot_utile_nom
                            , coalesce(:tot_pot_utile_nom_freddo,0.00) + coalesce(:pot_utile_nom_freddo,0.00) as tot_pot_utile_nom_freddo 
                            , coalesce(:tot_pot_focolare_lib,0.00) + coalesce(:pot_focolare_lib,0.00) as tot_pot_focolare_lib
                            , coalesce(:tot_pot_utile_lib,0.00) + coalesce(:pot_utile_lib,0.00)    as tot_pot_utile_lib "
	}    	    
	
	#sim01 Per i generatori del freddo, mettiamo nell'impianto la potenza maggiore
	#sim01 tra quella di raffreddamento e quella di riscaldamento
	#sim01 (viene valvata nella potenza libretto).
	if {$flag_tipo_impianto eq "F" } {#sim01 aggiunta if e suo contenuto 
	    set tot_pot_utile_nom $tot_pot_utile_nom_freddo;#sim04
	    if {$tot_pot_focolare_lib > $tot_pot_focolare_nom} {
		set tot_pot_focolare_nom $tot_pot_focolare_lib
	    }
	    
	    if {$tot_pot_utile_lib > $tot_pot_utile_nom} {
		set tot_pot_utile_nom $tot_pot_utile_lib
	    }
	}
	
	#nic03 if {$coimtgen(regione) eq "MARCHE"} #san02
	if {$coimtgen(flag_potenza) eq "pot_utile_nom"} {#nic03 (cambiata if)
	    set tot_potenza_chk $tot_pot_utile_nom;#san02
	    if {$flag_tipo_impianto eq "F" } {;#sim04 if else e loro contenuto
		set campo_potenza_per_errore "pot_utile_nom_freddo"
	    } else {
		set campo_potenza_per_errore "pot_utile_nom"
	    }
	} else {;#san02
	    set tot_potenza_chk $tot_pot_focolare_nom
	    set campo_potenza_per_errore "pot_focolare_nom";#sim04 
	};#san02
	
	#sim04
	
	#sim07 aggiunto condizione su funzione
	if {![string equal $tot_potenza_chk ""] &&
	    [db_0or1row check_fascia_pote ""]== 0 &&
	    $funzione ne "D"} {;#sim04
	    
	    element::set_error $form_name $campo_potenza_per_errore "non &egrave; compresa in nessuna fascia"
	    
	    incr error_num
	}
    }
    #sim07 fine
    
    
    #rom01 se esistono dichiarazini del caldo e del freddo non posso cambiare rispettivamente i campi num_prove_fumi e
    #rom01 num_circuiti.
    if {$funzione ==  "M" &&  [db_0or1row query "
                                select 1 
                                  from coimdimp b
                                 where b.cod_impianto   = :cod_impianto
                                   and b.gen_prog       = :gen_prog
                                   and flag_tracciato   in ('R1','R2','G','F')
                                 limit 1"]    
    } {#rom01 if e suo contenuto

	db_1row q "select num_prove_fumi as num_prove_fumi_old
                        , num_circuiti as num_circuiti_old 
                     from coimgend 
                    where cod_impianto = :cod_impianto 
                      and gen_prog     = :gen_prog"

	if {$flag_tipo_impianto eq "R" && $num_prove_fumi_old ne "" && $num_prove_fumi_old != $num_prove_fumi} {

	    element::set_error $form_name num_prove_fumi "Esistono già RCEE col numero prove fumi indicato.<br>Dismettere il generatore e aggiungerne uno nuovo."
	    incr error_num
	}

	if {$flag_tipo_impianto eq "F" && $num_circuiti_old ne "" && $num_circuiti_old != $num_circuiti} {

	    element::set_error $form_name num_circuiti "Esistono già RCEE col numero circuiti indicato.<br> Dismettere il generatore e aggiungerne uno nuovo."
	    incr error_num
	}
	

    }

    #gac02 controllo sui nuovi campi del cogeneratore
    if {![string equal $temp_h2o_uscita_min ""]} {
	set temp_h2o_uscita_min [iter_check_num $temp_h2o_uscita_min 2]
	if {$temp_h2o_uscita_min == "Error"} {
	    element::set_error $form_name temp_h2o_uscita_min "Deve essere numerico, max 2 dec"
	    incr error_num
	}
    }
    if {![string equal $temp_h2o_uscita_max ""]} {
	set temp_h2o_uscita_max [iter_check_num $temp_h2o_uscita_max 2]
	if {$temp_h2o_uscita_max == "Error"} {
	    element::set_error $form_name temp_h2o_uscita_max "Deve essere numerico, max 2 dec"
	    incr error_num
	}
	if {$temp_h2o_uscita_max < $temp_h2o_uscita_min} {
	    element::set_error $form_name temp_h2o_uscita "Max deve essere >= Min"
	    incr error_num
	}
    }

    if {![string equal $temp_h2o_ingresso_min ""]} {
	set temp_h2o_ingresso_min [iter_check_num $temp_h2o_ingresso_min 2]
	if {$temp_h2o_ingresso_min == "Error"} {
	    element::set_error $form_name temp_h2o_ingresso_min "Deve essere numerico, max 2 dec"
	    incr error_num
	}
    }
    if {![string equal $temp_h2o_ingresso_max ""]} {
	set temp_h2o_ingresso_max [iter_check_num $temp_h2o_ingresso_max 2]
	if {$temp_h2o_ingresso_max == "Error"} {
	    element::set_error $form_name temp_h2o_ingresso_max "Deve essere numerico, max 2 dec"
	    incr error_num
	}
	if {$temp_h2o_ingresso_max < $temp_h2o_ingresso_min} {
	    element::set_error $form_name temp_h2o_ingresso "Max deve essere >= Min"
	    incr error_num
	}
    }
    if {![string equal $temp_h2o_motore_min ""]} {
	set temp_h2o_motore_min [iter_check_num $temp_h2o_motore_min 2]
	if {$temp_h2o_motore_min == "Error"} {
	    element::set_error $form_name temp_h2o_motore_min "Deve essere numerico, max 2 dec"
	    incr error_num
	}
    }
    if {![string equal $temp_h2o_motore_max ""]} {
	set temp_h2o_motore_max [iter_check_num $temp_h2o_motore_max 2]
	if {$temp_h2o_motore_max == "Error"} {
	    element::set_error $form_name temp_h2o_motore_max "Deve essere numerico, max 2 dec"
	    incr error_num
	}
	if {$temp_h2o_motore_max < $temp_h2o_motore_min} {
	    element::set_error $form_name temp_h2o_motore "Max deve essere >= Min"
	    incr error_num
	}
    }
    if {![string equal $temp_fumi_valle_min ""]} {
	set temp_fumi_valle_min [iter_check_num $temp_fumi_valle_min 2]
	if {$temp_fumi_valle_min == "Error"} {
	    element::set_error $form_name temp_fumi_valle_min "Deve essere numerico, max 2 dec"
	    incr error_num
	}
    }
    if {![string equal $temp_fumi_valle_max ""]} {
	set temp_fumi_valle_max [iter_check_num $temp_fumi_valle_max 2]
	if {$temp_fumi_valle_max == "Error"} {
	    element::set_error $form_name temp_fumi_valle_max "Deve essere numerico, max 2 dec"
	    incr error_num
	}
	if {$temp_fumi_valle_max < $temp_fumi_valle_min} {
	    element::set_error $form_name temp_fumi_valle "Max deve essere >= Min"
	    incr error_num
	}
    }
    if {![string equal $temp_fumi_monte_min ""]} {
	set temp_fumi_monte_min [iter_check_num $temp_fumi_monte_min 2]
	if {$temp_fumi_monte_min == "Error"} {
	    element::set_error $form_name temp_fumi_monte_min "Deve essere numerico, max 2 dec"
	    incr error_num
	}
    }
    if {![string equal $temp_fumi_monte_max ""]} {
	set temp_fumi_monte_max [iter_check_num $temp_fumi_monte_max 2]
	if {$temp_fumi_monte_max == "Error"} {
	    element::set_error $form_name temp_fumi_monte_max "Deve essere numerico, max 2 dec"
	    incr error_num
	}
	if {$temp_fumi_monte_max < $temp_fumi_monte_min} {
	    element::set_error $form_name temp_fumi_monte "Max deve essere >= Min"
	    incr error_num
	}
    }
    if {![string equal $emissioni_monossido_co_min ""]} {
	set emissioni_monossido_co_min [iter_check_num $emissioni_monossido_co_min 2]
	if {$emissioni_monossido_co_min == "Error"} {
	    element::set_error $form_name emissioni_monossido_co_min "Deve essere numerico, max 2 dec"
	    incr error_num
	}
    }
    if {![string equal $emissioni_monossido_co_max ""]} {
	set emissioni_monossido_co_max [iter_check_num $emissioni_monossido_co_max 2]
	if {$emissioni_monossido_co_max == "Error"} {
	    element::set_error $form_name emissioni_monossido_co_max "Deve essere numerico, max 2 dec"
	    incr error_num
	}
	if {$emissioni_monossido_co_max < $emissioni_monossido_co_min} {
	    element::set_error $form_name emissioni_monossido_co "Max deve essere >= Min"
	    incr error_num
	}
    }
#gac02 fine controlli
    if {$error_num > 0} {
        ad_return_template
        return
    }       
 
 
    # Lancio la query di manipolazione dati contenuta in dml_sql
    with_catch error_msg {
	db_transaction {
	    switch $funzione {
		S {
		    db_dml upd_gend_x "update coimgend
                   set gen_prog         = :gen_prog
                     , descrizione      = :descrizione
                     , matricola        = :matricola
                     , modello          = :modello
                     , cod_cost         = :cod_cost
                     , matricola_bruc   = :matricola_bruc
                     , modello_bruc     = :modello_bruc
                     , cod_cost_bruc    = :cod_cost_bruc
                     , tipo_foco        = :tipo_foco
                     , mod_funz         = :mod_funz
                     , cod_utgi         = :cod_utgi
                     , tipo_bruciatore  = :tipo_bruciatore
                     , tiraggio         = :tiraggio
                     , locale           = :locale
                     , cod_emissione    = :cod_emissione
                     , cod_combustibile = :cod_combustibile
                     , data_installaz   = :data_installaz
                     , data_rottamaz    = :data_rottamaz
                     , pot_focolare_lib = :pot_focolare_lib
                     , pot_utile_lib    = :pot_utile_lib
                     , pot_focolare_nom = :pot_focolare_nom
                     , pot_utile_nom    = :pot_utile_nom
                     , pot_utile_nom_freddo    = :pot_utile_nom_freddo --sim04
                     , flag_attivo      = :flag_attivo
                     , note             = :note
                     , data_mod         =  current_date
                     , utente           = :id_utente
		     , gen_prog_est     = :gen_prog
                     , data_costruz_gen    = :data_costruz_gen
                     , data_costruz_bruc   = :data_costruz_bruc
                     , data_installaz_bruc = :data_installaz_bruc
                     , data_rottamaz_bruc  = :data_rottamaz_bruc
                     , marc_effic_energ    = :marc_effic_energ
                     , campo_funzion_max   = :campo_funzion_max
                     , campo_funzion_min   = :campo_funzion_min
                     , dpr_660_96          = :dpr_660_96
                     , cod_tpco            = :cod_tpco            -- dpr74
                     , cod_flre            = :cod_flre            -- dpr74
                     , carica_refrigerante = :carica_refrigerante -- dpr74
                     , sigillatura_carica  = :sigillatura_carica  -- dpr74
                     , cod_mode            = :cod_mode            -- nic01
                     , cod_mode_bruc       = :cod_mode_bruc       -- nic01
                     , cod_grup_term       = :cod_grup_term       -- san01
                     , num_circuiti        = :num_circuiti        -- sim05
                     , num_prove_fumi      = :num_prove_fumi      -- rom01
                     , per                 = :per                 -- sim08
                     , cop                 = :cop                 -- sim08
                     , tipologia_cogenerazione     = :tipologia_cogenerazione    --gac02
                     , temp_h2o_uscita_min         = :temp_h2o_uscita_min        --gac02
                     , temp_h2o_uscita_max         = :temp_h2o_uscita_max        --gac02
                     , temp_h2o_ingresso_min       = :temp_h2o_ingresso_min      --gac02
                     , temp_h2o_ingresso_max       = :temp_h2o_ingresso_max      --gac02
                     , temp_h2o_motore_min         = :temp_h2o_motore_min        --gac02
                     , temp_h2o_motore_max         = :temp_h2o_motore_max        --gac02
                     , temp_fumi_valle_min         = :temp_fumi_valle_min        --gac02
                     , temp_fumi_valle_max         = :temp_fumi_valle_max        --gac02
                     , temp_fumi_monte_min         = :temp_fumi_monte_min        --gac02
                     , temp_fumi_monte_max         = :temp_fumi_monte_max        --gac02
                     , emissioni_monossido_co_max  = :emissioni_monossido_co_max --gac02
                     , emissioni_monossido_co_min  = :emissioni_monossido_co_min --gac02
                     , funzione_grup_ter            = :funzione_grup_ter            --rom02
                     , funzione_grup_ter_note_altro = :funzione_grup_ter_note_altro --rom02
                     , flag_caldaia_comb_liquid     = :flag_caldaia_comb_liquid     --rom02
                     , rend_ter_max                 = :rend_ter_max                 --rom02
                     , rif_uni_10389                = :rif_uni_10389                --gac03
                     , altro_rif                    = :altro_rif                    --gac03
                     , altro_funz                   = :altro_funz                   --rom04
                 where cod_impianto = :cod_impianto
                   and gen_prog     = :gen_prog_old"

		    db_dml ins_gend_x "insert
                  into coimgend 
                     ( cod_impianto
                     , gen_prog
                     , descrizione
                     , matricola
                     , modello
                     , cod_cost
                     , matricola_bruc
                     , modello_bruc
                     , cod_cost_bruc
                     , tipo_foco
                     , mod_funz
                     , cod_utgi
                     , tipo_bruciatore
                     , tiraggio
                     , locale
                     , cod_emissione
                     , cod_combustibile
                     , data_installaz
                     , data_rottamaz
                     , pot_focolare_lib
                     , pot_utile_lib
                     , pot_focolare_nom
                     , pot_utile_nom
                     , pot_utile_nom_freddo --sim04
                     , flag_attivo
                     , note
                     , data_ins 
                     , utente
		     , gen_prog_est
                     , data_costruz_gen
                     , data_costruz_bruc
                     , data_installaz_bruc
                     , data_rottamaz_bruc
                     , marc_effic_energ
                     , campo_funzion_max
                     , campo_funzion_min
                     , dpr_660_96
                     , cod_tpco            -- dpr74
                     , cod_flre            -- dpr74
                     , carica_refrigerante -- dpr74
                     , sigillatura_carica  -- dpr74
                     , cod_mode            -- nic01
                     , cod_mode_bruc       -- nic01
                     , cod_grup_term       -- san01
                     , num_circuiti        -- sim05
                     , num_prove_fumi      -- rom01
                     , per                 -- sim08
                     , cop                 -- sim08
                     , tipologia_cogenerazione    --gac02
                     , temp_h2o_uscita_min        --gac02
                     , temp_h2o_uscita_max        --gac02
                     , temp_h2o_ingresso_min      --gac02
                     , temp_h2o_ingresso_max      --gac02
                     , temp_h2o_motore_min        --gac02
                     , temp_h2o_motore_max        --gac02
                     , temp_fumi_valle_min        --gac02
                     , temp_fumi_valle_max        --gac02
                     , temp_fumi_monte_min        --gac02
                     , temp_fumi_monte_max        --gac02
                     , emissioni_monossido_co_max --gac02
                     , emissioni_monossido_co_min --gac02
                     , funzione_grup_ter            --rom02
                     , funzione_grup_ter_note_altro --rom02
                     , flag_caldaia_comb_liquid     --rom02
                     , rend_ter_max                 --rom02
                     , rif_uni_10389                --gac03
                     , altro_rif                    --gac03
                     , altro_funz                   --rom04
		     )
                values 
                     (:cod_impianto
                     ,:gen_prog
                     ,:descrizione
                     ,:matricola
                     ,:modello
                     ,:cod_cost
                     ,:matricola_bruc
                     ,:modello_bruc
                     ,:cod_cost_bruc
                     ,:tipo_foco
                     ,:mod_funz
                     ,:cod_utgi
                     ,:tipo_bruciatore
                     ,:tiraggio
                     ,:locale
                     ,:cod_emissione
                     ,:cod_combustibile
                     ,:data_installaz
                     ,:data_rottamaz
                     ,:pot_focolare_lib
                     ,:pot_utile_lib
                     ,:pot_focolare_nom
                     ,:pot_utile_nom
                     ,:pot_utile_nom_freddo --sim04
                     ,:flag_attivo
                     ,:note
                     , current_date
                     ,:id_utente
		     ,:gen_prog
                     ,:data_costruz_gen
                     ,:data_costruz_bruc
                     ,:data_installaz_bruc
                     ,:data_rottamaz_bruc
                     ,:marc_effic_energ
                     ,:campo_funzion_max
                     ,:campo_funzion_min
                     ,:dpr_660_96
                     ,:cod_tpco            -- dpr74
                     ,:cod_flre            -- dpr74
                     ,:carica_refrigerante -- dpr74
                     ,:sigillatura_carica  -- dpr74
                     ,:cod_mode            -- nic01
                     ,:cod_mode_bruc       -- nic01
                     ,:cod_grup_term       -- san01
                     ,:num_circuiti        -- sim05
                     ,:num_prove_fumi      -- rom01
                     ,:per                 -- sim08
                     ,:cop                 -- sim08
                     ,:tipologia_cogenerazione    --gac02
                     ,:temp_h2o_uscita_min        --gac02
                     ,:temp_h2o_uscita_max        --gac02
                     ,:temp_h2o_ingresso_min      --gac02
                     ,:temp_h2o_ingresso_max      --gac02
                     ,:temp_h2o_motore_min        --gac02
                     ,:temp_h2o_motore_max        --gac02
                     ,:temp_fumi_valle_min        --gac02
                     ,:temp_fumi_valle_max        --gac02
                     ,:temp_fumi_monte_min        --gac02
                     ,:temp_fumi_monte_max        --gac02
                     ,:emissioni_monossido_co_max --gac02
                     ,:emissioni_monossido_co_min --gac02
                     ,:funzione_grup_ter            --rom02
                     ,:funzione_grup_ter_note_altro --rom02
                     ,:flag_caldaia_comb_liquid     --rom02
                     ,:rend_ter_max                 --rom02
                     ,:rif_uni_10389                --gac03
                     ,:altro_rif                    --gac03
                     ,:altro_funz                   --rom04
		     )"
		}
	    }
	    if {$funzione != "V"} {

		#sim07 tolto da qui il controllo sulla fascia di potenza

		# aggiorno il numero generatori
		db_dml upd_aimp_x "
                update coimaimp
                   set n_generatori = :count_gend
                     , data_mod     =  current_date
                     , utente       = :id_utente
                 where cod_impianto = :cod_impianto"

		# aggiorno la potenza focolare dell'impianto
		if {![string equal $tot_pot_focolare_nom ""]} {
		    db_dml upd_aimp_potenza_x "
                    update coimaimp
                       set potenza      = :tot_pot_focolare_nom
                     where cod_impianto = :cod_impianto"
		}
	    
		# aggiorno la potenza utile dell'impianto
		if {![string equal $tot_pot_utile_nom ""]} {
		    db_dml upd_aimp_potenza_utile_x "
                    update coimaimp
                       set potenza_utile = :tot_pot_utile_nom
                     where cod_impianto  = :cod_impianto"
		}

		# aggiorno la fascia di potenza dell'impianto
		if {![string equal $tot_potenza_chk ""]} {
		    if {[db_0or1row sel_pote_cod_x "
                        select cod_potenza 
                          from coimpote
                         where :tot_potenza_chk between potenza_min and potenza_max
                           and flag_tipo_impianto = :flag_tipo_impianto --sim03
                        "] == 1
		    } {
			db_dml upd_aimp_potenza_x "
                        update coimaimp
                           set cod_potenza  = :cod_potenza
                         where cod_impianto = :cod_impianto"
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

    if {$error_num > 0} {;#sim04
        ad_return_template
        return
    }

    # dopo l'inserimento posiziono la lista sul record inserito
    if {$funzione == "I"} {
        set last_gen_prog $gen_prog
    }
    set link_list      [subst $link_list_script]
    set link_gest      [export_url_vars cod_impianto gen_prog last_gen_prog nome_funz nome_funz_caller url_list_aimp url_aimp extra_par caller]
    switch $funzione {
        S {set return_url   "coimgend-gest?funzione=V&$link_gest"}
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template
