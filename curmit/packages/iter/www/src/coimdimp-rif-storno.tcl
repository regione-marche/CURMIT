ad_page_contract {
    rifiuto storno dichiarazioni (tabella "coimdimp")
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

set lvl 4
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
                  , iter_edit_data(a.data_controllo) as data_controllo_pretty
                  , a.data_controllo
                  , a.gen_prog
                  , a.cod_manutentore
                  , a.cod_opmanu_new
                  , a.cod_responsabile
                  , a.cod_proprietario
                  , a.cod_occupante
                  , a.flag_status
                  , a.garanzia
                  , a.conformita
                  , a.lib_impianto
                  , a.lib_uso_man
                  , a.inst_in_out
                  , a.idoneita_locale
                  , a.ap_ventilaz
                  , a.ap_vent_ostruz
                  , a.pendenza
                  , a.sezioni
                  , a.curve
                  , a.lunghezza
                  , a.conservazione
                  , a.scar_ca_si
                  , a.scar_parete
                  , a.riflussi_locale
                  , a.assenza_perdite
                  , a.pulizia_ugelli
                  , a.antivento
                  , a.scambiatore
                  , a.accens_reg
                  , a.disp_comando
                  , a.ass_perdite
                  , a.valvola_sicur
                  , a.vaso_esp
                  , a.disp_sic_manom
                  , a.organi_integri
                  , a.circ_aria
                  , a.guarn_accop
                  , a.assenza_fughe
                  , a.coibentazione
                  , a.eff_evac_fum
                  , a.cont_rend
                  , iter_edit_num(a.pot_focolare_mis, 2) as pot_focolare_mis
                  , iter_edit_num(a.portata_comb_mis, 2) as portata_comb_mis
                  , iter_edit_num(a.temp_fumi, 2) as temp_fumi
                  , iter_edit_num(a.temp_ambi, 2) as temp_ambi
                  , iter_edit_num(a.o2, 2) as o2
                  , iter_edit_num(a.co2, 2) as co2
                  , iter_edit_num(a.bacharach, 2) as bacharach
                  , a.co
                  , iter_edit_num(a.rend_combust, 2) as rend_combust
                  , a.osservazioni
                  , a.raccomandazioni
                  , a.prescrizioni
                  , iter_edit_data(a.data_utile_inter) as data_utile_inter
                  , a.n_prot
                  , iter_edit_data(a.data_prot) as data_prot
                  , a.delega_resp
                  , a.delega_manut
                  , a.num_bollo
                  , c.cognome   as cognome_resp
                  , c.nome      as nome_resp
                  , b.cognome   as cognome_manu
                  , b.nome      as nome_manu
                  , d.cognome   as cognome_prop
                  , d.nome      as nome_prop
                  , e.cognome   as cognome_occu
                  , e.nome      as nome_occu
                  , i.nome      as nome_opma
                  , i.cognome   as cognome_opma
                  , g.cod_intestatario   as cod_int_contr	
                  , h.cognome            as cognome_contr
                  , h.nome               as nome_contr
                  , iter_edit_num(a.costo, 2) as costo
                  , a.tipologia_costo
                  , riferimento_pag
		  , iter_edit_num(a.potenza, 2) as potenza
                  , a.data_ins
                  , a.flag_co_perc
		  , a.utente_ins
		  , iter_edit_data(a.data_arrivo_ente) as data_arrivo_ente
                  , cod_docu_distinta
                  , a.stato_dich
                  , coalesce(b.email,'?') as email_manutentore
                  , g.cod_impianto_est as codice_impianto
                  , l.denominazione as comune
                  , m.descr_topo || ' ' || m.descrizione || ', ' || coalesce(g.numero,'') as indirizzo 
                  , a.utente_ins as utente
               from coimdimp a
               left outer join coimmanu b on b.cod_manutentore  = a.cod_manutentore
               left outer join coimcitt c on c.cod_cittadino    = a.cod_responsabile
	       left outer join coimcitt d on d.cod_cittadino    = a.cod_proprietario
               left outer join coimcitt e on e.cod_cittadino    = a.cod_occupante
                    inner join coimaimp g on g.cod_impianto     = a.cod_impianto
               left outer join coimcitt h on h.cod_cittadino    = g.cod_intestatario
               left outer join coimopma i on i.cod_opma         = a.cod_opmanu_new
               left outer join coimcomu l on l.cod_comune       = g.cod_comune
               left outer join coimviae m on m.cod_via          = g.cod_via
                                         and m.cod_comune       = g.cod_comune
              where a.cod_dimp = :cod_dimp
"

if {$data_controllo < "2008-08-01"} {
    iter_return_complaint "
    Funzione possibile solo per dichiarazioni con data controllo successiva all '01/08/2008'."  
    ad_script_abort
}
if {[string equal $stato_dich ""]} {
    iter_return_complaint "
    Funzione annullata in quanto non e' stata inserita la richiesta di storno."  
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

if {[db_0or1row query "select 1 from coimdimp_stn where cod_dimp = :cod_dimp"] == 0} {
    set sostituto "Non era presente una dichiarazione sostitutiva"
} else {
    set sostituto "La dichiarazione sostitutiva predisposta e' stata cancellata"
}


# trovo destinatario della mail (utente che ha inserito la dichiarazione)
# se l'utente che ha inserito la dichiarazione sostitutiva e' un amministratore prendo la sua mail dalla tabella coimuten
# altrimenti se il responsabile e' un terzo prendo la mail del manutentore  rappresentante legale
# altrimenti se il responsabile e' l'amministratore prendo la mail dell'amministratore su coimuten
# altrimenti prendo il codice manutentore della dichiarazione      

set destmail ""
db_1row sel_uten "select e_mail, substr(id_utente,1,2) as inizuser from coimuten where id_utente = :utente"
if {$inizuser == "AM"} {
    set destmail $e_mail
}
#ns_log notice "prova dob 1 $destmail"

if {[string equal $destmail ""]} {
    if {[db_0or1row sel_terzo "select cod_responsabile as cod_terz from coimaimp where cod_impianto = :cod_impianto and flag_resp = 'T'"] == 1} {
	if {[db_0or1row sel_manu_leg "select email from coimmanu where cod_legale_rapp = :cod_terz"] == 1} {
	    set destmail $email
	}
    }
}
#ns_log notice "prova dob 2 $destmail"

if {[string equal $destmail ""]} {
    if {[db_0or1row sel_am "select cod_responsabile from coimaimp where cod_impianto = :cod_impianto and flag_resp = 'A'"] == 1} {
	db_1row sel_uten "select email from coimcitt where cod_cittadino = :cod_responsabile"
	set destmail $email
    }
}
#ns_log notice "prova dob 3 $destmail"

if {[string equal $destmail ""]} {
    if {![string equal $cod_manutentore ""]} {
	set destmail $email_manutentore
    }
}
#ns_log notice "prova dob 4 $destmail"


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

#ns_log notice "prova dob 5 $destmail"


if {![string equal $destmail ""]} {
    ns_sendmail $destmail $uff_info "Rifiuto richiesta di storno dichiarazione" "Si comunica che la richiesta di storno della dichiarazione n. $cod_dimp del $data_controllo_pretty relativa all'impianto $codice_impianto sito in $indirizzo nel comune di $comune .  Responsabile impianto $cognome_resp $nome_resp e' stata rifiutata.  $sostituto "
} else {
    ns_sendmail $uff_info $uff_info "Mancata spedizione mail rifiuto richiesta di storno dichiarazione" "Si comunica la mancata comunicazione al responsabile che la richiesta di storno della dichiarazione n. $cod_dimp del $data_controllo_pretty relativa all'impianto $codice_impianto sito in $indirizzo nel comune di $comune .  Responsabile impianto $cognome_resp $nome_resp e' stata rifiutata.  $sostituto "
}


db_dml query "update coimdimp set stato_dich = 'X' where cod_dimp = :cod_dimp"
db_dml query "delete from coimdimp_stn where cod_dimp = :cod_dimp"

set return_url $pack_dir/$directory/coimdimp-list?$link
ad_returnredirect -message "Rifiuto richiesta inoltrato al manutentore e cancellata eventuale dechiarazione sostitiva predisposta." $return_url
ad_script_abort
