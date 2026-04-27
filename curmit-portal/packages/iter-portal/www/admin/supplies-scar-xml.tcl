ad_page_contract {

    @author         Abid Boutheina
    @creation-date  23/06/2023

    @cvs-id supplies-scar-xml.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    mat02 05/11/2025 Aggiunta l'estrazione in csv.

    mat01 16/04/2025 Corretta la discrepanza della condizione where del filtro f_anno_rif 
    mat01            rispetto a quella della lista a video. Luca ha detto che la condizione della
    mat01            pagina dei filtri ( e di conseguenza della lista a video) è quella giusta 
    
    but01 22/04/2024  valorizzato il ca,mpo anno_rif con valore del anno di caricamento.
} {
    {f_competente        ""}
    {f_anno_rif          ""}
    {f_name_distributor  ""}
    {f_comune            ""}
    {f_combustibile      ""}
    {attachment_id       ""}
    {format              ""}
}
#mat02 aggiunto format

# Imposto variabili tipiche di ogni funzione
set lvl 1
#set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
#iter_get_coimtgen
set msg_err ""
# imposto filtro

if {[string equal $f_anno_rif ""]} {
    set where_anno_rif ""
} else {
    #mat01 set where_anno_rif  "and to_char(cr.publish_date,'YYYY') = :f_anno_rif"
    set where_anno_rif  "and  anno_rif=:f_anno_rif" ;#mat01
}
if {[string equal $f_name_distributor ""]} {
    set where_name_distributor ""
} else {
    set where_name_distributor  "and upper(d.name) like upper('%$f_name_distributor%')"
}
if {[string equal $f_comune ""]} {
    set where_f_comune ""
} else {
    set where_f_comune "and upper(comune_nome) like upper('%$f_comune%')"
}
if {[string equal $f_combustibile ""]} {
    set where_f_combustibile ""
} else {
    set where_f_combustibile "and combustibile_tipo = :f_combustibile"
}
if {[string equal $f_competente ""]} {
    set where_competente ""
} else {
    set where_competente "and i.instance_name = :f_competente"
}

set col_numero  "to_number(a.numero,'99999999')"

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

# imposto il nome dei file
set nome_file        "Estrazione lista forniture"
set nome_file        [iter_temp_file_name $nome_file]

