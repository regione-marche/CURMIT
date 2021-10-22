ad_page_contract {

  Storna movimenti PORTAFOGLIO ELETTRONICO manutentori etc.

  @author        Claudio pasolini
  @creation-date 2008-08-05
  @cvs-id        storno.tcl

} {
    {tran_id:integer,multiple ""}
    {cod_dimp     ""}
    {iter_dbn     ""}
    {extra_par    ""}
    {nome_funz    ""}
    {nome_funz_caller ""}
    {caller    "index"}
}

set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set page_title "Storno movimento"
set context [list  "$page_title"]

if {$caller == "index"} {
    set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
} else {
    set context_bar  [iter_context_bar \
                          [list "javascript:window.close()" "Torna alla Gestione"] \
                          "$page_title"]
}

set form_name    "storno"
set button_label "Conferma lo storno"

set readonly_key \{\}
set readonly_fld \{\}
set disabled_fld \{\}
set onsubmit_cmd ""
form create $form_name \
-html    $onsubmit_cmd

element create $form_name reason \
    -label   "Causale dello storno" \
    -widget   textarea \
    -datatype text \
    -html    "cols 50 rows 5 class form_element" \
    -optional

element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name tran_id   -widget hidden -datatype text -optional

if {[form is_request $form_name]} {

    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name tran_id   -value $tran_id
    
    #Aggiunto controllo che venga passato almeno un movimento
    if {[llength $tran_id] == 0} {
	set messaggio "Selezionare il movimento da stornare"
        set url_vars [export_url_vars caller nome_funz messaggio]
        ad_returnredirect "transactions?$url_vars"
	ad_script_abort
    }
    if {[llength $tran_id] != 1} {
	
	set messaggio "L'operazione di storno puo'essere applicata ad un solo movimento per volta!"
	set url_vars [export_url_vars caller nome_funz messaggio]
	ad_returnredirect "transactions?$url_vars"
	
	#    ad_return_complaint 1 "<li>L'operazione di storno puo'essere applicata ad un solo movimento per volta!"
	ad_script_abort
	ad_return_template
    }
    
    set link_list_script {[export_url_vars caller nome_funz nome_funz_caller]&[iter_set_url_vars $extra_par]}
    set link_list        [subst $link_list_script]

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
	set messaggio "ATTENZIONE! I dati provenienti da iter tramite mail non corrispondono a nessun movimento da stornare. Probabilmente si e' richiesto lo storno di una dichiarazione da parte di soggetto senza portafoglio. Verificare!"
	set url_vars [export_url_vars caller nome_funz messaggio]
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
	set messaggio "ATTENZIONE! Il movimento risulta cancellato. Contattare assistenza!"
	set url_vars [export_url_vars caller nome_funz messaggio]
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
    set messaggio "ATTENZIONE! Non è possibile stornare uno storno!"
    set url_vars [export_url_vars caller nome_funz messaggio]

    ad_returnredirect -message "ATTENZIONE! Non è possibile stornare uno storno!" transactions?$url_vars
    ad_script_abort
}

#Sandro ha detto che non si può stornare un movimento già stornato
if {$ref_tran_id ne ""} {
    set messaggio "ATTENZIONE! Non è possibile stornare un movimento già stornato!"
    set url_vars [export_url_vars caller nome_funz messaggio]

    ad_returnredirect transactions?$url_vars
    ad_script_abort

}
#Sandro ha detto che non si può stornare un movimento già stornato
# controllo saldo portafoglio del manutentore se esiste una dichiarazione sostitutiva


# se l'utente che ha inserito la dichiarazione sostitutiva e' un amministratore prendo il codice dell'utente come
# codice per collegarmi all'holder del movimento da inserire
# altrimenti se il responsabile e' un terzo prendo il codice manutentore  il cui rappresentante legale e' il 
# terzo responsabile
# altrimenti se il responsabile e' un amministratore prendo il codice dell'amministratore
# altrimenti prendo il codice manutentore della dichiarazione      

if {[db_0or1row query "select utente_ins
                                            ,substr(utente,1,2) as inizuser
                                            ,cod_impianto           
                                        from coimdimp_stn 
                                       where cod_dimp = :cod_dimp"] == 1} {
    set cod_manu ""
    if {$inizuser == "AM"} {
	set cod_manu $utente
    }
    if {[string equal $cod_manu ""]} {
	if {[db_0or1row sel_terzo "select cod_responsabile as cod_terz 
                                     from coimaimp 
                                    where cod_impianto = :cod_impianto 
                                      and flag_resp = 'T'"] == 1} {
	    db_1row sel_manu_leg "select cod_manutentore as cod_manu 
                                    from coimmanu 
                                   where cod_legale_rapp = :cod_terz"
	    
	} else {
	    if {[db_0or1row sel_am "select cod_responsabile as cod_ammin 
                                      from coimaimp 
                                     where cod_impianto = :cod_impianto
                                       and flag_resp = 'A'"] == 1} {
		set cod_manu $cod_ammin
	    } else {
		if {[db_0or1row sel_am "select cod_manutentore from coimaimp where cod_impianto = :cod_impianto"] == 1} {
		    set cod_manu $cod_manutentore
		}
	    }
	}
    }

# prendo codice manutentore curit  
    set holder_id [db_string holder "select holder_id
                                       from coimmanu
                                          , wal_holders 
                                      where cod_manutentore = :cod_manu
                                        and 'MA' || cast(holder_id as varchar(10)) = cod_manutentore" -default 0]

# se manutentore senza portafoglio blocco storno (in presenza di dichiarazione sostitutiva)  
    if {$holder_id == 0} {
	set messaggio "Manutentore dichiarazione sostitutiva privo di portafoglio! Storno annullato"
	set url_vars [export_url_vars caller nome_funz messaggio]
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
    db_1row sel_limiti_tgen "select flag_limite_portaf, valore_limite_portaf from coimtgen"

# se saldo inadeguato blocco storno  
    if {$flag_limite_portaf == "S"} {
	if {$balance < $valore_limite_portaf} {
	    set messaggio "Credito insufficiente per inserimento dichiarazione sostitutiva! Storno annullato"
	    set url_vars [export_url_vars caller nome_funz messaggio]
	    ad_returnredirect -message "Credito insufficiente per inserimento dichiarazione sostitutiva! Storno annullato" transactions?$url_vars
	    ad_script_abort
	    
	}
    }
}

}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system
    set reason  [string trim [element::get_value $form_name reason]]

    set user_id $id_utente
    set link_redirect [export_url_vars caller nome_funz receiving_element tran_id user_id reason extra_par]
    set return_url "storno-2?$link_redirect"
    
    ad_returnredirect $return_url
    ad_script_abort
}
ad_return_template

