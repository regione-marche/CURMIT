ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimaimp"
    @author          Valentina Catte
    @creation-date   25/08/2004

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimaimp-isrt-veloce.tcl

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    sim03 22/05/2017 Personaliz. per Comune di Jesi: ricodificare gli impianti come da Legge
    sim03            Reg. Marche CMJE.
    sim03            Per Comune di Senigalli: CMSE

    gab03 12/04/2017 Personaliz. per Provincia di Ancona: ricodificare gli impianti come da Legge
    gab03            Reg. Marche PRAN.

    gab02 06/04/2017 Faccio vedere nella tendina della fascia di potenza soltanto le potenze del
    gab02            caldo.

    gab01 08/02/2017 Personaliz. per Comune di Ancona: ricodificare gli impianti come da Legge
    gab01            Reg. Marche CMAN.

    sim02 27/09/2016 Taranto ha il cod. impianto composto dalle ultime 3 cifre del cod. istat 
    sim02            + un progressivo

    nic06 04/02/2016 Gestito coimtgen.lun_num_cod_impianto_est per regione MARCHE

    nic05 03/12/2015 Per la provincia di massa, il cod_impianto_est va costruito in modo
    nic05            particolare

    sim01 28/09/2015 Da ottobre 2015 gli enti della regione marche devono costruire il codice
    sim01            impianto con una sigla imposta dalla regione (es: CMPS) + un progressivo
    sim01            di 6 cifre.

    nic04 07/09/2015 Modifica valorizzazione di cod_impianto_est_new per CPESARO e PPU.

    nic03 16/05/2014 Comune di Rimini: se è attivo il parametro flag_gest_coimmode, deve
    nic03            comparire un menù a tendina con l'elenco dei modelli relativi al
    nic03            costruttore selezionato (tale menù a tendina deve essere rigenerato
    nic03            quando si cambia la scelta del costruttore).
    nic03            Ho dovuto aggiungere la gestione dei campi __refreshing_p e changed_field.

    nic02 03/10/2013 Non viene codificato il codice impianto se il codice potenza è non noto e
    nic02            la potenza è valorizzata con 0 o null. Lo correggo.

    nic01 27/09/2013 Dopo aver inserito il proprietario, chiede nuovamente di fare il cerca.
    nic01            Lo correggo in modo analogo al coimaimp-isrt-manu dove funziona.
} {
    
   {cod_impianto         ""}
   {last_cod_impianto    ""}
   {funzione            "I"}
   {caller          "index"}
   {nome_funz            ""}
   {nome_funz_caller     ""}
   {extra_par            ""}
   {cod_aces             ""}
   {url_coimaces_list    ""}
   {stato_01             ""}
   {cod_impianto_est_new ""}
   {f_resp_cogn          ""} 
   {f_resp_nome          ""} 
   {f_comune             ""}
   {f_cod_via            ""}
   {f_desc_via           ""}
   {f_desc_topo          ""}
   {flag_ins_occu        ""}
   {flag_ins_prop        ""}
   {flag_ins_terzi       ""}
   {flag_tipo_impianto       "R"}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

iter_blocca_doppio_click;#06/12/2013

# Controlla lo user
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

iter_get_coimtgen
set flag_cod_aimp_auto  $coimtgen(flag_cod_aimp_auto)
set flag_ente           $coimtgen(flag_ente)
set sigla_prov          $coimtgen(sigla_prov)
set flag_codifica_reg   $coimtgen(flag_codifica_reg)
set lun_num_cod_imp_est $coimtgen(lun_num_cod_imp_est);#nic06

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set current_date      [iter_set_sysdate]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# controllo se l'utente � un comune
set cod_comune_chk [iter_check_uten_comu $id_utente]

# controllo se l'utente � un manutentore
set cod_manutentore [iter_check_uten_manu $id_utente]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_impianto caller nome_funz nome_funz_caller]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set link_aces {[export_url_vars nome_funz_caller]&[iter_set_url_vars $extra_par]}
set titolo           "Impianto"
switch $funzione {
    I {set button_label "Conferma Inserimento"
       set page_title   "Inserimento $titolo"}
}

if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar  [iter_context_bar \
                     [list "javascript:window.close()" "Torna alla Gestione"] \
                     [list coimaimp-list?$link_list "Lista Impianti"] \
                     "$page_title"]
}

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimaimp"
set focus_field  "";#nic03
set readonly_key "readonly"
set readonly_fld "readonly"
set readonly_cod "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
 
switch $funzione {
   "I" {set readonly_key \{\}
        set readonly_fld \{\}
        set disabled_fld \{\}
       }
}

if {$flag_cod_aimp_auto == "F"} {
    set readonly_cod \{\}
}

form create $form_name \
-html    $onsubmit_cmd

#impianto 
element create $form_name cod_impianto_est \
-label   "cod_impianto_est" \
-widget   text \
-datatype text \
-html    "size 20 maxlength 20 $readonly_cod {} class form_element" \
-optional

element create $form_name data_installaz \
-label   "data_installaz" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name anno_costruzione \
-label   "anno_costruzione" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_combustibile \
-label   "cod_combustibile" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimcomb cod_combustibile descr_comb] \

element create $form_name cod_tpim \
-label   "tipologia" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimtpim cod_tpim descr_tpim]


element create $form_name stato \
-label   "stato" \
-widget   select \
-datatype text \
-html    "size 1 maxlength 1 $disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimimst cod_imst descr_imst cod_imst]

element create $form_name data_attivaz \
-label   "data_attivaz" \
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

#ubicazione

element create $form_name localita \
-label   "Localita" \
-widget   text \
-datatype text \
-html    "size 25 maxlength 40 $readonly_fld {} class form_element" \
-optional

if {$coimtgen(flag_ente) == "P"} {
    if {$cod_comune_chk eq ""} { 
	element create $form_name cod_comune \
	    -label   "Comune" \
	    -widget   select \
	    -options [iter_selbox_from_comu]\
	    -datatype text \
	    -html    "class form_element" \
	    -optional
    } else {
	element create $form_name cod_comune \
	    -label   "Comune" \
	    -widget   select \
	    -datatype text \
	    -html    "disabled {} class form_element" \
	    -optional \
	    -options [iter_selbox_from_comu]
    }
} else {
    element create $form_name cod_comune \
    -widget hidden \
    -datatype text \
    -optional

    element create $form_name descr_comu \
    -label   "Comune" \
    -widget   text \
    -datatype text \
    -html    "size 27 maxlength 40  readonly {} class form_element" \
    -optional
}

element create $form_name provincia \
-label   "Prov" \
-widget   text \
-datatype text \
-html    "size 2 maxlength 2  readonly {} class form_element" \
-optional

element create $form_name cap \
-label   "CAP" \
-widget   text \
-datatype text \
-html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
-optional

element create $form_name descr_via \
-label   "Via" \
-widget   text \
-datatype text \
-html    "size 25 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name descr_topo \
-label   "Descrizione toponimo" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimtopo descr_topo descr_topo]

