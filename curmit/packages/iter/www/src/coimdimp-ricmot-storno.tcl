ad_page_contract {
    storno dichiarazioni (tabella "coimdimp")
    @author          dob
    @creation-date   02/2009

    @param extra_par Variabili extra da restituire alla lista

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim01 16/03/2016 Corretto per gestione portafoglio da iter e non da portale
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
    context:onevalue
    form_name:onevalue
}


# Controlla lo user

set lvl 3
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

ns_log notice "prova dob 1 id_utente = $id_utente"


iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set denom_comune $coimtgen(denom_comune)
set sigla_prov   $coimtgen(sigla_prov)
set link         [export_ns_set_vars "url"]
set directory ""
set pack_key [iter_package_key]
set pack_dir [apm_package_url_from_key $pack_key]
append pack_dir "src"

set return_url $pack_dir/$directory/coimdimp-list?$link

set form_name "ricmot"
set page_title   "Richiesta storno modello"
set context ""

form create $form_name 

element create $form_name motivo_storno \
    -label   "Motivo storno" \
    -widget   textarea \
    -datatype text \
    -html    "cols 100 rows 5 class form_element" \
    -optional

element create $form_name cod_dimp  -widget hidden -datatype text 
element create $form_name nome_funz -widget hidden -datatype text 
element create $form_name cod_impianto -widget hidden -datatype text 
element create $form_name submit       -widget submit -datatype text -label "Richiedi" -html "class form_submit"

if {[form is_request $form_name]} {
    db_1row query "select motivo_storno from coimdimp where cod_dimp = :cod_dimp"
    element set_properties $form_name motivo_storno  -value $motivo_storno
    element set_properties $form_name cod_dimp       -value $cod_dimp
    element set_properties $form_name nome_funz      -value $nome_funz
    element set_properties $form_name cod_impianto   -value $cod_impianto
}