if {$format eq "xml"} {#mat02 aggiunta if-elseif e contenuto elseif 
    set file_xml_name    "$spool_dir/$nome_file.xml"
    
    set file_xml_url     "$spool_dir/$nome_file.xml"
    
    set file_xml [open $file_xml_name w]
    
    fconfigure $file_xml -encoding utf-8
    
    set stampa {<?xml version="1.0" encoding="UTF-8"?>
	<elenco_forniture>}
    
    #set sel_forn [db_map sel_fornt]
    
    db_foreach sel_fornt "" {
	
	append stampa "
    	    <fornitura>
              <name_distributor>$name_distributor</name_distributor>
	      <natura_giurid>$natura_giurid</natura_giurid>
              <utente_cogn_rag_soc>$utente_cogn_rag_soc</utente_cogn_rag_soc>
              <utente_nome>$utente_nome</utente_nome>
              <utente_cf>$utente_cf</utente_cf>
              <utente_piva>$utente_piva</utente_piva>
              <toponimo_tipo>$toponimo_tipo</toponimo_tipo>
              <toponimo_nome>$toponimo_nome</toponimo_nome>
              <toponimo_civico>$toponimo_civico</toponimo_civico>
              <toponimo_cap>$toponimo_cap</toponimo_cap>
              <comune_nome>$comune_nome</comune_nome>
              <comune_istat>$comune_istat</comune_istat>
              <ente_riferimento>$ente_riferimento</ente_riferimento>
              <catasto_sezione>$catasto_sezione</catasto_sezione>
              <catasto_foglio>$catasto_foglio</catasto_foglio>
              <catasto_particella>$catasto_particella</catasto_particella>
              <catasto_subalterno>$catasto_subalterno</catasto_subalterno>
              <pdr>$pdr</pdr>
              <pod>$pod</pod>
              <stato_pdr>$stato_pdr</stato_pdr>
              <matr_contatore>$matr_contatore</matr_contatore>
              <contratto_tipo>$contratto_tipo</contratto_tipo>
              <combustibile_tipo>$combustibile_tipo</combustibile_tipo>
              <combustibile_consumo>$combustibile_consumo</combustibile_consumo>
              <combustibile_um>$combustibile_um</combustibile_um>
              <combustibile_anno>$combustibile_anno</combustibile_anno>
	   </fornitura>
    	   "
	append stampa {}
	
	#append stampa "</forniture>"
	
    } if_no_rows {
	set msg_err      "Nessun fornitura selezionata con i criteri utilizzati"
	set msg_err_list [list $msg_err]
	iter_put_csv $file_xml msg_err_list
	
	append stampa {}
    }
    append stampa "
</elenco_forniture>"

    puts $file_xml $stampa
    close $file_xml
    
    ns_returnfile 200 text/xml $file_xml_url
    ad_script_abort

} elseif {$format eq "csv"} {

    set file_csv_name    "$spool_dir/$nome_file.csv"
    
    set file_csv_url     "$spool_dir_url/$nome_file.csv"
    
    set file_csv [open $file_csv_name w]
    
    fconfigure $file_csv -encoding iso8859-1
    
    set head_cols ""
    lappend head_cols "Ente riferimento"
    lappend head_cols "Distributore"
    lappend head_cols "Data caricamento"
    lappend head_cols "Anno riferimento"
    lappend head_cols "Natura giuridica"
    lappend head_cols "Cognome utente"
    lappend head_cols "Nome utente"
    lappend head_cols "Codice fiscale utente"
    lappend head_cols "Partita iva utente"
    lappend head_cols "Tipo toponimo"
    lappend head_cols "Nome toponimo"
    lappend head_cols "Civico"
    lappend head_cols "Cap"
    lappend head_cols "Comune"
    lappend head_cols "Codice istat comune"
    lappend head_cols "Sezione catasto"
    lappend head_cols "Foglio"
    lappend head_cols "Particella"
    lappend head_cols "Subalterno"
    lappend head_cols "Codice POD"
    lappend head_cols "Codice PDR"
    lappend head_cols "Stato PDR"
    lappend head_cols "Matricola contatore"
    lappend head_cols "Tipo contratto"
    lappend head_cols "Combustibile"
    lappend head_cols "Consumo annuo"
    lappend head_cols "Unità di misura consumo"
    lappend head_cols "Anno consumo"

    
    set file_cols ""
    lappend file_cols "ente_riferimento"
    lappend file_cols "name_distributor"
    lappend file_cols "publish_date"
    lappend file_cols "anno_rif"
    lappend file_cols "natura_giurid"
    lappend file_cols "utente_cogn_rag_soc"
    lappend file_cols "utente_nome"
    lappend file_cols "utente_cf"
    lappend file_cols "utente_piva"
    lappend file_cols "toponimo_tipo"
    lappend file_cols "toponimo_nome"
    lappend file_cols "toponimo_civico"
    lappend file_cols "toponimo_cap"
    lappend file_cols "comune_nome"
    lappend file_cols "comune_istat"
    lappend file_cols "catasto_sezione"
    lappend file_cols "catasto_foglio"
    lappend file_cols "catasto_particella"
    lappend file_cols "catasto_subalterno"
    lappend file_cols "pod"
    lappend file_cols "pdr"
    lappend file_cols "stato_pdr"
    lappend file_cols "matr_contatore"
    lappend file_cols "contratto_tipo"
    lappend file_cols "combustibile_tipo"
    lappend file_cols "combustibile_consumo"
    lappend file_cols "combustibile_um"
    lappend file_cols "combustibile_anno"
    


    
    set sw_primo_rec "t"
    db_foreach sel_fornt "" {

	set file_col_list ""

	if {$sw_primo_rec == "t"} {
	    set sw_primo_rec "f"
	    iter_put_csv $file_csv head_cols
	}

	foreach column_name $file_cols {	    
	    lappend file_col_list [set $column_name]
	}
	iter_put_csv $file_csv file_col_list
    } if_no_rows {
	set msg_err      "Nessun fornitura selezionata con i criteri utilizzati"
	set msg_err_list [list $msg_err]
	iter_put_csv $file_csv msg_err_list
	
    }

    ad_returnredirect $file_csv_url
    ad_script_abort

}
    