element create $form_name numero \
-label   "Numero" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name esponente \
-label   "Esponente" \
-widget   text \
-datatype text \
-html    "size 3 maxlength 3 $readonly_fld {} class form_element" \
-optional

element create $form_name scala \
-label   "Scala" \
-widget   text \
-datatype text \
-html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
-optional

element create $form_name piano \
-label   "Piano" \
-widget   text \
-datatype text \
-html    "size 4 maxlength 4 $readonly_fld {} class form_element" \
-optional

element create $form_name interno \
-label   "Interno" \
-widget   text \
-datatype text \
-html    "size 3 maxlength 3 $readonly_fld {} class form_element" \
-optional

#dati soggetti
#flag-responsabile
element create $form_name flag_responsabile \
-label   "responsabile" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Proprietario P} {Occupante O} {Amministratore A} {Intestatario I} {Terzi T}}

#intestatario
element create $form_name cognome_inte \
-label   "Cognome intestatario" \
-widget   text \
-datatype text \
-html    "size  18 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_inte \
-label   "Nome intestatario" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 100 $readonly_fld {} class form_element" \
-optional

#proprietario
element create $form_name cognome_prop \
-label   "Cognome proprietario" \
-widget   text \
-datatype text \
-html    "size 18 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_prop \
-label   "Nome proprietario" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 100 $readonly_fld {} class form_element" \
-optional

#occupante
element create $form_name cognome_occ \
-label   "Cognome occupante" \
-widget   text \
-datatype text \
-html    "size 18 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_occ \
-label   "Nome occupante" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 100 $readonly_fld {} class form_element" \
-optional

#amministratore
element create $form_name cognome_amm \
-label   "Cognome amministratore" \
-widget   text \
-datatype text \
-html    "size 18 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_amm \
-label   "Nome amministratore" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 100 $readonly_fld {} class form_element" \
-optional

#terzi
element create $form_name cognome_terzi \
-label   "Cognome terzi" \
-widget   text \
-datatype text \
-html    "size 18 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_terzi \
-label   "Nome terzi" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 100 $readonly_fld {} class form_element" \
-optional

#manutentore
if {[string equal $cod_manutentore ""]} {
    set sw_manu "f"
    set readonly_fld2 \{\}
    set cerca_manu  [iter_search $form_name coimmanu-list   [list dummy cod_manu_manu dummy cognome_manu dummy nome_manu]]
} else {
    set sw_manu "t"
    set readonly_fld2 "readonly"
    set cerca_manu ""
}

element create $form_name cognome_manu \
-label   "Cognome manutentore" \
-widget   text \
-datatype text \
-html    "size 18 maxlength 100 $readonly_fld2 {} class form_element" \
-optional

element create $form_name nome_manu \
-label   "Nome manutentore" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 100 $readonly_fld2 {} class form_element" \
-optional

#installatore
element create $form_name cognome_inst \
-label   "Cognome installatore" \
-widget   text \
-datatype text \
-html    "size 18 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_inst \
-label   "Nome installatore" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 40 $readonly_fld {} class form_element" \
-optional

#progettista
element create $form_name cognome_prog \
-label   "Cognome progettista" \
-widget   text \
-datatype text \
-html    "size 18 maxlength 40 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_prog \
-label   "Nome progettista" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 40 $readonly_fld {} class form_element" \
-optional

#dati generatore principale
element create $form_name matricola \
-label   "matricola" \
-widget   text \
-datatype text \
-html    "size 14 maxlength 35 $readonly_fld {} class form_element" \
-optional

if {$coimtgen(flag_gest_coimmode) eq "F"} {#nic03
    element create $form_name modello \
	-label   "modello" \
	-widget   text \
	-datatype text \
	-html    "size 14 maxlength 40 $readonly_fld {} class form_element" \
	-optional

    element create $form_name cod_mode -widget hidden -datatype text -optional;#nic03

    set html_per_cod_cost "";#nic03
} else {;#nic03
    element create $form_name modello  -widget hidden -datatype text -optional;#nic03

    element create $form_name cod_mode \
	    -label   "modello" \
	    -widget   select \
	    -datatype text \
	    -html    "$disabled_fld {} class form_element" \
	    -optional \
	    -options "";#nic03
    
    set html_per_cod_cost "onChange document.$form_name.__refreshing_p.value='1';document.$form_name.changed_field.value='cod_cost';document.$form_name.submit.click()";#nic03
};#nic03

element create $form_name cod_cost \
-label   "cod_cost" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element $html_per_cod_cost" \
-optional \
-options [iter_selbox_from_table coimcost cod_cost descr_cost] \

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

#gab02 inserisco nelle options solo le potenze del caldo.
#-options [iter_selbox_from_table coimpote cod_potenza descr_potenza potenza_min]
element create $form_name cod_potenza \
-label   "cod_potenza" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table_wherec coimpote cod_potenza descr_potenza potenza_min "where flag_tipo_impianto = 'R'"] \

element create $form_name flag_dpr412 \
-label   "dpr 412" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {S&igrave; S} {No N}}

element create $form_name cod_cted \
-label   "cod_cted" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimcted cod_cted "cod_cted||' '||descr_cted"] \

element create $form_name tiraggio \
-label   "tipo tiraggio" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Forzato F} {Naturale N}}

element create $form_name tipo_foco \
-label   "tipo focolare" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Aperto A} {Chiuso C}}

#dati contratto
element create $form_name num_contratto \
-label   "numero contratto" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 8 $readonly_fld {} class form_element" \
-optional

element create $form_name data_inizio_cont \
-label   "data inizio contratto" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name data_fine_cont \
-label   "data fine contratto" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_tpdu \
-label   "Destinazione d'uso" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimtpdu cod_tpdu descr_tpdu]

element create $form_name volimetria_risc \
-label   "Volimetria riscaldata" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

element create $form_name n_generatori \
-label   "n_generatori" \
-widget   text \
-datatype text \
-html    "size 2 maxlength 2 $readonly_fld {} class form_element" \
-optional

element create $form_name cod_utgi \
-label   "Dest. d'uso generatore" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table_obblig coimutgi cod_utgi descr_utgi cod_utgi]

element create $form_name cod_emissione \
-label   "scarico fumi" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table_obblig coimtpem cod_emissione descr_emissione cod_emissione] 

