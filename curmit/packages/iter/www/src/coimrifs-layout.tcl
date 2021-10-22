ad_page_contract {
    Stampa modello H impianto
    
    @author Giulio Laurenzi
    @creation-date 13/04/2004

    @cvs-id coimrfis-layout.tcl

    @param codice_as_resp

    USER  DATA       MODIFICHE
    ===== ========== ========================================================================================
    sim01 13/11/2019 Per la regione i file verranno salvati su file system non sul  db
    
} {
    {cod_as_resp             ""}
    {last_cod_as_resp        ""}
    {funzione            "V"}
    {caller          "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}
    {extra_par            ""}
    {cod_impianto         ""}
    {url_aimp             ""} 
    {url_list_aimp        ""}
    {flag_tracciato       ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
if {![string is space $nome_funz]} {
    set lvl        1
    set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
} else {
  # se la lista viene chiamata da un cerca, allora nome_funz non viene passato
  # e bisogna reperire id_utente dai cookie
  # set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
}

set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

set link_tab [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab [iter_tab_form $cod_impianto]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_as_resp caller nome_funz_caller nome_funz cod_impianto  url_list_aimp url_aimp]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set page_title       "Stampa Comunicazione"

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)
set flag_ente   $coimtgen(flag_ente)
set cod_prov    $coimtgen(cod_provincia)
set sigla_prov  $coimtgen(sigla_prov)
set denom_comune $coimtgen(denom_comune)

db_1row sel_desc "select nome_ente, indirizzo as indirizzo_ente, tipo_ufficio as tipo_ufficio_ente from coimdesc"

if {[db_0or1row sel_resp ""] == 0} {
    iter_return_complaint  "Dati Scheda non trovati</li>"
    return
}




if {$flag_ente == "P"} {
	set ente "Alla c.a. $nome_ente"
} elseif {$flag_ente == "C"} {
	set ente "Alla c.a. $nome_ente"
}



    append stampa "
		<table width=100% align=center>
			<!-- <tr><td >Regione Friuli</td></tr>
			<tr><td >&nbsp;</td></tr>
			<tr><td >&nbsp;</td></tr> -->
			<tr><td >&nbsp;</td></tr>
			<tr><td >&nbsp;</td></tr> 
			<tr><td ><i>Allegato 5</i></td></tr> 
			<tr><td ><table>
	                       <tr><td width=60%>&nbsp;</td>
	                           <td width=40%><b>$ente
	                                     <br>Ente locale responsabile dei controlli D.lgs 192/05 e s.m.i.
	                                     <br>$tipo_ufficio_ente
	                                     <br>$indirizzo_ente
	                                     <br>$denom_comune $sigla_prov</b>
	                           </td>
	                       </tr>
	                 </table>
				</td>
			</tr>
			<tr><td >&nbsp;</td></tr>
			<tr><td ><b>Oggetto: comunicazione cambio nominantivo del responsabile impianto</b><small> (Dichiarazione sostitutiva dell'atto di notorietà dell'art.47 del DPR 28/12/000 n. 445)</small></td></tr>
			<tr><td >&nbsp;</td></tr>		
			<tr>
			   <td  align=left class=form_title width=20%>Il/La sottoscritto/a: $cognome_resp $nome_resp</td>
			</tr>
                        <tr>
			   <td  align=left class=form_title width=20%>Residente in: $comune_resp, Provincia:$provincia_resp</td>
			</tr>
                        <tr>
			   <td  align=left class=form_title width=20%>Via: $ind_resp</td>
			</tr>
                        <tr>
			   <td  align=left class=form_title width=20%>Telefono: $tel_resp Cellulare: $cell_resp  Fax: $fax_resp</td>
			</tr>
                        <tr>
			   <td  align=left class=form_title width=20%>E-mail: $email_resp</td>
			</tr>
			<tr>
			   <td  align=left class=form_title width=20%>Consapevole delle responsabilità e delle sanzioni penali stabilite dalla Legge per false attestazioni e mendaci dichiarazioni (art.76 del DPR 445/2000), sotto la sua personale personalità
			   </td>
			</tr>
			<tr><td >&nbsp;</td></tr>	
			<tr>
			   <td width=100%  align=center><b>Dichiara</b></td>
			</tr>		
			<tr>
				<td width=100%>
			   		<table>"
						

	
	
	append stampa "
				</table>
			</td>
		</tr>
		<tr><td >&nbsp;</td></tr>
		<tr>
		   <td align=center class=form_title valign=top><b>Di essere responsabile per l'esercizio e la manutenzione dell'impianto</b></td>
                 </tr>
               	<tr>
		   <td width=100% >
		   <table width=100%>
		     <tr nowrap>
                        <td align=left class=form_title valign=top>Catasto impianti/codice <b>$cod_impianto_est</b></td>
		       	<td valign=top align=left class=form_title >Indirizzo $toponimo $indirizzo</td>
		       	<td valign=top align=left class=form_title >N&deg; Civ. $numero $esponente</td>
	 		<td valign=top align=left class=form_title>Comune $descr_comune</td>
		     </tr>
		   </table>
		</td></tr>
		<!-- <tr>
		   <td valign=top align=left class=form_title>Localit&agrave; $localita
		   </td>
		</tr> 		
		<tr>
		   <td  align=left class=form_title width=20%>di propriet&agrave; di $cognome_resp $nome_resp
		   </td>
		</tr>
		<tr>
		   <td  align=left class=form_title width=20%>composto dai seguenti generatori di calore:
		   </td>
		</tr> -->
		"
	
	append stampa "<tr><td><table>"
	
	db_foreach sel_gen_aimp2 "select gen_prog , iter_edit_num(pot_utile_nom, 2) as potenza , b.descr_comb as cod_combustibile
	                            from coimgend a
	                 			left outer join coimcomb b on b.cod_combustibile = a.cod_combustibile
	                           	where cod_impianto = :cod_impianto and flag_attivo = 'S'
	                           	order by gen_prog" {
		append stampa "
		    			       <tr> 
                                               <table width=100%>
		                               
					        <td valign=top align=left width=20% nowrap>Generatore n.: $gen_prog</td>
					        <td valign=top align=left width=50% nowrap>potenza termica utile di $potenza kW</td>
					        <td valign=top align=left width=30% nopwrap>Combustibile $cod_combustibile</td>
                                                
						</tr>"					
	}
	append stampa "
		</table></td></tr>
		<tr><td >&nbsp;</td></tr>
                <tr><td valign=top align=left class=form_title>Dalla data  $data_fin_valid_edit</td></tr>
                <tr><td >&nbsp;</td></tr>
                <tr><td valign=top align=left class=form_title>In qualità di $flag_resp CF: $cod_fiscale_resp PIVA:$cod_piva_resp</td></tr>
                <tr><td >&nbsp;</td></tr>
                <tr><td valign=top align=left class=form_title>Precedente responsabile dell'impianto: $cognome_old $nome_old</td></tr>
                <tr><td >&nbsp;</td></tr>
                <tr><td valign=top align=left class=form_title>Dichiara altresì di essere informato, ai sensi e per gli effetti per la legge 10 della L.675/96, che i dati personali saranno trattati anche con strumenti informatici, esclusivamente nell'ambito del procedimento per il quale la presente dichiarazione viene resa.</td></tr>
		<tr><td >&nbsp;</td></tr>
		<tr><td valign=top align=left class=form_title>Nominativo del fornitore di energia: $forn_energia</td></tr>
                <tr><td >&nbsp;</td></tr>
                <tr><td valign=top align=left class=form_title>Data: ...........  Firma: .........................................................................................</td></tr>
                <tr><td >&nbsp;</td></tr>
                <tr><td >Allegato fotocopia di un documento di identità del dichiarante</td></tr>
		"


# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file        "stampa comunicazione"

if {$coimtgen(regione) eq "MARCHE"} {#sim01 if e suo contenuto
    set spool_dir_perm     [iter_set_permanenti_dir]
    set spool_dir_url_perm [iter_set_permanenti_dir_url]
    set nome_file        [iter_temp_file_name -permanenti $nome_file]
    set file_html        "$spool_dir_perm/$nome_file.html"
    set file_pdf         "$spool_dir_perm/$nome_file.pdf"
    set file_pdf_url     "$spool_dir_url_perm/$nome_file.pdf"

} else {#sim01
    
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"
};#sim01

set   file_id  [open $file_html w]
fconfigure $file_id -encoding iso8859-1
puts  $file_id $stampa
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --bottom 0cm -f $file_pdf $file_html]

