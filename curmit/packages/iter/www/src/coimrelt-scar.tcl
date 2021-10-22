ad_page_contract {
    Scarico tabella "coimrelt" Scheda tecnica relazione biennale

    @author                  Adhoc
    @creation-date           31/01/2005

    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @param cod_relg          chiave parziale della tabella,
                             identifica i record da scaricare
    @cvs-id coimrelt-scar.tcl 
} { 
   {nome_funz ""}
   {cod_relg  ""}
}  -properties {
}

# Controlla lo user
set lvl 1
set id_utente   [lindex [iter_check_login $lvl $nome_funz] 1]

# leggo il record da scaricare ed il nome del file da scaricare.
if {[db_0or1row sel_relg {}] == 0} {
    iter_return_complaint "Relazione biennale non trovata"
}

# imposto la directory degli spool ed il loro nome.
set spool_dir        [iter_set_spool_dir]
set spool_dir_url    [iter_set_spool_dir_url]

# imposto il nome dei file
set nome_file        $nome_file_tec
# non devo generare il nome file temporaneo (con suffisso time)
# perche' il nome del file e' quello indicato dalla regione lombardia
# e memorizzato in inserimento sulla tabella coimrelg
# set nome_file      [iter_temp_file_name $nome_file]
set file_csv         "$spool_dir/$nome_file"
set file_csv_url     "$spool_dir_url/$nome_file"

# apro file temporaneo
set file_id [open $file_csv w]
# dichiaro di scrivere in formato iso West European
fconfigure $file_id -encoding iso8859-1

# come indicato dalla regione lombardia non serve una riga di testata.
# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols data_rel
lappend file_cols ente_istat
lappend file_cols sezione
lappend file_cols id_clsnc
lappend file_cols id_stclsnc
lappend file_cols obj_refer
lappend file_cols id_pot
lappend file_cols id_per
lappend file_cols id_comb
lappend file_cols n

db_foreach sel_relt {} {
    # costruisco il record di output
    set file_col_list ""
    foreach column_name $file_cols {
	set file_col_elem [set $column_name]
	# se la variabile e' null deve essere valorizzata con *
	if {[string equal $file_col_elem ""]} {
	    set file_col_elem "*"
	}
	lappend file_col_list $file_col_elem
    }
    iter_put_csv $file_id file_col_list
} if_no_rows {
    # chiudo il file csv
    close $file_id
    db_release_unused_handles

    iter_return_complaint "Scheda tecnica della relazione biennale non trovata"
}

# chiudo il file csv
close $file_id

db_release_unused_handles

# visualizzo il file creato
ad_returnredirect $file_csv_url