element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name cod_impianto  -widget hidden -datatype text -optional
element create $form_name cod_provincia -widget hidden -datatype text -optional
element create $form_name cod_citt_terzi -widget hidden -datatype text -optional
element create $form_name cod_citt_inte -widget hidden -datatype text -optional
element create $form_name cod_citt_prop -widget hidden -datatype text -optional
element create $form_name cod_citt_occ  -widget hidden -datatype text -optional
element create $form_name cod_citt_amm  -widget hidden -datatype text -optional
element create $form_name cod_manu_manu -widget hidden -datatype text -optional
element create $form_name cod_manut     -widget hidden -datatype text -optional
element create $form_name cod_manu_inst -widget hidden -datatype text -optional
element create $form_name cod_prog      -widget hidden -datatype text -optional
element create $form_name dummy         -widget hidden -datatype text -optional
element create $form_name stato_01      -widget hidden -datatype text -optional
element create $form_name cod_impianto_est_new -widget hidden -datatype text -optional
element create $form_name f_resp_cogn  -widget hidden -datatype text -optional
element create $form_name f_resp_nome  -widget hidden -datatype text -optional
element create $form_name f_comune     -widget hidden -datatype text -optional
element create $form_name f_cod_via    -widget hidden -datatype text -optional
element create $form_name f_desc_via   -widget hidden -datatype text -optional
element create $form_name f_desc_topo  -widget hidden -datatype text -optional
element create $form_name flag_ins_occu -widget hidden -datatype text -optional
element create $form_name flag_ins_prop -widget hidden -datatype text -optional
element create $form_name flag_ins_terzi -widget hidden -datatype text -optional
element create $form_name nome_funz_new -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_impianto -widget hidden -datatype text -optional
element create $form_name soloatt -widget hidden -datatype text -optional
element create $form_name flag_conferma -widget hidden -datatype text -optional
element create $form_name __refreshing_p -widget hidden -datatype text -optional;#nic03
element create $form_name changed_field    -widget hidden -datatype text -optional;#nic03



# link per i cerca
set soloatt "s"
if {$coimtgen(flag_viario) == "T"} {
    set cerca_viae [iter_search $form_name [ad_conn package_url]/tabgen/coimviae-filter [list dummy f_cod_via dummy descr_via dummy descr_topo cod_comune cod_comune dummy cap soloatt soloatt]]
} else {
    set cerca_viae ""
}

set cerca_inte  [iter_search $form_name coimcitt-filter [list dummy cod_citt_inte f_cognome cognome_inte f_nome nome_inte]]

set cerca_prop  [iter_search $form_name coimcitt-filter [list dummy cod_citt_prop f_cognome cognome_prop f_nome nome_prop]]

set cerca_occ   [iter_search $form_name coimcitt-filter [list dummy cod_citt_occ  f_cognome cognome_occ  f_nome nome_occ ]]

set cerca_amm   [iter_search $form_name coimcitt-filter [list dummy cod_citt_amm  f_cognome cognome_amm  f_nome nome_amm ]]

set cerca_terzi [iter_search $form_name coimmanu-list [list dummy cod_citt_terzi f_cognome cognome_terzi f_nome nome_terzi] [list f_ruolo "M"]]

set cerca_inst  [iter_search $form_name coimmanu-list   [list dummy cod_manu_inst dummy cognome_inst dummy nome_inst]]

set cerca_prog  [iter_search $form_name coimprog-list   [list dummy cod_prog dummy cognome_prog dummy nome_prog]]


set flag_ins_prop "S"
set flag_ins_terzi "S"

#link inserimento occupante
set nome_funz_new [iter_get_nomefunz coimcitt-isrt]
element set_properties $form_name nome_funz_new   -value $nome_funz_new

#link inserimento occupante
set link_ins_occu [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_occ nome nome_occ nome_funz nome_funz_new localita localita descr_via descr_via descr_topo descr_topo numero numero cap cap provincia provincia cod_comune cod_comune dummy cod_citt_occ] "Inserisci Sogg."]


#link inserimento proprietario
#27/09/2013 set link_ins_prop [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_prop nome nome_prop nome_funz nome_funz_new dummy cod_citt_prop flag_ins_prop flag_ins_prop] "Inserisci Sogg."]
set link_ins_prop [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_prop nome nome_prop nome_funz nome_funz_new dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy cod_citt_prop dummy dummy flag_ins_prop flag_ins_prop] "Inserisci Sogg."];#27/09/2013

