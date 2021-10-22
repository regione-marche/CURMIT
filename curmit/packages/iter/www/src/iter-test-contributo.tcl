ad_page_contract {
 @author dob
} {
    cod_manutentore
    {da_data "20090801"}
    {a_data "30000101"}
}     
ns_log notice "prova dob 1 iter-test-contributo inizio programma cod_manutentore $cod_manutentore da_data $da_data a_data $a_data" 

set flag_portafoglio [db_string query "select flag_portafoglio from coimtgen"]

set permanenti_dir [iter_set_permanenti_dir]
set file_esi_name  "Esito-controllo-contributo" 
set file_esi_name  [iter_temp_file_name -permanenti $file_esi_name]
set file_esi       "${permanenti_dir}/$file_esi_name.adp"

if {[catch {set file_esi_id [open $file_esi w]}]} {
    iter_return_complaint "File esito controllo contributo non aperto: $file_esi"
}
fconfigure $file_esi_id -encoding iso8859-1 -translation crlf

set iter_dbn [db_get_database]
if {$iter_dbn eq "iterrl-dev"} {
    set wallet_dbn "wallet-dev"
} elseif {$iter_dbn eq "iterrl-sta"} {
    set wallet_dbn "wallet-sta"
} else {
    set wallet_dbn "wallet"
}

set count_corretti 0
set count_scartati 0
set count_totale 0
set pagina ""

ns_log notice "prova dob 2 iter-test-contributo wallet_dbn $wallet_dbn iter_dbn $iter_dbn" 

db_foreach query "select a.cod_dimp,
                         a.data_controllo,
                         b.data_installaz,
                         b.cod_impianto_est
                    from coimdimp a,
                         coimaimp b
                   where a.cod_impianto = b.cod_impianto
                     and a.cod_manutentore = :cod_manutentore
                     and a.data_controllo between :da_data and :a_data
                order by a.data_controllo,b.cod_impianto" {


    incr count_totali
    set data_insta_check "1900-01-01"
    if {![string equal $data_installaz ""]} {
	set data_insta_check [db_string sel_dat "select to_char(add_months(:data_installaz, '1'), 'yyyy-mm-dd')"]
    }					
    
ns_log notice "prova dob 3 iter-test-contributo letto dimp $cod_dimp $data_controllo $data_installaz $data_insta_check $cod_impianto_est" 
    if {$data_controllo >= $data_insta_check} {
	if {[db_0or1row -dbn $wallet_dbn query "select tran_id
                                           ,amount
                                           ,holder_id as holder_id_old 
                                    from  wal_transactions 
                                   where  trim(substr(reference,1,position(' ' in reference))) = :cod_dimp
                                     and  trim(substr(reference,position(' ' in reference))) = :iter_dbn 
                                          limit 1"] == 0} {
	    append pagina "<tr><td>$data_controllo</td><td>$cod_impianto_est</td><td>$data_installaz</td><td>$cod_dimp</td></tr>"
	    incr count_scartati	    
	} 
    } else {
	incr count_corretti
    }
}

set page_title "Esito analisi scarico contributi per il manutentore $cod_manutentore dal $da_data al $a_data"
set context_bar [iter_context_bar \
		     [list "javascript:window.close()" "Chiudi finestra"] \
		     "$page_title"]

set pagina_esi [subst {
    <master   src="../../master">
    <property name="title">$page_title</property>
    <property name="context_bar">$context_bar</property>
    
    <center>
    
    <table>
    <tr><td colspan=4><b>ELABORAZIONE TERMINATA (manutentore: $cod_manutentore) </b></td></tr>

    $pagina

    <tr><td colspan=4>Modelli totali letti: $count_totale</td></tr>
    <tr><td colspan=4>Modelli con scarico portafoglio non previsto: $count_corretti</td></tr>
    <tr><td colspan=4>Modelli in cui manca lo scarico contributo: $count_scartati</td></tr>
    <tr><td colspan=4>&nbsp;</td><tr>

    $pagina

    </table>
}]
    

puts $file_esi_id $pagina_esi

close $file_esi_id

ad_return_template "../permanenti/$file_esi_name"


