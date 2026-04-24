ad_page_contract {

  Storna movimenti PORTAFOGLIO CAIT.

  @author        Gabriele Lo Vaglio
  @creation-date 23-06-2017
  @cvs-id        storno-2-recharge-cait.tcl

} {
    rec_id
    user_id
    reason
}

#dati per lo storno
set data_storno [ah::today_ansi]
set email [db_string party "select email from parties where party_id = :user_id"]
set now   [db_string now   "select to_char(current_timestamp, 'DD/MM/YYYY HH24:MI')"]
set reason [concat "$now - $email - $reason"]

#leggo movimento da stornare
db_1row movement "select  cait_id
                                         ,tran_type_id
                                         ,pay_type_id         
                                         ,payment_date
                                         ,creation_date      
                                         ,'storno ' || description as description  
                                         ,amount
                                         ,ref_rec_id
                                         ,num_reversale
                                         ,anno_reversale
                                         ,cro
                                         ,num_ordine          
                                         ,currency_date 
                                    from  wal_recharge_cait 
                                   where  rec_id  = :rec_id"

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
set mm_description [ad_urlencode $description]
set mm_reason [ad_urlencode $reason]
set url lotto/move-recharge-cait?cait_id=$cait_id&tran_type_id=$tran_type_id_storno&payment_type=C&payment_date=$data_storno&description=$mm_description&amount=$amount&reason=$mm_reason

set data [iter_httpget_wallet $url]

array set result $data
util_unlist $result(page) retcode ref_rec_id
if {$retcode ne "OK"} {
    ad_return_complaint 1 "<li>Si è verificato un errore imprevisto nell'inserimento del movimento di storno : $retcode"
    ad_script_abort
}
db_dml upd_mov "
        update wal_recharge_cait 
           set ref_rec_id = :ref_rec_id
         where rec_id = :rec_id"

set url_vars [ad_get_client_property -default "" iter-portal recharge-cait] 
ad_returnredirect -message "Il movimento è stato stornato." "recharge-cait?$url_vars"
ad_script_abort