if {[form is_request $form_name]} {

    element set_properties $form_name soloatt          -value "s"
    element set_properties $form_name flag_conferma    -value "s"
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_cod_impianto -value $last_cod_impianto
    element set_properties $form_name stato_01         -value $stato_01
    element set_properties $form_name cod_impianto_est_new -value $cod_impianto_est_new    
    element set_properties $form_name cod_impianto_est -value $cod_impianto_est_new    
    element set_properties $form_name f_resp_cogn      -value $f_resp_cogn
    element set_properties $form_name f_resp_nome      -value $f_resp_nome
    element set_properties $form_name f_comune         -value $f_comune 
    element set_properties $form_name f_cod_via        -value $f_cod_via
    element set_properties $form_name f_desc_via       -value $f_desc_via
    element set_properties $form_name f_desc_topo      -value $f_desc_topo
    element set_properties $form_name flag_ins_occu    -value $flag_ins_occu
    element set_properties $form_name flag_ins_prop    -value $flag_ins_prop
    element set_properties $form_name flag_ins_terzi    -value $flag_ins_terzi
    element set_properties $form_name cod_impianto     -value $cod_impianto
    element set_properties $form_name n_generatori     -value "1"
    element set_properties $form_name __refreshing_p   -value 0;#nic03
    element set_properties $form_name changed_field    -value "";#nic03

    if {$funzione == "I"} {
	if {[string equal $coimtgen(flag_ente) "C"]} {
	    #se l'ente e' un comune assegno alcuni default con i dati di ambiente
	    element set_properties $form_name cod_comune -value $coimtgen(cod_comu)
	    element set_properties $form_name descr_comu -value $coimtgen(denom_comune)
	}

        element set_properties $form_name provincia     -value $coimtgen(sigla_prov)
        element set_properties $form_name cod_provincia -value $coimtgen(cod_provincia)
	element set_properties $form_name flag_dpr412   -value "S"

	# se l'utente corrente e' un manutentore, allora valorizzo
	# il relativo cognome nome
	set cod_manu_manu [iter_check_uten_manu $id_utente]
	if {![string is space $cod_manu_manu]
        &&   [db_0or1row sel_manu_nome ""] == 1
	} {
	    element set_properties $form_name cod_manu_manu -value $cod_manu_manu
	    element set_properties $form_name cognome_manu  -value $cognome_manu
	    element set_properties $form_name nome_manu     -value $nome_manu
	}

	# valorizzo cognome e nome responsabile con cognome e nome dal filtro 
	set cognome_occu $f_resp_cogn
	set nome_occu    $f_resp_nome

	element set_properties $form_name cognome_occ      -value $cognome_occu
	element set_properties $form_name nome_occ         -value $nome_occu
	set resp_inte "O"
	element set_properties $form_name flag_responsabile -value $resp_inte

	if {$cod_comune_chk eq ""} {
	    element set_properties $form_name cod_comune -value $f_comune
	} else {
	    element set_properties $form_name cod_comune -value $cod_comune_chk
	}

    }
    # per ente Comune, il comune e' sempre valorizzato con la tgen
    # la provincia (readonly) e' sempre valorizzata con la tgen
    element set_properties $form_name descr_topo -value $f_desc_topo
    element set_properties $form_name descr_via  -value $f_desc_via

}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    set __refreshing_p    [element::get_value $form_name __refreshing_p];#nic03
    set changed_field     [element::get_value $form_name changed_field];#nic03
    set cod_impianto_est  [string trim [element::get_value $form_name cod_impianto_est]]
    set stato             [string trim [element::get_value $form_name stato]]
    set note              [string trim [element::get_value $form_name note]]
    set localita          [string trim [element::get_value $form_name localita]]

    if {[string equal $coimtgen(flag_ente) "C"]} {
        set descr_comu    [string trim [element::get_value $form_name descr_comu]]
    }
    if {$cod_comune_chk eq ""} {
	set cod_comune        [string trim [element::get_value $form_name cod_comune]]
    } else {
	element set_properties $form_name cod_comune -html    "readonly {} class form_element" -value $cod_comune_chk
	element set_properties $form_name cod_comune -html    "disabled {} class form_element"
	set cod_comune $cod_comune_chk
    }
    set provincia         [string trim [element::get_value $form_name provincia]]
    set cap               [string trim [element::get_value $form_name cap]]
    set descr_via         [string trim [element::get_value $form_name descr_via]]
    set descr_topo        [string trim [element::get_value $form_name descr_topo]]
    set numero            [string trim [element::get_value $form_name numero]]
    set esponente         [string trim [element::get_value $form_name esponente]]
    set scala             [string trim [element::get_value $form_name scala]]
    set piano             [string trim [element::get_value $form_name piano]]
    set interno           [string trim [element::get_value $form_name interno]]
    set flag_responsabile [string trim [element::get_value $form_name flag_responsabile]]
    set cognome_inte      [string trim [element::get_value $form_name cognome_inte]]
    set nome_inte         [string trim [element::get_value $form_name nome_inte]]
    set cognome_prop      [string trim [element::get_value $form_name cognome_prop]]
    set nome_prop         [string trim [element::get_value $form_name nome_prop]]
    set cognome_occ       [string trim [element::get_value $form_name cognome_occ]]
    set nome_occ          [string trim [element::get_value $form_name nome_occ]]
    set cognome_amm       [string trim [element::get_value $form_name cognome_amm]]
    set nome_amm          [string trim [element::get_value $form_name nome_amm]]
    set cognome_terzi     [string trim [element::get_value $form_name cognome_terzi]]
    set nome_terzi        [string trim [element::get_value $form_name nome_terzi]]
    set cognome_manu      [string trim [element::get_value $form_name cognome_manu]]
    set nome_manu         [string trim [element::get_value $form_name nome_manu]]
    set cognome_inst      [string trim [element::get_value $form_name cognome_inst]]
    set nome_inst         [string trim [element::get_value $form_name nome_inst]]
    set cognome_prog      [string trim [element::get_value $form_name cognome_prog]]
    set nome_prog         [string trim [element::get_value $form_name nome_prog]]
    set potenza           [string trim [element::get_value $form_name potenza]]
    set potenza_utile     [string trim [element::get_value $form_name potenza_utile]]
    set cod_potenza       [string trim [element::get_value $form_name cod_potenza]]
    set cod_provincia     [string trim [element::get_value $form_name cod_provincia]]
    set cod_citt_inte     [string trim [element::get_value $form_name cod_citt_inte]]
    set cod_citt_prop     [string trim [element::get_value $form_name cod_citt_prop]]
    set cod_citt_occ      [string trim [element::get_value $form_name cod_citt_occ]]
    set cod_citt_amm      [string trim [element::get_value $form_name cod_citt_amm]]
    set cod_citt_terzi    [string trim [element::get_value $form_name cod_citt_terzi]]
    set cod_manu_manu     [string trim [element::get_value $form_name cod_manu_manu]]
    set cod_manu_inst     [string trim [element::get_value $form_name cod_manu_inst]]
    set cod_prog          [string trim [element::get_value $form_name cod_prog]]
    set f_cod_via         [string trim [element::get_value $form_name f_cod_via]]
    set cod_via           ""
    set flag_dpr412       [string trim [element::get_value $form_name flag_dpr412]]
    set cod_cted          [string trim [element::get_value $form_name cod_cted]]
    set matricola         [string trim [element::get_value $form_name matricola]]
    set modello           [string trim [element::get_value $form_name modello]]
    set cod_cost          [string trim [element::get_value $form_name cod_cost]]
    set provenienza_dati  "3"
    set data_installaz    [string trim [element::get_value $form_name data_installaz]]
    set anno_costruzione  [string trim [element::get_value $form_name anno_costruzione]]
    set cod_combustibile  [string trim [element::get_value $form_name cod_combustibile]]
    set cod_tpim          [string trim [element::get_value $form_name cod_tpim]]
    set tipo_foco         [string trim [element::get_value $form_name tipo_foco]]
    set tiraggio          [string trim [element::get_value $form_name tiraggio]]
    set cod_tpdu          [string trim [element::get_value $form_name cod_tpdu]]
    set volimetria_risc   [string trim [element::get_value $form_name volimetria_risc]]
    set n_generatori      [string trim [element::get_value $form_name n_generatori]]
    set cod_utgi          [string trim [element::get_value $form_name cod_utgi]]
    set cod_emissione     [string trim [element::get_value $form_name cod_emissione]]

    set num_contratto     [string trim [element::get_value $form_name num_contratto]]
    set data_inizio_cont  [string trim [element::get_value $form_name data_inizio_cont]]
    set data_fine_cont    [string trim [element::get_value $form_name data_fine_cont]]
    set flag_conferma     [string trim [element::get_value $form_name flag_conferma]]

    #Imposto ora le options di cod_mode perchè solo adesso ho a disposizione la var. cod_cost
    element set_properties $form_name cod_mode -options [iter_selbox_from_table "coimmode where cod_cost = '[db_quote $cod_cost]'" cod_mode descr_mode];#nic03
    set cod_mode          [element::get_value $form_name cod_mode];#nic03


    if {[string equal $__refreshing_p "1"]} {;#nic03
        if {$changed_field eq "cod_cost"} {;#nic03
            set focus_field "$form_name.cod_mode";#nic03
        };#nic03

        element set_properties $form_name __refreshing_p -value 0;#nic03
        element set_properties $form_name changed_field  -value "";#nic03

        ad_return_template;#nic03
        return;#nic03
    };#nic03


    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"} {

	if {[string equal $flag_dpr412 ""]} {
	    element::set_error $form_name flag_dpr412 "Inserire"
	    incr error_num	    
	}

        if {[string equal $cod_impianto_est ""]
	&&  $flag_cod_aimp_auto == "F"
	} {
	    element::set_error $form_name cod_impianto_est "Inserire codice impianto"
	    incr error_num
	}

	if {[string equal $stato ""]} {
	    element::set_error $form_name stato "Inserire lo stato dell'impianto"
	    incr error_num
	}

