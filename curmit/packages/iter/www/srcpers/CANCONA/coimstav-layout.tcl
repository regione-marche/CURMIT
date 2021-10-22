ad_page_contract {

    @author          Paolo Formizzi Adhoc
    @creation-date   14/05/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimstav-layout.tcl
} {
    {cod_inco          ""}
    {funzione         "V"}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {f_data            ""}
    {f_tipo_data       ""}
    {f_cod_impianto    ""}
    {f_cod_tecn        ""}
    {f_cod_enve        ""}
    {f_cod_comb        ""}
    {f_anno_inst_da    ""}
    {f_anno_inst_a     ""}
    {f_cod_esito       ""}
    {f_cod_comune      ""}
    {f_cod_via         ""}
    {f_tipo_estrazione ""}
    {f_cod_comb        ""}
    {f_num_max         ""}

    {flag_inco         ""}
    {extra_par         ""}
    {cod_impianto      ""}
    {url_list_aimp     ""}
    {url_aimp          ""} 

    {flag_anteprima    ""}
    {f_cod_area        ""}
    {id_protocollo     ""}
    {protocollo_dt     ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# bisogna reperire id_utente dai cookie
#set id_utente [ad_get_cookie iter_login_[ns_conn location]]
set id_utente [iter_get_id_utente]

set data_corrente [iter_edit_date [iter_set_sysdate]]
set anno_corrente [string range [iter_set_sysdate] 0 3]
set mese_corrente [string range [iter_set_sysdate] 4 5]

# controllo di autorizzazioni gia' fatto in src
# set lvl 1
# set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set pack_key [iter_package_key]
set pack_dir [apm_package_url_from_key $pack_key]
set logo_dir           [iter_set_logo_dir]
append pack_dir "src"

set data_corrente [iter_edit_date [iter_set_sysdate]]
iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)
set gg_conferma_inco $coimtgen(gg_conferma_inco)
set flag_ente   $coimtgen(flag_ente)
set sigla_prov  $coimtgen(sigla_prov)
set cod_prov    $coimtgen(cod_provincia)
set denom_comune $coimtgen(denom_comune)

if {$flag_ente == "P"} {
    set logo "[string tolower $flag_ente]r[string tolower $sigla_prov]-stp.gif"
    set prov_comu "le Province"
} else {
    set logo "[string tolower $flag_ente][string tolower $denom_comune]-stp.gif"
    set prov_comu "i Comuni"
}

if {$flag_ente == "C"} {
    set luogo $coimtgen(denom_comune)
} else {
    if {[db_0or1row get_desc_prov ""] == 0} {
	set luogo ""
    } else {
	set luogo $desc_prov
    }
}


# Controllo se il Database e' Oracle o Postgres
set id_db     [iter_get_parameter database]

# imposto il nome dei file
set current_datetime [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]

set nome_file      "Avviso di verifica"
set nome_file      [iter_temp_file_name -permanenti $nome_file]
set nome_file2     "Avviso di verifica totale"
set nome_file2     [iter_temp_file_name -permanenti $nome_file2]

set file_html      "$permanenti_dir/$nome_file.html"
set file_html2     "$permanenti_dir/$nome_file2.html"

set file_pdf       "$permanenti_dir/$nome_file.pdf"
set file_pdf2      "$permanenti_dir/$nome_file2.pdf"

set file_pdf_url   "$permanenti_dir_url/$nome_file.pdf"
set file_pdf_url2  "$permanenti_dir_url/$nome_file2.pdf"

# file html aperto nel ciclo

set file_id2     [open $file_html2 w]
fconfigure $file_id2 -encoding iso8859-1

set stampa3 "
<table border>
<tr>
   <td align=center><b>Cod.impianto</b></td>
   <td align=center><b>Responsabile</b></td>
   <td align=center><b>Indirizzo   </b></td>
   <td align=center><b>Comune      </b></td>
</tr>"

if {[db_0or1row sel_cinc_count ""] == 0} {
    set conta 0
}
if {$conta == 0} {
    iter_return_complaint "Non ci sono campagne aperte"
}
if {$conta > 1} {
    iter_return_complaint "C'&egrave; pi&ugrave; di una campagna aperta"
}
if {$conta == 1} {
    if {[db_0or1row sel_cinc ""] == 0} {
	iter_return_complaint "Campagna non trovata"
    }
}


if {![string equal $id_protocollo ""]} {
    set protocollo "<tr><td colspan=2><b>Prot.</b> $id_protocollo</td></tr>"
} else {
    set protocollo ""
}

if {![string equal $protocollo_dt ""]} {
    set data_prot "<tr><td colspan=2><b>Data prot.</b> $protocollo_dt</td></tr>"
} else {
    set data_prot ""
}

if {![string equal $cod_inco ""]} {
    if {[db_0or1row sel_inco_2 ""] == 0} {
	iter_return_complaint "Appuntamento non trovato"
    } else {
	if {$stato != "2"} {
	    iter_return_complaint "Appuntamento non in stato 'Assegnato'"
	}
    }
}

# Personalizzo la pagina
if {$flag_anteprima == "T"} {
    set titolo       "Anteprima stampa avvisi di verifica"
    set page_title   "Anteprima stampa avvisi di verifica"
} else {
    set titolo       "Stampa avvisi di verifica"
    set page_title   "Stampa avvisi di verifica"
}
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
set link_filter  [export_ns_set_vars url]


# imposto il filtro per incontro
if {![string equal $cod_inco ""]} {
    set where_inco "and a.cod_inco = :cod_inco"
} else {
    set where_inco ""
}

# imposto il filtro per numero massimo
if {![string equal $f_num_max ""]} {
    set limit_ora "where rownum <= $f_num_max"
    set limit_pos "limit $f_num_max"
} else {
    set limit_ora ""
    set limit_pos ""
}

# imposto filtro per data
if {![string equal $f_data ""]} {
    switch $f_tipo_data {
	"A" {set where_data "and a.data_assegn       = :f_data"}
	"E" {set where_data "and a.data_estrazione   = :f_data"}
	"I" {set where_data "and a.data_verifica     = :f_data"}
    }
} else {
    set where_data ""
}

if {![string equal $f_cod_impianto ""]} {
    set where_codice "and b.cod_impianto_est = upper(:f_cod_impianto)"
} else {
    set where_codice ""
}

# imposto il filtro per il tecnico
if {![string equal $f_cod_tecn ""]} {
    set where_tecn "and a.cod_opve = :f_cod_tecn"
} else {
    set where_tecn ""
}

# imposto il filtro per comune
if {![string equal $f_cod_comune ""]} {
    set where_comune "and b.cod_comune = :f_cod_comune"
} else {
    set where_comune ""
}

# imposto filtro per via
if {![string equal $f_cod_via ""]} {
    set where_via "and b.cod_via = :f_cod_via"
} else {
    set where_via ""
}

# imposto filtro per tipo estrazione
if {![string equal $f_tipo_estrazione ""]} {
    set where_tipo_estr "and a.tipo_estrazione = :f_tipo_estrazione"
} else {
    set where_tipo_estr ""
}

# imposto filtro per combustibile
if {![string equal $f_cod_comb ""]} {
    set where_comb "and b.cod_combustibile = :f_cod_comb"
} else {
    set where_comb ""
}

# imposto filtro per data
if {![string equal $f_anno_inst_da ""]} {
    set where_anno_inst_da "and substr(b.data_installaz,1,4) >= :f_anno_inst_da"
} else {
    set where_anno_inst_da ""
}

# imposto filtro per area. ricordo che per questa estrazione si considerano
# solo le aree come raggruppamenti di comuni.
if {![string equal $f_cod_area ""]} {
    if {[db_0or1row sel_area_tipo_01 ""] == 0} {
	set tipo_01 ""
    }
    
    set lista_comu "("
    set conta_comu 0
    db_foreach sel_cmar "" {
	incr conta_comu
	append lista_comu "$cod_comune,"
    }
    if {$conta_comu > 0} {
	set lung_lista_comu [string length $lista_comu]
	set lista_comu [string range $lista_comu 0 [expr $lung_lista_comu -2]]
	append lista_comu ")"

	set where_area "and b.cod_comune in $lista_comu"
    } else {
	set where_area ""
    }
} else {
    set where_area ""
}

if {![string equal $f_anno_inst_a ""]} {
    set where_anno_inst_a  "and substr(b.data_installaz,1,4) <= :f_anno_inst_a"
} else {
    set where_anno_inst_a ""
}

# imposto il filtro per ente verificatore
if {![string equal $f_cod_enve ""]} {
    set where_enve "and a.cod_opve in (select z.cod_opve 
                                         from coimopve z
                                        where z.cod_enve = :f_cod_enve)"
} else {
    set where_enve ""
}


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
<tr><td valign=top align=left><table width=100%>
              <tr><td><small>$indirizzo
                               <br>$telefono
                               <br>$uff_info</small>
                  </td>
              </tr>
        </table>
    </td>
    <td valign=top align=left width=18%><table width=100%>
              <tr>
                 <td align=left>$nome_ente
                             <br>$assessorato 
                             <br><b>$tipo_ufficio</b></td>
              </tr>
        </table>
    </td>
    <td width=10%>&nbsp;</td>
    <td width=30%>
          <img src=$logo_dir/$logo>
    </td>
