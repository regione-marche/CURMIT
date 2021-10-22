ad_page_contract {

    @author          Paolo Formizzi Adhoc
    @creation-date   17/05/2004

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
    {f_data            ""}
    {f_tipo_data       ""}
    {f_cod_impianto    ""}
    {f_cod_tecn        ""}
    {f_cod_esito       ""}
    {f_cod_comune      ""}
    {f_cod_via         ""}
    {f_descr_via       ""}
    {f_descr_topo      ""}
    {f_tipo_estrazione ""}

    {f_cod_enve        ""}
    {f_cod_comb        ""}
    {f_anno_inst_da    ""}
    {f_anno_inst_a     ""}

    {flag_inco         ""}
    {extra_par         ""}
    {cod_impianto      ""}
    {url_list_aimp     ""}
    {url_aimp          ""}
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

# istruzioni gia' eseguite in /src
# set lvl 1
# set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# Personalizzo la pagina
set titolo       "Stampa Esito delle verifiche"
set page_title   "Stampa Esito delle verifiche"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

set pack_key     [iter_package_key]
set pack_dir     [apm_package_url_from_key $pack_key]
append pack_dir  "src"

set link_filter  [export_ns_set_vars url]
set extra_par_inco $extra_par

if {$flag_inco == "S"} {
    set link_inco [iter_link_inco $cod_inco $nome_funz_caller $url_list_aimp $url_aimp $nome_funz $funzione $extra_par_inco]
    set dett_tab [iter_tab_form $cod_impianto]
} else {
    set dett_tab  ""
    set link_inco ""
}

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

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]
set logo_dir_url  [iter_set_logo_dir_url]

# preparlo la routine che apre il file della stampa multipla
set apri_stampa_multipla {
    # imposto il nome dei file
    set nome_file2     "stampa esiti appuntamenti"
    set nome_file2      [iter_temp_file_name $nome_file2]
    set file_html2     "$spool_dir/$nome_file2.html"
    set file_pdf2      "$spool_dir/$nome_file2.pdf"
    set file_pdf_url2  "$spool_dir_url/$nome_file2.pdf"
    set file_doc2      "$spool_dir/$nome_file2.doc"
    set file_doc_url2  "$spool_dir_url/$nome_file2.doc"
    set file_id2       [open $file_html2 w]
    fconfigure $file_id2 -encoding iso8859-1

    set stampa3 "
<table border>
      <tr>
         <td align=center><b>Cod.impianto</b></td>
         <td align=center><b>Responsabile</b></td>
         <td align=center><b>Indirizzo   </b></td>
      </tr>"

    set ctr 0
}

set crea_stampa_multipla {
    append stampa3 "</table>"
    puts $file_id2 "
          </div>
       </body>
    </html>"
    close $file_id2

    iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 11 --portrait --top 1.5cm --bottom 1.5cm --left 2cm --right 2cm -f $file_pdf2 $file_html2]

    exec cp $file_html2 $file_doc2
}

# preparo la routine di stampa
set crea_stampa {
    # imposto il nome dei file
    set nome_file        "stampa esito appuntamento"
    set nome_file        [iter_temp_file_name $nome_file]
    set file_html        "$spool_dir/$nome_file.html"
    set file_pdf         "$spool_dir/$nome_file.pdf"

    set file_id          [open $file_html w]
    fconfigure $file_id -encoding iso8859-1
    puts $file_id $stampa
    puts $file_id "
          </div>
       </body>
    </html>"
    close $file_id

    # lo trasformo in PDF
    iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 11 --portrait --top 1.5cm --bottom 1.5cm --left 2cm --right 2cm -f $file_pdf $file_html]
}

