ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimaimp"
    @author          Valentina Catte
    @creation-date   25/08/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimaimp-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== ========================================================================
    sim04 22/05/2017 Personaliz. per Comune di Jesi: ricodificare gli impianti come da Legge
    sim04            Reg. Marche CMJE.
    sim04            Per Comune di Senigalli: CMSE

    gab02 12/04/2017 Personaliz. per Provincia di Ancona: ricodificare gli impianti come da Legge
    gab02            Reg. Marche PRAN.

    gab01 08/02/2017 Personaliz. per Comune di Ancona: ricodificare gli impianti come da Legge
    gab01            Reg. Marche CMAN.

    sim03 18/11/2016 Gestito la potenza in base al flag_tipo_impianto

    sim02 28/09/2016 Taranto ha il cod. impianto composto dalle ultime 3 cifre del codice istat
    sim02            + un progressivo

    nic01 04/02/2016 Gestito coimtgen.lun_num_cod_impianto_est per regione MARCHE

    sim01 28/09/2015 Da ottobre 2015 gli enti della regione marche devono costruire il codice
    sim01            impianto con una sigla imposta dalla regione (es: CMPS) + un progressivo
    sim01            di 6 cifre.

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
   {flag_conta           ""}
   {conta_max            ""}
   {flag_tipo_impianto   "R"}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

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
set lun_num_cod_imp_est $coimtgen(lun_num_cod_imp_est);#nic01

set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

if {![string equal $cod_impianto ""]} {
    set cod_impianto_est_new [db_string sel_est "select cod_impianto_est from coimaimp where cod_impianto = :cod_impianto"] 
}
# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# controllo se l'utente � un manutentore
set cod_manutentore [iter_check_uten_manu $id_utente]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_impianto caller nome_funz nome_funz_caller conta_max]&[iter_set_url_vars $extra_par]}
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

if {![string equal $cod_impianto ""]} {
    set readonly_fld "readonly"
    set disabled_fld "disabled"
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
-html    "size 1 maxlength 1 disabled {} class form_element" \
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

element create $form_name note_dest \
-label   "note_dest" \
-widget   textarea \
-datatype text \
-html    "cols 80 rows 2 $readonly_fld {} class form_element" \
-optional

if {$coimtgen(flag_ente) == "P"} {
    element create $form_name cod_comune \
   -label   "Comune" \
   -widget   select \
    -options [iter_selbox_from_comu]\
    -datatype text \
	-html    "$disabled_fld {} class form_element" \
    -optional
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
-html    "size 18 maxlength 100 $readonly_fld {} class form_element" \
-optional

element create $form_name nome_manu \
-label   "Nome manutentore" \
-widget   text \
-datatype text \
-html    "size 12 maxlength 100 $readonly_fld {} class form_element" \
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

element create $form_name modello \
-label   "modello" \
-widget   text \
-datatype text \
-html    "size 14 maxlength 35 $readonly_fld {} class form_element" \
-optional

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

element create $form_name cod_potenza \
-label   "cod_potenza" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimpote cod_potenza descr_potenza potenza_min] \

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

element create $form_name cod_cost \
-label   "cod_cost" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimcost cod_cost descr_cost] \

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

element create $form_name circuito_primario \
-label   "circuito_primario" \
-widget   select \
-datatype text \
    -html    "\{\} {} class form_element" \
-optional \
-options {{{} {}} {{Ad acqua calda (T<100°C)} C} {{Ad acqua surriscaldata (T>100°C)} S}}

element create $form_name distr_calore \
-label   "distr_calore" \
-widget   select \
-datatype text \
    -html    "\{\} {} class form_element" \
-optional \
    -options {{{} {}} {{Distribuzione centralizzata} D} {{Scambiatori dedicati per ogni Unit&agrave; Abitativa} S}}

element create $form_name n_scambiatori \
-label   "n_scambiatori" \
-widget   text \
-datatype text \
    -html    "size 2 maxlength 2 \{\} {} class form_element" \
-optional

element create $form_name potenza_scamb_tot \
-label   "potenza" \
-widget   text \
-datatype text \
    -html    "size 8 maxlength 12 \{\} {} class form_element" \
-optional

element create $form_name conta_max \
    -widget   hidden \
    -datatype text \
    -optional

multirow create multiple_form conta
set conta 0

if {![string equal $cod_impianto ""]
    && [string equal $flag_conta ""]
    && [string equal $conta_max ""]} {
    db_1row sel_n_scamb "select n_scambiatori from coimaimp where cod_impianto = :cod_impianto"
    set conta_max $n_scambiatori
}

