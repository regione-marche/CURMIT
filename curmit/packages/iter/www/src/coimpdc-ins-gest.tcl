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
    sim03 22/05/2017 Personaliz. per Comune di Jesi: ricodificare gli impianti come da Legge
    sim03            Reg. Marche CMJE.
    sim03            Per Comune di Senigalli: CMSE

    gab02 12/04/2017 Personaliz. per Provincia di Ancona: ricodificare gli impianti come da Legge
    gab02            Reg. Marche PRAN.

    gab01 08/02/2017 Personaliz. per Comune di Ancona: ricodificare gli impianti come da Legge
    gab01            Reg. Marche CMAN.

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
   {url_coimaces_list	""}
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
   {cod_as_resp          ""}
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


# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# controllo se l'utente ï¿½ un manutentore
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
       set page_title   "Inserimento $titolo"
	}
	M {set button_label "Conferma Modifica"
       set page_title   "Modifica $titolo"
	}
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
set form_name    "coimpdc"
set readonly_key "readonly"
set readonly_fld "readonly"
set readonly_cod "readonly"
set readonly_aimp "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""
 

switch $funzione {
   "I" {
		#set readonly_key \{\}
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

element create $form_name volimetria_risc \
-label   "Volimetria riscaldata" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
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

#ubicazione
element create $form_name cap \
-label   "CAP" \
-widget   text \
-datatype text \
-html    "size 5 maxlength 5 $readonly_fld {} class form_element" \
-optional

element create $form_name localita \
-label   "Localita" \
-widget   text \
-datatype text \
-html    "size 25 maxlength 40 $readonly_fld {} class form_element" \
-optional

if {$coimtgen(flag_ente) == "P"} {
    element create $form_name cod_comune \
   -label   "Comune" \
   -widget   select \
    -options [iter_selbox_from_comu]\
    -datatype text \
    -html    "$disabled_fld {} class form_element " \
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


element create $form_name cod_cted \
-label   "cod_cted" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table coimcted cod_cted "cod_cted||' '||descr_cted"] \

element create $form_name cod_utgi \
-label   "Dest. d'uso generatore" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options [iter_selbox_from_table_obblig coimutgi cod_utgi descr_utgi cod_utgi]

element create $form_name note_dest \
-label   "note_dest" \
-widget   textarea \
-datatype text \
-html    "cols 80 rows 2 $readonly_fld {} class form_element" \
-optional

element create $form_name data_installaz \
-label   "data_installaz" \
-widget   text \
-datatype text \
-html    "size 10 maxlength 10 $readonly_fld {} class form_element" \
-optional

#dati generatore principale

element create $form_name alimentazione \
-label   "alimentazione" \
-widget   select \
-datatype text \
-html    "class form_element" \
-optional \
-options [iter_selbox_from_table coimalim cod_alim descr_alim] \

element create $form_name cop \
-label   "cop" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 12 class form_element" \
-optional

element create $form_name per \
-label   "per" \
-widget   text \
-datatype text \
-html    "size 8 maxlength 12 class form_element" \
-optional

element create $form_name fonte_calore \
-label   "fonte_calore" \
-widget   select \
-datatype text \
-html    "class form_element" \
-optional \
-options  [iter_selbox_from_table coimfdc cod_fdc descr_fdc] \

#dati soggetti
#flag-responsabile
element create $form_name flag_responsabile \
-label   "responsabile" \
-widget   select \
-datatype text \
-html    "$disabled_fld {} class form_element" \
-optional \
-options {{{} {}} {Proprietario P} {Occupante O} {Amministratore A} {Intestatario I} {Terzi T}}

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

if {[string equal $cod_impianto ""]} {
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
} else {
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
#element create $form_name stato_01      -widget hidden -datatype text -optional
element create $form_name cod_impianto_est_new -widget hidden -datatype text -optional
element create $form_name f_resp_cogn  -widget hidden -datatype text -optional
element create $form_name f_resp_nome  -widget hidden -datatype text -optional
element create $form_name f_comune     -widget hidden -datatype text -optional
element create $form_name cod_as_resp  -widget hidden -datatype text -optional
element create $form_name f_cod_via    -widget hidden -datatype text -optional
element create $form_name f_desc_via   -widget hidden -datatype text -optional
element create $form_name f_desc_topo  -widget hidden -datatype text -optional
element create $form_name flag_ins_occu -widget hidden -datatype text -optional
element create $form_name flag_ins_prop -widget hidden -datatype text -optional
element create $form_name flag_ins_terzi -widget hidden -datatype text -optional
element create $form_name nome_funz_new -widget hidden -datatype text -optional
element create $form_name submit        -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name last_cod_impianto -widget hidden -datatype text -optional

# link per i cerca
if {[string equal $cod_impianto ""]} {
	if {$coimtgen(flag_viario) == "T"} {
	    set cerca_viae [iter_search $form_name [ad_conn package_url]/tabgen/coimviae-filter [list dummy f_cod_via dummy descr_via dummy descr_topo cod_comune cod_comune dummy dummy dummy dummy dummy dummy]]
	} else {
	    set cerca_viae ""
	}

	set cerca_cap   "<a href=\"http://www.poste.it/online/cercacap/\">Ricerca CAP"
	
	set cerca_inte  [iter_search $form_name coimcitt-filter [list dummy cod_citt_inte f_cognome cognome_inte f_nome nome_inte]]

	set cerca_prop  [iter_search $form_name coimcitt-filter [list dummy cod_citt_prop f_cognome cognome_prop f_nome nome_prop]]

	set cerca_occ   [iter_search $form_name coimcitt-filter [list dummy cod_citt_occ  f_cognome cognome_occ  f_nome nome_occ ]]

	set cerca_amm   [iter_search $form_name coimcitt-filter [list dummy cod_citt_amm  f_cognome cognome_amm  f_nome nome_amm ]]

	set cerca_terzi [iter_search $form_name coimmanu-list  [list dummy cod_citt_terzi f_cognome cognome_terzi f_nome nome_terzi] [list f_ruolo "M"]]
	set cerca_inst  [iter_search $form_name coimmanu-list   [list dummy cod_manu_inst dummy cognome_inst dummy nome_inst]]

	set cerca_prog  [iter_search $form_name coimprog-list   [list dummy cod_prog dummy cognome_prog dummy nome_prog]]

	#link inserimento proprietario
	set link_ins_prop [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_prop nome nome_prop nome_funz nome_funz_new dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy cod_citt_prop dummy dummy flag_ins_prop flag_ins_prop] "Inserisci Sogg."]
	
	#link inserimento occupante
	set link_ins_occu [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_occ nome nome_occ nome_funz nome_funz_new localita localita descr_via descr_via descr_topo descr_topo numero numero cap cap provincia provincia cod_comune cod_comune dummy cod_citt_occ] "Inserisci Sogg."]

	#link inserimento terzi
	#set link_ins_terzi [iter_link_ins $form_name coimcitt-isrt [list cognome cognome_terzi nome nome_terzi nome_funz nome_funz_new dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy dummy cod_citt_terzi dummy dummy dummy dummy  flag_ins_terzi flag_ins_terzi] "Inserisci Sogg."]
} else {
	set cerca_viae ""
	set cerca_cap ""
	set cerca_inte ""
	set cerca_prop ""
	set cerca_occ ""
	set cerca_amm ""
	set cerca_terzi ""
	set cerca_inst ""
	set cerca_prog ""
	set link_ins_occu ""
	set link_ins_prop ""
}

set flag_ins_prop "S"
set flag_ins_terzi "S"

#link inserimento occupante
set nome_funz_new [iter_get_nomefunz coimcitt-isrt]
element set_properties $form_name nome_funz_new   -value $nome_funz_new

if {[form is_request $form_name]} {
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
    element set_properties $form_name nome_funz_caller -value $nome_funz_caller
    element set_properties $form_name extra_par        -value $extra_par
    element set_properties $form_name last_cod_impianto -value $last_cod_impianto
    #element set_properties $form_name stato_01         -value $stato_01
    element set_properties $form_name cod_impianto_est_new -value $cod_impianto_est_new    
    element set_properties $form_name cod_impianto_est -value $cod_impianto_est_new  
	element set_properties $form_name flag_responsabile -value "P"
    element set_properties $form_name f_resp_cogn      -value $f_resp_cogn
    element set_properties $form_name f_resp_nome      -value $f_resp_nome
    element set_properties $form_name f_comune         -value $f_comune 
    element set_properties $form_name cod_as_resp      -value $cod_as_resp
    element set_properties $form_name f_cod_via        -value $f_cod_via
    element set_properties $form_name f_desc_via       -value $f_desc_via
    element set_properties $form_name f_desc_topo      -value $f_desc_topo
    element set_properties $form_name flag_ins_occu    -value $flag_ins_occu
    element set_properties $form_name flag_ins_prop    -value $flag_ins_prop
    element set_properties $form_name flag_ins_terzi    -value $flag_ins_terzi
    element set_properties $form_name cod_impianto     -value $cod_impianto
   	
	if {[string equal $coimtgen(flag_ente) "C"]} {
	    #se l'ente è un comune assegno alcuni default con i dati di ambiente
	    element set_properties $form_name cod_comune -value $coimtgen(cod_comu)
	    element set_properties $form_name descr_comu -value $coimtgen(denom_comune)
	}

    element set_properties $form_name provincia     -value $coimtgen(sigla_prov)
    element set_properties $form_name cod_provincia -value $coimtgen(cod_provincia)
	
	
	
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
	    element set_properties $form_name cap          		-value $cap
	    element set_properties $form_name localita         	-value $localita
	    element set_properties $form_name cod_comune       	-value $cod_comune
	    element set_properties $form_name cod_provincia     -value $cod_provincia
	    element set_properties $form_name cod_cted         	-value $cod_cted
	
		element set_properties $form_name cod_utgi         	-value $cod_utgi
		element set_properties $form_name note_dest     	-value $note_dest
		element set_properties $form_name alimentazione     -value $cod_alim
		element set_properties $form_name cop  			   	-value $cop
		
		element set_properties $form_name per		     	-value $per
		element set_properties $form_name fonte_calore     	-value $cod_fdc
	    element set_properties $form_name data_installaz    -value $data_installaz
	    element set_properties $form_name flag_responsabile -value $flag_responsabile
	    if {$flag_responsabile == "T"} {       
			element set_properties $form_name cognome_terzi	-value $cognome_resp
			element set_properties $form_name nome_terzi    -value $nome_resp
			element set_properties $form_name cod_citt_terzi     -value $cod_responsabile
		}
		element set_properties $form_name cognome_manu     -value $cognome_manu
	    element set_properties $form_name nome_manu        -value $nome_manu
	    element set_properties $form_name cod_manu_manu    -value $cod_manutentore
	    element set_properties $form_name cognome_prop     -value $cognome_prop
	    element set_properties $form_name nome_prop        -value $nome_prop
	    element set_properties $form_name cod_citt_prop    -value $cod_responsabile
		element set_properties $form_name cognome_occ      -value $cognome_occ
	    element set_properties $form_name nome_occ         -value $nome_occ
	    element set_properties $form_name cod_citt_occ     -value $cod_occupante
		element set_properties $form_name cognome_inst     -value $cognome_inst
	    element set_properties $form_name nome_inst        -value $nome_inst
		element set_properties $form_name cod_citt_occ     -value $cod_installatore
	    element set_properties $form_name cognome_prog     -value $cognome_prog
	    element set_properties $form_name nome_prog        -value $nome_prog
		element set_properties $form_name cod_prog       	-value $cod_progettista
	    element set_properties $form_name cognome_amm      -value $cognome_amm
	    element set_properties $form_name nome_amm         -value $nome_amm
	    element set_properties $form_name cod_citt_amm     -value $cod_amministratore
		element set_properties $form_name cognome_inte     -value $cognome_inte
	    element set_properties $form_name nome_inte        -value $nome_inte
	    element set_properties $form_name cod_citt_inte    -value $cod_intestatario
	} else {
		element set_properties $form_name cognome_prop     -value $f_resp_cogn
	    element set_properties $form_name nome_prop        -value $f_resp_nome
		element set_properties $form_name descr_topo       	-value $f_desc_topo
		element set_properties $form_name f_cod_via        	-value $f_cod_via
	    element set_properties $form_name descr_via        	-value $f_desc_via
	    element set_properties $form_name cod_comune		-value $f_comune
	}
}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    set cod_impianto_est  [string trim [element::get_value $form_name cod_impianto_est]]
	#set stato             [string trim [element::get_value $form_name stato]]
	#set stato "A"
	#element set_properties $form_name stato			-value "A"
	set note_dest              [string trim [element::get_value $form_name note_dest]]
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
	set cod_cted          [string trim [element::get_value $form_name cod_cted]]
	set cod_utgi          [string trim [element::get_value $form_name cod_utgi]]

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
   
    set cod_combustibile  "9"
    set provenienza_dati  "4"
    set data_installaz    [string trim [element::get_value $form_name data_installaz]]
    
    set volimetria_risc   [string trim [element::get_value $form_name volimetria_risc]]
  
	if {$funzione == "M"} {
		if {$coimtgen(flag_viario) == "T"} {
			set sel_aimp [db_map sel_aimp_vie]
		} else {
			set sel_aimp [db_map sel_aimp_no_vie]
		}
	
		db_1row sel_aimp $sel_aimp
		
		if {[string equal $coimtgen(flag_ente) "C"]} {
			element set_properties $form_name descr_comu        -value $descr_comu
		}
		element set_properties $form_name cod_comune        -value $cod_comune
		element set_properties $form_name descr_topo        -value $descr_topo
		element set_properties $form_name cod_cted        -value $cod_cted
		element set_properties $form_name cod_utgi        -value $cod_utgi

	}
	
	set cod_alim     	  [string trim [element::get_value $form_name alimentazione]]
	set cop   			  [string trim [element::get_value $form_name cop]]
	set per   			  [string trim [element::get_value $form_name per]]
	set cod_fdc      	  [string trim [element::get_value $form_name fonte_calore]]
	
    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0
  
	if {$funzione == "I"} {

		
	
	    if {[string equal $cod_impianto_est ""]
			&& $flag_cod_aimp_auto == "F"
		} {
		    element::set_error $form_name cod_impianto_est "Inserire codice impianto"
		    incr error_num
		}
	
#		if {[string equal $stato ""]} {
#		    element::set_error $form_name stato "Inserire lo stato dell'impianto"
#		    incr error_num
#		}
	
	    if {![string equal $cod_impianto_est ""]
			&& [db_0or1row check_aimp ""] == 1
		} {
		    element::set_error $form_name cod_impianto_est "Esiste gi&agrave; un impianto con questo codice"
		    incr error_num
		}
	     
	    if {[string equal $data_installaz ""]} {
	    	element::set_error $form_name data_installaz "inserire data"
	        incr error_num
	    } else {
	    	set data_installaz [iter_check_date $data_installaz]
	        if {$data_installaz == 0} {
	        	element::set_error $form_name data_installaz "Data non corretta"
	            incr error_num
	        }
	    }

		# se la via ï¿½ valorizzata, ma manca il comune: errore
	
	    if {![string equal $descr_via  ""]
			|| ![string equal $descr_topo ""]
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
	}
	
	

	if {[string equal $cod_utgi ""]} {
		element::set_error $form_name cod_utgi "inserire destinazione"
		incr error_num
	}
	
	if {[string equal $cod_alim ""]} {
		element::set_error $form_name alimentazione "inserire l'alimentazione"
		incr error_num
	}
	if {[string equal $cop ""]} {
		element::set_error $form_name cop "inserire COP"
		incr error_num
	} else {
		set cop [iter_check_num $cop 2]
		if {$cop == "Error"} {
			element::set_error $form_name cop "numerico con al massimo 2 decimali"
			incr error_num
		} else {
			if {[iter_set_double $cop] >=  [expr pow(10,2)]
			    ||  [iter_set_double $cop] <= -[expr pow(10,2)]} {
			    element::set_error $form_name cop "deve essere < di 99,99"
			    incr error_num
			}
		}
	}
	
	if {[string equal $per ""]} {
		element::set_error $form_name per "inserire PER"
		incr error_num
	} else {
		set per [iter_check_num $per 2]
		if {$per == "Error"} {
			element::set_error $form_name per "numerico con al massimo 2 decimali"
			incr error_num
		} else {
			if {[iter_set_double $per] >=  [expr pow(10,2)]
			    ||  [iter_set_double $per] <= -[expr pow(10,2)]} {
			    element::set_error $form_name per "deve essere < di 99,99"
			    incr error_num
			}
		}
	}
	
	if {[string equal $cod_fdc  ""]} {
		element::set_error $form_name fonte_calore "inserire la fonte di calore"
		incr error_num
	}
	
	if {$cod_utgi != "X" && ![string equal $note_dest ""]} {
		element::set_error $form_name note_dest "valorizzare solo se la destinazione è 'altro'"
		incr error_num
	}

	#ns_return 200 text/html $volimetria_risc
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
		    if {$flag_codifica_reg == "T"} {
                        #gab02 aggiunto alle condizioni la provincia di Ancona
                        #gab01 aggiunto alle condizioni il comune di Ancona
			if {$coimtgen(ente) eq "CPESARO" || $coimtgen(ente) eq "PPU"  || $coimtgen(ente) eq "CFANO" || $coimtgen(ente) eq "CANCONA" || $coimtgen(ente) eq "PAN" || $coimtgen(ente) eq "CJESI" || $coimtgen(ente) eq "CSENIGALLIA"} {#sim01: aggiunta if ed il suo contenuto
			    if {$coimtgen(ente) eq "CPESARO"} {
				set sigla_est "CMPS"
			    } elseif {$coimtgen(ente) eq "CFANO"} {
				set sigla_est "CMFA"
			    } elseif {$coimtgen(ente) eq "CANCONA"} {;#gab01
				set sigla_est "CMAN"
			    } elseif {$coimtgen(ente) eq "PAN"} {;#gab02
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
			    #nic01 set progressivo_est [db_string sel "select lpad(:progressivo_est, 6, '0')"]
                            set progressivo_est [db_string sel "select lpad(:progressivo_est,:lun_num_cod_imp_est,'0')"];#nic01
			    
			    set cod_impianto_est "$sigla_est$progressivo_est"
			    
			} else {#sim01
			    # caso standard

			    db_1row sel_dati_comu ""
			    if {$coimtgen(ente) eq "PMS"} {#sim02: Riportate modifiche fatte per Massa in data 03/12/2015 per gli altri programmi dove e' presente la codifica dell'impianto 
				set progressivo [db_string query "select lpad(:progressivo, 5, '0')"]
				set cod_istat  "[string range $cod_istat 5 6]/"
			    } elseif {$coimtgen(ente) eq "PTA"} {#sim02: aggiunta if e suo contenuto
				set progressivo [db_string query "select lpad(:progressivo, 7, '0')"]
				set fine_istat  [string length $cod_istat]
				set iniz_ist    [expr $fine_istat -3]
				set cod_istat  "[string range $cod_istat $iniz_ist $fine_istat]"
			    } else {
				#sim01: la sel_dati_comu andava in errore sul lpad di progressivo.Quindi faccio lpad dopo la query
				set progressivo [db_string query "select lpad(:progressivo, 7, '0')"];#sim01
			    }
#				if {![string equal $potenza "0.00"]} {
#				    if {$potenza < 35} {
#					set tipologia "IN"
#				    } else {
#					set tipologia "CT"
#				    }
			    set tipologia "PC"
			    #sim02 set cod_impianto_est "$cod_istat$tipologia$progressivo"
			    set cod_impianto_est "$cod_istat$progressivo";#sim02
			    set dml_comu [db_map upd_prog_comu]
#				} else {
#				    if {![string equal $cod_potenza "0"]
#					&& ![string equal $cod_potenza ""]} {
#					switch $cod_potenza {
#					    "B"  {set tipologia "IN"}
#					    "A"  {set tipologia "CT"}
#					    "MA" {set tipologia "CT"}
#					    "MB" {set tipologia "CT"}
#					}
#		
#					set cod_impianto_est "$cod_istat$tipologia$progressivo"
#					set dml_comu [db_map upd_prog_comu]
#				    } else {
#					set cod_impianto_est ""
#				    }
#				}
			};#sim01
		    } else {
			db_1row get_cod_impianto_est ""
		    }
    	            db_1row sel_cod_comb "select cod_combustibile from coimcomb where descr_comb = 'POMPA DI CALORE'"
		    set dml_sql_aimp [db_map ins_aimp]
		    # inserimento generatore
		    set gen_prog     1
		    set gen_prog_est 1
		    set dml_sql_gend [db_map ins_gend]
		    if {![string equal $cod_as_resp ""]} {
				set dml_upd_asresp [db_map upd_as_resp]
		    }
		}
		M {
			set dml_sql_aimp [db_map upd_aimp]
		
		}
    }
	
	if {![string equal $cod_citt_inte ""]} {
		set cod_cittadino $cod_citt_inte
    }

    # Lancio la query di manipolazione dati contenute in dml_sql
    if {[info exists dml_sql_aimp]} {
		with_catch error_msg {
		    db_transaction {
	
				db_dml dml_coimaimp $dml_sql_aimp 
					
				if {[info exists dml_sql_gend]} {
					db_dml dml_coimaimp $dml_sql_gend
				}
		#		if {[info exists dml_ins_citt] } {
		#		    db_dml dml_coicitt $dml_ins_citt
		#		}
		        if {[info exists dml_comu]} {
				    db_dml dml_coimcomu $dml_comu
				}
		        if {[info exists dml_upd_asresp]} {
				    db_dml dml_coim_as_resp $dml_upd_asresp
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
    set link_gest [export_url_vars cod_impianto cod_impianto_old nome_funz_caller extra_par caller]&nome_funz=impianti

    set return_url   "coimaimp-sche?funzione=V&$link_gest"

    ad_returnredirect $return_url
    ad_script_abort
}

ad_return_template

