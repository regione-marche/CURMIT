ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimdimp"
    @author          Adhoc
    @creation-date   13/03/2006

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz_caller identifica l'entrata di menu, serve per la 
    @                navigazione con navigation bar

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimdimp-gest.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    innes 17/05/2018

    sim06 13/04/2018 Anche iterprug,iterprgo,iterprts e iterprpn devono avere momentaneamente
    sim06            la possibilità di inserire RCEE col bollino anche col wallet attivo

    sim05 05/05/2017 Solo per Firenze si può inserire sia un rct standard che un rct legna 

    sim04 05/04/2017 Se la dichiarazione è riferita ad un impianto con teleriscaldamento
    sim04            devo puntare al programma coimdimp-r3-gest.

    gab01 22/02/2017 Se la dichiarazione è riferita ad un generatore con combustibile a legna
    gab01            devo puntare al programma coimdimp-1b-gest (solo se il flag della tabella
    gab01            coimtgen per la gestione della legna è T).

    sim03 25/10/2016 Anche per gli amministratori di iterprrc sarà presente il flag_tracciato NW
    sim03            per inserire rct senza il portafoglio

    sim02 18/10/2016 Solo per taranto ci sarà anche il flag_tracciato NW che è rct senza
    sim02            il portafoglio

    sim01 17/03/2016 Per gli storni ho aggiunto la gestione del freddo.

    nic01 17/09/2015 Aggiunto link per gestione dichiarazioni di avvenuta manutenzione per
    nic01            la regione Marche.
} {
    {cod_dimp             ""}
    {last_cod_dimp        ""}
    {funzione            "V"}
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
    {tabella              ""}
    {targa                ""}
    dbn_iter             
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
set funzione "V" ;#innes
switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

if {[exists_and_not_null tabella]} {
    set stn "_stn"
} else {
    set stn " "
    set tabella ""
}


#sim03 scommentato id_utente
#innes set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]


set login_cohesion_marche_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cohesion_marche_p];#innes

set login_cittadino_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cittadino_p];#innes

if {$login_cohesion_marche_p eq "1"} {#innes: aggiunta if, else e loro contenuto
    set codice_fiscale [iter::check_login_cohesion -nome_array_output array_cohesion -dbn_iter $dbn_iter -cod_impianto $cod_impianto]
    # Se in futuro ci sara' bisogno di altri campi useremo i valori di array_cohesion
} else {
    if {$login_cittadino_p} {
	set user_id [iter::script_init_cittadino]
    }
}

set id_utente "";#innes (dove e' rimasto l'utilizzo di id_utente, non serve)


#iter_get_coimtgen
iter_get_coimtgen -dbn $dbn_iter 
set flag_ente    $coimtgen(flag_ente)
set denom_comune $coimtgen(denom_comune)
set sigla_prov   $coimtgen(sigla_prov)
set link         [export_ns_set_vars "url"]

set pack_key [iter_portal_package_key ]
set pack_dir [apm_package_url_from_key $pack_key]
#innes append pack_dir "src"

set directory ""
#switch $flag_ente {
#    "P" {set directory "$flag_ente$sigla_prov"}
#    "C" {set directory "$flag_ente$denom_comune"}
#    default {set directory "standard"}
#}

if {$funzione != "I" && ![exists_and_not_null tabella]} {

    if {[db_0or1row -dbn $dbn_iter sel_dimp_flag_tracciato ""] == 0} {
	iter_return_complaint "Modello non trovato "
	return
    }
}

#set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