if {[string equal $flag_conta ""]
    && [string equal $conta_max ""]} {
    set conta_max "1"
} else {
    if {![string equal $flag_conta ""]} {
	set conta_max [expr $conta_max + 1]
    }
}

#    ns_return 200 text/html "$conta - $conta_max"; return
while {$conta < $conta_max} {
    incr conta 
    multirow append multiple_form $conta
    
    element create $form_name scamb_prog.$conta \
	-label   "numero" \
	-widget   text \
	-datatype text \
	-html    "size 3 maxlength 10 readonly {} class form_element" \
	-optional
    
    element create $form_name potenza_scamb.$conta \
	-label   "potenza focolare libretto" \
	-widget   text \
	-datatype text \
	-html    "size 8 maxlength 8 \{\} {} class form_element" \
	-optional
}

element create $form_name cod_distributore \
-label   "Distributore" \
-widget   select \
-datatype text \
    -html    "\{\} {} class form_element" \
-optional \
-options [iter_selbox_from_table coimdist cod_distr ragione_01] \

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

if {[string equal $cod_impianto ""]} {
    # link per i cerca
    if {$coimtgen(flag_viario) == "T"} {
	set cerca_viae [iter_search $form_name [ad_conn package_url]/tabgen/coimviae-filter [list dummy f_cod_via dummy descr_via dummy descr_topo cod_comune cod_comune dummy dummy dummy dummy dummy dummy]]
    } else {
	set cerca_viae ""
    }
    
    set flag_ins_prop "S"
    set flag_ins_terzi "S"
    
    #link inserimento occupante
    set nome_funz_new [iter_get_nomefunz coimcitt-isrt]
    element set_properties $form_name nome_funz_new   -value $nome_funz_new
    
    #link inserimento occupante
    set link_ins_occu [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_occ nome nome_occ nome_funz nome_funz_new localita localita descr_via descr_via descr_topo descr_topo numero numero cap cap provincia provincia cod_comune cod_comune dummy cod_citt_occ] "Inserisci Sogg."]
    
#link inserimento proprietario
    set link_ins_prop [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_prop nome nome_prop nome_funz nome_funz_new dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy cod_citt_prop dummy dummy flag_ins_prop flag_ins_prop] "Inserisci Sogg."]
    
    set cerca_inte  [iter_search $form_name coimcitt-filter [list dummy cod_citt_inte f_cognome cognome_inte f_nome nome_inte]]
    
    set cerca_prop  [iter_search $form_name coimcitt-filter [list dummy cod_citt_prop f_cognome cognome_prop f_nome nome_prop]]
    
    set cerca_occ   [iter_search $form_name coimcitt-filter [list dummy cod_citt_occ  f_cognome cognome_occ  f_nome nome_occ ]]
    
    set cerca_amm   [iter_search $form_name coimcitt-filter [list dummy cod_citt_amm  f_cognome cognome_amm  f_nome nome_amm ]]
    
    set cerca_terzi [iter_search $form_name coimmanu-list  [list dummy cod_citt_terzi f_cognome cognome_terzi f_nome nome_terzi] [list f_ruolo "M"]]
    set cerca_inst  [iter_search $form_name coimmanu-list   [list dummy cod_manu_inst dummy cognome_inst dummy nome_inst]]
    
    set cerca_prog  [iter_search $form_name coimprog-list   [list dummy cod_prog dummy cognome_prog dummy nome_prog]]
} else {
    set cerca_viae ""
    set cerca_inte ""
    set cerca_prop ""
    set cerca_occ ""
    set cerca_amm ""
    set cerca_terzi ""
    set cerca_inst ""
    set cerca_prog ""
    set cerca_manu ""
    set link_ins_occu ""
    set link_ins_prop ""
}



#link inserimento terzi
#set link_ins_terzi [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_terzi nome nome_terzi nome_funz nome_funz_new dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy cod_citt_terzi dummy dummy dummy dummy  flag_ins_terzi flag_ins_terzi] "Inserisci Sogg."]

