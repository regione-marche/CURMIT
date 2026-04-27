ad_library {

    Holders Procs.

    @author Simone Pesci                      
    @cvs-id $Id:

}

ad_proc -public MPAY_crea_buffer {
    bufferdati
} { 
} {
    

    set current_timestamp             [db_string q "select to_char(current_timestamp,'yyyyMMddHH24mi')"]
    set portaleid                     "PortaleMARBOL"

    set hash_md5 [MPAY_crea_hash $bufferdati $current_timestamp]
    
    #set hash_md5 [::md5::md5 -hex $hash_response]
    
    #set hash_md5 [db_string q "select lower(:hash_md5)"]
       
    set bufferdati_base64 [::base64::encode $bufferdati]


    set bufferdati_base64 [regsub -all \r $bufferdati_base64 ""]
    set bufferdati_base64 [regsub -all \n $bufferdati_base64 ""]

    
    set buffer "<Buffer>
<TagOrario>$current_timestamp</TagOrario>
<CodicePortale>$portaleid</CodicePortale>
<BufferDati>$bufferdati_base64</BufferDati>
<Hash>$hash_md5</Hash>
</Buffer>"
    
    set buffer [regsub -all \r $buffer ""]
    set buffer [regsub -all \n $buffer ""]
    
    set buffer [regsub -all "\\+" $buffer "%2B"]

    return $buffer
        
}

ad_proc -public MPAY_crea_hash {
    bufferdati
    current_timestamp
} {
} {

    set encryptIV   ""
    set encryptKey  ""
    

    set hash $encryptIV$bufferdati$encryptKey$current_timestamp
    
    set hash_md5 [::md5::md5 -hex $hash]
    
    set hash_md5 [db_string q "select lower(:hash_md5)"]

    return $hash_md5

}

ad_proc -public MPAY_call_ws {
    buffer
    end_point
    caller
    xml_request
} {
} {

    
    set spool_dir          "[acs_root_dir]/packages/wallet/www/MPAY/log"
    
    set nome_file_temp     $caller
    set path_file_input    "$spool_dir/${nome_file_temp}-input.xml"
    set path_file_response "$spool_dir/${nome_file_temp}-response.xml"
    set path_file_trace    "$spool_dir/${nome_file_temp}-trace.txt"
    set path_file_xml    "$spool_dir/${nome_file_temp}-xml.txt"
    set path_file_paymentrequest "$spool_dir/${nome_file_temp}-paymentrequest.xml"

    #if {1==0} {#sim li attivo solo per i test
    set         file_id [open $path_file_paymentrequest w]
    fconfigure $file_id -encoding utf-8
    puts       $file_id $xml_request
    close      $file_id
    
    set         file_id [open $path_file_input w]
    puts       $file_id "buffer=$buffer"
    close      $file_id
    #}

    # Parametro -k: This  option explicitly allows curl to perform "insecure"
    #               SSL connections and transfers (altrimenti errore certificato)
    # Parametri -H: Impostano alcuni header:
    #               Content-type va specificato per indicare il formato dei dati (-d)
    # Parametro -d: Sends  the  specified data in a POST request
    # Parametro --trace-ascii: Scrive nel file indicato il trace della chiamata
    
    # Curl scrive sempre una progress meter nello stderr
    # Per questo motivo, va fatta la catch ed ignorato l'errore
    # La response viene scritta nel file indicato dopo il >
    
    #sim_test set end_point "$end_point?buffet=$buffer"
    
    exec curl \
            -vs \
	-k \
	-d @$path_file_input \
	-X POST \
	--connect-timeout 100 \
	--trace-ascii $path_file_trace \
	$end_point > $path_file_response
    
if {[file exists $path_file_trace]} {
    set file_id  [open $path_file_trace r]
    fconfigure   $file_id -encoding utf-8
    set trace    [read $file_id]
    close        $file_id
    ns_log Notice "invoke;call_payment_request;step13;trace:$trace"
} else {
    set trace     ""
}

return $path_file_response

}
