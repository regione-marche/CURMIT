ad_page_contract {
    storno dichiarazioni (tabella "coimdimp")
    @author          dob
    @creation-date   02/2009

    @param extra_par Variabili extra da restituire alla lista
} {
    
   {cod_dimp             ""}
   {last_cod_dimp        ""}
   {funzione            "D"}
   {caller          "index"}
   {nome_funz            ""}
   {nome_funz_caller     ""}
   {extra_par            ""}
   {cod_impianto         ""}
   {url_aimp             ""} 
   {url_list_aimp        ""}
   {flag_no_link         "F"}
   {url_gage             ""}
   {cod_opma             ""}
   {data_ins             ""}
   {cod_impianto_est_new ""}
   {flag_tracciato       ""}
   {gen_prog             ""}

} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}


# Controlla lo user

set lvl 3
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set denom_comune $coimtgen(denom_comune)
set sigla_prov   $coimtgen(sigla_prov)
set link         [export_ns_set_vars "url"]
set directory ""
set pack_key [iter_package_key]
set pack_dir [apm_package_url_from_key $pack_key]
append pack_dir "src"


db_1row query "select a.cod_dimp
                  , a.cod_impianto
                  , a.data_controllo
                  , iter_edit_data(a.data_controllo) as data_controllo_pretty
                  , a.cod_manutentore
                  , a.cod_responsabile
                  , a.cod_proprietario
                  , iter_edit_num(a.pot_focolare_mis, 2) as pot_focolare_mis
                  , iter_edit_num(a.portata_comb_mis, 2) as portata_comb_mis
                  , c.cognome   as cognome_resp
                  , c.nome      as nome_resp
                  , b.cognome   as cognome_manu
                  , b.nome      as nome_manu
		  , iter_edit_num(a.potenza, 2) as potenza
                  , a.data_ins
		  , a.utente_ins
                  , coalesce(b.email,'?') as email_manutentore
                  , a.stato_dich                
                  , g.cod_impianto_est as codice_impianto
                  , m.descr_topo || ' ' || m.descrizione || ', ' || coalesce(g.numero,'') as indirizzo 
                  , l.denominazione as comune
                  , a.utente_ins as utente
                  , coalesce(a.importo_tariffa,0.00) as importo_tariffa
               from coimdimp a
               left outer join coimmanu b on b.cod_manutentore  = a.cod_manutentore
               left outer join coimcitt c on c.cod_cittadino    = a.cod_responsabile
              inner join coimaimp g on g.cod_impianto     = a.cod_impianto
               left outer join coimcomu l on l.cod_comune       = g.cod_comune
               left outer join coimviae m on m.cod_via          = g.cod_via
                                         and m.cod_comune       = g.cod_comune
              where a.cod_dimp = :cod_dimp"

if {$data_controllo < "2008-08-01"} {
    iter_return_complaint "
    Funzione possibile solo per dichiarazioni con data controllo successiva all '01/08/2008'."  
    ad_script_abort
}

ns_log notice "sandro controllo storno $importo_tariffa"

if {$importo_tariffa == 0.00} {
    iter_return_complaint "
    Funzione possibile solo per dichiarazioni che prevedono il contributo regionale."  
    ad_script_abort
}

if {$importo_tariffa == 0} {
    iter_return_complaint "
    Funzione possibile solo per dichiarazioni che prevedono il contributo regionale."  
    ad_script_abort
}

if {$importo_tariffa < 0.1} {
    iter_return_complaint "
    Funzione possibile solo per dichiarazioni che prevedono il contributo regionale."  
    ad_script_abort
}

#ns_log notice "provadob1 storno $importo_tariffa"

if {[string equal $stato_dich "R"]} {
    iter_return_complaint "
    Funzione annullata in quanto  e' gia' stata inserita la richiesta di storno."  
    ad_script_abort
} elseif {[string equal $stato_dich "A"]} {
    iter_return_complaint "
    Funzione annullata in quanto la richiesta di storno e' stata gia' accettata."  
    ad_script_abort
} elseif {[string equal $stato_dich "X"]} {
    iter_return_complaint "
    Funzione annullata in quanto la richiesta di storno e' stata gia' rifiutata."  
    ad_script_abort
} elseif {[string equal $stato_dich "S"]} {
    iter_return_complaint "
    Funzione annullata in quanto gia' sostituito in seguito a storno."  
    ad_script_abort
}

set uff_info [db_string query "select uff_info from coimdesc limit 1"]