if {[form is_request $form_name]} {
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

    if {$funzione == "I"} {

	if {[string equal $coimtgen(flag_ente) "C"]} {
	    #se l'ente � un comune assegno alcuni default con i dati di ambiente
	    element set_properties $form_name cod_comune -value $coimtgen(cod_comu)
	    element set_properties $form_name descr_comu -value $coimtgen(denom_comune)
	}

	element set_properties $form_name conta_max -value $conta_max
        element set_properties $form_name provincia     -value $coimtgen(sigla_prov)
        element set_properties $form_name cod_provincia -value $coimtgen(cod_provincia)
	element set_properties $form_name flag_dpr412   -value "S"
	element set_properties $form_name stato		-value "A"

	set link_aggiungi_gen "<a href=\"coimtele-ins-gest?funzione=I&[export_url_vars cod_impianto url_list_aimp url_aimp nome_funz nome_funz_caller extra_par flag_tracciato conta_max]&flag_conta=S\">Aggiungi scambiatore</a>"

	if {![string equal $cod_impianto ""]} {

	    if {$coimtgen(flag_viario) == "T"} {
		set sel_aimp [db_map sel_aimp_vie]
	    } else {
		set sel_aimp [db_map sel_aimp_no_vie]
	    }

	    db_1row sel_aimp $sel_aimp

	    element set_properties $form_name volimetria_risc  	-value $volimetria_risc
	    element set_properties $form_name descr_topo       	-value $toponimo
	    element set_properties $form_name descr_via        	-value $indirizzo
	    element set_properties $form_name numero           	-value $numero
	    element set_properties $form_name f_cod_via        	-value $cod_via
	    element set_properties $form_name esponente        	-value $esponente
	    element set_properties $form_name scala            	-value $scala
	    element set_properties $form_name piano            	-value $piano
	    element set_properties $form_name interno          	-value $interno
	    element set_properties $form_name cap          	-value $cap
	    element set_properties $form_name localita         	-value $localita
	    element set_properties $form_name cod_comune       	-value $cod_comune
	    element set_properties $form_name cod_provincia     -value $cod_provincia
	    element set_properties $form_name cod_cted         	-value $cod_cted
	    element set_properties $form_name data_installaz    -value $data_installaz
	    element set_properties $form_name flag_responsabile -value $flag_responsabile
	    if {$flag_responsabile == "T"} {       
		element set_properties $form_name cognome_terzi	-value $cognome_resp
		element set_properties $form_name nome_terzi    -value $nome_resp
	    }
	    element set_properties $form_name cognome_manu     -value $cognome_manu
	    element set_properties $form_name nome_manu        -value $nome_manu
	    element set_properties $form_name cod_manu_manu    -value $cod_manutentore
	    element set_properties $form_name cod_citt_prop    -value $cod_responsabile
	    element set_properties $form_name cognome_prop     -value $cognome_prop
	    element set_properties $form_name nome_prop        -value $nome_prop
	    element set_properties $form_name cognome_occ      -value $cognome_occ
	    element set_properties $form_name nome_occ         -value $nome_occ
	    element set_properties $form_name cognome_inst     -value $cognome_inst
	    element set_properties $form_name nome_inst        -value $nome_inst
	    element set_properties $form_name cognome_prog     -value $cognome_prog
	    element set_properties $form_name nome_prog        -value $nome_prog
	    element set_properties $form_name cognome_amm      -value $cognome_amm
	    element set_properties $form_name nome_amm         -value $nome_amm
	    element set_properties $form_name cognome_inte     -value $cognome_inte
	    element set_properties $form_name nome_inte        -value $nome_inte
	    element set_properties $form_name cod_citt_occ     -value $cod_occupante
	    element set_properties $form_name cod_citt_amm     -value $cod_amministratore
	    element set_properties $form_name cod_citt_inte      -value $cod_intestatario
	    element set_properties $form_name cod_prog          -value $cod_progettista
	    element set_properties $form_name circuito_primario -value $circuito_primario
	    element set_properties $form_name distr_calore      -value $distr_calore
	    element set_properties $form_name potenza_scamb_tot -value $potenza_scamb_tot
	    element set_properties $form_name n_scambiatori     -value $n_scambiatori
	    element set_properties $form_name cod_distributore  -value $cod_distributore
	    element set_properties $form_name note_dest     	-value $note_dest

	    db_1row sel_aimp "select a.cod_utgi
		     		   , u.descr_utgi
                     from coimgend a left outer join coimutgi u on a.cod_utgi = u.cod_utgi
                     where  a.cod_impianto = :cod_impianto limit 1"
	
	    element set_properties $form_name cod_utgi			-value $cod_utgi
	    
	    db_foreach sel_scamb "select scamb_prog, iter_edit_num(potenza, 2) as potenza_scamb from coimscamb where cod_impianto = :cod_impianto order by scamb_prog" {
		element set_properties $form_name scamb_prog.$scamb_prog -value $scamb_prog
		element set_properties $form_name potenza_scamb.$scamb_prog -value $potenza_scamb
	    }
	} else {
	    element set_properties $form_name cognome_prop     -value $f_resp_cogn
	    element set_properties $form_name nome_prop        -value $f_resp_nome
	    element set_properties $form_name cod_comune       	-value $f_comune
	    element set_properties $form_name f_cod_via        	-value $f_cod_via
	    element set_properties $form_name descr_topo       	-value $f_desc_topo
	    element set_properties $form_name descr_via        	-value $f_desc_via
	}
    }
}


