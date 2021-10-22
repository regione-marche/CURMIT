#www/caldaie/src/
ad_page_contract {
    lista per scarico incontri

    @author         Paolo Formizzi Adhoc
    @creation-date  27/04/2004

    @cvs-id coiminco-scar.tcl

} {
    {cod_cinc          ""}
    {f_data            ""}
    {f_tipo_data       ""}
    {f_cod_impianto    ""}
    {f_cod_enve        ""}
    {f_cod_tecn        ""}
    {f_cod_esito       ""}
    {f_cod_comune      ""}
    {f_cod_via         ""}
    {f_descr_via       ""}
    {f_descr_topo      ""}
    {f_tipo_estrazione ""}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {f_anno_inst_da    ""}
    {f_anno_inst_a     ""}
    {f_cod_comb        ""}
    {f_num_asse        ""}
    {f_cod_area        ""}
    {f_da_data_disp    ""}
    {flag_tipo_impianto ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
}
if {[db_0or1row sel_cinc ""] == 0} {
    iter_return_complaint "Campagna non trovata"
}

# Imposto variabili tipiche di ogni funzione
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string equal $nome_funz_caller ""]} {
    set nome_funz_caller $nome_funz
}


iter_get_coimtgen 
set flag_ente  $coimtgen(flag_ente)
set sigla_prov $coimtgen(sigla_prov)
set flag_viario $coimtgen(flag_viario)

set page_title   "Assegnazione multipla appuntamenti"
set context_bar  [iter_context_bar -nome_funz $nome_funz] 
set link_filter  [export_ns_set_vars "url" ]


# imposto filtro per data
if {![string equal $f_data ""]} {
    switch $f_tipo_data {
	"E" {set where_data "and a.data_estrazione   = :f_data"}
	"I" {set where_data "and a.data_verifica     = :f_data"}
	"A" {set where_data "and a.data_assegn       = :f_data"}
    }
} else {
    set where_data ""
}

if {![string equal $f_cod_impianto ""]} {
    set where_codice "and c.cod_impianto_est = upper(:f_cod_impianto)"
} else {
    set where_codice ""
}


# imposto il filtro per esito
if {![string equal $f_cod_esito ""]} {
    set where_esito "and a.esito = :f_cod_esito"
} else {
    set where_esito ""
}

# imposto il filtro per comune
if {![string equal $f_cod_comune ""]} {
    set where_comune "and c.cod_comune = :f_cod_comune"
} else {
    set where_comune ""
}

# imposto filtro per via
if {![string equal $f_cod_via ""]} {
    set where_via "and c.cod_via = :f_cod_via"
} else {
    set where_via ""
    if {(![string equal $f_descr_via ""]
    ||   ![string equal $f_descr_topo ""])
    &&  $flag_viario == "F"
    } {
	set f_descr_via1  [iter_search_word $f_descr_via]
	set f_descr_topo1 [iter_search_word $f_descr_topo]
	set where_via "
        and c.indirizzo like upper(:f_descr_via1)
        and c.toponimo  like upper(:f_descr_topo1)"
    }
}

# imposto filtro per combustibile
if {![string equal $f_cod_comb ""]} {
    set where_comb "and c.cod_combustibile = :f_cod_comb"
} else {
    set where_comb ""
}

# imposto filtro per data
if {![string equal $f_anno_inst_da ""]} {
    set where_anno_inst_da "and substr(c.data_installaz,1,4) >= :f_anno_inst_da"
} else {
    set where_anno_inst_da ""
}
#inizio dpr74
# imposto filtro per tipo impianto
if {![string equal $flag_tipo_impianto ""]} {
    set where_tipo_imp "and c.flag_tipo_impianto = :flag_tipo_impianto"
} else {
    set where_tipo_imp ""
}
#fine dpr74

# sf 11112013 comune utente

db_0or1row sel_cout_check " select count(*) as conta_cout
                                   from coimcout
                                   where id_utente = :id_utente
                                         "
	
if {$conta_cout > 0} {
    set where_cout "and c.cod_comune in (select ll.cod_comune from coimcout ll where ll.id_utente = :id_utente)"
} else {
    set where_cout ""
}

# sf fine

#imposto filtro per num_max 

if {![string equal $f_num_asse ""]} {
    set limit_pos "limit $f_num_asse"
    set limit_ora "where rownum <= $f_num_asse"
} else {
    set limit_pos ""
    set limit_ora ""
}

if {![string equal $f_anno_inst_a ""]} {
    set where_anno_inst_a  "and substr(c.data_installaz,1,4) <= :f_anno_inst_a"
} else {
    set where_anno_inst_a ""
}

# imposto filtro per area. ricordo che per questa estrazione si considerano
# solo le aree come raggruppamenti di comuni.
if {![string equal $f_cod_area ""]} {
    if {[db_0or1row sel_area_tipo_01 ""] == 0} {
	set tipo_01 ""
    }
    
    set lista_comu "("
    set conta_comu 0
    db_foreach sel_cmar "" {
	incr conta_comu
	append lista_comu "$cod_comune,"
    }
    if {$conta_comu > 0} {
	set lung_lista_comu [string length $lista_comu]
	set lista_comu [string range $lista_comu 0 [expr $lung_lista_comu -2]]
	append lista_comu ")"

	set where_area "and c.cod_comune in $lista_comu"
    } else {
	set where_area ""
    }
} else {
    set where_area ""
}


# imposto filtro per tipo estrazione
if {![string equal $f_tipo_estrazione ""]} {
    set where_tipo_estr "and a.tipo_estrazione = :f_tipo_estrazione"
} else {
    set where_tipo_estr ""
}

if {![string equal $f_cod_enve ""]} {
   if {[db_0or1row sel_enve ""] == 0} {
         set ragione_01 ""
   }

   if {![string equal $f_cod_tecn ""]} {
       if {[db_0or1row sel_tecn ""] == 0} {
	   set nome_verif    ""
	   set cogn_verif    ""
       }
   } else {
       set nome_verif    ""
       set cogn_verif    ""
   }
    
} else {
  set ragione_01 ""
  set nome_verif ""
  set cogn_verif ""
}
 
set lista_cod ""
# inizio del ciclo

set order_by "order by d.denominazione, via, lpad(c.numero,8,'0')"

if {$flag_viario == "T"} {
    set sel_inco [db_map sel_inco_si_vie]
} else {
    set sel_inco [db_map sel_inco_no_vie]
}

db_foreach sel_inco $sel_inco {
    lappend lista_cod $cod_inco
}

with_catch error_msg {
    db_transaction {

	db_1row sel_tgen "select flag_asse_data from coimtgen"
	set data_verifica ""
	set ora_verifica ""
	set contatore_assegnati 0
	foreach cod_inco $lista_cod {

	    if {$flag_asse_data == "S"} {
		if {[db_0or1row sel_inco_disp ""] == 1} {
		    db_dml upd_inco ""		
		    db_dml del_disp ""
		    incr contatore_assegnati
		}
	    } else {
		db_dml upd_inco ""
		incr contatore_assegnati
	    }	
	}
    }
} {
    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
    seguente messaggio di errore <br><b>$error_msg</b><br>
    Contattare amministratore di sistema e comunicare il messaggio
    d'errore. Grazie."
}

if {$contatore_assegnati == 0} {   
    set msg "Nessun incontro selezionato con i criteri utilizzati"
} else {
    set msg "<b>Assegnati $contatore_assegnati appuntamenti a $ragione_01 $cogn_verif $nome_verif</b>"
}

ad_return_template