# sf 11112013 comune utente

        db_0or1row sel_cout_check " select count(*) as conta_cout
                                   from coimcout
                                   where id_utente = :id_utente "
	
       if {$conta_cout > 0} {
              db_0or1row sel_comu_check " select count(*) as conta_comu
                                   from coimcout
                                   where id_utente = :id_utente
                                   and cod_comune = :cod_comune"        
       }
     
     if {$conta_cout > 0} {
       if {$conta_comu == 0} {
             element::set_error $form_name cod_comune "Non abilitato ad inserire impianti sul comune specificato"
	    incr error_num
       }
     }

# sf fine



        if {![string equal $cod_impianto_est ""]
	&&   [db_0or1row check_aimp ""] == 1
	} {
	    element::set_error $form_name cod_impianto_est "Esiste gi&agrave; un impianto con questo codice"
	    incr error_num
	}
     
        set flag_potenza_ok "f"
        if {![string equal $potenza ""]} {
	    set potenza [iter_check_num $potenza 2]
            if {$potenza == "Error"} {
                element::set_error $form_name potenza "numerico, max 2 dec"
                incr error_num
            } else {
                if {[iter_set_double $potenza] >=  [expr pow(10,7)]
                ||  [iter_set_double $potenza] <= -[expr pow(10,7)]} {
                    element::set_error $form_name potenza "Deve essere < di 10.000.000"
                    incr error_num
                } else {
		    set flag_potenza_ok "t"
		}
           
                set potenza_tot $potenza
		if {$flag_potenza_ok == "t"
		&&  [db_0or1row check_fascia_pote ""]== 0} {
		    element::set_error $form_name potenza "Non compresa in nessuna fascia"
		    incr error_num
		}

                if {![string equal $potenza ""]} {
                    if {[string equal $cod_tpim ""]} {
                       if {$potenza > 35} {
                           set cod_tpim "2"
		       } else { 
                           set cod_tpim "1"
		       }
		    }              
		}       
            }
        }

	if {[string equal $potenza_utile ""]} {
            element::set_error $form_name potenza_utile "Inserire potenza utile"
	    incr error_num
        }
        set flag_potenza_ok "f"
        if {[string equal $potenza_utile ""]} {
	    set potenza_utile 0
        } else {
            set potenza_utile [iter_check_num $potenza_utile 2]
            if {$potenza_utile == "Error"} {
                element::set_error $form_name potenza_utile "numerico, max 2 dec"
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
		    element::set_error $form_name potenza_utile "Non compresa in nessuna fascia"
		    incr error_num
		}           
            }
        }

        if {![string equal $potenza ""]
	    && $potenza != "Error"} {
	    set potenza_tot $potenza
	    if {![string equal $cod_potenza ""] } {
               if {[db_0or1row check_fascia_pote2 ""]== 0} {
		    element::set_error $form_name potenza "Non compresa nella fascia di potenza"
		    incr error_num
	       }
	    } else {
		if {[db_0or1row assegna_fascia ""]== 0} {
		    element::set_error $form_name potenza "Nessuna fascia disponibile"
		    incr error_num
		}
	    }
	} else {
	    if {[string equal $cod_potenza ""] } {
	        element::set_error $form_name potenza "Inserire potenza o fascia"
	        incr error_num
	    }
	}

	if {![string equal $cod_potenza ""]
	    && [string equal $potenza ""]} {
	    if {[db_0or1row sel_pote ""] == 0} {
		set potenza 0
	    }
	}

	
        if {[string equal $data_installaz ""]} {
            element::set_error $form_name data_installaz "Inserire data"
            incr error_num
        } else {
            set data_installaz [iter_check_date $data_installaz]
            if {$data_installaz == 0} {
                element::set_error $form_name data_installaz "Data non corretta"
                incr error_num
            } else {
		if {$data_installaz > $current_date} {
		    element::set_error $form_name data_installaz  "Deve essere inferiore alla data odierna"
		    incr error_num
		}
	    }
        }

	if {[string equal $anno_costruzione ""]} {
            element::set_error $form_name anno_costruzione "Inserire data"
            incr error_num
        } else {
            set anno_costruzione [iter_check_date $anno_costruzione]
            if {$anno_costruzione == 0} {
                element::set_error $form_name anno_costruzione "Data non corretta"
                incr error_num
            } else {
		if {$anno_costruzione > $current_date} {
		    element::set_error $form_name anno_costruzione  "Deve essere inferiore alla data odierna"
		    incr error_num
		}
	    }
        }