if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    set note_dest              [string trim [element::get_value $form_name note_dest]]
    set cod_impianto_est  [string trim [element::get_value $form_name cod_impianto_est]]
    set stato             [string trim [element::get_value $form_name stato]]
    set stato "A"
    element set_properties $form_name stato			-value "A"
    set note              [string trim [element::get_value $form_name note]]
    set localita          [string trim [element::get_value $form_name localita]]

    if {[string equal $coimtgen(flag_ente) "C"]} {
        set descr_comu    [string trim [element::get_value $form_name descr_comu]]
    }
    set cod_comune        [string trim [element::get_value $form_name cod_comune]]
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

    if {![string equal $cod_impianto ""]} {

	if {$coimtgen(flag_viario) == "T"} {
	    set sel_aimp [db_map sel_aimp_vie]
	} else {
	    set sel_aimp [db_map sel_aimp_no_vie]
	}
	
	db_1row sel_aimp $sel_aimp
	
	element set_properties $form_name descr_topo       	-value $toponimo	
	    element set_properties $form_name cod_comune       	-value $cod_comune
	element set_properties $form_name cod_provincia     -value $cod_provincia
	element set_properties $form_name cod_cted         	-value $cod_cted
	element set_properties $form_name flag_responsabile -value $flag_responsabile
	
	db_1row sel_aimp "select a.cod_utgi
		     		   , u.descr_utgi
                     from coimgend a left outer join coimutgi u on a.cod_utgi = u.cod_utgi
                     where  a.cod_impianto = :cod_impianto"
	
	element set_properties $form_name cod_utgi			-value $cod_utgi
    }
	set conta 0
	while {$conta < $conta_max} {
	    incr conta
	    element set_properties $form_name scamb_prog.$conta -value $conta
	}

    set circuito_primario [string trim [element::get_value $form_name circuito_primario]]
    set distr_calore      [string trim [element::get_value $form_name distr_calore]]
    set potenza_scamb_tot [string trim [element::get_value $form_name potenza_scamb_tot ]]
    set n_scambiatori     [string trim [element::get_value $form_name n_scambiatori ]]
    set conta_max         [element::get_value $form_name conta_max]
    set cod_distributore  [element::get_value $form_name cod_distributore]

    set link_aggiungi_gen "<a href=\"coimtele-ins-gest?funzione=I&[export_url_vars cod_impianto url_list_aimp url_aimp nome_funz nome_funz_caller extra_par flag_tracciato conta_max]&flag_conta=S\">Aggiungi scambiatore</a>"
	
    set conta 0
    while {$conta < $conta_max} {
	incr conta
	set scamb_prog($conta)         [element::get_value $form_name scamb_prog.$conta]
	set potenza_scamb($conta)     [element::get_value $form_name potenza_scamb.$conta]
    }

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
    if {$funzione == "I"} {

	if {$cod_utgi != "X" && ![string equal $note_dest ""]} {
		element::set_error $form_name note_dest "valorizzare solo se la destinazione è 'altro'"
		incr error_num
	}

	if {[string equal $circuito_primario ""]} {
	    element::set_error $form_name circuito_primario "Inserire"
	    incr error_num	    
	}

	if {[string equal $cod_distributore ""]} {
	    element::set_error $form_name cod_distributore "Inserire"
	    incr error_num	    
	}

	if {[string equal $distr_calore ""]} {
	    element::set_error $form_name distr_calore "Inserire"
	    incr error_num
	}

	if {[string equal $n_scambiatori ""]} {
	    element::set_error $form_name n_scambiatori "Inserire"
	    incr error_num
	} else {
	    if {$n_scambiatori != $conta_max} {
		element::set_error $form_name n_scambiatori "N. scambiatori non corrisponde agli scambiatori aggiunti"
		incr error_num
	    }
	}

	if {[string equal $potenza_scamb_tot ""]} {
	    element::set_error $form_name potenza_scamb_tot "Inserire"
	    incr error_num
	} else {
	    set conta 0
	    set potenza_tot_check "0.00"
	    while {$conta < $conta_max} {
		incr conta
		if {[string equal $potenza_scamb($conta) ""]} {
		    element::set_error $form_name potenza_scamb.$conta "Inserire"
		    incr error_num
		} else {
		    set potenza_scamb($conta) [iter_check_num $potenza_scamb($conta) 2]
		    if {$potenza_scamb($conta) == "Error"} {
			element::set_error $form_name potenza_scamb.$conta "Deve essere numerico e pu&ograve; avere al massimo 2 decimali"
			incr error_num
		    } else {
			if {[iter_set_double $potenza_scamb($conta)] >=  [expr pow(10,7)]
			    ||  [iter_set_double $potenza_scamb($conta)] <= -[expr pow(10,7)]} {
			    element::set_error $form_name potenza_scamb.$conta "Deve essere inferiore di 10.000.000"
			    incr error_num
			} else {
			    set potenza_tot_check [expr $potenza_tot_check + $potenza_scamb($conta)]
			}
		    }
		}
	    }
	    set potenza_scamb_tot [iter_check_num $potenza_scamb_tot 2]
	    if {$potenza_scamb_tot == "Error"} {
		element::set_error $form_name potenza_scamb_tot "Deve essere numerico e pu&ograve; avere al massimo 2 decimali"
		incr error_num
	    } else {
		if {[iter_set_double $potenza_scamb_tot] >=  [expr pow(10,7)]
		    ||  [iter_set_double $potenza_scamb_tot] <= -[expr pow(10,7)]} {
			    element::set_error $form_name potenza_scamb_tot "Deve essere inferiore di 10.000.000"
		    incr error_num
		} else {
		    if {$potenza_tot_check != $potenza_scamb_tot} {
			element::set_error $form_name potenza_scamb_tot "Il totale delle potenza inserite non corrisponde"
			incr error_num
		    }
		}
	    }
	}

        if {[string equal $cod_impianto_est ""]
	&&  $flag_cod_aimp_auto == "F"
	} {
	    element::set_error $form_name cod_impianto_est "Inserire codice impianto"
	    incr error_num
	}

#        if {![string equal $cod_impianto_est ""]
#	&&   [db_0or1row check_aimp ""] == 1
#	} {
#	    element::set_error $form_name cod_impianto_est "Esiste gi&agrave; un impianto con questo codice"
#	    incr error_num
#	}
     
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

        if {[string equal $data_installaz ""]} {
            element::set_error $form_name data_installaz "Inserire data"
            incr error_num
        } else {
            set data_installaz [iter_check_date $data_installaz]
            if {$data_installaz == 0} {
                element::set_error $form_name data_installaz "Data non corretta"
                incr error_num
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
		    incr error_num
		} else {
		    if {[string equal $coimtgen(flag_ente) "C"]} {
			element set_properties $form_name cod_comune -value $coimtgen(cod_comu)
			element set_properties $form_name descr_comu -value $coimtgen(denom_comune)
		    }

#		    element::set_error $form_name descr_comu "valorizzare il Comune"
		} 
	    } 
	}

	if {[string equal $coimtgen(flag_ente) "C"]} {
	    set cod_comune $coimtgen(cod_comu)
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
	if {[string equal $f_cod_via ""]} {
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
			if {[string equal $flag_ins_occu ""]
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
		    if {[db_0or1row sel_cod_legale ""] == 0} {
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
		    element::set_error $form_name flag_responsabile "Indicare responsabile"
		    incr error_num 
#		}
	    }
	}

	if {[string equal $cognome_prop ""] && [string equal $nome_prop ""]
	    && [string equal $cognome_amm ""]&& [string equal $nome_amm ""]
	} {
	    set cod_citt_prop ""
	    element::set_error $form_name cognome_prop "inserire proprietario o amministratore"
	    set cod_citt_amm ""
	    element::set_error $form_name cognome_amm "inserire amministratore o proprietario"
	    incr error_num
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
	    element::set_error $form_name cognome_inst "inserire installatore"
	    incr error_num
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
	    if {[string equal $cod_impianto ""]} {
		db_1row sel_dual_aimp ""
		# inserimento impianto
		if {$flag_codifica_reg == "T"} {
                    #gab02 aggiunto alle condizioni la provincia di Ancona
		    #gab01 aggiunto alle condizioni il comune di Ancona
		    if {$coimtgen(ente) eq "CPESARO" || $coimtgen(ente) eq "PPU" || $coimtgen(ente) eq "CFANO" || $coimtgen(ente) eq "CANCONA" || $coimtgen(ente) eq "PAN" || $coimtgen(ente) eq "CJESI" || $coimtgen(ente) eq "CSENIGALLIA"} {#sim01: aggiunta if ed il suo contenuto
			if {$coimtgen(ente) eq "CPESARO"} {
			    set sigla_est "CMPS"
			} elseif {$coimtgen(ente) eq "CFANO"} {
			    set sigla_est "CMFA"
			} elseif {$coimtgen(ente) eq "CANCONA"} {;#gab01
                            set sigla_est "CMAN"
                        } elseif {$coimtgen(ente) eq "PAN"} {;#gab02
                            set sigla_est "PRAN"
			} elseif {$coimtgen(ente) eq "CJESI"} {;#sim04
                            set sigla_est "CMJE"
                        } elseif {$coimtgen(ente) eq "CSENIGALLIA"} {;#sim04
                            set sigla_est "CMSE"
                        } else {
			    set sigla_est "PRPU"
			}
			
			set progressivo_est [db_string sel "select nextval('coimaimp_est_s')"]
			# devo fare l'lpad con una seconda query altrimenti mi andava in errore
			#nic01 set progressivo_est [db_string sel "select lpad(:progressivo_est, 6, '0')"]
			set progressivo_est [db_string sel "select lpad(:progressivo_est,:lun_num_cod_imp_est,'0')"];#nic01
			
			set cod_impianto_est "$sigla_est$progressivo_est"
	
		    } else {#sim01
			# caso standard
			
			db_1row sel_dati_comu ""
			if {$coimtgen(ente) eq "PMS"} {#sim02: Riportate modifiche fatte per Massa in data 03/12/2015 per gli altri programmi dove è presente la codifica dell'impianto 
			    set progressivo [db_string query "select lpad(:progressivo, 5, '0')"]
			    set cod_istat  "[string range $cod_istat 5 6]/"
			} elseif {$coimtgen(ente) eq "PTA"} {#sim02: aggiunta if e suo contenuto
			    set progressivo [db_string query "select lpad(:progressivo, 7, '0')"]
			    set fine_istat  [string length $cod_istat]
			    set iniz_ist    [expr $fine_istat -3]
			    set cod_istat  "[string range $cod_istat $iniz_ist $fine_istat]"
			} else {#sim02
			    #sim01: la sel_dati_comu andava in errore sul lpad di progressivo.Quindi faccio lpad dopo la query
			    set progessivo [db_string query "select lpad(:progressivo, 7, '0')"];#sim01
			};#sim02

			set tipologia "TL"
			#sim02 set cod_impianto_est "$cod_istat$tipologia$progressivo"
			set cod_impianto_est "$cod_istat$progressivo";#sim02
			set dml_comu [db_map upd_prog_comu]
		    };#sim01
		} else {
		    db_1row get_cod_impianto_est ""
		}
		
		db_1row sel_cod_comb "select cod_combustibile from coimcomb where descr_comb = 'TELERISCALDAMENTO'"
		set dml_sql_aimp [db_map ins_aimp]
		# inserimento generatore
		set gen_prog     1
		set gen_prog_est 1
		set dml_sql_gend [db_map ins_gend]

	    } else {
		set dml_sql_aimp [db_map upd_aimp]
	    }
	}
    }

    # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql_aimp]
    } {
	with_catch error_msg {
	    db_transaction {

		db_dml dml_coimaimp $dml_sql_aimp 
		if {[info exists dml_sql_gend] } {
		    db_dml dml_coimgend $dml_sql_gend
		}
                if {[info exists dml_comu]} {
		    db_dml dml_coimcomu $dml_comu
		}
		set conta 0
		db_dml del_scamb ""
		while {$conta < $conta_max} {
		    incr conta
		    set scamb_prog_db $scamb_prog($conta)
		    set potenza_db  $potenza_scamb($conta)
		    db_dml ins_scamb ""
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
    set link_gest [export_url_vars cod_impianto cod_impianto_old nome_funz_caller extra_par caller conta_max]&nome_funz=impianti

    set return_url   "coimaimp-sche?funzione=V&$link_gest"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template

