ad_page_contract {
    Lista tabella "coimrelt" Scheda tecnica relazione biennale

    @author                  Giulio Laurenzi
    @creation-date           15/03/2005

    @param search_word       parola da ricercare con una query
    @param rows_per_page     righe per pagina
    @param caller            se diverso da index rappresenta il nome del form 
                             da cui e' partita la ricerca ed in questo caso
                             imposta solo azione "sel"
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param nome_funz_caller  identifica l'entrata di menu,
                             serve per la navigation bar
    @param receiving_element nomi dei campi di form che riceveranno gli
                             argomenti restituiti dallo script di zoom,
                             separati da '|' ed impostarli come segue:

    @cvs-id coimrelt-list.tcl 
} { 
   {search_word       ""}
   {rows_per_page     ""}
   {caller            "index"}
   {nome_funz         ""}
   {nome_funz_caller  ""} 
   {receiving_element ""}
   {last_sezione      ""}
   {last_id_clsnc     ""}
   {last_id_stclsnc   ""}
   {last_obj_refer    ""}
   {last_id_pot       ""}
   {last_id_per       ""}
   {last_id_comb      ""}
   {cod_relg          ""}
   {cod_relt          ""}
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
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title      "Lista scheda tecnica"
set context_bar     [iter_context_bar -nome_funz $nome_funz_caller]

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "coimrelt-gest"
set form_di_ricerca ""
set col_di_ricerca  ""
set extra_par       [list rows_per_page     $rows_per_page \
                          receiving_element $receiving_element]
set link_aggiungi   "<a href=\"$gest_prog?funzione=I&[export_url_vars cod_relg last_sezione last_id_clsnc last_id_stclsnc last_obj_refer last_id_pot last_id_per last_id_comb caller nome_funz extra_par nome_funz_caller]\">Aggiungi</a>"
set rows_per_page   [iter_set_rows_per_page $rows_per_page $id_utente]
set link_righe      [iter_rows_per_page     $rows_per_page]
set link_relg       [export_url_vars cod_relg nome_funz nome_funz_caller]

set link {
    [if {$sezione == "V"} {
	return "<a href=\"$gest_prog?funzione=V&[export_url_vars cod_relg cod_relt last_sezione last_id_clsnc last_id_stclsnc last_obj_refer last_id_pot last_id_per last_id_comb nome_funz nome_funz_caller extra_par]\">Selez.</a>"
     } else {
	 return "&nbsp;"
     }]
}

set actions "
    <td nowrap>$link</td>"
set js_function ""

set des_sezione {
    [switch $sezione {
	"V" { return "Verifiche"}
	"C" { return "Consuntivazioni"}
    default { return ""}
    }]
}

set des_clsnc {
    [switch $id_clsnc {
	"1" {
	    switch $id_stclsnc {
		"1" { return "8a"}
  	        "2" { return "8b"}
	        "3" { return "8c"}
	        "4" { return "8d"}
	    default { return ""}
	    }
	}
	"2" { return "A$id_stclsnc"}
        "3" { return "C$id_stclsnc"}
        "4" {
	    if {$id_stclsnc <= 14} {
		set num [expr $id_stclsnc + 18]
		return "A$num"
	    } else {
		if {$id_stclsnc > 14
		&&  $id_stclsnc < 99
		} {
		    return "C$id_stclsnc"
		} else {
		    if {$id_stclsnc == 99} {
			return "D99"
		    } else {
			return ""
		    }
		}
	    }
	}
        "5" {
	    switch $id_stclsnc {
		"1" { return "Totale verificati" }
		"2" { return "Totale autodichiarati" }
		"3" { return "Totale non conformi" }
		"4" { return "Totale conformi" }
	    default { return ""}
	    } 
	}
    }]
}

set des_comb {
    [switch $id_comb {
	"1" { return "Gas naturale"}
	"2" { return "Gpl"}
	"3" { return "Gasolio"}
	"5" { return "Altro"}
    default { return ""}
	}]
}

set des_pot {
    [switch $id_pot {
	"1" { return "inferiore a 35 kW"}
        "2" { return "da 35 a 116 kW"}
        "3" { return "da 116 a 350 kW"}
        "4" { return "oltre 350 kW"}
    default { return ""}
    }]
}

set des_per {
    [switch $id_per {
	"1" { return  "prima del 1990"}
        "2" { return  "dal 1990 al 2000"}
        "3" { return  "oltre il 2000"}
    default { return ""}
    } ]
}

set des_obj_refer {
    [switch $obj_refer {
	"I" { return "Impianti"}
        "G" { return "Generatori"}
    }]
}

# imposto la struttura della tabella
set table_def [list \
    [list actions       "Azioni"       no_sort $actions] \
    [list des_sezione   "Sezione"      no_sort "<td nowrap align=left>$des_sezione</td>"] \
    [list des_clsnc     "Descrizione"  no_sort "<td nowrap>$des_clsnc</td>"] \
    [list des_pot       "Potenza"      no_sort "<td nowrap>$des_pot</td>"] \
    [list des_per       "Periodo"      no_sort "<td nowrap>$des_per</td>"] \
    [list des_comb      "Combustibile" no_sort "<td nowrap>$des_comb</td>"] \
    [list des_obj_refer "Oggetto"      no_sort "<td nowrap>$des_obj_refer</td>"] \
    [list n             "Numero"       no_sort {r}] \
]

# imposto la query SQL 
# imposto la condizione per la prossima pagina

if {![string is space $last_sezione]
&&  ![string is space $last_id_clsnc]
&&  ![string is space $last_id_stclsnc]
&&  ![string is space $last_obj_refer]
&&  ![string is space $last_id_pot]
&&  ![string is space $last_id_per]
&&  ![string is space $last_id_comb]
} {
    set where_last "and (        sezione    < :last_sezione
                         or (    sezione    = :last_sezione
                             and id_clsnc   > :last_id_clsnc)
                         or (    sezione    = :last_sezione
                             and id_clsnc   = :last_id_clsnc
                             and id_stclsnc > :last_id_stclsnc)
                         or (    sezione    = :last_sezione
                             and id_clsnc   = :last_id_clsnc
                             and id_stclsnc = :last_id_stclsnc
                             and id_pot     > :last_id_pot)
                         or (    sezione    = :last_sezione
                             and id_clsnc   = :last_id_clsnc
                             and id_stclsnc = :last_id_stclsnc
                             and id_pot     = :last_id_pot
                             and id_per     > :last_id_per)
                         or (    sezione    = :last_sezione
                             and id_clsnc   = :last_id_clsnc
                             and id_stclsnc = :last_id_stclsnc
                             and id_pot     = :last_id_pot
                             and id_per     = :last_id_per
                             and id_comb    > :last_id_comb)
                         or (    sezione    = :last_sezione
                             and id_clsnc   = :last_id_clsnc
                             and id_stclsnc = :last_id_stclsnc
                             and id_pot     = :last_id_pot
                             and id_per     = :last_id_per
                             and id_comb    = :last_id_comb
                             and obj_refer >= :last_obj_refer)
                        )"
} else {
     set where_last ""
}

