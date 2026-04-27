ad_page_contract {

  Storna movimenti PORTAFOGLIO ELETTRONICO manutentori etc.

  @author        Claudio pasolini
  @creation-date 2008-08-05
  @cvs-id        storno.tcl

  USER  DATA       MODIFICHE
  ===== ========== ===============================================================================================
  rom01 20/10/2021 Corretto errore presente in caso di storno della dichiarazione sostitutiva: l'holder_id del
  rom01            manutentore veniva letto senza tenere in considerazione l'ente in cui ci troviamo e in caso di
  rom01            multiportafoglio, come le Marche, la query estraeva tante righe quante sono gli enti. In realta'
  rom01            bisogna estrarre l'holder_id solo dell'ente in cui ci troviamo.

  gab01 09/04/2018 Ricevo e passo il parametro f_ente_portafoglio.

} {
    {tran_id:integer,multiple ""}
    {cod_dimp               ""}
    {iter_dbn               ""}
    {f_ente_portafoglio     ""}
}

#if {![llength $tran_id] == 1} {

#    ad_return_complaint 1 "<li>L'operazione di storno puo'essere applicata ad un solo movimento per volta!"
#    ad_script_abort
#}

if {[llength $tran_id] == 0} {
    set messaggio "Selezionare il movimento da stornare"
    ad_returnredirect -message $messaggio transactions
    ad_script_abort    
}
if {[llength $tran_id] != 1} {
    
    set messaggio "L'operazione di storno puo'essere applicata ad un solo movimento per volta!"
    ad_returnredirect -message $messaggio transactions
    ad_script_abort
}

# nel caso che sia uno storno richiesto da ambiente iter cliccando su link su una mail
# ricavo tran_id usando cod_dimp e nome database che compongono il reference
# estraggo anche il codice del manutentore del movimento da annullare e l'importo del movimento
# per il controllo sul saldo del manutentore 