</table>"

set ctr 0

if {$flag_viario == "T"} {
    set sel_inco "sel_inco_si_viae"
} else {
    set sel_inco "sel_inco_no_viae"
}

db_foreach $sel_inco "" {

    if {$coimtgen(flag_stp_presso_terzo_resp) eq "T"
    &&  $flag_resp                            eq "T"
    } {;#13/11/2013
	# se è attivo l'apposito parametro ed il responsabile è un terzo, devo stampare
	# C/O l'indirizzo del terzo responsabile.
	# Con questa query leggo indirizzo as indirizzo_resp, cap as cap_resp, etc...
	# di coimmanu con cod_legale_rapp = :cod_responsabile
	db_0or1row sel_manu_resp "";#13/11/2013
    };#13/11/2013

    if {![string equal $ora_verifica_edit ""]} {
	set ora_verifica_stp " alle ore $ora_verifica_edit"
    } else {
	set ora_verifica_stp ""
    }
    # controllo se il codice opve ha come tre ultimi caratteri = '000' 
    # se cosi' visualizzo solo l'ente
    set iniz_cod_opve [expr [string length $cod_opve] -3]
    set fine_cod_opve [expr [string length $cod_opve] -1] 
    set extr_cod_opve [string range $cod_opve $iniz_cod_opve $fine_cod_opve]
    if {$extr_cod_opve == "000"} {
	set opve " della ditta $desc_enve"
    } else {
	set opve " $nome_opve della ditta $desc_enve"
    }

    set stampa ""
    append stampa $testata

    if {$potenza > 35} {
	set contr "biennale"
    } else {
	set contr "annuale"
    }
    set potenza_edit [iter_edit_num $potenza 2]

    if {$flag_dichiarato == "S"
    &&  $potenza <= 35
    } {
	set oneroso "N"
    } else {
	set oneroso "S"
    }

    switch $mese_corrente {
	"01" {set mese_anno "Gennaio $anno_corrente"}
	"02" {set mese_anno "Febbraio $anno_corrente"}
	"03" {set mese_anno "Marzo $anno_corrente"}
	"04" {set mese_anno "Aprile $anno_corrente"}
	"05" {set mese_anno "Maggio $anno_corrente"}
	"06" {set mese_anno "Giugno $anno_corrente"}
	"07" {set mese_anno "Luglio $anno_corrente"}
	"08" {set mese_anno "Agosto $anno_corrente"}
	"09" {set mese_anno "Settembre $anno_corrente"}
	"10" {set mese_anno "Ottobre $anno_corrente"}
	"11" {set mese_anno "Novembre $anno_corrente"}
	"12" {set mese_anno "Dicembre $anno_corrente"}
    }

    append stampa "
            <table border=0 width=100%>
               <tr>
                  <td width=50%>&nbsp;</td>
                  <td width=50% align=left>$luogo, $data_corrente</td>
               </tr>
               <tr><td colspan=2>&nbsp;</td></tr>
               <tr>
                  <td width=50%>&nbsp;</td>
                  <td width=50% align=left>Spett.le
                                       <br>$cognome_resp $nome_resp
                                       <br>$indirizzo_resp $numero_resp
                                       <br>$cap_resp $comune_resp $provincia_resp
                  </td>
               </tr>
            </table>
    <table width=100%>
               $protocollo
               $data_prot
               <tr>
                   <td valign=top colspan=2 width=100%>
                      <br>alla c.a. responsabile impianto termico / terzo Titolare dell'impianto termico responsabile
                   </td>
               </tr>
               <tr>
                  <td valign=top width=05%><b>OGGETTO:</b></td>
                  <td valign=top width=95%>
                     <b>Controllo dello stato di esercizio e manutenzione dell'impianto termico -
                     <br><u>preavviso di verifica</u>.</b>
                  </td>
               </tr>
               <tr>
                  <td colspan=2>&nbsp;</td>
               </tr>
               <tr>
                  <td valign=top colspan=2>
                    <div align=justify> 
                    $nome_ente ha avviato la campagna di controllo degli
                    impianti termici allo scopo di favorire il risparmio energetico, la
                    riduzione delle emissioni inquinanti e, attraverso l'attivazione
                    degli Enti competenti, la sicurezza degli impianti stessi. La legge
                    n.10/1991 e il DPR di attuazione n.412/1993, modificato dal DPR 
                    n.551/1999, stabiliscono, infatti, che <u>$prov_comu devono 
                    effettuare i controlli necessari a verificare, con onere a carico
                    degli utenti, l'effettivo stato di manutenzione e il rendimento
                    di combustione degli impianti di riscaldamento.</u></b>
                    <br><br>
                    Ai sensi della vigente normativa, &egrave; considerato responsabile
                    del corretto stato di esercizio e manutenzione dell'impianto 
                    termico ad uso riscaldamento o produzione centralizzata di acqua
                    calda per usi igienici e sanitari:
                    <ul>
                        <li><b>L'occupante a qualsiasi titolo dell'immobile per la 
                            durata dell'occupazione (proprietario, inquilino, ecc.)</b>
                            nel caso di edifici con impianti termici individuali 
                            (ossia di potenza inferiore a 35kW);
                        </li>
                        <li><b>L'Amministratore</b> di condominio negli edifici dotati
                            di impianti termici centralizzati;
                        </li>
                        <li>Nel caso di soggetti diversi delle persone fisiche,
                            obblighi e responsabilit&agrave; si intendono riferiti
                            <b>agli Amministratori</b>;
                        </li>
                        <li>In tutti i casi si pu&ograve; anche delegare la
                            responsabilit&agrave; dell'impianto ad un'impresa, 
                            cosiddetta <b>\"Terzo responsabile\"</b>.
                           <br>&nbsp;
                        </li>
                    </ul>
                    </div>
                  </td>
               </tr>
               <tr>
                  <td colspan=2 valign=bottom>
                     <table border=1>
                        <tr>
                           <td valign=bottom>
                              <p align=justify>
                              Le comunico pertanto che questo Ente, nell'esercizio delle
                              proprie funzioni, ha incaricato il Tecnico Verificatore 
                              <b>$nome_opve</b> (cell. <b>$cell_opve</b>), a ci&ograve; abilitato, di effettutare il 
                              controllo dell'impianto termico installato nell'immobile 
                              sito in 
                              <b>$indir - $cap_aimp $comu_aimp</b>.
                              <br>La verifica avr&agrave; luogo a partire dal mese $mese_anno.
                              </p>
                           </td>
                        </tr>
                     </table>
                 </td>
               </tr>
               <tr>
                 <td colspan=2>
                    <div align=justify>
                    <br>Il Verificatore &egrave; munito di tessera di riconoscimento con 
                    fotografia rilasciata dalla Provincia e si metter&agrave; in 
                    contatto con Lei per concordare la data e l'ora precise della 
                    verifica.
                    <br>Qualora Lei non corrisponda alla figura di responsabile dell'
                    impianto ovvero non ne abbia delega scritta dal proprietario, come
                    sopra definito, La prego di indicare al Verificatore, se possibile,
                    l'identit&agrave; di tale soggetto.
                    </div>
                    <br>
                 </td>
               </tr>
               <tr>
                  <td colspan=2 valign=bottom>
                     <table border=1>
                        <tr>
                           <td valign=bottom>
                              <p align=justify>
                              Nel caso l'impianto sia disattivato in via permanente, sia 
                              inserito in cicli di processo o sia dichiarato (solo per 
                              impianti di potenza inferiore a 35 kW), compili la dichiarazione
                              allegata e la spedisca tramite posta o fax ai recapiti sotto 
                              indicati, unitamente alla fotocopia di un documento di 
                              identit&agrave; in corso di validit&agrave; (fotocopia semplice,
                              senza marca da bollo).
                              </p>
                           </td>
                        </tr>
                     </table>
                  </td>
               </tr>
               <tr>
                  <td colspan=2>
                   <div align=justify>
                    <br>Nel caso il responsabile abbia provveduto alla dichiarazione 
                    del proprio impianto il costo della verifica risulta nullo.
                    "

	    # (A)questo append viene aggiunto per chiudere i tag DIV, TD, TR e 
            # TABLE. questa parte va aggiunta solo se nella stampa ho tolto 
            # le due pagine seguenti [vedi commento successivo indicato con(B)]
	    append stampa "
                    </div>
                 </td>
               </tr>
            </table>
               "

    set file_id   [open $file_html w]
    fconfigure $file_id -encoding iso8859-1
    puts $file_id $stampa
    close $file_id
    # lo trasformo in PDF
    iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --bottom 0cm -f $file_pdf $file_html]

    if {$ctr == 0} {
	puts $file_id2 $stampa
    } else {
        puts $file_id2 "<!-- PAGE BREAK -->"
        puts $file_id2 $stampa
    }

    if {[db_0or1row sel_aimp ""] == 0} {
	set nome_resp ""
    }

    append stampa3 "
    <tr>
       <td>$cod_impianto_est</td>
       <td>$nome_resp</td>
       <td>$indir</td>
       <td>$comune_resp</td>
    </tr>"

    set sql_contenuto  "lo_import(:file_html)"
    set tipo_contenuto [ns_guesstype $file_pdf]

    set contenuto_tmpfile  $file_pdf

    set flag_docu "S"
    if {[db_0or1row sel_docu ""] == 0} {
	set flag_docu "N"
	set cod_documento ""
    }
    if {$flag_anteprima != "T"} {
	with_catch error_msg {
	    db_transaction {
		
		if {[string equal $cod_documento ""]
		|| $flag_docu == "N"
		} {
		    db_1row sel_docu_next ""
		    set tipo_documento "AV"
		    db_dml dml_sql_docu [db_map ins_docu]
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
		
		db_dml dml_sql4 [db_map upd_inco]
		
	    }
	} {
	    iter_return_complaint "Spiacente, ma il DBMS ha restituito il
            seguente messaggio di errore <br><b>$error_msg</b><br>
            Contattare amministratore di sistema e comunicare il messaggio
            d'errore. Grazie."
	}
    }
    ns_unlink $file_html
    ns_unlink $file_pdf

    incr ctr

}

append stampa3 "</table>"

close $file_id2

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --bottom 0cm -f $file_pdf2 $file_html2]

# preparo link_inco e dett_tab solo ora, cioe' dopo l'aggiornamento sul db
if {$flag_inco == "S"} {
    set link_inco [iter_link_inco $cod_inco $nome_funz_caller $url_list_aimp $url_aimp $nome_funz $funzione $extra_par]
    set dett_tab [iter_tab_form $cod_impianto]
} else {
    set dett_tab ""
    set link_inco ""
}
ad_return_template
