ad_page_contract {
    Pagina di aggiornamento automatico dei db della regione
    
    @author Gianni Prosperi
    @date   26/4/2007

    @cvs_id aggiornamento-db-gest.tcl
} {
    {nome_funz          ""}
    {nome_funz_caller   ""}
    {caller        "index"}
    {sql_istruction}
    nome_database:optional,multiple
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

set logo_url [iter_set_logo_dir_url]


set titolo     "Aggiornamento tabelle dei database regionali - Esecuzione"
set page_title $titolo
set main_directory [ad_conn package_url]
set context_bar [iter_context_bar [list ${main_directory}main "Home"] "$titolo"]
#set url_nome_funz [export_url_vars nome_funz]

if {$nome_funz_caller eq ""} {
    set nome_funz_caller $nome_funz
}

if {![info exists sql_istruction]} {
    iter_return_complaint "Attenzione! <br>Non &egrave; stata inserita nessuna query sql"
    return
}

if {[string equal [string range $sql_istruction 0 1] "u "]} {
    set sql_istruction "update [string range $sql_istruction 2 end]"
}

set conta 1
set log_db ""

append log_db "<tr><td>Istruzione SQL: <strong>$sql_istruction</strong></td></tr><tr><td>&nbsp;</td></tr>"

if {[exists_and_not_null nome_database]} {
    foreach {nome_database} $nome_database {
	if {$nome_database ne ""} {
            set error_msg ""
	    with_catch error_msg {
                exec psql -h 10.252.10.3 $nome_database -c $sql_istruction > /dev/null
	    } {}
	    if {$error_msg ne ""} {
		if {$conta == 1} {
		    ns_log notice "Aggiornamento database regionali: $nome_database  Terminata con errore: $error_msg"
		    iter_return_complaint "<strong>$error_msg</strong>"
		    return
		} else {
		    ns_log notice "Aggiornamento database regionali: $nome_database  Terminata con errore: $error_msg"
		    append log_db "<tr><td>
                                  Database <strong>$nome_database</strong>: Errore: $error_msg
                               </td></tr>
                              "
		}
	    } else {
                ns_log notice "Aggiornamento database regionali: $nome_database  Terminata correttamente"
		append log_db "<tr><td>
                                  Database <strong>$nome_database</strong>: Query eseguita correttamente
                               </td></tr>
                              "
		
	    }
	    incr conta
	}
    }
}

ad_return_template