if {[db_0or1row query "select iter_edit_data(a.data_controllo) as data_controllo_stn
                            , c.cognome   as cognome_resp_stn
                            , c.nome      as nome_resp_stn
                            , iter_edit_num(a.pot_focolare_mis, 2) as pot_focolare_mis_stn
                            , b.cognome   as cognome_manu_stn
                            , b.nome      as nome_manu_stn
                            , a.utente_ins as utente_stn
                        from coimdimp_stn a 
                        left outer join coimmanu b on b.cod_manutentore  = a.cod_manutentore
                        left outer join coimcitt c on c.cod_cittadino    = a.cod_responsabile
                        where cod_dimp = :cod_dimp"] == 0} {
    set sostituto "Senza dichiarazione sostitutiva"
} else {
    if {$data_controllo_pretty != $data_controllo_stn} {
	set diff_data "data controllo da $data_controllo_pretty a $data_controllo_stn"
    } else {
	set diff_data ""
    } 
    if {$pot_focolare_mis != $pot_focolare_mis_stn} {
	set diff_potenza "potenza nominale al focolare da $pot_focolare_mis a $pot_focolare_mis_stn"
    } else {
	set diff_potenza ""
    } 
    if {($cognome_manu != $cognome_manu_stn) || ($nome_manu != $nome_manu_stn)} {
	set diff_manu "manutentore da $cognome_manu $nome_manu a $cognome_manu_stn $nome_manu_stn"
    } else {
	set diff_manu ""
    } 
    if {($cognome_resp != $cognome_resp_stn) || ($nome_resp != $nome_resp_stn)} {
	set diff_resp "soggetto responsabile da $cognome_resp $nome_resp a $cognome_resp_stn $nome_resp_stn"
    } else {
	set diff_resp ""
    } 
    if {$diff_data == "" && $diff_potenza == "" && $diff_manu == "" && $diff_resp == ""} {
	set cambiamenti "dove non si riscontrano differenze riguardanti data controllo, potenza nominale, manutentore, responsabile."
    } else {
	set cambiamenti "dove si riscontrano differenze per $diff_data $diff_potenza $diff_manu $diff_resp"
    }
    set sostituto "E' presente una dichiarazione sostitutiva visibile a sistema $cambiamenti"
    set utente $id_utente

}

# trovo destinatario della mail (utente che ha inserito lo storno)
# se l'utente che ha inserito la dichiarazione sostitutiva e' un amministratore prendo la sua mail dalla tabella coimuten
# altrimenti se il responsabile e' un terzo prendo la mail del manutentore  rappresentante legale
# altrimenti se il responsabile e' l'amministratore prendo la mail dell'amministratore su coimuten
# altrimenti prendo il codice manutentore della dichiarazione      

set destmail ""
db_1row sel_uten "select e_mail, substr(id_utente,1,2) as inizuser from coimuten where id_utente = :utente"
if {$inizuser == "AM"} {
    set destmail $e_mail
}
#ns_log notice "provadob1 destmail $destmail"

if {[string equal $destmail ""]} {
    if {[db_0or1row sel_terzo "select cod_responsabile as cod_terz from coimaimp where cod_impianto = :cod_impianto and flag_resp = 'T'"] == 1} {
	if {[db_0or1row sel_manu_leg "select email from coimmanu where cod_legale_rapp = :cod_terz"] == 1} {
	    set destmail $email
	}
    }
}
#ns_log notice "provadob2 destmail $destmail"


if {[string equal $destmail ""]} {
    if {[db_0or1row sel_am "select cod_responsabile from coimaimp where cod_impianto = :cod_impianto and flag_resp = 'A'"] == 1} {
	db_1row sel_uten "select email from coimcitt where cod_cittadino = :cod_responsabile"
	set destmail $email
    }
}
#ns_log notice "provadob3 destmail $destmail"

if {[string equal $destmail ""]} {
    if {![string equal $cod_manutentore ""]} {
	set destmail $email_manutentore
    }
}
#ns_log notice "provadob4 destmail $destmail"

if {[string equal $destmail ""] || [string equal $destmail "."] } {

#ns_log notice "prova dob cerca mail curit cod_manutentore $cod_manutentore"
    set url "http://areaoperativa.curit.it/iter-portal/get-mail-manut?cod_manutentore=$cod_manutentore"
#    set destmail [ad_httpget -url $url -timeout 100]

    set data [ad_httpget -url $url -timeout 100]
    array set result $data
    set destmail $result(page)

#ns_log notice "prova dob trovata mail $destmail"
    if {$destmail == "?"} {
	set destmail ""
    }
}


if {![string equal $destmail ""]} {

#B80 inserimento log per rich storno - start
 #   ns_sendmail "andrea_madonini@yahoo.it" $destmail "CHECK-RICH-STORNO-ENTE: Richiesta storno dichiarazione $cod_dimp" "Si richiede lo storno della dichiarazione n. $cod_dimp del $data_controllo_pretty relativa all'impianto $codice_impianto sito in $indirizzo nel comune di $comune .  Responsabile impianto $cognome_resp $nome_resp.  $sostituto"
#B80 inserimento - end

    ns_sendmail $uff_info $destmail "Richiesta storno dichiarazione" "Si richiede lo storno della dichiarazione n. $cod_dimp del $data_controllo_pretty relativa all'impianto $codice_impianto sito in $indirizzo nel comune di $comune .  Responsabile impianto $cognome_resp $nome_resp.  $sostituto"
} else {

#B80 inserimento log per rich storno - start
   # ns_sendmail "andrea_madonini@yahoo.it" $uff_info "CHECK-RICH-STORNO-ENTE: Richiesta storno dichiarazione da mittente sconosciuto $cod_dimp" "Si richiede lo storno della dichiarazione n. $cod_dimp del $data_controllo_pretty relativa all'impianto $codice_impianto sito in $indirizzo nel comune di $comune .  Responsabile impianto $cognome_resp $nome_resp.  $sostituto"
#B80 inserimento - end

    ns_sendmail $uff_info $uff_info "Richiesta storno dichiarazione da mittente sconosciuto" "Si richiede lo storno della dichiarazione n. $cod_dimp del $data_controllo_pretty relativa all'impianto $codice_impianto sito in $indirizzo nel comune di $comune .  Responsabile impianto $cognome_resp $nome_resp.  $sostituto"
}


db_dml query "update coimdimp set stato_dich = 'R' where cod_dimp = :cod_dimp"

set return_url $pack_dir/$directory/coimdimp-list?$link
ad_returnredirect -message "Richiesta di storno inoltrata" $return_url
ad_script_abort
