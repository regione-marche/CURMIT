ad_page_contract {

  Storna movimenti PORTAFOGLIO CAIT.

  @author        Gabriele Lo Vaglio
  @creation-date 23/06/2017
  @cvs-id        storno-recharge-cait.tcl

} {
    {rec_id:integer,multiple ""}
    {iter_dbn     ""}
}

if {[llength $rec_id] == 0} {
    set messaggio "Selezionare il movimento da stornare"
    ad_returnredirect -message $messaggio recharge-cait
    ad_script_abort    
}
if {[llength $rec_id] != 1} {
    
    set messaggio "L'operazione di storno puo'essere applicata ad un solo movimento per volta!"
    ad_returnredirect -message $messaggio recharge-cait
    ad_script_abort
}
 
 
if {[db_0or1row query "select amount 
                         from  wal_recharge_cait 
                        where  rec_id = :rec_id 
                               limit 1"] == 0} {
    set url_vars [ad_get_client_property -default "" iter-portal admin/recharge-cait]
    ad_returnredirect -message "ATTENZIONE! Il movimento risulta cancellato. Contattare assistenza!" recharge-cait?$url_vars
    ad_script_abort   
}


# controllo che il movimento da stornare non sia a sua volta uno storno!

db_1row query "select reason
                    , ref_rec_id
                    , tran_type_id
                    , flag_storno
                    , wallet_tran_id
                 from wal_recharge_cait
                where rec_id = :rec_id"


if {$flag_storno ne "f"} {
    # retrieve eventual url vars setting
    set url_vars [ad_get_client_property -default "" iter-portal admin/recharge-cait]
    ad_returnredirect -message "ATTENZIONE! Non è possibile stornare uno storno!" recharge-cait?$url_vars
    ad_script_abort
}

#Sandro ha detto che non si può stornare un movimento già stornato
if {$tran_type_id == 1 && $ref_rec_id ne ""} {
    set messaggio "ATTENZIONE! Non è possibile stornare un movimento già stornato!"
    set url_vars [export_url_vars caller nome_funz messaggio]

    ad_returnredirect -message $messaggio recharge-cait?$url_vars
    ad_script_abort

}

if {$tran_type_id == 2} {
    set url_vars [ad_get_client_property -default "" iter-portal admin/recharge-cait]
    ad_returnredirect -message "ATTENZIONE! E' possibile stornare un versamento al manutentore solo dalla <a href=\"transactions?f_tran_id=$wallet_tran_id\">lista movimenti</a>" -html  recharge-cait?$url_vars
    ad_script_abort
}

set page_title "Storno movimento"
set context [list [list admin Administration] [list recharge-cait "Lista movimenti"] "$page_title"]

set user_id [ad_conn user_id]

ad_form \
    -name storno-recharge-cait \
    -action storno-2-recharge-cait \
    -export {rec_id user_id} \
    -edit_buttons [list [list "Conferma lo storno" go]] \
    -form {
        {reason:text(textarea),nospell 
            {label {Causale dello storno}}
            {html {rows 5 cols 50 wrap soft}}
        }
	
    } 