#        if {[string equal $data_installaz ""]} {
#            element::set_error $form_name data_installaz "Inserire data"
#            incr error_num
#        } else {
#            set data_installaz [iter_check_date $data_installaz]
#            if {$data_installaz == 0} {
#                element::set_error $form_name data_installaz "Data non corretta"
#                incr error_num
#            }
#        }

	# se la via � valorizzata, ma manca il comune: errore
        if {![string equal $descr_via  ""]
	||  ![string equal $descr_topo ""]
	} {
	    if {[string equal $cod_comune ""]} {
		if {$coimtgen(flag_ente) == "P"} {
		    element::set_error $form_name cod_comune "valorizzare il Comune" 
		} else {
		    element::set_error $form_name descr_comu "valorizzare il Comune"
		} 
		incr error_num
	    } 
	}

	if {$coimtgen(flag_ente) == "P"} {
	    if {[string equal $cod_comune ""]} {
		element::set_error $form_name cod_comune "valorizzare il Comune" 
		incr error_num
	    }
	}

	if {[string equal $descr_via  ""]
	&&  [string equal $localita ""]} {
	    element::set_error $form_name descr_via "valorizzare l'indirizzo o la localit&agrave;" 
	    incr error_num
	}

	# si controlla la via solo se il primo test e' andato bene.
	# in questo modo si e' sicuri che f_comune e' stato valorizzato.
	if {$coimtgen(flag_viario) == "T"} {
	    if {[string equal $descr_via  ""]
   	    &&  [string equal $descr_topo ""]
	    } {
		set f_cod_via ""
	    } else {
		# controllo codice via
		set chk_out_rc      0
		set chk_out_msg     ""
		set chk_out_cod_via ""
		set ctr_viae        0
		if {[string equal $descr_topo ""]} {
		    set eq_descr_topo  "is null"
		} else {
		    set eq_descr_topo  "= upper(:descr_topo)"
		}
		if {[string equal $descr_via ""]} {
		    set eq_descrizione "is null"
		} else {
		    set eq_descrizione "= upper(:descr_via)"
		}
		db_foreach sel_viae "" {
		    incr ctr_viae
		    if {$cod_via == $f_cod_via} {
			set chk_out_cod_via $cod_via
			set chk_out_rc       1
		    }
		}
		switch $ctr_viae {
		    0 { set chk_out_msg "Via non trovata"}
		    1 { set chk_out_cod_via $cod_via
			set chk_out_rc       1 }
		    default {
			if {$chk_out_rc == 0} {
			    set chk_out_msg "Trovate pi&ugrave; vie: usa il link cerca"
			}
		    }
		}
		set f_cod_via $chk_out_cod_via
		set cod_via   $chk_out_cod_via
		if {$chk_out_rc == 0} {
		    element::set_error $form_name descr_via $chk_out_msg
		    incr error_num
		}
	    }
	}

        if {![string equal $cap ""]} {
            set cap [iter_check_num $cap 0]
            if {$cap == "Error"} {
                element::set_error $form_name cap "numerico"
                incr error_num
	    }
	} else {
	    if {[db_0or1row sel_comu_cap ""] == 0} {
		set cap ""
	    }
	}

        if {![string equal $numero ""]} {
            set numero [iter_check_num $numero 0]
            if {$numero == "Error"} {
                element::set_error $form_name numero "N. civ deve essere numerico"
                incr error_num
	    }
	}

        #routine generica per controllo codice soggetto
        set check_cod_citt {
            set chk_out_rc       0
            set chk_out_msg      ""
            set chk_out_cod_citt ""
            set ctr_citt         0
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
            db_foreach sel_citt "" {
                incr ctr_citt
                if {$cod_cittadino == $chk_inp_cod_citt} {
		    set chk_out_cod_citt $cod_cittadino
                    set chk_out_rc       1
		}
	    }
            switch $ctr_citt {
 		0 { set chk_out_msg "Soggetto non trovato"}
	 	1 { set chk_out_msg "Esiste gi&agrave; un soggetto con il nominativo inserito,<br> verificarne la correttezza con il tasto cerca<br>o inserirne uno nuovo"
		    set chk_out_cod_citt $cod_cittadino
		    set chk_out_rc       1 }
	  default {
                    if {$chk_out_rc == 0} {
			set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		    }
 		}
	    }
 	}

        if {[string equal $cognome_inte ""]
	&&  [string equal $nome_inte    ""]
	} {
            set cod_citt_inte ""
	} else {
	    set chk_inp_cod_citt $cod_citt_inte
	    set chk_inp_cognome  $cognome_inte
	    set chk_inp_nome     $nome_inte
	    eval $check_cod_citt
            set cod_citt_inte    $chk_out_cod_citt

	    switch $chk_out_rc {
		0 {
		    element::set_error $form_name cognome_inte $chk_out_msg
		    incr error_num
		}
		1 {
		    if {[string equal $chk_inp_cod_citt ""]} {
			element::set_error $form_name cognome_inte $chk_out_msg
			incr error_num
		    }
		}
	    }
	}
        if {[string equal $cognome_prop ""]
	&&  [string equal $nome_prop    ""]
	} {
            set cod_citt_prop ""
	} else {
	    if {![string equal [string toupper $cognome_prop] [string toupper $cognome_occ]]
	    ||  ![string equal [string toupper $nome_prop] [string toupper $nome_occ]]
	    } {
		set chk_inp_cod_citt $cod_citt_prop
		set chk_inp_cognome  $cognome_prop
		set chk_inp_nome     $nome_prop
		eval $check_cod_citt
		set cod_citt_prop    $chk_out_cod_citt
		
		switch $chk_out_rc {
		    0 {
			element::set_error $form_name cognome_prop $chk_out_msg
			incr error_num
		    }
		    1 {
			if {[string equal $chk_inp_cod_citt ""]} {
			    element::set_error $form_name cognome_prop $chk_out_msg
			    incr error_num
			}
		    }
		}
	    }
	}
        ########
	# se il soggetto occupante non c'� lo inserisco con l'indirizzo
        # uguale all'ubicazione dell'impianto. se il soggetto � presente 
        # con piu' omonimi, la prima volta visualizzo il messaggio, la 
        # seconda volta lascio inserire il soggetto.
        # se c'� un solo soggetto occupante con cognome e nome uguale (e
        # l'occupante e' stato inserito senza l'utilizzo del cerca), visualizzo 
        # un messaggio che informa l'utente dell'esistenza di un soggetto
        # omonimo, invitando a verificare se il soggetto � corretto, in altro 
        # casol l'utente deve inserire il nuovo soggetto manualmente.

        if {[string equal $cognome_occ ""]
	&&  [string equal $nome_occ    ""]
	} {
            set cod_citt_occ ""
	} else {
	    set chk_inp_cod_citt $cod_citt_occ
	    set chk_inp_cognome  $cognome_occ
	    set chk_inp_nome     $nome_occ

	    eval $check_cod_citt
	    
            set cod_citt_occ     $chk_out_cod_citt
	    if {[db_0or1row sel_comu_desc ""] == 0} {
		set desc_comune ""
	    }

	    if {$flag_ins_occu == "T"} {
		db_1row sel_cod_citt ""
		set cod_citt_occ $cod_cittadino
		set indirizzo "$descr_topo $descr_via"
#		set dml_ins_citt [db_map ins_citt]
	    } else {
		switch $chk_out_rc {
		    0 {
			if {$flag_ins_occu == ""
		        &&  $chk_out_msg   == "Trovati pi&ugrave; soggetti: usa il link cerca"
		        } {
			    element::set_error $form_name cognome_occ $chk_out_msg
			    incr error_num
#			    set flag_ins_occu "T"
#			    element set_properties $form_name flag_ins_occu -value $flag_ins_occu
		        } else {
			    if {$flag_ins_occu == ""} {
				element::set_error $form_name cognome_occ $chk_out_msg
				incr error_num
			    } else {
				# in questo caso il soggetto non esiste
#				db_1row sel_cod_citt ""
#				set cod_citt_occ $cod_cittadino
#				set indirizzo "$descr_topo $descr_via"
#				set dml_ins_citt [db_map ins_citt]
			    }
		        }
		    }
		    1 {
			if {[string equal $chk_inp_cod_citt ""]} {
			    element::set_error $form_name cognome_occ $chk_out_msg
			    incr error_num
			}
	 	    }
		}
	    }
	}

        if {[string equal $cognome_amm ""]
	&&  [string equal $nome_amm    ""]
	} {
            set cod_citt_amm ""
	} else {
	    set chk_inp_cod_citt $cod_citt_amm
	    set chk_inp_cognome  $cognome_amm
	    set chk_inp_nome     $nome_amm
	    eval $check_cod_citt
            set cod_citt_amm     $chk_out_cod_citt
	    switch $chk_out_rc {
		0 {
		    element::set_error $form_name cognome_amm $chk_out_msg
		    incr error_num
		}
		1 {
		    if {[string equal $chk_inp_cod_citt ""]} {
			element::set_error $form_name cognome_amm $chk_out_msg
			incr error_num
		    }
		}
	    }
	}


        if {[string equal $cognome_terzi ""]
	&&  [string equal $nome_terzi    ""]
	} {
            set cod_citt_terzi ""
	} else {
	    if {![string equal $flag_responsabile "T"]} {
		element::set_error $form_name cognome_terzi "non inserire terzo responsabile: non &egrave; il responsabile"
		incr error_num
	    } else {
		if {[string range $cod_citt_terzi 0 1] == "MA"} {
		    set cod_manut $cod_citt_terzi

		    element set_properties $form_name cod_manut   -value $cod_manut
		    if {[db_0or1row sel_cod_legale_temp "select a.cod_legale_rapp as cod_citt_terzi
                                                         , b.cognome as cognome_terzi
                                                         , b.nome as nome_terzi
                                                      from coimmanu a
                                                         , coimcitt b
                                                     where a.cod_manutentore = :cod_manut
                                                       and a.cod_legale_rapp = b.cod_cittadino"] == 0} {
			set link_ins_rapp [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_terzi nome nome_terzi nome_funz nome_funz_new dummy dummy dummy dummy  dummy dummy  dummy dummy  dummy dummy  dummy dummy  dummy dummy  dummy dummy cod_manutentore cod_manut dummy dummy flag_ins_terzi flag_ins_terzi] "crea automaticamente legale rappresentante"]
			element::set_error $form_name cognome_terzi "aggiornare il manutentore con i dati del legale rappresentante <br>o $link_ins_rapp"
			incr error_num
		    } else {
			set chk_inp_cod_citt $cod_citt_terzi
			set chk_inp_cognome  $cognome_terzi
			set chk_inp_nome     $nome_terzi
			eval $check_cod_citt
			set cod_citt_terzi        $chk_out_cod_citt
			if {$chk_out_rc == 0} {
			    element::set_error $form_name cognome_terzi $chk_out_msg
			    incr error_num
			}
		    }
		}
	    }
	}




        #congruenza cod_resp con rispettivo codice
        set cod_citt_resp ""
        switch $flag_responsabile {
	    "T" {
		if {[string equal $cognome_terzi ""]
	        &&  [string equal $nome_terzi ""]
		} {
		    element::set_error $form_name cognome_terzi "inserire terzi: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_citt_resp $cod_citt_terzi
		}
	    }
	    "P" {
		if {[string equal $cognome_prop ""]
	        &&  [string equal $nome_prop ""]
		} {
		    element::set_error $form_name cognome_prop "inserire proprietario: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_citt_resp $cod_citt_prop
		}
	    }
	    "O" {
		if {[string equal $cognome_occ ""]
	        &&  [string equal $nome_occ ""]
		} {
		    element::set_error $form_name cognome_occ "inserire occupante: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_citt_resp $cod_citt_occ
		}
	    }
	    "A" {
		if {[string equal $cognome_amm  ""]
	        &&  [string equal $nome_amm     ""]
		} {
		    element::set_error $form_name cognome_amm "inserire amministratore: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_citt_resp $cod_citt_amm
		}
	    }
	    "I" {
		if {[string equal $cognome_inte  ""]
	        &&  [string equal $nome_inte     ""]
		} {
		    element::set_error $form_name cognome_inte "inserire intestatario: &egrave; il responsabile"
		    incr error_num
		} else {
		    set cod_citt_resp $cod_citt_inte
		}
	    }
	    default {
#		if {$flag_dichiarato == "S"} {
#		    element::set_error $form_name flag_responsabile "Indicare responsabile"
#		    incr error_num 
#		}
	    }
	}

        #routine generica per controllo codice manutentore
        set check_cod_manu {
            set chk_out_rc       0
            set chk_out_msg      ""
            set chk_out_cod_manu ""
            set ctr_manu         0
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
            db_foreach sel_manu "" {
                incr ctr_manu
                if {$cod_manutentore == $chk_inp_cod_manu} {
		    set chk_out_cod_manu $cod_manutentore
                    set chk_out_rc       1
		}
	    }
            switch $ctr_manu {
 		0 { set chk_out_msg "Soggetto non trovato"}
	 	1 { set chk_out_cod_manu $cod_manutentore
		    set chk_out_rc       1 }
	  default {
                    if {$chk_out_rc == 0} {
			set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		    }
 		}
	    }
 	}

        if {[string equal $cognome_manu ""]
	&&  [string equal $nome_manu    ""]
	} {
            set cod_manu_manu ""
	} else {
	    set chk_inp_cod_manu $cod_manu_manu
	    set chk_inp_cognome  $cognome_manu
	    set chk_inp_nome     $nome_manu
	    eval $check_cod_manu
            set cod_manu_manu    $chk_out_cod_manu
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_manu $chk_out_msg
                incr error_num
	    }
	}

        if {[string equal $cognome_inst ""]
	&&  [string equal $nome_inst    ""]
	} {
            set cod_manu_inst ""
	} else {
	    set chk_inp_cod_manu $cod_manu_inst
	    set chk_inp_cognome  $cognome_inst
	    set chk_inp_nome     $nome_inst
	    eval $check_cod_manu
            set cod_manu_inst    $chk_out_cod_manu
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_inst $chk_out_msg
                incr error_num
	    }
	}

        #routine per controllo codice progettista
        set check_cod_prog {
            set chk_out_rc       0
            set chk_out_msg      ""
            set chk_out_cod_prog ""
            set ctr_prog         0
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
            db_foreach sel_prog "" {
                incr ctr_prog
                if {$cod_progettista == $chk_inp_cod_prog} {
		    set chk_out_cod_prog $cod_progettista
                    set chk_out_rc       1
		}
	    }
            switch $ctr_prog {
 		0 { set chk_out_msg "Soggetto non trovato"}
	 	1 { set chk_out_cod_prog $cod_progettista
		    set chk_out_rc       1 }
	  default {
                    if {$chk_out_rc == 0} {
			set chk_out_msg "Trovati pi&ugrave; soggetti: usa il link cerca"
		    }
 		}
	    }
 	}

        if {[string equal $cognome_prog ""]
	&&  [string equal $nome_prog    ""]
	} {
            set cod_prog ""
	} else {
	    set chk_inp_cod_prog $cod_prog
	    set chk_inp_cognome  $cognome_prog
	    set chk_inp_nome     $nome_prog
	    eval $check_cod_prog
            set cod_prog         $chk_out_cod_prog
            if {$chk_out_rc == 0} {
                element::set_error $form_name cognome_prog $chk_out_msg
                incr error_num
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
	
	if {![string equal $n_generatori ""]} {
	    set n_generatori [iter_check_num $n_generatori 0]
	    if {$n_generatori == "Error"} {
		element::set_error $form_name n_generatori "deve essere numerico"
		incr error_num
	    }
	}

	   if {![string equal $matricola ""]} {
	    if {$flag_conferma == "s"} {
		if {[db_0or1row query "select 1 from coimgend where matricola = :matricola limit 1"] == 1} {
		    element::set_error $form_name matricola "Attenzione esiste a catasto un generatore con la stessa matricola. Confermi l'inserimento?"
		    if {$error_num == 0} {
			element set_properties $form_name flag_conferma -value "n"
		    }
		    incr error_num
		}
	    }
	}

        #dati del generatore
        if {[string equal $matricola ""]} {
           element::set_error $form_name matricola "Inserire matricola"
            incr error_num
        }

	if {$coimtgen(flag_gest_coimmode) eq "F"} {;#nic03
	    if {[string equal $modello ""]} {
		element::set_error $form_name modello "Inserire il modello"
		incr error_num
	    }
	} else {;#nic03
	    if {$cod_mode eq ""} {;#nic03
		element::set_error $form_name cod_mode "Selezionare il modello";#nic03
		incr error_num;#nic03
	    } else {;#nic03
		# Devo comunque valorizzare la colonna coimgend.modello
		if {![db_0or1row query "select descr_mode as modello
                                          from coimmode
                                         where cod_mode = :cod_mode"]
		} {#nic03
		    element::set_error $form_name cod_mode "Modello non trovato in anagrafica";#nic03
		    incr error_num;#nic03
		};#nic03
	    };#nic03
	};#nic03


        if {[string equal $cod_cost ""]} {
            element::set_error $form_name cod_cost "Inserire costruttore generatore"
            incr error_num
        }
    }

    if {$error_num > 0} {
        ad_return_template
        return
    }

    if {[string equal [string toupper $cognome_prop] [string toupper $cognome_occ]]
    &&  [string equal [string toupper $nome_prop] [string toupper $nome_occ]]
    } {
	set cod_citt_prop $cod_citt_occ
    }
 
    #imposto i campi di default per inserimento
    set cod_catasto ""
    set cod_qua ""
    set cod_urb ""

    switch $funzione {
           #inserimento impianto
        I {
	    db_1row sel_dual_aimp ""
	    # inserimento impianto
	    if {$flag_cod_aimp_auto == "T"} {
		if {$flag_codifica_reg == "T"} {
		    
		    if {![string equal $cod_comune ""]} {
                        #gab03 aggiunto alle condizioni la provincia di Ancona
                        #gab01 aggiunto alle condizioni il comune di Ancona
			if {$coimtgen(ente) eq "CPESARO" || $coimtgen(ente) eq "PPU" || $coimtgen(ente) eq "CFANO" || $coimtgen(ente) eq "CANCONA" || $coimtgen(ente) eq "PAN" || $coimtgen(ente) eq "CJESI" || $coimtgen(ente) eq "CSENIGALLIA"} {#sim01: aggiunta if ed il suo contenuto
			    
			    if {$coimtgen(ente) eq "CPESARO"} {
				set sigla_est "CMPS"
			    } elseif {$coimtgen(ente) eq "CFANO"} {
                                set sigla_est "CMFA"
			    } elseif {$coimtgen(ente) eq "CANCONA"} {;#gab01
				set sigla_est "CMAN"
			    } elseif {$coimtgen(ente) eq "PAN"} {;#gab03
				set sigla_est "PRAN"
			    } elseif {$coimtgen(ente) eq "CJESI"} {;#sim03
				set sigla_est "CMJE"
			    } elseif {$coimtgen(ente) eq "CSENIGALLIA"} {;#sim03
				set sigla_est "CMSE"
			    } else {
				set sigla_est "PRPU"
			    }
			    
			    set progressivo_est [db_string sel "select nextval('coimaimp_est_s')"]
			    
			    # devo fare l'lpad con una seconda query altrimenti mi andava in errore
			    #nic06 set progressivo_est [db_string sel "select lpad(:progressivo_est,6,'0')"]
			    set progressivo_est [db_string sel "select lpad(:progressivo_est,:lun_num_cod_imp_est,'0')"];#nic06

			    set cod_impianto_est "$sigla_est$progressivo_est"

			} else {#sim01

			    if {$coimtgen(ente) eq "PGO"} {
				set lun_progressivo 7
			    } else {
				set lun_progressivo 6
			    }

			    # caso standard
			    db_1row sel_dati_comu ""
			    if {$coimtgen(ente) eq "PMS"} {#nic05: aggiunta if. Originale nell'else
				set progressivo [db_string query "select lpad(:progressivo, 5, '0')"];#nic05
				set cod_istat  "[string range $cod_istat 5 6]/";#nic05
			    } elseif {$coimtgen(ente) eq "PTA"} {#sim02: aggiunta if e suo contenuto
				set progressivo [db_string query "select lpad(:progressivo, 7, '0')"]
				set fine_istat  [string length $cod_istat]
				set iniz_ist    [expr $fine_istat -3]
				set cod_istat  "[string range $cod_istat $iniz_ist $fine_istat]"
			    } else {#nic05
				#sim01: la sel_dati_comu andava in errore sul lpad di progressivo.Quindi faccio lpad dopo la query
				set progressivo [db_string query "select lpad(:progressivo, $lun_progressivo, '0')"];#sim01
				#sim01 if {$coimtgen(ente) eq "CPESARO" || $coimtgen(ente) eq "PPU"} {#nic04
				#sim01     set cod_istat [string range $cod_istat 3 5];#nic04 (fatto da Sandro)
				#sim01 };#nic04
			    };#nic05

			    if {![string equal $potenza "0.00"]
			    &&  ![string equal $potenza ""]
			    } {
				if {$potenza < 35} {
				    set tipologia "IN"
				} else {
				    set tipologia "CT"
				}
				set cod_impianto_est "$cod_istat$progressivo"
				set dml_comu         [db_map upd_prog_comu]
			    } else {
				if {![string equal $cod_potenza "0"]
				&&  ![string equal $cod_potenza ""]
				} { 
				    switch $cod_potenza {
					"B"  {set tipologia "IN"}
					"A"  {set tipologia "CT"}
					"MA" {set tipologia "CT"}
					"MB" {set tipologia "CT"}
				    }
				    
				    set cod_impianto_est "$cod_istat$progressivo"
				    set dml_comu         [db_map upd_prog_comu]
				} else {
				    # nic02 set cod_impianto_est ""
				    set cod_impianto_est "$cod_istat$progressivo";#nic02
				    set dml_comu         [db_map upd_prog_comu];#nic02
				}
			    }
			};#sim01
		    } else {
			set cod_impianto_est ""
		    }
		} else {
		    db_1row get_cod_impianto_est ""
		}

	    }
	    set dml_sql_aimp [db_map ins_aimp]
	    # inserimento generatore
	    set gen_prog     1
	    set gen_prog_est 1
	    set dml_sql_gend [db_map ins_gend]
	}
    }

    if {![string equal $cod_citt_inte ""]} {
	set cod_cittadino $cod_citt_inte
    }
    
    # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql_aimp]
    &&  [info exists dml_sql_gend]
    } {

	with_catch error_msg {
	    db_transaction {

		db_dml dml_coimaimp $dml_sql_aimp 
		db_dml dml_coimaimp $dml_sql_gend 
		if {[info exists dml_ins_citt] } {
		    db_dml dml_coicitt $dml_ins_citt
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

    set cod_impianto_old $cod_impianto
    set link_gest [export_url_vars cod_impianto_old nome_funz_caller extra_par caller]&nome_funz=isrt_veloce

    if {$nome_funz == "isrt_manu"} {
	set return_url   "coimaimp-isrt-veloce?funzione=I&nome_funz=isrt_manu"
    } else {
	set return_url   "coimaimp-ins-filter?$link_gest"
    }

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template

