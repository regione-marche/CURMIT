ad_page_contract {
    Lista tabella ""

    @author                  Giulio Laurenzi
    @creation-date           30/08/2004

    @param search_word       parola da ricercare con una query
    @param rows_per_page     una delle dimensioni della tabella  
    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param receiving_element nomi dei campi di form che riceveranno gli
                             argomenti restituiti dallo script di zoom,
                             separati da '|' ed impostarli come segue:

    @cvs-id coimstev-list.tcl
} { 
    {cod_inco          ""}
    {funzione         "V"}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {f_data            ""}
    {f_tipo_data       ""}
    {f_cod_impianto    ""}
    {f_cod_tecn        ""}
    {f_cod_enve        ""}
    {f_cod_comb        ""}
    {f_anno_inst_da    ""}
    {f_anno_inst_a     ""}
    {f_cod_esito       ""}
    {f_cod_comune      ""}
    {f_cod_via         ""}
    {f_tipo_estrazione ""}
    {f_cod_comb        ""}
    {flag_inco         ""}
    {extra_par         ""}
    {cod_impianto      ""}
    {url_list_aimp     ""}
    {url_aimp          ""}   
    {conta_flag        ""}
    {flag_inco         ""}
    {extra_par         ""}
    {cod_impianto      ""}
    {url_list_aimp     ""}
    {url_aimp          ""}   
    {id_stampa         ""}
    {flag_avviso       ""}

    {f_flag_pericolosita ""}
    {f_esito_verifica    ""}
    {f_da_potenza        ""}
    {f_a_potenza         ""}
    {f_cod_tano          ""}
    {f_da_data_controllo ""}
    {f_a_data_controllo  ""}
    {flag_tipo_impianto  ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}


# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
    # se la lista viene chiamata da un cerca, nome_funz non viene passato
    # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

set nome_funz_coimcitt [iter_get_nomefunz "coimcitt-gest"]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

if {[db_0or1row sel_cinc_count ""] == 0} {
    set conta 0
}
if {$conta == 0} {
    iter_return_complaint "Non ci sono campagne aperte"
}
if {$conta > 1} {
    iter_return_complaint "C'&egrave; pi&ugrave; di una campagna aperta"
}
if {$conta == 1} {
    if {[db_0or1row sel_cinc ""] == 0} {
	iter_return_complaint "Campagna non trovata"
    }
}



set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set layout_prog     "coimstev-layout"

set form_di_ricerca ""
set col_di_ricerca  ""
set form_name       "coimstev"

set page_title      "Lista appuntamenti per stampa esiti"

set link_righe      ""
set link_aggiungi   ""
set link_filter     "[export_ns_set_vars url]&nome_funz=stev"
set link_anteprima "[export_ns_set_vars url]&flag_anteprima=T&[export_url_vars id_protocollo protocollo_dt tipo_progressivo]"
set extra_par        [list]

if {$conta_flag != "t"} {
    set link_conta      "<a href=\"$curr_prog?conta_flag=t&[export_ns_set_vars url]\">Conta</a>"
} else {
    set link_conta ""
}

set actions ""
set js_function ""

#set checked ""
set url_vars        [export_ns_set_vars "url" "flag_sel"]

# imposto la struttura della tabella

#inizio dpr74
set stato_imp {
   [set coloretipo "AZURE"
    set tipoimp "nd"
    if {$flag_tipo_impianto == "R"} {
	set coloretipo "MAGENTA"
	set tipoimp "Ri"
    }
    if {$flag_tipo_impianto == "F"} {
	set coloretipo "LIGHTSKYBLUE"
	set tipoimp "Fr"
    }
    if {$flag_tipo_impianto == "C"} {
	set coloretipo "BEIGE"
	set tipoimp "Co"
    }
    if {$flag_tipo_impianto == "T"} {
	set coloretipo "ORANGE"
	set tipoimp "Te"
    }
    
    return "<td nowrap align=centre bgcolor=$coloretipo>$tipoimp</font></td>"]
}

#fine dpr74

set link    "\[export_url_vars cod_cittadino\]"
set actions "
    <td nowrap><a target=citt href=\"coimcitt-gest?funzione=M&flag_mod=t&nome_funz_caller=$nome_funz_caller&nome_funz=$nome_funz_coimcitt&$link\">Mod sogg.</a></td>"

set table_def [list \
	[list actions                 "Azioni"           no_sort $actions] \
	[list cod_impianto_est "Codice"           no_sort      {l}] \
	[list indir            "Ubicazione imp."  no_sort      {l}] \
	[list nom_resp         "Responsabile"     no_sort      {l}] \
	[list indirizzo_resp   "Ind. Resp."       no_sort      {l}] \
	[list numero_resp      "Num."             no_sort      {l}] \
	[list cap_resp         "Cap"              no_sort      {l}] \
	[list comune_resp      "Comune"           no_sort      {l}] \
	[list provincia_resp   "Provincia"        no_sort      {l}] \
       [list flag_tipo_impianto  "TI"          no_sort  $stato_imp] \
]



# imposto la query SQL

iter_get_coimtgen
set flag_ente        $coimtgen(flag_ente)         
set sigla_prov       $coimtgen(sigla_prov)
set flag_viario      $coimtgen(flag_viario)
set gg_conferma_inco $coimtgen(gg_conferma_inco)
set data_corrente [iter_set_sysdate]

if {$flag_ente == "C"} {
    set luogo $coimtgen(denom_comune)
} else {
    set cod_prov $coimtgen(cod_provincia)
    if {[db_0or1row get_desc_prov ""] == 0} {
	set luogo ""
    } else {
	set luogo $desc_prov
    }
}

# imposto il filtro per incontro
if {![string equal $cod_inco ""]} {
    set where_inco "and a.cod_inco = :cod_inco"
} else {
    set where_inco ""
}

# imposto filtro per data
if {![string equal $f_data ""]} {
    switch $f_tipo_data {
	"A" {set where_data "and a.data_assegn       = :f_data"}
	"E" {set where_data "and a.data_estrazione   = :f_data"}
	"I" {set where_data "and a.data_verifica     = :f_data"}
    }
} else {
    set where_data ""
}

if {![string equal $f_cod_impianto ""]} {
    set where_codice "and b.cod_impianto_est = upper(:f_cod_impianto)"
} else {
    set where_codice ""
}

# imposto il filtro per la ristampa
if {[string equal $cod_inco ""]} {
    set where_docu "and a.cod_documento_02 is null"
} else {
    set where_docu ""
}

# imposto il filtro per il tecnico
if {![string equal $f_cod_tecn ""]} {
    set where_tecn "and a.cod_opve = :f_cod_tecn"
} else {
    set where_tecn ""
}

# imposto il filtro per comune
if {![string equal $f_cod_comune ""]} {
    set where_comune "and b.cod_comune = :f_cod_comune"
} else {
    set where_comune ""
}

# imposto filtro per via
if {![string equal $f_cod_via ""]} {
    set where_via "and b.cod_via = :f_cod_via"
} else {
    set where_via ""
}

# imposto filtro per tipo estrazione
if {![string equal $f_tipo_estrazione ""]} {
    set where_tipo_estr "and a.tipo_estrazione = :f_tipo_estrazione"
} else {
    set where_tipo_estr ""
}

# imposto filtro per combustibile
if {![string equal $f_cod_comb ""]} {
    set where_comb "and b.cod_combustibile = :f_cod_comb"
} else {
    set where_comb ""
}

# imposto filtro per data
if {![string equal $f_anno_inst_da ""]} {
    set where_anno_inst_da "and substr(h.data_installaz,1,4) >= :f_anno_inst_da"
} else {
    set where_anno_inst_da ""
}

if {![string equal $f_anno_inst_a ""]} {
    set where_anno_inst_a  "and substr(h.data_installaz,1,4) <= :f_anno_inst_a"
} else {
    set where_anno_inst_a ""
}

# imposto il filtro per ente verificatore
if {![string equal $f_cod_enve ""]} {
    set where_enve "and a.cod_opve in (select z.cod_opve 
                                         from coimopve z
                                        where z.cod_enve = :f_cod_enve)"
} else {
    set where_enve ""
}