# Controllo se il Database e' Oracle o Postgres
set id_db     [iter_get_parameter database]

set sql_contenuto  "lo_import(:file_html)"
set tipo_contenuto [ns_guesstype $file_pdf]

set contenuto_tmpfile  $file_pdf

with_catch error_msg {
    db_transaction {
	db_1row sel_docu_next ""
	set tipo_documento "CO"
	db_dml dml_sql_docu [db_map ins_docu]
	
	if {$coimtgen(regione) eq "MARCHE"} {#sim01 if e suo contenuto

	    db_dml q "update coimdocu
		  	             set tipo_contenuto = :tipo_contenuto
			               , path_file      = :file_pdf
			           where cod_documento  = :cod_documento"
	    
	} else {#sim01


	if {$id_db == "postgres"} {
	    if {[db_0or1row sel_docu_contenuto ""] == 1} {
		if {![string equal $docu_contenuto_check ""]} {
		    db_dml dml_sql2 [db_map upd_docu_2]
		}
	    }
	    db_dml dml_sql3 [db_map upd_docu_3]
	} else {
	    db_dml dml_sql2 [db_map upd_docu_2] -blob_files [list $contenuto_tmpfile]
	}

    };#sim01
    }
} {
    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
}


ns_unlink $file_html
ad_returnredirect $file_pdf_url
ad_script_abort