# preparo la routine di scrittura sul database
set insert_coimdocu {
    set sql_contenuto  "lo_import(:file_html)"
    set tipo_contenuto [ns_guesstype $file_pdf]

    set contenuto_tmpfile  $file_pdf

    set flag_docu "S"
    if {[db_0or1row sel_docu ""] == 0} {
	set flag_docu "N"
	set cod_documento ""
    }

    # questa db_transaction non pretende di funzionare per tutti i record
    # della db_foreach ma per le varie query della singola stampa
    with_catch error_msg {
	db_transaction {
	    if {[string equal $cod_documento ""]
	    ||  $flag_docu == "N"
	    } {
		db_1row sel_docu_next ""
		set tipo_documento "EV"
		db_dml ins_docu ""
	    } else {
		db_dml upd_docu ""
	    }

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
	    db_dml upd_inco ""
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }

    ns_unlink $file_html
    ns_unlink $file_pdf
}

set scrivi_stampa_multipla {

   # in caso di stampa multipla creo un unico pdf
    if {$ctr == 0} {
	puts $file_id2 $stampa
    } else {
	puts $file_id2 "
        <br style=\"page-break-before:always\">"
	puts $file_id2 $stampa
    }
    
    if {[db_0or1row sel_aimp_2 ""] == 0} {
	set nome_resp ""
    }
    
    # elenco che apparira' a video
    append stampa3 "
    <tr>
        <td>$cod_impianto_est</td>
        <td>$nome_resp</td>
        <td>$indir</td>
    </tr>"

    incr ctr
}

# creo la form che permette di modificare la stampa:
set form_name     "coimstev"

form create $form_name

element create $form_name stampa \
-label   "Stampa html" \
-widget   textarea \
-datatype text \
-html    "cols 100 rows 150 class form_element" \
-optional

element create $form_name cod_inco      -widget hidden -datatype text -optional
element create $form_name funzione      -widget hidden -datatype text -optional
element create $form_name caller        -widget hidden -datatype text -optional
element create $form_name nome_funz     -widget hidden -datatype text -optional
element create $form_name nome_funz_caller -widget hidden -datatype text -optional
element create $form_name f_data        -widget hidden -datatype text -optional
element create $form_name f_cod_impianto -widget hidden -datatype text -optional
element create $form_name f_cod_tecn    -widget hidden -datatype text -optional
element create $form_name f_cod_esito   -widget hidden -datatype text -optional
element create $form_name f_cod_comune  -widget hidden -datatype text -optional
element create $form_name f_cod_via     -widget hidden -datatype text -optional
element create $form_name f_descr_via   -widget hidden -datatype text -optional
element create $form_name f_descr_topo  -widget hidden -datatype text -optional
element create $form_name f_tipo_estrazione -widget hidden -datatype text -optional
element create $form_name f_cod_enve    -widget hidden -datatype text -optional
element create $form_name f_cod_comb    -widget hidden -datatype text -optional
element create $form_name f_anno_inst_da -widget hidden -datatype text -optional
element create $form_name f_anno_inst_a -widget hidden -datatype text -optional
element create $form_name flag_inco     -widget hidden -datatype text -optional
element create $form_name extra_par     -widget hidden -datatype text -optional
element create $form_name cod_impianto  -widget hidden -datatype text -optional
element create $form_name url_list_aimp -widget hidden -datatype text -optional
element create $form_name url_aimp      -widget hidden -datatype text -optional

element create $form_name cod_impianto_est -widget hidden -datatype text -optional
element create $form_name indir            -widget hidden -datatype text -optional

element create $form_name submit        -widget submit -datatype text -label "Stampa" -html "class form_submit"

set flag_inco_request "N"
#if {[form is_request $form_name]} {
    if {$flag_inco == "S"} {
	set flag_inco_request "S"
    }


    db_1row sel_date ""

    if {![string equal $cod_inco ""]} {
	if {[db_0or1row sel_inco_2 ""] == 0} {
	    iter_return_complaint "Appuntamento non trovato"
	} else {
	    if {$stato != "8"} {
		iter_return_complaint "Appuntamento non in stato 'Effettuato'"
	    }
	}
    }

# preparo la stampa
iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)
set flag_ente   $coimtgen(flag_ente)
set sigla_prov  $coimtgen(sigla_prov)
set cod_prov    $coimtgen(cod_provincia)
set denom_comune $coimtgen(denom_comune)

