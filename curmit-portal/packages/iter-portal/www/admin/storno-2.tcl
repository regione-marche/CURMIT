ad_page_contract {

  Storna movimenti PORTAFOGLIO ELETTRONICO manutentori etc.

  @author        Nelson Secco
  @creation-date 2008-08-05
  @cvs-id        storno.tcl


  USER  DATA       MODIFICHE
  ===== ========== =============================================================================================
  sim01 09/08/2018 Corretto errore che capitava in caso di storno su ente con contributo regionale. 
  sim01            Il pezzo di codice del programma cercava di creare (in modo errato) in automatico lo storno del 
  sim01            contributo regionale. 
  sim01            Ho commentato il pezzo di codice e sarà l'utente ad effettuare lo storno sia sul costo del bollino
  sim01            che sul contributo.

  gab01 09/04/2018 Ricevo e passo il parametro f_ente_portafoglio.
  

} {
    tran_id
    user_id
    reason
    f_ente_portafoglio
}

#dati per lo storno
set data_storno [ah::today_ansi]
set email [db_string party "select email from parties where party_id = :user_id"]
set now   [db_string now   "select to_char(current_timestamp, 'DD/MM/YYYY HH24:MI')"]
set reason [concat "$now - $email - $reason"]

set coimdimp_stn_col [db_columns coimdimp_stn]
regsub -all " " $coimdimp_stn_col "," coimdimp_stn_col

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

if {$f_ente_portafoglio ne ""} {
    set and_nome_istanza "and instance_name = '$f_ente_portafoglio'"
} else {
    set and_nome_istanza ""
}


#prendo il codice portafoglio del manutentore
db_1row holder   "select wallet_id
                    from wal_holders
                   where holder_id = :holder_id
                       $and_nome_istanza"

if {$tran_type_id == 1} {
    set tran_type_id_storno 2
} elseif {$tran_type_id == 2} {
    set tran_type_id_storno 1
} else {
    ad_return_complaint 1 "<li>Si è verificato un errore nei 'TIPI TRANSAZIONE': 'tran_type_id = $tran_type_id'"
    ad_script_abort
}
set oggi [db_string query "select current_date"]

#web service crea storno
set mm_reference [ad_urlencode $reference]
set mm_description [ad_urlencode $description]
set mm_reason [ad_urlencode $reason]

#gab01 passo al web service anche f_ente_portafoglio
set url lotto/move?wallet_id=$wallet_id&body_id=$body_id&tran_type_id=$tran_type_id_storno&payment_type=C&payment_date=$data_storno&reference=$mm_reference&description=$mm_description&amount=$amount&tran_id=$tran_id&reason=$mm_reason&ente_portafoglio=$f_ente_portafoglio
set data [iter_httpget_wallet $url]

array set result $data

util_unlist $result(page) retcode ref_tran_id
if {$retcode ne "OK"} {
    ad_return_complaint 1 "<li>Si è verificato un errore imprevisto nell'inserimento del movimento di storno : $retcode"
    ad_script_abort
}
db_dml upd_mov "
        update wal_transactions set
            ref_tran_id = :ref_tran_id
        where tran_id = :tran_id"

#aggiornamento eventuale dati dichiarazioni su iter
#ns_log notice "prova dob 1"
if {[db_0or1row -dbn $iter_dbn query "select 1 from coimdimp where cod_dimp = :cod_dimp"] == 1} {
#ns_log notice "prova dob 2"
    if {[db_0or1row -dbn $iter_dbn query "select cod_impianto,substr(utente,1,2) as inizuser
                                                , costo as costo_stn 
                                            from coimdimp_stn where cod_dimp = :cod_dimp"] == 1} {
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
	    if {[db_0or1row -dbn $iter_dbn sel_terzo "select cod_responsabile as cod_terz from coimaimp where cod_impianto = :cod_impianto and flag_resp = 'T'"] == 1} {
		db_1row -dbn $iter_dbn sel_manu_leg "select cod_manutentore as iter_code from coimmanu where cod_legale_rapp = :cod_terz"
		
	    } else {
		if {[db_0or1row -dbn $iter_dbn sel_am "select cod_responsabile as cod_ammin from coimaimp where cod_impianto = :cod_impianto and flag_resp = 'A'"] == 1} {
		    set iter_code $cod_ammin
		} else {
		    if {[db_0or1row -dbn $iter_dbn sel_am "select cod_manutentore from coimaimp where cod_impianto = :cod_impianto"] == 1} {
			set iter_code $cod_manutentore
		    }
		}
	    }
	}

#sim01 questa parte di codice è un refuso che non capitava mai perche' non c'era il contributo regionale. 
#Ce ne siamo accorti perche' il contributo e' presente su UCIT ed ha segnalato un errore.
#Lo salto in blocco

	if {1==0} {#sim01
#trovo il costo
	if {[db_0or1row -dbn $iter_dbn sel_tariffa "select importo as costo 
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

	#gab01 passo al web service anche f_ente_portafoglio
	set url lotto/itermove?iter_code=$iter_code&body_id=2&tran_type_id=2&payment_type=1&payment_date=$oggi&reference=$mm_reference&description=$mm_description&amount=$costo_stn&ente_portafoglio=$f_ente_portafoglio
	set data [iter_httpget_wallet $url]
	#set data [ad_httpget -url $url -timeout 3]
	array set result $data
	util_unlist $result(page) retcode ref_tran_id
	if {$retcode ne "OK"} {
	    ad_return_complaint 1 "<li>Si è verificato un errore imprevisto nell'inserimento nel movimento sostitutivo: $retcode"
	    ad_script_abort
	}

    };#sim01

	if {[db_table_exists -dbn $iter_dbn coimdimp_comodo]} {
	    db_dml -dbn $iter_dbn query "drop table coimdimp_comodo"
	}

	db_dml -dbn $iter_dbn query "create table coimdimp_comodo as (select * from coimdimp where cod_dimp = :cod_dimp)"
	db_dml -dbn $iter_dbn query "delete from coimdimp where cod_dimp = :cod_dimp"
	
	db_dml -dbn $iter_dbn query "insert into coimdimp ($coimdimp_stn_col) (select $coimdimp_stn_col from coimdimp_stn where cod_dimp = :cod_dimp)"
	db_dml -dbn $iter_dbn query "delete from coimdimp_stn where cod_dimp = :cod_dimp"
	db_dml -dbn $iter_dbn query "insert into coimdimp_stn ($coimdimp_stn_col) (select $coimdimp_stn_col from coimdimp_comodo where cod_dimp = :cod_dimp)"
	db_dml -dbn $iter_dbn query "update coimdimp set stato_dich = 'S' where cod_dimp = :cod_dimp"
	
    } else {
	db_dml -dbn $iter_dbn query "insert into coimdimp_stn ($coimdimp_stn_col) (select $coimdimp_stn_col from coimdimp where cod_dimp = :cod_dimp)"
	db_dml -dbn $iter_dbn query "delete from coimdimp where cod_dimp = :cod_dimp"
    }
}

set url_vars [ad_get_client_property -default "" iter-portal admin/transactions] 
ad_returnredirect -message "Il movimento è stato stornato." "transactions?$url_vars"
ad_script_abort

