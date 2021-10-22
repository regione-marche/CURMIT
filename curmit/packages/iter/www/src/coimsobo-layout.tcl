ad_page_contract {

    @author          giulio Laurenzi
    @creation-date   09/06/2006

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimstev-layout.tcl
} {
    {cod_inco          ""}
    {funzione          ""}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    conferma:optional,multiple
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# bisogna reperire id_utente dai cookie
#set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente [iter_get_id_utente]

# istruzioni gia' eseguite in /src
 set lvl 1
 set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# Personalizzo la pagina
set titolo       "Stampa sollecito bollettini"
set page_title   "Stampa sollecito bollettini"
set context_bar  "home"
#[iter_context_bar -nome_funz $nome_funz_caller]

set pack_key     [iter_package_key]
set pack_dir     [apm_package_url_from_key $pack_key]
append pack_dir  "src"

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]



# imposto il nome dei file
set nome_file        "stampa_sollecito_bollettini"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set file_id     [open $file_html w]
fconfigure $file_id -encoding iso8859-1


set data_corrente [iter_set_sysdate] 

    iter_get_coimdesc
    set nome_ente    $coimdesc(nome_ente)
    set tipo_ufficio $coimdesc(tipo_ufficio)
    set assessorato  $coimdesc(assessorato)
    set indirizzo    $coimdesc(indirizzo)
    set telefono     $coimdesc(telefono)
    set resp_uff     $coimdesc(resp_uff)
    set uff_info     $coimdesc(uff_info)
    set dirigente    $coimdesc(dirigente)

set testata "
<table width=100%>
   <tr>
      <td valign=top width=25%>
         <small><small>Via Don Maraglio, 4
         <br>46100 Mantova
         <br>tel.0376 401727/401729
         <br>fax 0376 401460
         <br>videoconferenza 0376 321712
         <br>energia@provincia.mantova.it
         <br>www.provincia.mantova.it</small></small>
      </td>
      <td valign=top width=25%>
             Area gestione
         <br>del territorio
         <br>e infrastrutture
         <br><b>Servizio Energia</b>
      </td>
      <td width=50%>
          <img src=$logo_dir/prmn-stp.gif>
      </td>
   </tr>
 </table>"

set conta_boll 0
set stampa ""
set stampa2 "<table border=1 cellpadding=0 cellspacing=0>
               <tr>
                  <th>Manutentore</th>
                  <th>Nr. bollini</th>
                  <th>Data scadenza</th>
               </tr>"

if {[exists_and_not_null conferma]} {
    foreach {cod_bollini} $conferma {
	db_1row sel_boll "" 

	incr conta_boll
	if {$conta_boll > 1} {
	    append stampa "<!-- PAGE BREAK -->"
	}
    
	append stampa $testata
	append stampa2 "
               <tr>
                  <td>$cognome $nome</td>
                  <td>$nr_bollini</td>
                  <td>$data_scadenza_edit</td>
               </tr>"

	append stampa "
        <table width=100%>
         <tr>
            <td align=left width=60%>Prot. - GN 2006 - 38866</td>
            <td align=left width=40%>&nbsp;</td>
         </tr>
         <tr>
            <td align=left width=60%>Mantova, [iter_edit_date $data_corrente]</td>
            <td align=left width=40%>&nbsp;</td>
         </tr>
         <tr>
             <td>&nbsp;</td>
             <td align=left>$cognome $nome</td>
         </tr>
         <tr>
            <td>&nbsp;</td>
            <td align=left>$indirizzo</td>
         </tr>
         <tr>
            <td>&nbsp;</td>
            <td align=left>$cap $comune $provincia</td>
         </tr>
        </table>
        <br><br><br><br>

        <table width=100%>
          <tr align=justify>
              <td>Oggetto: <b>Mancato pagamento per dichiarazione impianti termici</b></td>
          </tr>
        </table>
        <br><br><br><br>
        <table width=100%>
            <tr align=justify>
                <td>Cortese Ditta/manutentore, con la presente siamo a comunicare 
                    che ad oggi [iter_edit_date $data_corrente] non risulta ancora effettuato il 
                    pagamento dell'impianto dovuto per l'assegnazione di num.
                    $nr_bollini Bollini verdi.
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr align=justify>
                <td>Come indicato nella convenzione da voi sottoscritta, il pagamento deve essere eseguito <b><u>entro 60 giorni dalla consegna</u></b>. Siamo pertanto a sollecitare il pagamento da effettuarsi mediante l'utilizzo di bollettino postale gi&agrave; in vs. possesso o tramite bonifico bancario.
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr align=justify>
                <td><b><u>Si prega inoltre, a pagamento effettuato, di trasmettere a mezzo fax (al numero 0376/401.460) o posta, la ricevuta dell'avvenuto versamento a codesto ufficio.</u></b>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr align=justify>
                <td>Certi di vostro sollecito riscontro cogliamo l'occasione per porgere i nostri pi&ugrave; distinti saluti
                </td>
            </tr>
        </table>
        <br><br><br><br>
        <table width=100%>
                 <tr>
                    <td width=50%>&nbsp;</td>
                    <td width=50% align=center>Il Dirigente</td>
                 </tr>
                 <tr>
                    <td>&nbsp;</td>
                    <td align=center>(Arch. Giancarlo Leoni)</td>
                 </tr>
                 <tr>
                    <td>&nbsp;</td>
                    <td align=center><img src=$logo_dir/firma-dirig-prmn.gif></td>
                 </tr>
          </table>
"
    }
} else {
    set stampa "Nessun dato corrisponde ai criteri impostati."
    set stampa2 "Nessun dato corrisponde ai criteri impostati."
}

if {$conta_boll >= 1} {
    append stampa2 "</table>"
}
   
puts $file_id $stampa
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 2cm --right 2cm --top 1.5cm --bottom 1.5cm -f $file_pdf $file_html]

# preparo la routine di scrittura sul database

set sql_contenuto  "lo_import(:file_html)"
set tipo_contenuto [ns_guesstype $file_pdf]

set contenuto_tmpfile  $file_pdf


# questa db_transaction non pretende di funzionare per tutti i record
# della db_foreach ma per le varie query della singola stampa
with_catch error_msg {
    db_transaction {
	foreach {cod_bollini} $conferma {
	    db_1row sel_boll "" 
	    db_1row sel_docu_next ""
	    set tipo_documento "SO"
	    db_dml ins_docu ""
	    
	    # Controllo se il Database e' Oracle o Postgres
	    set id_db         [iter_get_parameter database]
	    if {$id_db == "postgres"} {
		if {[db_0or1row sel_docu_contenuto ""] == 1} {
		    if {![string equal $docu_contenuto_check ""]} {
			db_dml upd_docu_2 ""
		    }
		}
		db_dml upd_docu_3 ""
	    } else {
		db_dml upd_docu_2 "" -blob_files [list $contenuto_tmpfile]
	    }
	}
    }
} {
    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
    seguente messaggio di errore <br><b>$error_msg</b><br>
    Contattare amministratore di sistema e comunicare il messaggio
    d'errore. Grazie."
}

ns_unlink $file_html
#ns_unlink $file_pdf

 

ad_return_template