set sel_relt [db_map sel_relt]

set table_result [ad_table -Tmax_rows $rows_per_page -Tmissing_text "Non trovata nessuna relazione biennale." -Textra_vars {nome_funz nome_funz_caller extra_par sezione id_clsnc id_stclsnc obj_refer id_pot id_comb id_per last_sezione last_id_clsnc last_id_stclsnc last_obj_refer last_id_pot last_id_per last_id_comb link gest_prog sezione id_clsnc id_stclsnc obj_refer id_pot id_comb id_per cod_relt} go $sel_relt $table_def]

# preparo url escludendo last_data_rel e last_ente_istat che vengono
# passati esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" "last_sezione last_id_clsnc last_id_stclsnc last_obj_refer last_id_pot last_id_per last_id_comb"]
set link_altre_pagine "Vai alla <a href=\"$curr_prog?$url_vars\">prima pagina</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_sezione    $sezione
    set last_id_clsnc   $id_clsnc
    set last_id_stclsnc $id_stclsnc
    set last_obj_refer  $obj_refer
    set last_id_pot     $id_pot
    set last_id_per     $id_per
    set last_id_comb    $id_comb
    append url_vars "&[export_url_vars last_sezione last_id_clsnc last_id_stclsnc last_obj_refer last_id_pot last_id_per last_id_comb]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}
# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
              $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
