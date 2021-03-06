ad_page_contract {

    @author        Romitti Luca
    @creation-date 21/12/2020

    @cvs-id
    
} {
    cod_impianto
    {last_cod_impianto ""}
    {funzione          "V"}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {extra_par         ""}
    {url_list_aimp2    ""}
    {url_list_aimp     ""}
    {url_aimp          ""}
    {flag_assegnazione ""}
    {conferma_inco     ""}
    {f_data_libretto   ""}
    {f_cod_via         ""}
    {msg_cod_combustibile ""}
} -properties {
}

set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set link_gest [export_url_vars cod_impianto last_cod_impianto nome_funz nome_funz_caller extra_par url_list_aimp url_aimp caller]

# Controlla lo user
if {[db_0or1row sel_ruolo "select 1
                             from coimuten
                            where id_utente = :id_utente
                              and id_ruolo = 'manutentore'"]} {
    iter_return_complaint "Accesso non consentito ai manutentori!"
    return
}

iter_get_coimtgen
set flag_codifica_reg   $coimtgen(flag_codifica_reg)

if {$flag_codifica_reg == "T"} {

    db_transaction {

	set lun_num_cod_imp_est $coimtgen(lun_num_cod_imp_est)
	if {$coimtgen(ente) eq "CPESARO"} {
	    set sigla_est "CMPS"
	} elseif {$coimtgen(ente) eq "CFANO"} {
	    set sigla_est "CMFA"
	} elseif {$coimtgen(ente) eq "CANCONA"} {
	    set sigla_est "CMAN"
	} elseif {$coimtgen(ente) eq "PAN"} {
	    set sigla_est "PRAN"
	} elseif {$coimtgen(ente) eq "CJESI"} {
	    set sigla_est "CMJE"
	} elseif {$coimtgen(ente) eq "CSENIGALLIA"} {
	    set sigla_est "CMSE"
	} elseif {$coimtgen(ente) eq "PPU"} {
	    set sigla_est "PRPU"
	} elseif {$coimtgen(ente) eq "PMC"} {
	    set sigla_est "PRMC"
	} elseif {$coimtgen(ente) eq "CMACERATA"} {
	    set sigla_est "CMMC"
	} elseif {$coimtgen(ente) eq "CCIVITANOVA MARCHE"} {
	    set sigla_est "CMCM"
	} elseif {$coimtgen(ente) eq "CASCOLI PICENO"} {
	    set sigla_est "CMAP"
	} elseif {$coimtgen(ente) eq "CSAN BENEDETTO DEL TRONTO"} {
	    set sigla_est "CMSB"
	} elseif {$coimtgen(ente) eq "PAP"} {
	    set sigla_est "PRAP"
	} elseif {$coimtgen(ente) eq "PFM"} {
	    set sigla_est "PRFM"
	} else {
	    set sigla_est ""
	}
	
	set progressivo_est [db_string sel "select nextval('coimaimp_est_s')"]
	set progressivo_est [db_string sel "select lpad(:progressivo_est,:lun_num_cod_imp_est,'0')"]
	set targa "$sigla_est$progressivo_est"

	db_dml upd_targa "update coimaimp 
                             set targa        = :targa 
                               , data_mod     = current_date
                               , utente       = :id_utente               
                           where cod_impianto = :cod_impianto"

	ns_log notice "coimaimp-inserisci-targa: l'utente $id_utente ha inserito la targa $targa sull'impianto $cod_impianto."

    };#fine transactions

};#fine flag_codifica

set return_url   "coimaimp-gest?funzione=$funzione&$link_gest"
ad_returnredirect $return_url
ad_script_abort

