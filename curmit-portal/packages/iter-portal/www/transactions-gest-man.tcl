ad_page_contract {
    Add/Edit/Delete                                   
    @author          Simone Pesci   
    @creation-date   14/03/2016

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimmanu-gest.tcl


    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom03 10/11/2022 La Citta' Metropolitana di Palermo ha chiesto che non sia possibile caricare
    rom03            importi inferiori a 90 Euro. Prima erano di 150 Euro.

    rom02 10/11/2022 La Citta' Metropolitana di Palermo ha chiesto che non sia possibile caricare
    rom02            importi inferiori a 150 Euro.

    rom01 09/03/2021 Il Comune di Salerno (Sinergia) ha chiesto che non sia possibile caricare
    rom01            importi inferiori a 80 Euro.

    gab01 10/04/2018 Ricevo il parametro f_ente_portafoglio per l'eventuale gestione del 
    gab01            multiportafoglio

    sim03 01/03/2019 Regione Calabria ha chiesto che non sia possibile caricare importi minori
    sim03            di 200 euro

    sim02 20/10/2016 La data di versamento deve essere prevalorizzata ad oggi e deve essere non modificabile

    sim01 12/10/2016 Aggiunto gestione della ricarica da parte del manutentore

} {
   
   {f_ente_portafoglio ""}
   {funzione  "I"}
   {caller    "index"}
   {nome_funz ""}
   {nome_funz_caller ""}
   {extra_par ""}
   {url_manu      ""}
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set maintainer_id [iter::script_init]
if {[string equal $maintainer_id "0"]} {
    ad_returnredirect services
}

set sw_multi_portafoglio [parameter::get_from_package_key -package_key wallet -parameter sw_multi_portafoglio -default 0];#gab01

if {$sw_multi_portafoglio} {;#gab01 aggiunta if, else e contenuto
    
    set where_controlli_multiportafoglio   "and instance_name = :f_ente_portafoglio"

    if {![db_0or1row q "select g.group_name as nome_ente_portafoglio
                          from groups g
                             , iter_instances i
                         where g.group_id = i.instance_id
                           and i.instance_name = :f_ente_portafoglio"]} {

        ad_returnredirect -message "ATTENZIONE! E' necessario selezionare un ente portafoglio" "ec-filter?maintainer_id=$maintainer_id"
        ad_script_abort

    }

    set mess_err_multiportafoglio "per l'ente: $nome_ente_portafoglio"
} else {
    set where_controlli_multiportafoglio   ""
    set nome_ente_portafoglio              ""
    set mess_err_multiportafoglio          ""
}

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set button_label "Conferma Inserimento"
set page_title   "Inserimento movimento"
set context [list  "$page_title"]

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "transactions"
set readonly_key "readonly"
set readonly_fld "readonly"
set disabled_fld "disabled"
set onsubmit_cmd ""

form create $form_name \
-html    $onsubmit_cmd

set l_of_l_manu [db_list_of_lists query "select name
                                              , iter_code 
                                           from iter_maintainers 
                                          where maintainer_id = :maintainer_id"]

set payment_date [db_string q "select to_char(current_date,'DD/MM/YYYY')"];#sim02

element create $form_name cognome_manu \
    -label   "Manutentore" \
    -widget   select \
    -datatype text \
    -html     "display {}" \
    -options  $l_of_l_manu \
    -optional

element create $form_name amount \
    -label "Importo" \
    -widget text \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -optional

#sim02 aggiunto value e cambiato widget da text a inform
element create $form_name payment_date \
    -label "Data versamento" \
    -widget inform \
    -datatype text \
    -html    "size 10 maxlength 10 class form_element" \
    -value $payment_date \
    -optional

element create $form_name saldo_manu       -widget hidden -datatype text -optional
element create $form_name cod_portafoglio  -widget hidden -datatype text -optional

element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name extra_par -widget hidden -datatype text -optional
element create $form_name submit    -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name cod_manutentore  -widget hidden -datatype text -optional
element create $form_name f_ente_portafoglio  -widget hidden -datatype text -optional;#gab01

if {[form is_request $form_name]} {

    element set_properties $form_name funzione  -value $funzione
    element set_properties $form_name caller    -value $caller
    element set_properties $form_name nome_funz -value $nome_funz
    element set_properties $form_name extra_par -value $extra_par
    element set_properties $form_name f_ente_portafoglio  -value $f_ente_portafoglio;#gab01

}

if {[form is_valid $form_name]} {
  # form valido dal punto di vista del templating system

    set cognome_manu           [element::get_value $form_name cognome_manu]
    set amount                 [string trim [element::get_value $form_name amount]]
    #set description           [string trim [element::get_value $form_name description]]
    set cod_portafoglio        [string trim [element::get_value $form_name cod_portafoglio]]
    set payment_date           [string trim [element::get_value $form_name payment_date]]
    set f_ente_portafoglio     [element::get_value $form_name f_ente_portafoglio];#gab01

    set cod_manutentore $cognome_manu

    # controlli standard su numeri e date, per Ins ed Upd
    set error_num 0

    #sim if {![db_0or1row query "select iter_code as cod_manutentore
    #sim                          from iter_maintainers
    #sim                         where name = upper(:cognome_manu)"]} {  ;#sim }
    if {$cod_manutentore eq ""} {
	
	element::set_error $form_name cognome_manu "Soggetto non trovato"
	incr error_num
	
    } else {
    
	if {![db_0or1row q "select wallet_id 
                              from wal_holders
                             where 'MA' || lpad(cast(holder_id as varchar(10)),6,0) =:cod_manutentore
                               $where_controlli_multiportafoglio --gab01
                               and wallet_id is not null"]} {
	    element::set_error $form_name cognome_manu "Nessun portafoglio associato al manutentore $cod_manutentore $mess_err_multiportafoglio";#gab01 aggiunto mess_err_multiportafoglio
	    incr error_num
	}
    }

    if {[string equal $amount ""]} {
	element::set_error $form_name amount "Inserire l'importo"
	incr error_num
    } else {
        set amount [iter_check_num $amount 2]
        if {$amount == "Error"} {
            element::set_error $form_name amount "Deve essere numerico, max 2 dec"
            incr error_num
	} else {#sim03 else e suo contenuto

	    if {[db_get_database] eq "iter-portal-calabria"} {
		if {$amount < 200} {
		    element::set_error $form_name amount "Impossibile inserire un importo inferiore a 200 Euro"
		    incr error_num
	    
		}
	    }

	    if {[db_get_database] eq "iter-portal-sinergia"} {#rom01 Aggiunta if e suo contenuto
		if {$amount < 80} {
		    element::set_error $form_name amount "Impossibile inserire un importo inferiore a 80 Euro."
		    incr error_num
		}
	    }
	    
	    if {[db_get_database] eq "iter-portal-palermo"} {#rom02 Aggiunta if e suo contenuto
		#rom03 Messo il limite da 150 a 90 euro.
                if {$amount < 90} {
                    element::set_error $form_name amount "Impossibile inserire un importo inferiore a 90 Euro."
                    incr error_num
                }
            }
	}
    }
    if {[string equal $payment_date ""]} {
            element::set_error $form_name payment_date "Inserire data versamento"
            incr error_num
    } else {
	set payment_date [iter_check_date $payment_date]
	if {$payment_date == 0} {
                element::set_error $form_name payment_date "Data versamento deve essere una data"
                incr error_num
	}
    }

    if {[db_0or1row q "select 1 
                         from wal_transactions
                        where 'MA' || lpad(cast(holder_id as varchar(10)),6,0) = :cod_manutentore
                          and status = 'L'
                          $where_controlli_multiportafoglio --gab01
                        limit 1"]} {

	element::set_error $form_name cognome_manu "Esiste già un versamento in lavorazione per questo manutentore $mess_err_multiportafoglio";#gab01 aggiunto mess_err_multiportafoglio
	incr error_num

    } 

    #if {[string equal $description ""]} {
	#element::set_error $form_name description "Inserire estremi del versamento"
	#incr error_num
    #}


    if {$error_num > 0} {
        ad_return_template
        return
    }

    set payment_date [db_string q "select :payment_date::date"]  

    set reference ""
    set oggi [db_string sel_date "select current_date"]

    set description "Ricarica portafoglio";#sim01
    set link_description [export_vars {description}]    

    #se creo il movimento come manutentore va fatto sempre inserito con stato L
    set status "L"
    #gab01 passo al web service anche f_ente_portafoglio
    set url "lotto/itermove?iter_code=$cod_manutentore&body_id=&tran_type_id=1&payment_type=1&payment_date=$payment_date&reference=$reference&$link_description&amount=$amount&status=$status&ente_portafoglio=$f_ente_portafoglio"

    set data [iter_httpget_wallet $url]

    array set result $data
    
    set risultato [string range $result(page) 0 [expr [string first " " $result(page)] - 1]]
    if {$risultato == "OK"} {
	set transaz_eff "T"
    } else {
	element::set_error $form_name cognome_manu "ATTENZIONE transazione non avvenuta correttamente"
	ad_return_template
	return
    }
       
    set return_url "ec?maintainer_id=$maintainer_id&f_ente_portafoglio=$f_ente_portafoglio";#gab01 passo anche f_ente_portafoglio

ad_returnredirect $return_url
ad_script_abort
}

ad_return_template
