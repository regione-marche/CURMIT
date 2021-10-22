ad_page_contract {
    Lista tabelle accessorie per varie pagine del libretto di impianto

    @author          Gabriele Lo Vaglio - clonato da coimdimp-list
    @creation-date   30/06/2016
 
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    gac01 20/11/2019 Attualmente i controlli non vengono più fatti sulla coimcimp-list ma sulla
    gac01            gest in modo da permettere di visualizzare agli utenti il pregresso.

    rom05 06/08/2019 Modificato il link per i Rapporti d'Ispezione, prima bisogna passare dal
    rom05            programma coimaimp-warning come per gli RCEE. Sandro ha detto che i 
    rom05            manutentori, visto che accedono solo in visualizzazione, non devono
    rom05            passasre dal warning.

    rom04 26/04/2019 Aggiunta la proc iter_check_mandatory_fields

    rom03 08/01/2019 Aggiunta variabile flag_tipo_impianto

    rom02 15/11/2018 Modificato link_scheda_13 su rischiesta della Regione.

    rom01 26/06/2018 Modificato link_scheda_13 per i manutentori in "Visualizza".

} { 
    
    {caller            "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {receiving_element ""}
    cod_impianto
    {url_aimp      ""}
    {url_list_aimp ""}
    
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

# B80: RECUPERO LO USER - INTRUSIONE
set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente_loggato_vero [ad_get_client_property iter logged_user_id]
set session_id [ad_conn session_id]
set adsession [ad_get_cookie "ad_session_id"]
set referrer [ns_set get [ad_conn headers] Referer]
set clientip [lindex [ns_set iget [ns_conn headers] x-forwarded-for] end]

iter_get_coimtgen
iter_check_mandatory_fields $cod_impianto;#rom04


# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
    # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
    # e bisogna reperire id_utente dai cookie
    # set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title  "Schede principali del libretto"

set flag_tipo_impianto [db_string q "select flag_tipo_impianto from coimaimp where cod_impianto = :cod_impianto"];#rom03


set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.

set curr_prog       [file tail [ns_conn url]]
set gest_prog_trat_acq  "coimaimp-tratt-acqua-gest"    ;#rom01
set gest_prog           "coimrecu-cond-aimp-gest"
set gest_prog_2         "coimcamp-sola-aimp-gest"
set gest_prog_3         "coimaltr-gend-aimp-gest"
set gest_prog_reg_cont  "coimaimp-regol-contab-gest"   ;#rom01
set gest_prog_sist_dist "coimaimp-sist-distribuz-gest" ;#rom01
set gest_prog_sist_emis "coimaimp-sist-emissione-gest" ;#rom01
set gest_prog_4         "coimaccu-aimp-gest"
set gest_prog_5         "coimtorr-evap-aimp-gest"
set gest_prog_6         "coimraff-aimp-gest"
set gest_prog_7         "coimscam-calo-aimp-gest"
set gest_prog_8         "coimcirc-inte-aimp-gest"
set gest_prog_9         "coimtrat-aria-aimp-gest"
set gest_prog_10        "coimrecu-calo-aimp-gest"
set gest_prog_11        "coimvent-aimp-gest"


set url_vars_per_coimaimp_gest_e_list [export_url_vars cod_impianto nome_funz nome_funz_caller caller cod_impianto_url_aimp url_list_aimp]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&$url_vars_per_coimaimp_gest_e_list]\">Aggiungi</a>"
set link_aggiungi_2 "<a href=\"$gest_prog_2?funzione=I&$url_vars_per_coimaimp_gest_e_list]\">Aggiungi</a>"
set link_aggiungi_3 "<a href=\"$gest_prog_3?funzione=I&$url_vars_per_coimaimp_gest_e_list]\">Aggiungi</a>"
set link_aggiungi_4 "<a href=\"$gest_prog_4?funzione=I&$url_vars_per_coimaimp_gest_e_list]\">Aggiungi</a>"
set link_aggiungi_5 "<a href=\"$gest_prog_5?funzione=I&$url_vars_per_coimaimp_gest_e_list]\">Aggiungi</a>"
set link_aggiungi_6 "<a href=\"$gest_prog_6?funzione=I&$url_vars_per_coimaimp_gest_e_list]\">Aggiungi</a>"
set link_aggiungi_7 "<a href=\"$gest_prog_7?funzione=I&$url_vars_per_coimaimp_gest_e_list]\">Aggiungi</a>"
set link_aggiungi_8 "<a href=\"$gest_prog_8?funzione=I&$url_vars_per_coimaimp_gest_e_list]\">Aggiungi</a>"
set link_aggiungi_9 "<a href=\"$gest_prog_9?funzione=I&$url_vars_per_coimaimp_gest_e_list]\">Aggiungi</a>"
set link_aggiungi_10 "<a href=\"$gest_prog_10?funzione=I&$url_vars_per_coimaimp_gest_e_list]\">Aggiungi</a>"
set link_aggiungi_11 "<a href=\"$gest_prog_11?funzione=I&$url_vars_per_coimaimp_gest_e_list]\">Aggiungi</a>"


set link_modifica     "<a href=\"$gest_prog_trat_acq?funzione=V&$url_vars_per_coimaimp_gest_e_list]\">Modifica</a>"  ;#rom01
set link_modifica_2   "<a href=\"$gest_prog_reg_cont?funzione=V&$url_vars_per_coimaimp_gest_e_list]\">Modifica</a>"  ;#rom01
set link_modifica_3   "<a href=\"$gest_prog_sist_dist?funzione=V&$url_vars_per_coimaimp_gest_e_list]\">Modifica</a>" ;#rom01
set link_modifica_4   "<a href=\"$gest_prog_sist_emis?funzione=V&$url_vars_per_coimaimp_gest_e_list]\">Modifica</a>" ;#rom01


# imposto variabile uten per poi creare il tabella di link in base
# al tipo di utente
set uten "default"
set nome_funz_impianti "impianti"


# controllo se l'utente � un manutentore
if {[iter_check_uten_manu $id_utente] != ""} {
    set uten "manu"
}

# controllo se l'utente e' il responsabile cooperativa 
if {[iter_check_uten_coop_resp $id_utente] != ""} {
    set uten "coop_resp"
}

# controllo se l'utente e' l'addetto mod h cooperativa 
if {[iter_check_uten_coop_modh $id_utente] != ""} {
    set uten "coop_modh"
}
# controllo se l'utente e' l'addetto rapp.ver. cooperativa 
if {[iter_check_uten_coop_rappv $id_utente] != ""} {
    set uten "coop_rappv"
}

# controllo se l'utetne e' un ente verificatore o operatore
set cod_tecn  [iter_check_uten_opve $id_utente]
set cod_enve  [iter_check_uten_enve $id_utente]
if {![string equal $cod_tecn ""]} {
    set uten "opve"
    set nome_funz_impianti "impianti-ver"
}

if {![string equal $cod_enve ""]} {
    set uten "enve"
    set nome_funz_impianti "impianti-ver"
}


set link_scheda_1 "<a href=\"coimaimp-gest?[export_url_vars cod_impianto url_list_aimp nome_funz_caller url_aimp]&nome_funz=impianti\">Inserisci/Modifica</a>"
set link_scheda_1bis "<a href=\"coimaimp-bis-gest?[export_url_vars cod_impianto url_list_aimp nome_funz_caller url_aimp]&nome_funz=impianti\">Inserisci/Modifica</a>"
set link_ubic "[export_url_vars url_list_aimp cod_impianto nome_funz_caller url_aimp]&nome_funz=$nome_funz_impianti"
set link_scheda_1_2 "<a href=\"coimaimp-ubic?&$link_ubic\">Inserisci/Modifica</a>"
set link_sogg "[export_url_vars cod_impianto url_list_aimp nome_funz_caller url_aimp]&nome_funz=$nome_funz_impianti"
set link_scheda_1_6 "<a href=\"coimaimp-sogg?&$link_sogg\">Inserisci/Modifica</a>"
set link_as_resp "[export_url_vars cod_impianto url_list_aimp nome_funz_caller url_aimp]&nome_funz=[iter_get_nomefunz coim_as_resp-gest]"
set link_scheda_3 "<a href=\"coim_as_resp-list?&$link_as_resp\">Inserisci/Modifica</a>"

db_1row sel_count_gend "select count(*) as conta_gend
                          from coimgend
                         where cod_impianto = :cod_impianto"
switch $conta_gend {
    1 {set coimgend "coimgend-gest?funzione=V&"
	db_1row sel_cod_gend " select gen_prog
                                 from coimgend
                                where cod_impianto = :cod_impianto"
	set link_gend "[export_url_vars cod_impianto url_list_aimp nome_funz_caller gen_prog url_aimp]&nome_funz=[iter_get_nomefunz coimgend-gest]"
    }
    default {set coimgend "coimgend-list?"
	set link_gend "[export_url_vars cod_impianto url_list_aimp last_cod_impianto nome_funz_caller url_aimp]&nome_funz=[iter_get_nomefunz coimgend-list]"
    }
}
set link_scheda_4 "<a href=\"$coimgend$link_gend\">Inserisci/Modifica</a>"

if {$coimtgen(regione) eq "MARCHE"} {

    set link_scheda "[export_url_vars cod_impianto url_list_aimp nome_funz_caller url_aimp]&nome_funz=[iter_get_nomefunz coimdimp-list]&caller=dimp"

    set label_dichiarazioni "Scheda 11: RCEE e moduli regionali"

    set coimaimp_warning "coimaimp-warning?"

    set link_scheda_11 "<a href=\"$coimaimp_warning&$link_scheda\">Inserisci/Modifica</a>"
    
} else {
    
    set coimdimp "coimdimp-list?"
    set label_dichiarazioni "Scheda 11: Dichiarazioni"

    set link_scheda_11 "<a href=\"$coimdimp&$link_dimp\">Inserisci/Modifica</a>"

}

set flag_cimp "S"
set link_cimp "[export_url_vars cod_impianto url_list_aimp nome_funz_caller url_aimp flag_cimp]&nome_funz=[iter_get_nomefunz coimcimp-list]"
set link_cimp_warning "[export_url_vars cod_impianto url_list_aimp nome_funz_caller url_aimp flag_cimp]&nome_funz=[iter_get_nomefunz coimcimp-list]&caller=cimp";#rom05

if {$uten eq "manu" } {#rom01 aggiunta if e contenuto, aggiunta else
#rom02set link_scheda_13 "<a href=\"coimcimp-list?&$link_cimp\">Visualizza</a>"
    set link_scheda_13 "<a href=\"coimcimp-list?&$link_cimp\">Clicca qui per visualizzare i rapporti di ispezione.</a>";#rom02
} else {
#rom02set link_scheda_13 "<a href=\"coimcimp-list?&$link_cimp\">Inserisci/Modifica</a>"
    #gac01 scommentato rom05
    set link_scheda_13 "<a href=\"coimcimp-list?&$link_cimp\">Clicca qui per inserire/modificare i rapporti di ispezione.</a>";#rom02
    #gac01 set link_scheda_13 "<a href=\"coimaimp-warning?&$link_cimp_warning\">Clicca qui per inserire/modificare i rapporti di ispezione.</a>";#rom05
};#rom01

#set link_trat_acq "\export_url_vars "
set link    "\[export_url_vars cod_recu_cond_aimp\]&$url_vars_per_coimaimp_gest_e_list"
set link_2  "\[export_url_vars cod_camp_sola_aimp\]&$url_vars_per_coimaimp_gest_e_list"
set link_3  "\[export_url_vars cod_altr_gend_aimp\]&$url_vars_per_coimaimp_gest_e_list"
set link_4  "\[export_url_vars cod_accu_aimp\]&$url_vars_per_coimaimp_gest_e_list"
set link_5  "\[export_url_vars cod_torr_evap_aimp\]&$url_vars_per_coimaimp_gest_e_list"
set link_6  "\[export_url_vars cod_raff_aimp\]&$url_vars_per_coimaimp_gest_e_list"
set link_7  "\[export_url_vars cod_scam_calo_aimp\]&$url_vars_per_coimaimp_gest_e_list"
set link_8  "\[export_url_vars cod_circ_inte_aimp\]&$url_vars_per_coimaimp_gest_e_list"
set link_9  "\[export_url_vars cod_trat_aria_aimp\]&$url_vars_per_coimaimp_gest_e_list"
set link_10  "\[export_url_vars cod_recu_calo_aimp\]&$url_vars_per_coimaimp_gest_e_list"
set link_11 "\[export_url_vars cod_vent_aimp\]&$url_vars_per_coimaimp_gest_e_list"

set actions     "<td nowrap><a href=\"$gest_prog?funzione=V&$link\">Selez.</a>"
set actions_2 "<td nowrap><a href=\"$gest_prog_2?funzione=V&$link_2\">Selez.</a>"
set actions_3 "<td nowrap><a href=\"$gest_prog_3?funzione=V&$link_3\">Selez.</a>"
set actions_4 "<td nowrap><a href=\"$gest_prog_4?funzione=V&$link_4\">Selez.</a>"
set actions_5 "<td nowrap><a href=\"$gest_prog_5?funzione=V&$link_5\">Selez.</a>"
set actions_6 "<td nowrap><a href=\"$gest_prog_6?funzione=V&$link_6\">Selez.</a>"
set actions_7 "<td nowrap><a href=\"$gest_prog_7?funzione=V&$link_7\">Selez.</a>"
set actions_8 "<td nowrap><a href=\"$gest_prog_8?funzione=V&$link_8\">Selez.</a>"
set actions_9 "<td nowrap><a href=\"$gest_prog_9?funzione=V&$link_9\">Selez.</a>"
set actions_10 "<td nowrap><a href=\"$gest_prog_10?funzione=V&$link_10\">Selez.</a>"
set actions_11 "<td nowrap><a href=\"$gest_prog_11?funzione=V&$link_11\">Selez.</a>"

set table_def [list \
		   [list actions                "Azioni"                    no_sort $actions] \
		   [list num_rc                 "Num"                       no_sort {l}] \
		   [list data_installaz         "Data Installazione"        no_sort {c}] \
		   [list data_dismissione       "Data Dismissione"          no_sort {c}] \
		   [list descr_cost             "Costruttore"               no_sort {l}] \
		   [list modello                "Modello"                   no_sort {l}] \
		   [list matricola              "Matricola"                 no_sort {l}] \
		   [list portata_term_max       "Port. termica<br>max nom." no_sort {c}] \
		   [list portata_term_min       "Port. termica<br>min nom." no_sort {c}] \
		  ]

set table_def_2 [list \
		     [list actions_2            "Azioni"                    no_sort $actions_2] \
		     [list num_cs               "Num"                       no_sort {l}] \
		     [list data_installaz       "Data Installazione"        no_sort {c}] \
		     [list descr_cost           "Costruttore"               no_sort {l}] \
		     [list collettori           "Collettori"                no_sort {c}] \
		     [list sup_totale           "Sup. Totale"               no_sort {c}] \
		]

set table_def_3 [list \
		     [list actions_3            "Azioni"                    no_sort $actions_3] \
		     [list num_ag               "Num"                       no_sort {l}] \
		     [list data_installaz       "Data Installazione"        no_sort {c}] \
                     [list data_dismissione     "Data Dismissione"          no_sort {c}] \
		     [list descr_cost           "Costruttore"               no_sort {l}] \
                     [list modello              "Modello"                   no_sort {l}] \
		     [list matricola            "Matricola"                 no_sort {l}] \
		     [list tipologia            "Tipologia"                 no_sort {l}] \
                     [list potenza_utile        "Potenza utile"             no_sort {c}] \
		    ]

set table_def_4 [list \
                     [list actions_4            "Azioni"                    no_sort $actions_4] \
                     [list num_ac               "Num"                       no_sort {l}] \
                     [list data_installaz       "Data Installazione"        no_sort {c}] \
                     [list data_dismissione     "Data Dismissione"          no_sort {c}] \
                     [list descr_cost           "Costruttore"               no_sort {l}] \
                     [list modello              "Modello"                   no_sort {l}] \
                     [list matricola            "Matricola"                 no_sort {l}] \
                     [list capacita             "Capacit&agrave"            no_sort {r}] \
                     [list utilizzo             "Utilizzo"                  no_sort {l}] \
                     [list coibentazione        "Coibentazione"             no_sort {c}] \
		     ]

set table_def_5 [list \
                     [list actions_5            "Azioni"                    no_sort $actions_5] \
                     [list num_te               "Num"                       no_sort {l}] \
                     [list data_installaz       "Data Installazione"        no_sort {c}] \
                     [list data_dismissione     "Data Dismissione"          no_sort {c}] \
                     [list descr_cost           "Costruttore"               no_sort {l}] \
                     [list modello              "Modello"                   no_sort {l}] \
                     [list matricola            "Matricola"                 no_sort {l}] \
                     [list capacita             "Capacit&agrave"            no_sort {r}] \
                     [list num_ventilatori      "Num. Ventilatori"          no_sort {r}] \
                     [list tipi_ventilatori     "Tipo Ventilatori"          no_sort {l}] \
                     ]

set table_def_6 [list \
                     [list actions_6            "Azioni"                    no_sort $actions_6] \
                     [list num_rv               "Num"                       no_sort {l}] \
                     [list data_installaz       "Data Installazione"        no_sort {c}] \
                     [list data_dismissione     "Data Dismissione"          no_sort {c}] \
                     [list descr_cost           "Costruttore"               no_sort {l}] \
                     [list modello              "Modello"                   no_sort {l}] \
                     [list matricola            "Matricola"                 no_sort {l}] \
                     [list num_ventilatori      "Num. Ventilatori"          no_sort {r}] \
                     [list tipi_ventilatori     "Tipo Ventilatori"          no_sort {l}] \
                     ]

set table_def_7 [list \
                     [list actions_7            "Azioni"                    no_sort $actions_7] \
                     [list num_sc               "Num"                       no_sort {l}] \
                     [list data_installaz       "Data Installazione"        no_sort {c}] \
                     [list data_dismissione     "Data Dismissione"          no_sort {c}] \
                     [list descr_cost           "Costruttore"               no_sort {l}] \
                     [list modello              "Modello"                   no_sort {l}] \
                     ]

set table_def_8 [list \
                     [list actions_8            "Azioni"                    no_sort $actions_8] \
                     [list num_ci               "Num"                       no_sort {l}] \
                     [list data_installaz       "Data Installazione"        no_sort {c}] \
                     [list data_dismissione     "Data Dismissione"          no_sort {c}] \
                     [list lunghezza            "Lunghezza"                 no_sort {r}] \
                     [list superficie           "Superficie"                no_sort {r}] \
                     [list profondita           "Profondit&agrave;"         no_sort {r}] \
                     ]

set table_def_9 [list \
                     [list actions_9            "Azioni"                    no_sort $actions_9] \
                     [list num_ut               "Num"                       no_sort {l}] \
                     [list data_installaz       "Data Installazione"        no_sort {c}] \
                     [list data_dismissione     "Data Dismissione"          no_sort {c}] \
                     [list descr_cost           "Costruttore"               no_sort {l}] \
                     [list modello              "Modello"                   no_sort {l}] \
                     [list matricola            "Matricola"                 no_sort {l}] \
		     		 [list portata_mandata      "Port. ventilatore<br> di mandata " no_sort {c}] \
                     [list potenza_mandata      "Pot. ventilatore<br> di mandata" no_sort {c}] \
                     [list portata_ripresa      "Port. ventilatore<br> di ripresa " no_sort {c}] \
                     [list potenza_ripresa      "Pot. ventilatore<br> di ripresa" no_sort {c}] \
                     ]

set table_def_10 [list \
                     [list actions_10           "Azioni"                    no_sort $actions_10] \
                     [list num_rc               "Num"                       no_sort {l}] \
                     [list data_installaz       "Data Installazione"        no_sort {c}] \
                     [list data_dismissione     "Data Dismissione"         no_sort {c}] \
                     [list tipologia            "Tipologia"                 no_sort {l}] \
                     [list installato_uta_vmc   "Installato in U.T.A. o V.M.C." no_sort {l}] \
                     [list indipendente         "Indipendente"               no_sort {l}] \
                     [list portata_mandata      "Port. ventilatore<br> di mandata " no_sort {c}] \
                     [list potenza_mandata      "Pot. ventilatore<br> di mandata" no_sort {c}] \
                     [list portata_ripresa      "Port. ventilatore<br> di ripresa " no_sort {c}] \
                     [list potenza_ripresa      "Pot. ventilatore<br> di ripresa" no_sort {c}] \
                     ]
					 

					 
					 
					 
					 
set table_def_11 [list \
                     [list actions_11           "Azioni"                    no_sort $actions_11] \
                     [list num_vm               "Num"                       no_sort {l}] \
                     [list data_installaz       "Data Installazione"        no_sort {c}] \
					 [list data_dismissione     "Data Dismissione"         no_sort {c}] \
					 [list descr_cost           "Costruttore"               no_sort {l}] \
					 [list modello              "Modello"                   no_sort {l}] \
					 [list tipologia            "Tipologia"                 no_sort {l}] \
					 [list note_tipologia_altro "Altro"                     no_sort {l}] \
                     [list portata_aria         "Massima Portata Aria"              no_sort {c}] \
					 [list rendimento_rec       "Rendimento di recupero / COP"              no_sort {c}] \
                     ]
					 
					 

set sel_recu_cond_aimp [db_map sel_recu_cond_aimp]
set sel_camp_sola_aimp [db_map sel_camp_sola_aimp]
set sel_altr_gend_aimp [db_map sel_altr_gend_aimp]
set sel_accu_aimp      [db_map sel_accu_aimp]
set sel_torr_evap_aimp [db_map sel_torr_evap_aimp]
set sel_raff_aimp      [db_map sel_raff_aimp]
set sel_scam_calo_aimp [db_map sel_scam_calo_aimp]
set sel_circ_inte_aimp [db_map sel_circ_inte_aimp]
set sel_trat_aria_aimp [db_map sel_trat_aria_aimp]
set sel_recu_calo_aimp [db_map sel_recu_calo_aimp]
set sel_vent_aimp      [db_map sel_vent_aimp]

set table_result   [ad_table -Tmissing_text "Non &egrave; presente nessun Recuperatore/Condensatore." -Textra_vars {cod_recu_cond_aimp caller cod_impianto nome_funz nome_funz_caller url_list_aimp url_aimp } go $sel_recu_cond_aimp $table_def]

set table_result_2 [ad_table -Tmissing_text "Non &egrave; presente nessun Campo Solare." -Textra_vars {cod_camp_sola_aimp cod_impianto caller nome_funz nome_funz_caller url_list_aimp url_aimp } go $sel_camp_sola_aimp $table_def_2]

set table_result_3 [ad_table -Tmissing_text "Non &egrave; presente nessun Altro Generatore." -Textra_vars {cod_altr_gend_aimp cod_impianto caller nome_funz nome_funz_caller url_list_aimp url_aimp } go $sel_altr_gend_aimp $table_def_3]

set table_result_4 [ad_table -Tmissing_text "Non &egrave; presente nessun Accumulo." -Textra_vars {cod_accu_aimp cod_impianto caller nome_funz nome_funz_caller url_list_aimp url_aimp } go $sel_accu_aimp $table_def_4]

set table_result_5 [ad_table -Tmissing_text "Non &egrave; presente nessuna Torre Evaporativa." -Textra_vars {cod_torr_evap_aimp cod_impianto caller nome_funz nome_funz_caller url_list_aimp url_aimp } go $sel_torr_evap_aimp $table_def_5]

set table_result_6 [ad_table -Tmissing_text "Non &egrave; presente nessun Raffreddatore di Liquido." -Textra_vars {cod_raff_aimp cod_impianto caller nome_funz nome_funz_caller url_list_aimp url_aimp } go $sel_raff_aimp $table_def_6]

set table_result_7 [ad_table -Tmissing_text "Non &egrave; presente nessuno Scambiatore di Calore Intermedio." -Textra_vars {cod_raff_aimp cod_impianto caller nome_funz nome_funz_caller url_list_aimp url_aimp } go $sel_scam_calo_aimp $table_def_7]

set table_result_8 [ad_table -Tmissing_text "Non &egrave; presente nessun Circuito Interrato a Condensazione/Espansione Diretta." -Textra_vars {cod_circ_inte_aimp cod_impianto caller nome_funz nome_funz_caller url_list_aimp url_aimp } go $sel_circ_inte_aimp $table_def_8]

set table_result_9 [ad_table -Tmissing_text "Non &egrave; presente nessun Unità di Trattamento Aria." -Textra_vars {cod_trat_aria_aimp cod_impianto caller nome_funz nome_funz_caller url_list_aimp url_aimp } go $sel_trat_aria_aimp $table_def_9]

set table_result_10 [ad_table -Tmissing_text "Non &egrave; presente nessun recuperatore di calore." -Textra_vars {cod_recu_calo_aimp cod_impianto caller nome_funz nome_funz_caller url_list_aimp url_aimp } go $sel_recu_calo_aimp $table_def_10]

set table_result_11 [ad_table -Tmissing_text "Non &egrave; presente nessun impianto di ventilazione." -Textra_vars {cod_vent_aimp cod_impianto caller nome_funz nome_funz_caller url_list_aimp url_aimp } go $sel_vent_aimp $table_def_11]

db_release_unused_handles
ad_return_template 
