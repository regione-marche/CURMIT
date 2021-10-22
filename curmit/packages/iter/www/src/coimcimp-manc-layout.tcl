ad_page_contract {
    Stampa Rapporto di verifica
    
    @author        Luca Romitti
    @creation-date 11/06/2021

    @cvs-id coimcimp-manc-layout.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    rom01 16/06/2021 Sandro mi ha chiesto di aggiungere alla stampa i dati essenziali dell'impianto:
    rom01            Codice Impianto e ubicazione, anagrafica utente (nome cognome, indirizzo e CF),
    rom01            cod_cimp.

} {
    {cod_cimp         ""}
    {funzione        "V"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {flag_ins        "S"}
    {cod_impianto     ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# imposto l'utente
set id_utente [ad_get_cookie iter_login_[ns_conn location]]

iter_get_coimtgen
set flag_viario coimtgen(flag_viario)

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set stampa ""

if {[db_0or1row sel_cimp ""] == 0} {
    iter_return_complaint "Rapporto di verifica non trovato"
    return
}

iter_get_coimdesc
set ente $coimdesc(nome_ente)

regsub -all \n  $note_verificatore  \<br>  note_verificatore

set logo_dir      [iter_set_logo_dir]

set stampe_logo_in_tutte_le_stampe [parameter::get_from_package_key -package_key iter -parameter stampe_logo_in_tutte_le_stampe -default "0"];#sim01
set stampe_logo_nome               [parameter::get_from_package_key -package_key iter -parameter stampe_logo_nome];#sim01
set stampe_logo_height             [parameter::get_from_package_key -package_key iter -parameter stampe_logo_height];#sim01
set logo_dx_nome                   [parameter::get_from_package_key -package_key iter -parameter master_logo_dx_nome];#gab01
set master_logo_sx_titolo_sopra    [parameter::get_from_package_key -package_key iter -parameter master_logo_sx_titolo_sopra];#gab01
set master_logo_sx_titolo_sotto    [parameter::get_from_package_key -package_key iter -parameter master_logo_sx_titolo_sotto];#gab01


if {$stampe_logo_in_tutte_le_stampe eq "1" && $stampe_logo_nome ne ""} {#sim01 Aggiunta if e suo contenuto
    if {$stampe_logo_height ne ""} {
        set height_logo "height=$stampe_logo_height"
    } else {
        set height_logo ""
    }
    set logo "<img src=$logo_dir/$stampe_logo_nome $height_logo>"
    set logo_dx "<img src=$logo_dir/$logo_dx_nome $height_logo>";#gab01 
} else {
    set logo ""
    set logo_dx "";#gab01
}

set stampa "
<!-- FOOTER RIGHT  \"Pagina \$PAGE(1) di \$PAGES(1)\"-->
<table border=0 width=100%>
  <tr>
    <td width=100%>
      <table width=100% border=1 bgcolor=#D6D6D6>
        <tr>"

if {$stampe_logo_in_tutte_le_stampe eq "1" && $stampe_logo_nome ne ""} {#sim01
    append stampa "
          <td width=5%>$logo</td>
          <!-- gab01 -->
          <td width=90%>
          <!-- gab01 <td width=95%> -->";#sim01
} else {#sim01
    append stampa "
          <td width=100%>"
};#sim01

set dicitura_comune "$master_logo_sx_titolo_sopra $master_logo_sx_titolo_sotto";#gab01

append stampa "
            <table width=100%>
              <tr>
                <td width=100% align=center colspan=2><b>VERIFICA DELLO STATO DI MANUTENZIONE ED ESERCIZIO DEGLI IMPIANTI TERMICI</b></td>
              </tr>
              <tr>
                <td align=center colspan=2><b>(ai sensi del DLgs 192/05 e succ. mod.)</b></td>
              </tr>
              <tr>
                <!-- gab01 <td align=left><b>$ente</b></td> -->
                <!-- gab01 -->
                <td align=left><b>$dicitura_comune</b></td>
                <td align=right><b>$ente</b></td>
              </tr>
            </table>"
if {$stampe_logo_in_tutte_le_stampe eq "1" && $stampe_logo_nome ne ""} {#gab01
    append stampa "
          </td>
          <td width=5%>$logo_dx</td>"
} else {#gab01
    append stampa "
          </td>"
}
append stampa "
        </tr>   
      </table>
    </td>   
  </tr>
  <tr>
    <td>
      <table width=100% >
        <tr><td>&nbsp;</td></tr>
        <tr><td>&nbsp;</td></tr>
       <!--rom01 inizio-->
        <tr>
          <td valign=top align=left>Codice Impianto:</td>
          <td valign=top>$cod_impianto_est</td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td valign=top align=left>Ubicazione Impianto:</td>
          <td valign=top>$ubicazione_impianto</td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td valign=top align=left>Responsabile:</td>
          <td valign=top>$responsabile_impianto</td>
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td valign=top align=left>Protocollo:</td>
          <td valign=top>$cod_cimp</td>
        </tr>
       <!--rom01 fine-->
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td valign=top align=left>Data mancata ispezione:</td>
          <td valign=top>$data_controllo</td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td valign=top align=left>Verbale N.:</td>
          <td valign=top>$verb_n</td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td valign=top align=left>Ispettore:</td>
          <td valign=top>$des_opve</td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td valign=top align=left>Tipologia Costo:</td>
          <td valign=top>$tipologia_costo</td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td valign=top align=left>Costo:</td>
          <td valign=top>$costo Euro</td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td valign=top align=left>Riferimento Pagamento:</td>
          <td valign=top>$riferimento_pag</td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td valign=top align=left>Data scadenza pagamento:</td>
          <td valign=top>$data_scad</td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td valign=top align=left>Motivazione:</td>
          <td valign=top>$descr_noin </td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
          <td valign=top align=left>Note:</td>
          <td valign=top>$note_verificatore</td>
        </tr>
      </table>
    </td>
  </tr>
</table>"

#ns_return 200 text/html "$stampa"; return
# creo file temporaneo html
# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file        "stampa rapporto di verifica"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set   file_id  [open $file_html w]
fconfigure $file_id -encoding iso8859-1
puts  $file_id $stampa
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 9 --left 1cm --right 1cm --top 1cm --bottom 0cm -f $file_pdf $file_html]

# Controllo se il Database e' Oracle o Postgres
set id_db     [iter_get_parameter database]

set sql_contenuto  "lo_import(:file_html)"
set tipo_contenuto [ns_guesstype $file_pdf]

set contenuto_tmpfile  $file_pdf

if {[db_0or1row sel_docu ""] == 0} {
    set flag_docu "N"
} else {
    set flag_docu "S"
}

if {$flag_ins == "S"} {
    with_catch error_msg {
	db_transaction {
	    if {[string equal $cod_documento ""]
		|| $flag_docu == "N"} {
		db_1row sel_docu_next ""
		set tipo_documento "RV"
		db_dml dml_sql_docu [db_map ins_docu]
		db_dml dml_sql_cimp [db_map upd_cimp]
	    } else {
		db_dml dml_sql_docu [db_map upd_docu]
	    }
	    
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
	    
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }
}


ns_unlink $file_html
ad_returnredirect $file_pdf_url
ad_script_abort
