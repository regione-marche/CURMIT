ad_proc iter-stat-gen-dich {
	{
	-cod_batc   ""	
   	-f_data1_it ""
   	-f_data2_it ""	
	-f_data1    ""
   	-f_data2    ""
	
    }
} {
	# aggiorno stato di coimbatc
    iter_batch_upd_flg_sta -iniz $cod_batc
	ns_log Notice "Inizio della procedura iter-stat-gen-dich-proc"
	
	#crea statistiche per ente e per id_utente
	with_catch error_msg {
	    set nome_file        "Estrazione Statistiche - dichiarazioni"
		set nome_file         [iter_temp_file_name -permanenti $nome_file]
		set permanenti_dir     [iter_set_permanenti_dir]
		set permanenti_dir_url [iter_set_permanenti_dir_url]
		set file_csv         "$permanenti_dir/$nome_file.csv"
		set file_csv_url     "$permanenti_dir_url/$nome_file.csv"
		set file_id [open $file_csv w]
		fconfigure $file_id -encoding iso8859-1
					
		#imposto la prima riga
		set giorno ""
		lappend giorno "Dati Dal $f_data1_it Al $f_data2_it"
		iter_put_csv $file_id giorno
		
		# imposto la seconda riga del file csv
		set     head_cols ""
		lappend head_cols "Ente"
		lappend head_cols "ID Utente"
		lappend head_cols "Cogn.Utente"
              lappend head_cols "Nome.Utente"
		lappend head_cols "N°dichiarazioni"
		iter_put_csv $file_id head_cols
			
		# crea la tabella
		db_foreach sel_database_enti "" {
			if {$nome_database ne ""} {
				with_catch error_msg {
					set ritorno ""
					lappend ritorno $denominazione_ente
					iter_put_csv $file_id ritorno  
					set utente [list "UPA" "CLAAI" "CNA" "ASSO" "ASSI"]
					foreach u $utente {
						set query [exec psql $nome_database -h 10.252.10.3 -c "
								select a.id_utente,a.cognome,a.nome,count(b.*) 
								from coimuten a left outer join coimdimp b on a.id_utente=b.utente_ins 
								where b.data_controllo between '$f_data1' and '$f_data2' and b.utente_ins like '$u%' 
								group by a.id_utente,a.cognome,a.nome
								order by a.id_utente"]
						# suddivide la risposta della query in righe(ogni riga è un elemento della lista)
						set row 	[split $query "\n"]
						set count 	[llength $row]
						for {set r 2} {$r < $count - 2} {incr r} {
							# suddivide la riga in colonne
							set column 		[split [lindex $row $r] "|"]
							set id_utente 	[string trim [set id_utente [lindex $column 0]]]
							set cognome 	[string trim [set cognome [lindex $column 1]]]
							set nome 		[string trim [set nome [lindex $column 2]]]
							set count_dimp 	[set count_dimp [lindex $column 3]]
							# solo per la prima riga di ogni ente ne visualizza la denominazione
							set ritorno ""
							lappend ritorno " " $id_utente $cognome $nome $count_dimp  
							iter_put_csv $file_id ritorno 
						}
					}
					set ritorno ""
					iter_put_csv $file_id ritorno
				} {ns_log Notice "errore: $error_msg"}
			}
		}
			
		# chiudo file csv
		close $file_id
		
		set esit_riga     [list "Statistiche - dichiarazioni" $file_csv_url $file_csv]
	    set esit_list     ""
		lappend esit_list $esit_riga
		iter_batch_upd_flg_sta -fine $cod_batc $esit_list

    } {
        iter_batch_upd_flg_sta -abend $cod_batc
        ns_log Error "iter_stat_gen_dich-proc: $error_msg"
    }
    
	ns_log Notice "Fine della procedura iter-stat-gen-dich-proc"
    return

}