if {$flag_ente == "P"} {
    set logo "[string tolower $flag_ente]r[string tolower $sigla_prov]-stp.gif"
} else {
    set logo "[string tolower $flag_ente][string tolower $denom_comune]-stp.gif"
}


    # imposto il filtro per incontro
    if {![string equal $cod_inco ""]} {
	set where_inco "and a.cod_inco = :cod_inco"
    } else {
	# per stampa multipla evito di ristampare documenti di esito gia'
	# stampati.
	set where_inco "and a.cod_documento_02 is null"
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
	if {(![string equal $f_descr_via ""]
	||   ![string equal $f_descr_topo ""])
	&&   [string equal $f_cod_via ""]
	} {
	    set f_descr_via1  [iter_search_word $f_descr_via]
	    set f_descr_topo1 [iter_search_word $f_descr_topo]
	    set where_via "
            and b.indirizzo like upper(:f_descr_via1)
            and b.toponimo  like upper(:f_descr_topo1)"
	}
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

    set testata {
<head>
  <style type="text/css">
     <!--
        body {
           font-family: Arial;
           font-size: 11pt;
           letter-spacing: 0.2pt;
        }
        small {
           font-size: 8pt;
        }
        @page Section1 {
           size:          portrait;
           margin-top:    1.5cm;
           margin-bottom: 1.5cm;
           margin-left:   2cm;
           margin-right:  2cm;
        }
        div.Section1 {
           page:Section1;
        }
     -->
  </style>
</head>
<body>
  <div class="Section1">
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
                              <br><b>$tipo_ufficio</b></td>
                </tr>
          </table>
      </td>
      <td width=10%>&nbsp;</td>
      <td width=30%>
            <img src=$logo_dir/$logo>
      </td>
  </table>
}
  # con questa tecnica posso scrivere l'html contenuto nella testata
  # senza mettere \" al posto di "
    set testata [subst $testata] 

    if {$flag_viario == "T"} {
	set sel_inco "sel_inco_si_viae"
    } else {
	set sel_inco "sel_inco_no_viae"
    }

    set flag_ente $coimtgen(flag_ente)
    if {$flag_ente == "C"} {
	set luogo $coimtgen(denom_comune)
    } else {
	set cod_prov $coimtgen(cod_provincia)
	if {[db_0or1row get_desc_prov ""] == 0} {
	    set luogo ""
	} else {
	    set luogo $desc_prov
	}
    }

    # in caso di stampa multipla preparo un unico pdf contenente tutte
    # le lettere
    if {$flag_inco != "S"} {
	eval $apri_stampa_multipla
    }

    set conta_inco 0
    db_foreach $sel_inco "" {
	incr conta_inco
	set stampa ""

	append stampa $testata

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
        <br><br>"

	if {$potenza > 35} {
	    set contr "biennale"
	} else {
	    set contr "annuale"
	}

	if {$flag_dichiarato == "S"
	&& $potenza <= 35
	} {
	    set oneroso "N"
	} else {
	    set oneroso "S"
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

	if {$esito == "N"} {

###mantova
	    append stampa "
            <table width=100%>
               $protocollo
               $data_prot
             <tr align=justify><td>Oggetto: <b>Controllo $contr dello stato di manutenzione degli impianti termici ai sensi della L. n° 10/1991 e D.P.R. n° 412/1993 - Esito del controllo ed invito alla <u>messa a norma dell'impianto termico</u>.</b></td></tr>
            <tr>
               <td>&nbsp;</td>
            </tr>
            </table>"

	    db_1row sel_ver ""
	    append stampa "
            <table width=100%>
             <tr align=justify>
                <td>A seguito del controllo effettuato in data $data_verifica sul generatore di calore sito in: $indir $comu $prov di cui la S.V. &egrave; responsabile, il tecnico abilitato al controllo $verificatore ha segnalato a Questa Amministrazione le seguenti anomalie e/o situazioni di non conformit&agrave; alle norme vigenti (art.31,III comma, L.n°10/1991 - art.11, comma 18, D.P.R.n°412/1993):</td>
            </tr>"

	    # questa non sarebbe una db_foreach, ma una db_0or1row perche'
	    # esiste uno ed un solo rapporto di verifica collegato
            # all'appuntamento ma non esiste un indice univoco.

	    db_foreach sel_cimp "" {
		append stampa "
                <tr>
                  <td><u>Generatore: $gen_prog_est</u></td>
                </tr>
                </table>
                <table>"

 		db_foreach sel_anom "" {
		    append stampa "
                    <tr>
                       <td><b>$cod_tanom: $descr_tano</b></td>
                    </tr>
		"
		}    
		append stampa "
                </table>
                <table>"
	    
		append stampa "
		    <tr>
                       <td>Osservazioni: $note_conf &nbsp; $note_verificatore</td>
                    </tr>"
	    }
	    append stampa "
            <tr><td>&nbsp;</td></tr>
            <tr align=justify>
               <td>La invitiamo pertanto a provvedere al ripristino delle normali condizioni di funzionamento, all'acquisizione della documentazione mancante e/o all'eliminazione dei problemi evidenziati (eventualmente specificare la tipologia di intervento da adottare) ed a inviare o consegnandola brevi mano debita comunicazione a questo Ente, compilando un apposito Modello di dichiarazione che si allega alla presente.</td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr align=justify>
               <td>Al modello di dichiarazione dovranno essere a sua volta allegati i seguenti documenti barrati:</td>
       <br>
       </table>
       <table width=100%>
            <tr align=justify>
               <td>_Una fotocopia del documento d'identit&agrave; del dichiarante;</td>
            </tr>
            <tr align=justify>
               <td>_Una copia del rapporto di controllo tecnico rilasciato, timbrato e firmato dal manutentore che provveder&agrave; all'eliminazione dei problemi evidenziati;</td>
            </tr>
            <tr align=justify>
               <td>_I risultati di una nuova verifica di combustione ('strisciata' relativa al controllo dei fumi) effettuata dal manutentore; la 'strisciata' deve essere timbrata e firmata dal manutentore;</td>
            </tr>
            <tr align=justify>
               <td>_Copia del certificato di prevenzione incendi (CPI/NOP);</td>
            </tr>
            <tr align=justify>
               <td>_Copia del certificato ISPESL o copia della raccomandata di richiesta sopralluogo dopo la valutazione positiva del progetto.</td>
            </tr>
            <tr align=justify>
               <td>In caso di sostituzioni andr&agrave; allegata anche oppurtuna dichiarazione di conformit&agrave; rilasciata timbrata e firmata dalla ditta che effettuer&agrave; l'intervento.</td>
            </tr>
            <tr align=justify>
               <td>Le ricordiamo che qualora il tecnico abilitato al controllo avesse dichiarato, sul rapporto tecnico a Lei rilasciato in copia, l'impianto 'non esercibile', questo potr&agrave; essere rimesso in funzione solo successivamente all'intervento della ditta di manutenzione che avr&agrave; provveduto all'eliminazione delle anomalie riscontrate.</td>
            </tr>
            <tr align=justify>
                <td>Qualora nel frattempo avesse gi&agrave; provveduto, La preghiamo di considerare nulla la presente, fermo restando che in ogni caso deve comunicarci, con l'apposito modello di dichiarazione allegato, l'avvenuta esecuzione degli interventi e/o eliminazione dei problemi evidenziati.</td>
           </tr>
            <tr><td>&nbsp;</td></tr>
          </table>
       <table width=100%>
           </tr>
            <tr><td>&nbsp;</td></tr>
       </table>
       <table width=100%>
          <tr align=justify>
              <td>Si fa presente che, successivamente alla mancata ricezione della dichiarazione di cui sopra da Voi compilata e/o, comunque, decorso il termine di <u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u> giorni dalla ricezione della presente, verr&agrave; ripetuta la verifica sull'impianto termico di cui in oggetto, con onere a carico del responsabile dell'impianto.</td>
          </tr>
          <tr align=justify>
             <td>Qualora in tale sede si accertasse la mancata regolarizzazione, la S.V. sar&agrave; soggetta alle sanzioni amministrative pecuniarie previste dalla Legge (art.34 comma 5 della Legge n. 10/1991).</td>
          </tr>
          <tr>
             <td>Si applicher&agrave; inoltre il disposto dell'art. 16, comma 6, del D.Lgs. 23/05/2000 n. 164, secondo cui, in caso di non conformit&agrave; alle prescrizioni del DPR n.412/1993 o in caso di reiterato rifiuto del responsabile a consentire le verifiche, la Provincia pu&ograve; chiedere alle imprese di distribuzione di gas naturale di sospenderne la fornitura all'impianto.</td>
          </tr>
          <tr align=justify>
             <td>Per qualsiasi informazione e/o chiarimenti la S.V. potr&agrave; rivolgersi al seguente ufficio: $assessorato $telefono</td>
          </tr>
            <tr>
               <td>&nbsp;</td>
            </tr>
          <tr>
             <td>Distinti saluti.</td>
          </tr>
        </table>
<table width=100%>
        <tr><td>&nbsp;</td></tr>
        <tr>
           <td>Allegato: modello di dichiarazione</td>
        </tr>
</table>"

	    append stampa "
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
    
	    if {[db_0or1row sel_aimp ""] == 0} {
		set nome_resp ""
		set data_nas ""
		set comune_nas ""
		set comune ""
		set indiriz ""
		set numero ""
	    }

	    if {[db_0or1row sel_docu_2 ""] == 0} {
		set protocollo_01 ""
	    }

	    append stampa "
            <!-- PAGE BREAK -->
             <table width=100%>
              <tr>
                 <td width=65%>&nbsp;</td>
                 <td align=left valign=top width=5%><b>Spett.</b> </td>
                 <td align=left width=30%><b>$nome_ente</b></td>
              </tr>
              <tr>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
                 <td align=left><b>Servizio $assessorato</b></td>
              </tr>
              <tr>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
                 <td align=left><b>$indirizzo</b></td>
              </tr>
              <tr>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
                 <td align=left><b>46100 Mantova</b></td>
              </tr>
            </table>
        <tr><td>&nbsp;</td></tr>
            <table width=100%>
              <tr>
                 <td align=center><big><b>Dichiarazione sostitutiva di atto di notoriat&agrave;</b></big></td>
              </tr>
              <tr>
                 <td align=center><small>(art.4 della Legge 4 gennaio 1968 n°15; art.3, comma 11, della Legge 15 maggio 1997 n° 127 - art.2 D.P.R. 20 ottobre 1998 n°403)</small></td>
             </tr>
             <tr><td>&nbsp;</td></tr>
             <tr>
                <td>Il/la sottoscritto/a __________________________________________</td>
             </tr>
             <br>
             <tr>
                <td>nato/a ____________________________________________ il ___________________</td>
             </tr>
             <br>
             <tr>
                <td>residente a _____________________ in via ___________________  n° _____ </td>
             </tr>
             <br>
             <tr>
               <td>in qualit&agrave; di responasabile dell'impianto termico ubicato in ___________________</td>
             </tr>
             <br>
             <tr align=justify>
                <td>consapevole delle responsabilit&agrave; e delle sanzioni penali stabilite dalla legge per false attestazioni e mendaci dichiarazioni, sotto la sua personale responsabilit&agrave; (art.26 L. n°15/1968),con riferimento all'Invito del $data_avviso_01 (Prot. n° $protocollo_01) ed inerente la messa a norma dell'impianto,</td>
             </tr>
             <tr><td>&nbsp;</td></tr>
             <tr>
                <td align=center><b>DICHIARA</b></td>
             </tr>
             <tr><td>&nbsp;</td></tr>
             <tr>
                <td>Che (specificare l'eliminazione dell'anomalia evidenziata e/o l'intervento effettuato).</td>
             </tr>
             <tr><td>&nbsp;</td></tr>
             <tr>
                <td width=100%><hr size=1></td>
             </tr>
             <tr>
                <td width=100%><hr size=1></td>
             </tr>
             <tr>
                <td width=100%><hr size=1></td>
             </tr>
             <tr>
                <td width=100%><hr size=1></td>
             </tr>
             <tr>
                <td width=100%><hr size=1></td>
             </tr>
             <tr>
                <td>Si allegano: (barrare le caselle corrispondenti).</td>
             </tr>
            </table>
            <table>
             <tr align=justify>
                <td>_ Fotocopia del documento d'identit&agrave; del dichiarante</td>
             </tr>
             <tr align=justify>
                <td>_ Copia del rapporto di controllo tecnico rilasciato, firmato e timbrato dal manutentore che ha provveduto all'eliminazione dei problemi evidenziati;</td>
             </tr>
             <tr align=justify>
                <td>_ I risultati di una nuova verifica di combustione (strisciata relativa al controllo dei fumi) effettuata dal manutentore;</td>
             </tr>
             <tr align=justify>
                <td>_ Fotocopia della dichiarazione di conformit&agrave; rilasciata, firmata e timbrata dalla ditta che ha effettuato l'intervento (solo in caso di sostituzioni);</td>
             </tr>
             <tr align=justify>
                <td>_ Copia del certificato di prevenzione incendi (CPI/NOP);</td>
             </tr>
            <tr align=justify>
               <td>_ Copia del certificato ISPESL o copia della raccomandatadi richiesta sopralluogo dopo la valutazione positiva del progetto.</td>
            </tr>
             <tr><td>&nbsp;</td></tr>
             <tr><td>&nbsp;</td></tr>
           </table>
           <table width=100%>
             <tr>
                <td>Data <u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</u></td>
             </tr>
             <tr>
                <td align=right>Il/La Dichiarante</td>
             </tr>
             <tr><td>&nbsp;</td></tr>
            </table>
            <br>
            <table width=100%>
             <tr align=justify>
                <td><small><b>N.B.:</b> Dichiarazione esente da autentica di firma ai sensi dell'art.3, comma 11, della legge 15 maggio 1997 n°27, cos&igrave; come modificato dall'art.2, commi 10 e 11, dalla legge 16/06/1998 n°191; esente da imposta di bollo ai sensi dell'art.14 Tabella B del D.P.R. n°642/72.</small></td>
             </tr>
            </table>
        "
###mantova

	} else {
	    append stampa "
            <table width=100%>
               $protocollo
               $data_prot
             <tr>
                <td>Oggetto:</td>
                <td><b>Controllo $contr dello stato di manutenzione degli impianti termici ai sensi della L. </b></td>
             </tr>
             <tr>
                <td>&nbsp;</td>
                <td><b>nÂ° 10/1991 e D.P.R. n° 412/1993 - Esito del controllo.</b></td>
             </tr>
             <tr>
                <td colspan=2>&nbsp;</td>
             </tr>
            </table>"

	    append stampa "
            <table width=100%>
             <tr>
                <td>A seguito del controllo effettuato sul generatore di calore sito in:</td>
             </tr>
             <tr>
                <td>$indir di cui ls S.V. &egrave; responsabile, il tecnico abilitato al controllo ha segnalato a Questa Amministrazione la conformit&agrave; dell'impianto alle norme vigenti (art.31,III comma, L.n°10/1991 - art.11, comma 18, D.P.R.n°412/1993).</td>
            </tr>
            <tr>
               <td>&nbsp;</td>
            </tr>
           </table>
           <table width=100%>
           <tr><td>&nbsp;</td></tr>
           <tr><td>&nbsp;</td></tr>

          </table>"
	}

	if {$coimtgen(flag_enti_compet) == "T"} {
	    db_1row sel_cimp_1 ""
	    db_1row sel_ver ""
	    set lista_enti [db_list_of_lists sel_ente ""]

	    foreach ente $lista_enti {
	        util_unlist $ente nome_ente indirizzo_ente numero_ente cap_ente comune_ente provincia_ente cod_area

	        append stampa "
                <br style=\"page-break-before:always\">"
	        append stampa $testata
	        append stampa "
              <table width=100%>
                 <tr>
                    <td valign=top width=40%>
                       <table width=100% border=1>
                       <tr>
                          <td>
                              Spazio riservato al Prot. Generale<br><br><br><br><br><br>
                          </td>
                       </tr>
                       </table>
                    </td>
                    <td width=10%>&nbsp;</td>
                    <td valign=top width=50%>
                      <div align=justify>
                        OGGETTO: controllo su impianto termico
                        <br>di <b>$indir</b> Livorno.
                      </div>
                    </td>
                 </tr>
                 <tr><td colspan=3>&nbsp;</td></tr>
                 <tr>
                    <td colspan=3 align=left>
                      Rif. N V. 
                      <br>C.I. $cod_impianto_est
                    </td>
                 </tr>
                 <tr>
                    <td colspan=2>&nbsp;</td>
                    <td>
                      <br>Al $nome_ente
                      <br>$indirizzo_ente $numero_ente
                      <br>$cap_ente $comune_ente 
                      <br>$provincia_ente
                    </td>
                 </tr>
                 <tr><td colspan=3>&nbsp;</td></tr>
              </table>
                  <div align=justify>
                    <br>&nbsp;&nbsp;&nbsp;
                    In relazione al controllo effettuato all'impianto termico
                    di cui all'oggetto e su indicazione del tecnico incaricato 
                    ($verificatore della ditta $desc_enve $tel_enve) 
                    si trasmette per competenza verbale di soppraluogo
                     del $data_verifica
                    le seguenti anomalie:<br>
                  </div>"

		db_foreach sel_anom "" {
		    append stampa "
                    <tr>
                       <td><b>$cod_tanom: $descr_tano</b></td>
                    </tr>
		"
		}

	        append stampa "
                   <br>
                   <br>&nbsp;&nbsp;&nbsp;
                    Distinti saluti.

                  <table width=100%>
                    <tr>
                       <td width=50%>&nbsp;</td>
                       <td width=50% align=center>
                          IL CAPO SETTORE
                          <br>(XXXXX)
                       </td>
                    </tr>
                  </table>"
	    }
	}

	if {$flag_inco == "S"} {
	    # nel caso della stampa singola visualizzo l'html prodotto
	    # permettendone la modifica (prima bisogna uscire dal ciclo)
	    # memorizzo alcuni campi che mi serviranno nella form is_valid
#	    element set_properties $form_name cod_impianto_est -value $cod_impianto_est
#	    element set_properties $form_name indir            -value $indir
	    eval $apri_stampa_multipla
	    eval $crea_stampa
	    eval $insert_coimdocu
	    eval $scrivi_stampa_multipla
	    eval $crea_stampa_multipla

	} else {

	    # altrimenti scrivo il file e lo memorizzo sul database.
	    eval $crea_stampa
	    eval $insert_coimdocu
	    eval $scrivi_stampa_multipla
	}
    }
    if {$flag_inco != "S"} {
	eval $crea_stampa_multipla
    }

#}

#if {[form is_valid $form_name]} {
    # in questo caso ci si arriva solo se flag_inco == "S"
    # leggo i dati di mappa che mi servono ora.
    # gli altri campi hidden sono gia' stati ricevuti come parametro
#    set stampa           [element::get_value $form_name stampa]
#    set cod_impianto_est [element::get_value $form_name cod_impianto_est]
#    set indir            [element::get_value $form_name indir]

    # reperisco l'eventuale cod_documento gia' stampato
    # (serve a insert_coimdocu)
#    if {[db_0or1row sel_inco_cod_documento ""] == 0} {
#	set cod_documento ""
#    }

    # scrivo il file e lo memorizzo sul database.
#    eval $apri_stampa_multipla
#    eval $crea_stampa
#    eval $insert_coimdocu
#    eval $scrivi_stampa_multipla
#    eval $crea_stampa_multipla
#}

ad_return_template