if {[form is_valid $form_name]} {
    set motivo_storno  [string trim [element::get_value $form_name motivo_storno]]
    set cod_dimp       [string trim [element::get_value $form_name cod_dimp]]
    set nome_funz      [string trim [element::get_value $form_name nome_funz]]
    set cod_impianto   [string trim [element::get_value $form_name cod_impianto]]

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
                  , coalesce(a.importo_tariffa,0.00) as importo_tariffa
                  , a.utente_ins as utente
                  , coalesce(a.costo, 0) as costo --sim01
               from coimdimp a
               left outer join coimmanu b on b.cod_manutentore  = a.cod_manutentore
               left outer join coimcitt c on c.cod_cittadino    = a.cod_responsabile
              inner join coimaimp g on g.cod_impianto     = a.cod_impianto
               left outer join coimcomu l on l.cod_comune       = g.cod_comune
               left outer join coimviae m on m.cod_via          = g.cod_via
                                         and m.cod_comune       = g.cod_comune
              where a.cod_dimp = :cod_dimp"

    if {$data_controllo < "2008-08-01"} {
	element::set_error $form_name motivo_storno "Funzione possibile solo per dichiarazioni con data controllo successiva all '01/08/2008'."  
	ad_return_template
	return
    }

ns_log notice "sandro controllo storno $cod_dimp $importo_tariffa"


    if {$costo <= 0} {#sim01 fatto controllo su valore corretto
	element::set_error $form_name motivo_storno "Funzione possibile solo per dichiarazioni con importo inserito."
	ad_return_template
	return
    }
#sim01 commentato vecchi controlli
#if {$importo_tariffa == 0.00} {
#      ns_log notice "sandro 0.00 controllo storno $cod_dimp $importo_tariffa"
#      element::set_error $form_name motivo_storno "Funzione possibile solo per dichiarazioni con il contributo regionale."  
#	ad_return_template
#	return
#}

#if {$importo_tariffa == 0} {
#      ns_log notice "sandro  0 controllo storno $cod_dimp $importo_tariffa"
#       element::set_error $form_name motivo_storno "Funzione possibile solo per dichiarazioni con il contributo regionale." 
#	ad_return_template
#	return
#}

#if {$importo_tariffa < 0.1} {
#      ns_log notice "sandro 0.1 controllo storno $cod_dimp $importo_tariffa"
#      element::set_error $form_name motivo_storno "Funzione possibile solo per dichiarazioni con il contributo regionale."  
#	ad_return_template
#	return
#}


    if {[string equal $stato_dich "R"]} {
	element::set_error $form_name motivo_storno "Funzione annullata in quanto  e' gia' stata inserita la richiesta di storno."  
	ad_return_template
	return
    } elseif {[string equal $stato_dich "A"]} {
	element::set_error $form_name motivo_storno "
    Funzione annullata in quanto la richiesta di storno e' stata gia' accettata."  
	ad_return_template
	return
    } elseif {[string equal $stato_dich "X"]} {
	element::set_error $form_name motivo_storno "
    Funzione annullata in quanto la richiesta di storno e' stata gia' rifiutata."  
	ad_return_template
	return
    } elseif {[string equal $stato_dich "S"]} {
	element::set_error $form_name motivo_storno "
    Funzione annullata in quanto gia' sostituito in seguito a storno."  
	ad_return_template
	return
    }

    if {$motivo_storno == ""} {
	element::set_error $form_name motivo_storno "Per richiedere lo storno serve inserire una motivazione"
	ad_return_template
	return
    } else {
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
	if {[string equal $destmail ""]} {
	    if {[db_0or1row sel_terzo "select cod_responsabile as cod_terz from coimaimp where cod_impianto = :cod_impianto and flag_resp = 'T'"] == 1} {
		if {[db_0or1row sel_manu_leg "select email from coimmanu where cod_legale_rapp = :cod_terz"] == 1} {
		    set destmail $email
		}
	    }
	}
	if {[string equal $destmail ""]} {
	    if {[db_0or1row sel_am "select cod_responsabile from coimaimp where cod_impianto = :cod_impianto and flag_resp = 'A'"] == 1} {
		db_1row sel_uten "select email from coimcitt where cod_cittadino = :cod_responsabile"
		set destmail $email
	    }
	}
	
	if {[string equal $destmail ""]} {
	    if {![string equal $cod_manutentore ""]} {
		set destmail $email_manutentore
	    }
	}

	if {![string equal $destmail ""]} {
#	    ns_log notice "$uff_info $destmail Richiesta storno dichiarazione Si richiede lo storno della dichiarazione n. $cod_dimp del $data_controllo_pretty relativa all'impianto $codice_impianto sito in $indirizzo nel comune di $comune.  Responsabile impianto $cognome_resp $nome_resp. Motivazione: $motivo_storno  $sostituto"

	    ns_sendmail $uff_info $destmail "Richiesta storno dichiarazione" "Si richiede lo storno della dichiarazione n. $cod_dimp del $data_controllo_pretty relativa all'impianto $codice_impianto sito in $indirizzo nel comune di $comune.  Responsabile impianto $cognome_resp $nome_resp. Motivazione: $motivo_storno  $sostituto"


           #B80 inserimento log per rich storno - start
           #ns_sendmail "andrea_madonini@yahoo.it" $destmail "CHECK-RICH-STORNO-MAN 1: Richiesta storno dichiarazione: $cod_dimp $importo_tariffa" "Si richiede lo storno della dichiarazione n. $cod_dimp - $importo_tariffa - del $data_controllo_pretty relativa all'impianto $codice_impianto sito in $indirizzo nel comune di $comune.  Responsabile impianto $cognome_resp $nome_resp. Motivazione: $motivo_storno  $sostituto"
           # set motivo_storno [subst [regsub -all {\n} $motivo_storno " "]]
           regsub -all "\r\n" $motivo_storno " " motivo_storno
           regsub -all "\n" $motivo_storno " " motivo_storno

           #ns_sendmail "andrea_madonini@yahoo.it" $destmail "CHECK-RICH-STORNO-MAN 2: Richiesta storno dichiarazione: $cod_dimp $importo_tariffa" "Si richiede lo storno della dichiarazione n. $cod_dimp - $importo_tariffa - del $data_controllo_pretty relativa all'impianto $codice_impianto sito in $indirizzo nel comune di $comune.  Responsabile impianto $cognome_resp $nome_resp. Motivazione: $motivo_storno  $sostituto"
           #B80 inserimento - end

	} else {
#	    ns_log notice "$uff_info $uff_info Richiesta storno dichiarazione da mittente sconosciuto Si richiede lo storno della dichiarazione n. $cod_dimp del $data_controllo_pretty relativa all'impianto $codice_impianto sito in $indirizzo nel comune di $comune .  Responsabile impianto $cognome_resp $nome_resp.  Motivazione: $motivo_storno  $sostituto"
	    ns_sendmail $uff_info $uff_info "Richiesta storno dichiarazione da mittente sconosciuto" "Si richiede lo storno della dichiarazione n. $cod_dimp del $data_controllo_pretty relativa all'impianto $codice_impianto sito in $indirizzo nel comune di $comune .  Responsabile impianto $cognome_resp $nome_resp.  Motivazione: $motivo_storno  $sostituto"
	}
	
	db_dml query "update coimdimp set stato_dich = 'R', motivo_storno =:motivo_storno where cod_dimp = :cod_dimp"
	
	set return_url $pack_dir/$directory/coimdimp-list?$link
	ad_returnredirect -message "Richiesta di storno inoltrata" $return_url
	ad_script_abort
    }
}