if {$tran_id == 0} {
    if {[db_0or1row query "select tran_id
                                           ,amount
                                           ,holder_id as holder_id_old 
                                    from  wal_transactions 
                                   where  trim(substr(reference,1,position(' ' in reference))) = :cod_dimp
                                     and  trim(substr(reference,position(' ' in reference))) = :iter_dbn 
                                          limit 1"] == 0} {
	set url_vars [ad_get_client_property -default "" iter-portal admin/transactions]
	ad_returnredirect -message "ATTENZIONE! I dati provenienti da iter tramite mail non corrispondono a nessun movimento da stornare. Probabilmente si e' richiesto lo storno di una dichiarazione da parte di soggetto senza portafoglio. Verificare!" transactions?$url_vars
	ad_script_abort

    }
} else {
    if {[db_0or1row query "select amount
                                                   ,holder_id as holder_id_old 
                                                   ,trim(substr(reference,1,position(' ' in reference))) as cod_dimp
                                                   ,trim(substr(reference,position(' ' in reference))) as iter_dbn
                                    from  wal_transactions 
                                   where  tran_id = :tran_id 
                                          limit 1"] == 0} {
	set url_vars [ad_get_client_property -default "" iter-portal admin/transactions]
	ad_returnredirect -message "ATTENZIONE! Il movimento risulta cancellato. Contattare assistenza!" transactions?$url_vars
	ad_script_abort
	
    }
}


# controllo che il movimento da stornare non sia a sua volta uno storno!
#set reason [db_string check "select reason from wal_transactions where tran_id = :tran_id"]

db_1row query "select reason
                    , ref_tran_id
                    , tran_type_id
                 from wal_transactions
                where tran_id = :tran_id"


if {$reason ne ""} {
    # retrieve eventual url vars setting
    set url_vars [ad_get_client_property -default "" iter-portal admin/transactions]
    ad_returnredirect -message "ATTENZIONE! Non è possibile stornare uno storno!" transactions?$url_vars
    ad_script_abort
}

#Sandro ha detto che non si può stornare un movimento già stornato
if {$ref_tran_id ne ""} {
    set messaggio "ATTENZIONE! Non è possibile stornare un movimento già stornato!"
    set url_vars [export_url_vars caller nome_funz messaggio f_ente_portafoglio];#gab01 aggiunto f_ente_portafoglio

    ad_returnredirect -message $messaggio transactions?$url_vars
    ad_script_abort

}

# controllo saldo portafoglio del manutentore se esiste una dichiarazione sostitutiva


# se l'utente che ha inserito la dichiarazione sostitutiva e' un amministratore prendo il codice dell'utente come
# codice per collegarmi all'holder del movimento da inserire
# altrimenti se il responsabile e' un terzo prendo il codice manutentore  il cui rappresentante legale e' il 
# terzo responsabile
# altrimenti se il responsabile e' un amministratore prendo il codice dell'amministratore
# altrimenti prendo il codice manutentore della dichiarazione      

if {[db_0or1row -dbn $iter_dbn query "select utente_ins
                                            ,substr(utente,1,2) as inizuser
                                            ,cod_impianto           
                                        from coimdimp_stn 
                                       where cod_dimp = :cod_dimp"] == 1} {
    set cod_manu ""
    if {$inizuser == "AM"} {
	set cod_manu $utente
    }
    if {[string equal $cod_manu ""]} {
	if {[db_0or1row -dbn $iter_dbn sel_terzo "select cod_responsabile as cod_terz from coimaimp where cod_impianto = :cod_impianto and flag_resp = 'T'"] == 1} {
	    db_1row -dbn $iter_dbn sel_manu_leg "select cod_manutentore as cod_manu from coimmanu where cod_legale_rapp = :cod_terz"
	    
	} else {
	    if {[db_0or1row -dbn $iter_dbn sel_am "select cod_responsabile as cod_ammin from coimaimp where cod_impianto = :cod_impianto and flag_resp = 'A'"] == 1} {
		set cod_manu $cod_ammin
	    } else {
		if {[db_0or1row -dbn $iter_dbn sel_am "select cod_manutentore from coimaimp where cod_impianto = :cod_impianto"] == 1} {
		    set cod_manu $cod_manutentore
		}
	    }
	}
    }

# prendo codice manutentore   
    #rom01set holder_id [db_string holder "select holder_id from wal_holders where 'MA' || lpad(cast(holder_id as varchar(10)),6,0) = :cod_manu" -default 0]

    set holder_id [db_string holder "
                  select holder_id
                    from wal_holders
                   where 'MA' || lpad(cast(holder_id as varchar(10)),6,0) = :cod_manu
                     and instance_name = :iter_dbn" -default 0];#rom01

# se manutentore senza portafoglio blocco storno (in presenza di dichiarazione sostitutiva)  
    if {$holder_id == 0} {
	    set url_vars [ad_get_client_property -default "" iter-portal admin/transactions]
	    ad_returnredirect -message "Manutentore dichiarazione sostitutiva privo di portafoglio! Storno annullato" transactions?$url_vars
	    ad_script_abort
    }

# prendo saldo del manutentore  
    set balance [db_string bal "
         select coalesce(
                     sum(
                        case 
                        when t.sign = '+' then amount
                        else amount * -1
                         end), 0.00)
          from wal_transactions m, wal_transaction_types t
         where m.holder_id    = :holder_id
           and m.tran_type_id = t.tran_type_id" -default 0] 

# se il manutentore non e' cambiato aggiungo al saldo l'importo della dichiarazione da stornare  
    if {$holder_id == $holder_id_old} {
	set balance [expr $balance + $amount]
    }
#
# prendo i limiti per il portafoglio  
    db_1row -dbn $iter_dbn sel_limiti_tgen "select flag_limite_portaf, valore_limite_portaf from coimtgen"

# se saldo inadeguato blocco storno  
    if {$flag_limite_portaf == "S"} {
	if {$balance < $valore_limite_portaf} {
	    set url_vars [ad_get_client_property -default "" iter-portal admin/transactions]
	    ad_returnredirect -message "Credito insufficiente per inserimento dichiarazione sostitutiva! Storno annullato" transactions?$url_vars
	    ad_script_abort
	    
	}
    }
}

set page_title "Storno movimento"
set context [list [list admin Administration] [list transactions "Lista movimenti"] "$page_title"]

set user_id [ad_conn user_id]

ad_form \
    -name storno \
    -action storno-2 \
    -export {tran_id user_id f_ente_portafoglio} \
    -edit_buttons [list [list "Conferma lo storno" go]] \
    -form {
        {reason:text(textarea),nospell 
            {label {Causale dello storno}}
            {html {rows 5 cols 50 wrap soft}}
        }
	
    } 