if {$flag_tracciato == "F" && [string equal $gen_prog ""] && $funzione == "I"} {

    set flag_conf "S"
    # set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

    set form_name "coimdimp"
    form create $form_name \
	
    set link_tab [iter_links_form $cod_impianto $tabella $nome_funz_caller $url_list_aimp $url_aimp $extra_par]
    set dett_tab [iter_tab_form $cod_impianto]
    
    set nome_funz "datigen"
    set link2     "nome_funz=$nome_funz&nome_funz_caller=impianti&cod_impianto=$cod_impianto&tabella=$tabella"

} else {

    set flag_conf "N"

    db_1row -dbn $dbn_iter sel_aimp_potenza "select potenza
                                                  , flag_tipo_impianto --sim01
                                               from coimaimp
                                              where  cod_impianto = :cod_impianto
                                                    "
    
    #innes set cod_manu [iter_check_uten_manu $id_utente];#sim03

    #sim03 aggiunto || per PRC
    #sim06 aaggiunto || per PUD PGO PTS PPN
    if {$coimtgen(ente) eq "PTA" || ($coimtgen(ente) eq "PRC" && $cod_manu eq "" ) ||
	$coimtgen(ente) eq "PUD" ||
	$coimtgen(ente) eq "PGO" ||
	$coimtgen(ente) eq "PTS" ||
	$coimtgen(ente) eq "PPN" 
    } {;#sim02 
	set tipologia_costo ""	    
	if {$cod_dimp ne ""} {
	    db_0or1row -dbn $dbn_iter q "select tipologia_costo
                       from coimdimp 
                      where cod_dimp = :cod_dimp"
	}

	if {$tipologia_costo ne "LM" && $flag_tracciato eq "R1" && $funzione ne "I"} {;#sim02
	    set flag_tracciato "NW"
	}
    }

    if {[exists_and_not_null tabella]} {
	if {$flag_tipo_impianto eq "F"} {#sim01: Aggiunta if e suo contenuto
	    set flag_tracciato "R2"
	} elseif {$flag_tipo_impianto eq "T"} {;#sim04
	    set flag_tracciato "R3"
	}  elseif {$flag_tipo_impianto eq "C"} {#rom01 
	    set flag_tracciato "R4"
	} else {
	    if {$flag_tracciato ne "1B"} {;#sim05
		set flag_tracciato "R1"
	    };#sim05
	}
	
	#sim01 if {$potenza >= 35} {
	#sim01    set flag_tracciato "F"
	#sim01    set flag_tracciato "R1"
	#sim01 } else {
	#sim01    set flag_tracciato "G"
	#sim01    set flag_tracciato "R1"
	#sim01 }
        
    }
    
    # ns_log notice "prova dob seleziona tracciato $nome_funz $nome_funz_caller "

    if {$coimtgen(flag_gest_rcee_legna) eq "T"} {;#gab01 aggiunta if e suo contenuto                       
	if {$funzione ne "I"} { 
	    db_0or1row -dbn $dbn_iter q "select gen_prog 
                                           from coimdimp 
                                          where cod_dimp = :cod_dimp"
	}
    
	if {$gen_prog ne ""} {;#gab01
	    set cond_legna  [db_0or1row -dbn $dbn_iter q "select gen_prog
                                             from coimgend
                                            where cod_impianto     = :cod_impianto
                                              and gen_prog         = :gen_prog
                                              and cod_combustibile in ('6','12','112','211')"]
	} else {
	    set cond_legna  [db_0or1row -dbn $dbn_iter q "select gen_prog
                                             from coimgend
                                            where cod_impianto     = :cod_impianto
                                              and cod_combustibile in ('6','12','112','211') limit 1"]
	}
    
	if {$cond_legna} {;#gab01 
	    set tipo_r1 "coimdimp-1b-gest"
	} else {
	    set tipo_r1 "coimdimp-rct-gest"
	}
    } else {
	set tipo_r1 "coimdimp-rct-gest"
    }
    #sim02 aggiunto NW
    #gab01 "R1"    {set return_url $pack_dir/$directory/coimdimp-rct-gest?$link}
    #sim04 aggiunto R3
    #sim05 aggiunto 1B usato da Firenze
    #rom01 aggiunto R4 per cogenerazione 
#innes    switch $flag_tracciato {
#innes	"H"     {set return_url $pack_dir/$directory/coimdimp-h-gest?$link}
#innes	"HB"    {set return_url $pack_dir/$directory/coimdimp-hb-gest?$link}
#innes	"G"     {set return_url $pack_dir/$directory/coimdimp-g-gest?$link}
#innes	"F"     {set return_url $pack_dir/$directory/coimdimp-f-gest?$link}
#innes	"R1"    {set return_url $pack_dir/$directory/$tipo_r1?$link}
#innes	"1B"    {set return_url $pack_dir/$directory/coimdimp-1b-gest?$link}
#innes	"R2"    {set return_url $pack_dir/$directory/coimdimp-fr-gest?$link}
#innes	"R3"    {set return_url $pack_dir/$directory/coimdimp-r3-gest?$link}
#innes	"R4"    {set return_url $pack_dir/$directory/coimdimp-r4-gest?$link}
#innes	"DA"    {set return_url $pack_dir/$directory/coimdimp-dam-gest?$link}
#innes	"NW"    {set return_url $pack_dir/$directory/coimdimp-rct-nowallet-gest?$link}
#innes	default {set return_url $pack_dir/$directory/coimdimp-g-gest?$link}
#innes    }

    switch $flag_tracciato {
	"H"     {set return_url coimdimp-h-gest?$link}
	"HB"    {set return_url coimdimp-hb-gest?$link}
	"G"     {set return_url coimdimp-g-gest?$link}
	"F"     {set return_url coimdimp-f-gest?$link}
	"R1"    {set return_url $tipo_r1?$link}
	"1B"    {set return_url coimdimp-1b-gest?$link}
	"R2"    {set return_url coimdimp-fr-gest?$link}
	"R3"    {set return_url coimdimp-r3-gest?$link}
	"R4"    {set return_url coimdimp-r4-gest?$link}
	"DA"    {set return_url coimdimp-dam-gest?$link}
	"NW"    {set return_url coimdimp-rct-nowallet-gest?$link}
	default {set return_url coimdimp-g-gest?$link}
    }
    


    
    ad_returnredirect $return_url
    # Claudio
    ad_script_abort
}
