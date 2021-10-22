ad_page_contract {

  Storna movimenti PORTAFOGLIO ELETTRONICO manutentori etc.

  @author        Nelson Secco
  @creation-date 2008-08-05
  @cvs-id        storno.tcl

} {
    tran_id
    user_id
    reason
    {nome_funz ""} 
    {extra_par ""}
}

set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

#dati per lo storno
set data_storno [ah::today_ansi]
set email [db_string party "select e_mail 
                              from coimuten
                             where id_utente = :user_id"]
set now   [db_string now   "select to_char(current_timestamp, 'DD/MM/YYYY HH24:MI')"]
set reason [concat "$now - $email - $reason"]
#leggo movimento da stornare
db_1row movement "select  holder_id
                                         ,tran_type_id  
                                         ,body_id       
                                         ,payment_date  
                                         ,reference     
                                         ,pay_type_id   
                                         ,'storno ' || description as description  
                                         ,amount        
                                         ,currency_date
                                         ,trim(substr(reference,1,position(' ' in reference))) as cod_dimp
                                         ,trim(substr(reference,position(' ' in reference))) as iter_dbn 
                                    from  wal_transactions 
                                   where  tran_id  = :tran_id"

#prendo il codice portafoglio del manutentore
db_1row holder   "select  wallet_id
                                    from  wal_holders
                                   where  holder_id = :holder_id"

if {$tran_type_id == 1} {
    set tran_type_id_storno 2
} elseif {$tran_type_id == 2} {
    set tran_type_id_storno 1
} else {
    
    set messaggio "Si è verificato un errore nei 'TIPI TRANSAZIONE': 'tran_type_id = $tran_type_id'"
    set url_vars [export_url_vars caller nome_funz messaggio]
    ad_returnredirect "transactions?$url_vars"
    #ad_return_complaint 1 "<li>Si è verificato un errore nei 'TIPI TRANSAZIONE': 'tran_type_id = $tran_type_id'"
    ad_script_abort
}
set oggi [db_string query "select current_date"]

#web service crea storno
set mm_reference [ad_urlencode $reference]
set mm_description [ad_urlencode $description]
set mm_reason [ad_urlencode $reason]
set url lotto/move?wallet_id=$wallet_id&body_id=$body_id&tran_type_id=$tran_type_id_storno&payment_type=C&payment_date=$data_storno&reference=$mm_reference&description=$mm_description&amount=$amount&tran_id=$tran_id&reason=$mm_reason
set data [iter_httpget_wallet $url]
array set result $data
util_unlist $result(page) retcode ref_tran_id
if {$retcode ne "OK"} {
    set messaggio "Si è verificato un errore imprevisto nell'inserimento del movimento di storno : $retcode"
    set url_vars [export_url_vars caller nome_funz messaggio]
    ad_returnredirect "transactions?$url_vars"

    #ad_return_complaint 1 "<li>Si è verificato un errore imprevisto nell'inserimento del movimento di storno : $retcode"
    ad_script_abort
}

db_dml upd_mov "
        update wal_transactions set
            ref_tran_id = :ref_tran_id
        where tran_id = :tran_id"

#aggiornamento eventuale dati dichiarazioni su iter
#ns_log notice "prova dob 1"
if {[db_0or1row query "select 1 
                         from coimdimp 
                        where cod_dimp = :cod_dimp"] == 1} {
#ns_log notice "prova dob 2"
    if {[db_0or1row query "select cod_impianto
                                , substr(utente,1,2) as inizuser
                                , costo as costo_stn 
                             from coimdimp_stn
                            where cod_dimp = :cod_dimp"] == 1} {
#web service inserimento movimento sostitutivo
	set reference "$cod_dimp $iter_dbn"
	set description "sostituisce il pagamento $ref_tran_id"
	set mm_reference [ad_urlencode $reference]
	set mm_description [ad_urlencode $description]

	set iter_code ""
	if {$inizuser == "AM"} {
	    set iter_code $utente
	}
	if {[string equal $iter_code ""]} {
	    if {[db_0or1row sel_terzo "select cod_responsabile as cod_terz
                                         from coimaimp 
                                        where cod_impianto = :cod_impianto 
                                          and flag_resp = 'T'"] == 1} {
		db_1row sel_manu_leg "select cod_manutentore as iter_code 
                                        from coimmanu 
                                       where cod_legale_rapp = :cod_terz"
		
	    } else {
		if {[db_0or1row sel_am "select cod_responsabile as cod_ammin
                                          from coimaimp 
                                         where cod_impianto = :cod_impianto 
                                           and flag_resp = 'A'"] == 1} {
		    set iter_code $cod_ammin
		} else {
		    if {[db_0or1row sel_am "select cod_manutentore
                                              from coimaimp 
                                             where cod_impianto = :cod_impianto"] == 1} {
			set iter_code $cod_manutentore
		    }
		}
	    }
	}
#trovo il costo
	if {[db_0or1row sel_tariffa "select importo as costo 
                                       from coimaimp a,
                                            coimtari c
                                      where c.cod_potenza = a.cod_potenza
                                        and a.cod_impianto = :cod_impianto
                                        and c.data_inizio = (select max(data_inizio) 
                                                               from coimtari 
                                                              where cod_listino = '0' 
                                                                and tipo_costo = 7)
                                        and c.tipo_costo = 7
                                        and c.cod_listino = '0'  
                                                    "] == 0} {
	    set costo 0
	}

	#set url lotto/itermove?iter_code=$iter_code&body_id=3&tran_type_id=2&payment_type=1&payment_date=$oggi&reference=$mm_reference&description=$mm_description&amount=$costo
	set url lotto/itermove?iter_code=$iter_code&body_id=2&tran_type_id=2&payment_type=1&payment_date=$oggi&reference=$mm_reference&description=$mm_description&amount=$costo_stn
	set data [iter_httpget_wallet $url]
	array set result $data
	util_unlist $result(page) retcode ref_tran_id
	if {$retcode ne "OK"} {
	    set messaggio "Si è verificato un errore imprevisto nell'inserimento nel movimento sostitutivo: $retcode"
	    set url_vars [export_url_vars caller nome_funz messaggio]
	    ad_returnredirect "transactions?$url_vars"
	    #ad_return_complaint 1 "<li>Si è verificato un errore imprevisto nell'inserimento nel movimento sostitutivo: $retcode"
	    ad_script_abort
	}
	if {[db_table_exists  coimdimp_comodo]} {
	    db_dml  query "drop table coimdimp_comodo"
	}
	db_dml query "create table coimdimp_comodo as (select * from coimdimp where cod_dimp = :cod_dimp)"
	db_dml query "delete from coimdimp where cod_dimp = :cod_dimp"
	db_dml query "insert into coimdimp (select * from coimdimp_stn where cod_dimp = :cod_dimp)"
	db_dml query "delete from coimdimp_stn where cod_dimp = :cod_dimp"
	db_dml query "insert into coimdimp_stn (select * from coimdimp_comodo where cod_dimp = :cod_dimp)"
	db_dml query "update coimdimp set stato_dich = 'S' where cod_dimp = :cod_dimp"
	
    } else {
	db_dml query "insert into coimdimp_stn (select * from coimdimp where cod_dimp = :cod_dimp)"
	db_dml query "delete from coimdimp where cod_dimp = :cod_dimp"
    }
}

set messaggio_ok "Il movimento è stato stornato."

set url_vars [export_url_vars caller nome_funz receiving_element messaggio_ok]&[iter_set_url_vars $extra_par]
ad_returnredirect -message "Il movimento è stato stornato." "transactions?$url_vars"
ad_script_abort

