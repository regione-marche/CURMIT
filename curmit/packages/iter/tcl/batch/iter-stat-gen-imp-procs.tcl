ad_proc iter-stat-gen-imp {
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
	ns_log Notice "Inizio della procedura iter-stat-gen-imp-proc"
    
	with_catch error_msg {
	    set nome_file        "Estrazione Statistiche - impianti"
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
		lappend head_cols "Numero impianti"
		lappend head_cols "Impianti Attivi"
		lappend head_cols "Impianti Potenza > 0"
		lappend head_cols "Impianti Pot. Utile > 0"
		lappend head_cols "Impianti con Manut. Val."
		lappend head_cols "Numero generatori"
		lappend head_cols "Generatori Pot.Foc. > 0"
		lappend head_cols "Generatori Pot:Uti. > 0"
		lappend head_cols "Generatori Matr. val."
		lappend head_cols "Generatori Costr. Val."
		lappend head_cols "Numero Vie nel Viario"
		lappend head_cols "Numero Modelli"
		lappend head_cols "Modelli con manut. registrati"
		lappend head_cols "Modelli Temp.Fumi > 0"
		lappend head_cols "Modelli Temp.Amb. > 0"
		lappend head_cols "Modelli O2 > 0"
		lappend head_cols "Modelli CO2 > 0"
		lappend head_cols "Modelli Bacharach > 0"
		lappend head_cols "Modelli CO > 0"
		lappend head_cols "Modelli  Rend. Comb. > 0"
		lappend head_cols "Numero Verifiche"
		lappend head_cols "Allegati 2008 Man."
		lappend head_cols "Allegati 2008 Cait e altri"
		lappend head_cols "Confartigianato"
		lappend head_cols "CNA"
		lappend head_cols "CLAAI"
		lappend head_cols "ASSO"
              lappend head_cols "ASSISTAL"
		lappend head_cols "Modelli su Imp. > 35"
		lappend head_cols "Modelli su Imp > 35 <50"
		lappend head_cols "Modelli su imp.>50 <116"
		lappend head_cols "Modelli su imp.> 116 <350"
		lappend head_cols "Modelli su imp. > 350"
		lappend head_cols "Diff di 75 gg da ins. e data controllo"
              lappend head_cols "Fascia MA"
              lappend head_cols "Fascia C"
              lappend head_cols "Fascia MB"
              lappend head_cols "Fascia A"
              lappend head_cols "Fascia 0"
              lappend head_cols "Fascia B"
              lappend head_cols "Fascia nulla"
		iter_put_csv $file_id head_cols
		
		set tot_num_aimp 0
		set tot_num_att 0
		set tot_num_pot 0
		set tot_num_pot_uti 0
		set tot_num_manu 0
		set tot_num_gend 0
		set tot_num_gend_potf 0
		set tot_num_gend_potu 0
		set tot_num_gend_matr 0
		set tot_num_gend_cost 0
		set tot_num_dimp 0
		set tot_num_dimp_manu 0
		set tot_num_dimp_fumi 0
		set tot_num_dimp_o2 0
		set tot_num_dimp_co2 0
		set tot_num_dimp_co 0
		set tot_num_dimp_rend 0
		set tot_num_cimp 0
		
		db_foreach sel_database_enti "" {
			if {$nome_database ne ""} {
				with_catch error_msg {
					set dml_sql [db_map sel_aimp]
					set num_aimp [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_aimp "\n"]
					set num_aimp [string trim [set num_aimp [lindex $res 2]]]
					set tot_num_aimp [expr $tot_num_aimp + $num_aimp]
				
					set dml_sql [db_map sel_att]
					set num_att [exec psql $nome_database -h 10.252.10.3  -c $dml_sql]
					set res [split $num_att "\n"]
					set num_att [string trim [set num_att [lindex $res 2]]]
					set tot_num_att [expr $tot_num_att + $num_att]

					set dml_sql [db_map sel_pot]
					set num_pot [exec psql $nome_database -h 10.252.10.3  -c $dml_sql]
					set res [split $num_pot "\n"]
					set num_pot [string trim [set num_pot [lindex $res 2]]]
					set tot_num_pot [expr $tot_num_pot + $num_pot]
			
					set dml_sql [db_map sel_pot_uti]
					set num_pot_uti [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_pot_uti "\n"]
					set num_pot_uti [string trim [set num_pot_uti [lindex $res 2]]]
					set tot_num_pot_uti [expr $tot_num_pot_uti + $num_pot_uti]
				
					set dml_sql [db_map sel_manu]
					set num_manu [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_manu "\n"]
					set num_manu [string trim [set num_manu [lindex $res 2]]]
					set tot_num_manu [expr $tot_num_manu + $num_manu]

					set dml_sql [db_map sel_gend]
					set num_gend [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_gend "\n"]
					set num_gend [string trim [set num_gend [lindex $res 2]]]
					set tot_num_gend [expr $tot_num_gend + $num_gend]

					set dml_sql [db_map sel_gend_pots]
					set num_gend_potf [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_gend_potf "\n"]
					set num_gend_potf [string trim [set num_gend_potf [lindex $res 2]]]
					set tot_num_gend_potf [expr $tot_num_gend_potf + $num_gend_potf]

					set dml_sql [db_map sel_gend_potu]
					set num_gend_potu [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_gend_potu "\n"]
					set num_gend_potu [string trim [set num_gend_potu [lindex $res 2]]]
					set tot_num_gend_potu [expr $tot_num_gend_potu + $num_gend_potu]

					set dml_sql [db_map sel_gend_matr]
					set num_gend_matr [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_gend_matr "\n"]
					set num_gend_matr [string trim [set num_gend_matr [lindex $res 2]]]
					set tot_num_gend_matr [expr $tot_num_gend_matr + $num_gend_matr]

					set dml_sql [db_map sel_gend_cost]
					set num_gend_cost [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_gend_cost "\n"]
					set num_gend_cost [string trim [set num_gend_cost [lindex $res 2]]]
					set tot_num_gend_cost [expr $tot_num_gend_cost + $num_gend_cost]

					set dml_sql [db_map sel_viae]
					set num_viae [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_viae "\n"]
					set num_viae [string trim [set num_viae [lindex $res 2]]]

					set dml_sql [db_map sel_dimp]
					set num_dimp [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp "\n"]
					set num_dimp [string trim [set num_dimp [lindex $res 2]]]
					set tot_num_dimp [expr $tot_num_dimp + $num_dimp]

					set dml_sql [db_map sel_dimp_manu]
					set num_dimp_manu [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_manu "\n"]
					set num_dimp_manu [string trim [set num_dimp_manu [lindex $res 2]]]
					set tot_num_dimp_manu [expr $tot_num_dimp_manu + $num_dimp_manu]

					set dml_sql [db_map sel_dimp_fumi]
					set num_dimp_fumi [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_fumi "\n"]
					set num_dimp_fumi [string trim [set num_dimp_fumi [lindex $res 2]]]
					set tot_num_dimp_fumi [expr $tot_num_dimp_fumi + $num_dimp_fumi]

					set dml_sql [db_map sel_dimp_ambi]
					set num_dimp_ambi [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_ambi "\n"]
					set num_dimp_ambi [string trim [set num_dimp_ambi [lindex $res 2]]]

					set dml_sql [db_map sel_dimp_o2]
					set num_dimp_o2 [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_o2 "\n"]
					set num_dimp_o2 [string trim [set num_dimp_o2 [lindex $res 2]]]
					set tot_num_dimp_o2 [expr $tot_num_dimp_o2 + $num_dimp_o2]

					set dml_sql [db_map sel_dimp_co2]
					set num_dimp_co2 [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_co2 "\n"]
					set num_dimp_co2 [string trim [set num_dimp_co2 [lindex $res 2]]]
					set tot_num_dimp_co2 [expr $tot_num_dimp_co2 + $num_dimp_co2]

					set dml_sql [db_map sel_dimp_bach]
					set num_dimp_bach [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_bach "\n"]
					set num_dimp_bach [string trim [set num_dimp_bach [lindex $res 2]]]

					set dml_sql [db_map sel_dimp_co]
					set num_dimp_co [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_co "\n"]
					set num_dimp_co [string trim [set num_dimp_co [lindex $res 2]]]
					set tot_num_dimp_co [expr $tot_num_dimp_co + $num_dimp_co]

					set dml_sql [db_map sel_dimp_rend]
					set num_dimp_rend [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_rend "\n"]
					set num_dimp_rend [string trim [set num_dimp_rend [lindex $res 2]]]
					set tot_num_dimp_rend [expr $tot_num_dimp_rend + $num_dimp_rend]

					set dml_sql [db_map sel_cimp]
					set num_cimp [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_cimp "\n"]
					set num_cimp [string trim [set num_cimp [lindex $res 2]]]
					set tot_num_cimp [expr $tot_num_cimp + $num_cimp]

					set dml_sql [db_map sel_dimp_ma_2008]
					set num_dimp_ma_2008 [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_ma_2008 "\n"]
					set num_dimp_ma_2008 [string trim [set num_dimp_ma_2008 [lindex $res 2]]]

					set dml_sql [db_map sel_dimp_cait_2008]
					set num_dimp_cait_2008 [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_cait_2008 "\n"]
					set num_dimp_cait_2008 [string trim [set num_dimp_cait_2008 [lindex $res 2]]]

					set dml_sql [db_map sel_dimp_cait_upa]
					set num_dimp_cait_upa  [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_cait_upa "\n"]
					set num_dimp_cait_upa [string trim [set num_dimp_cait_upa [lindex $res 2]]]

					set dml_sql [db_map sel_dimp_cait_cna]
					set num_dimp_cait_cna  [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_cait_cna "\n"]
					set num_dimp_cait_cna [string trim [set num_dimp_cait_cna [lindex $res 2]]]

					set dml_sql [db_map sel_dimp_cait_claai]
					set num_dimp_cait_claai [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_cait_claai "\n"]
					set num_dimp_cait_claai [string trim [set num_dimp_cait_claai [lindex $res 2]]]

					set dml_sql [db_map sel_dimp_cait_asso]
					set num_dimp_cait_asso [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_cait_asso "\n"]
					set num_dimp_cait_asso [string trim [set num_dimp_cait_asso [lindex $res 2]]]

                                  set dml_sql [db_map sel_dimp_cait_assistal]
					set num_dimp_cait_assistal [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_cait_assistal "\n"]
					set num_dimp_cait_assistal [string trim [set num_dimp_cait_assistal [lindex $res 2]]]


					set dml_sql [db_map sel_dimp_min_35]
					set num_dimp_min_35 [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_min_35 "\n"]
					set num_dimp_min_35 [string trim [set num_dimp_min_35 [lindex $res 2]]]

					set dml_sql [db_map sel_dimp_mag_35_min_50]
					set num_dimp_mag_35_min_50 [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_mag_35_min_50 "\n"]
					set num_dimp_mag_35_min_50 [string trim [set num_dimp_mag_35_min_50 [lindex $res 2]]]

					set dml_sql [db_map sel_dimp_mag_50_min_116]
					set num_dimp_mag_50_min_116 [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_mag_50_min_116 "\n"]
					set num_dimp_mag_50_min_116 [string trim [set num_dimp_mag_50_min_116 [lindex $res 2]]]

					set dml_sql [db_map sel_dimp_mag_116_min_350]
					set num_dimp_mag_116_min_350 [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_mag_116_min_350 "\n"]
					set num_dimp_mag_116_min_350 [string trim [set num_dimp_mag_116_min_350 [lindex $res 2]]]

					set dml_sql [db_map sel_dimp_mag_350]
					set num_dimp_mag_350 [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_mag_350 "\n"]
					set num_dimp_mag_350 [string trim [set num_dimp_mag_350 [lindex $res 2]]]

					set dml_sql [db_map sel_dimp_scad_75]
					set num_dimp_scad_75 [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_dimp_scad_75 "\n"]
					set num_dimp_scad_75 [string trim [set num_dimp_scad_75 [lindex $res 2]]]

                                  set dml_sql [db_map sel_aimp_ma]
					set num_f_ma [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_f_ma "\n"]
					set num_f_ma [string trim [set num_f_ma [lindex $res 2]]]
                                     
                                  set dml_sql [db_map sel_aimp_c]
					set num_f_c [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_f_c "\n"]
					set num_f_c [string trim [set num_f_c [lindex $res 2]]]
                       
                                  set dml_sql [db_map sel_aimp_mb]
					set num_f_mb [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_f_mb "\n"]
					set num_f_mb [string trim [set num_f_mb [lindex $res 2]]]

                                  set dml_sql [db_map sel_aimp_a]
					set num_f_a [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_f_a "\n"]
					set num_f_a [string trim [set num_f_a [lindex $res 2]]]
                         
                                  set dml_sql [db_map sel_aimp_0]
					set num_f_0 [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_f_0 "\n"]
					set num_f_0 [string trim [set num_f_0 [lindex $res 2]]]
        
                                  set dml_sql [db_map sel_aimp_b]
					set num_f_b [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_f_b "\n"]
					set num_f_b [string trim [set num_f_b [lindex $res 2]]]

                                  set dml_sql [db_map sel_aimp_n]
					set num_f_n [exec psql $nome_database -h 10.252.10.3 -c $dml_sql]
					set res [split $num_f_n "\n"]
					set num_f_n [string trim [set num_f_n [lindex $res 2]]]
					set ritorno ""
					lappend ritorno $denominazione_ente $num_aimp $num_att $num_pot $num_pot_uti $num_manu $num_gend $num_gend_potf $num_gend_potu 
					lappend ritorno $num_gend_matr $num_gend_cost $num_viae $num_dimp $num_dimp_manu $num_dimp_fumi $num_dimp_ambi $num_dimp_o2 
					lappend ritorno $num_dimp_co2 $num_dimp_bach $num_dimp_co $num_dimp_rend $num_cimp $num_dimp_ma_2008 $num_dimp_cait_2008 $num_dimp_cait_upa
					lappend ritorno $num_dimp_cait_cna $num_dimp_cait_claai $num_dimp_cait_asso  $num_dimp_cait_assistal $num_dimp_min_35 $num_dimp_mag_35_min_50 $num_dimp_mag_50_min_116 
					lappend ritorno $num_dimp_mag_116_min_350 $num_dimp_mag_350 $num_dimp_scad_75 
                                  lappend ritorno $num_f_ma $num_f_c $num_f_mb $num_f_a $num_f_0 $num_f_b $num_f_n 
					iter_put_csv $file_id ritorno  
				} {ns_log Notice "errore: $error_msg"}
			}
		}
		#compilo la tabella
		set riepilogo ""
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		lappend riepilogo "Riepilogo impianti"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		set perc [expr 100*$tot_num_att/$tot_num_aimp]
		lappend riepilogo "Totali impianti attivi (impianti che hanno un modello o una verifica collegati)" $tot_num_att "su" $tot_num_aimp "$perc%"
		iter_put_csv $file_id riepilogo  
		set riepilogo ""
		set perc [expr 100*$tot_num_pot/$tot_num_att]
		lappend riepilogo "Impianti con Potenza al focolare" $tot_num_pot_uti "pari al" "$perc%" "degli attivi"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		set perc [expr 100*$tot_num_pot_uti/$tot_num_att]
		lappend riepilogo "Impianti con Potenza utile" $tot_num_pot_uti "" "$perc%" "degli attivi"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		lappend riepilogo "Impianti collegati al manutentore" $tot_num_manu	
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		set perc [expr 100*$tot_num_att/$tot_num_gend]
		lappend riepilogo "Generatori collegati agli impianti" $tot_num_gend "pari al" "$perc%" "degli attivi"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		lappend riepilogo "Riepilogo Generatori"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		lappend riepilogo "Numero di generatori" $tot_num_gend	
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		set perc [expr 100*$tot_num_gend_potu/$tot_num_gend]
		lappend riepilogo "Numero di generatori con potenza utile" $tot_num_gend_potu "pari al" "$perc%" "dei presenti"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		set perc [expr 100*$tot_num_gend_potf/$tot_num_gend]
		lappend riepilogo "Numero di generatori con potenza foc." $tot_num_gend_potf "" "$perc%" "dei presenti"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		set perc [expr 100*$tot_num_gend_matr/$tot_num_gend]
		lappend riepilogo "Numero generatori con matricola" $tot_num_gend_matr "" "$perc%" "dei presenti"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		set perc [expr 100*$tot_num_gend_cost/$tot_num_gend]
		lappend riepilogo "Numero di genaratori con costruttore" $tot_num_gend_cost "" "$perc%" "dei presenti"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		lappend riepilogo "Riepilogo dichiarazioni"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		lappend riepilogo "Numero di modelli presenti" $tot_num_dimp
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		set perc [expr 100*$tot_num_dimp_manu/$tot_num_dimp]
		lappend riepilogo "Modelli con manutentori registrati" $tot_num_dimp_manu "pari al" "$perc%" "dei presenti"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		set perc [expr 100*$tot_num_dimp_fumi/$tot_num_dimp]
		lappend riepilogo "Modelli con tem.fumi presente" $tot_num_dimp_fumi "" "$perc%" "dei presenti"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		set perc [expr 100*$tot_num_dimp_o2/$tot_num_dimp]
		lappend riepilogo "Modelli con O2 presente" $tot_num_dimp_o2 "" "$perc%" "dei presenti"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		set perc [expr 100*$tot_num_dimp_co2/$tot_num_dimp]
		lappend riepilogo "Modelli con CO2 presente" $tot_num_dimp_co2 "" "$perc%" "dei presenti"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		set perc [expr 100*$tot_num_dimp_co/$tot_num_dimp]
		lappend riepilogo "Modelli com CO presente" $tot_num_dimp_co "" "$perc%" "dei presenti"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		set perc [expr 100*$tot_num_dimp_rend/$tot_num_dimp]
		lappend riepilogo "Modelli con rendimento presente" $tot_num_dimp_rend "" "$perc%" "dei presenti"
		iter_put_csv $file_id riepilogo 
		set riepilogo ""
		lappend riepilogo "Riepilogo verifiche"
		iter_put_csv $file_id riepilogo
		set riepilogo ""
		lappend riepilogo "Numero totale verifiche" $tot_num_cimp 			
		iter_put_csv $file_id riepilogo
				
		# chiudo file csv

		close $file_id
		
		set esit_riga     [list "Statistiche - impianti" $file_csv_url $file_csv]
	    set esit_list     ""
		lappend esit_list $esit_riga
		iter_batch_upd_flg_sta -fine $cod_batc $esit_list

    } {
        iter_batch_upd_flg_sta -abend $cod_batc
        ns_log Error "iter_stat_gen_imp-proc: $error_msg"
    }
  
	ns_log Notice "Fine della procedura iter-stat-gen-imp-proc"
    return

}