# imposto filtro per flag_pericolosita
if {![string equal $f_flag_pericolosita ""]} {
    set where_flag_pericolosita "and a.new1_flag_peri_8p = :f_flag_pericolosita"
} else {
    set where_flag_pericolosita ""
}

# imposto filtro per esito_verifica
if {![string equal $f_esito_verifica ""]} {
    set where_esito_verifica "and a.esito_verifica = :f_esito_verifica"
} else {
    set where_esito_verifica ""
}

# imposto filtro per da_data_controllo
if {![string equal $f_da_data_controllo ""]} {
    set where_da_data_controllo "and a.data_controllo >= :f_da_data_controllo"
} else {
    set where_da_data_controllo ""
}

# imposto filtro per a_data_controllo
if {![string equal $f_a_data_controllo ""]} {
    set where_a_data_controllo "and a.data_controllo <= :f_a_data_controllo"
} else {
    set where_a_data_controllo ""
}

# imposto filtro per da_potenza
if {![string equal $f_da_potenza ""]} {
    set where_da_potenza "and b.potenza >= :f_da_potenza"
} else {
    set where_da_potenza ""
}

# imposto filtro per da_potenza
if {![string equal $f_a_potenza ""]} {
    set where_a_potenza "and b.potenza <= :f_a_potenza"
} else {
    set where_a_potenza ""
}
#inizio dpr74
if {![string equal $flag_tipo_impianto ""]} {
    set where_tipo_imp  "and b.flag_tipo_impianto = :flag_tipo_impianto"
} else {
set where_tipo_imp ""
}
#fine dpr74
# imposto filtro per cod_tano
if {![string equal $f_cod_tano ""]} {
    set where_cod_tano "and exists (select * from coimanom j where j.cod_cimp_dimp = a.cod_cimp and j.flag_origine = 'RV' and j.cod_tanom = :f_cod_tano)"
} else {
    set where_cod_tano ""
}



if {$conta_flag == "t"} {
#     il numero dei record estratti
    if {$flag_viario == "T"} {
	db_1row sel_conta_inco_si_viae ""
    } else {
	db_1row sel_conta_inco_no_viae ""
    }
    set link_conta "Avvisi estratti: <b>$conta_inco</b>"
}


if {$flag_viario == "T"} {
    set sql_query [db_map sel_inco_si_viae]
} else {
    set sql_query [db_map sel_inco_no_viae]
}

set table_result [ad_table  -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {} go $sql_query $table_def]

# preparo url escludendo last_cod_impianto che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" last_cod_impianto]

set link_altre_pagine ""

# creo testata della lista
set list_head [iter_list_head $form_di_ricerca   $col_di_ricerca \
	       $link_conta    $link_altre_pagine $link_righe ""]




db_release_unused_handles
ad_return_template 
