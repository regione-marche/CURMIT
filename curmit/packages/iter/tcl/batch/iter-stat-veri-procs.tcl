ad_proc iter_stat_veri {
    {
	-cod_batc           ""
	-cod_cinc           ""
	-data_verifica_iniz ""
	-data_verifica_fine ""
    }
} {
    Elaborazione     Statistica verifiche
    @author          Giulio Laurenzi
    @creation-date   16/07/2004
    @cvs-id          iter_stat_veri

    nic01 30/05/2013 Corretta query nel file xql perche' non contava le anomalie.
                     Modificata la proc perche' Sandro vuole contare le anom. anche per le
                     verifiche con esito positivo.
} {
    # aggiorno stato di coimbatc
    iter_batch_upd_flg_sta -iniz $cod_batc

    with_catch error_msg {
	# imposto variabili usate nel programma:
	set sysdate_edit [iter_edit_date [iter_set_sysdate]]

	iter_get_coimtgen
	set flag_ente     $coimtgen(flag_ente)
	set denom_comune  $coimtgen(denom_comune)
	set cod_prov      $coimtgen(cod_provincia)
    
	iter_get_coimdesc
	set nome_ente     $coimdesc(nome_ente)
	set tipo_ufficio  $coimdesc(tipo_ufficio)
	set assessorato   $coimdesc(assessorato)
	set indirizzo     $coimdesc(indirizzo)
	set telefono      $coimdesc(telefono)
	set resp_uff      $coimdesc(resp_uff)
	set uff_info      $coimdesc(uff_info)
	set dirigente     $coimdesc(dirigente)

	# imposto la directory degli permanenti ed il loro nome.
	set permanenti_dir     [iter_set_permanenti_dir]
	set permanenti_dir_url [iter_set_permanenti_dir_url]
	set logo_dir           [iter_set_logo_dir]
    
	# imposto il nome dei file
	set nome_file     "Statistica Verifiche"
	set nome_file     [iter_temp_file_name -permanenti $nome_file]
	set file_html     "$permanenti_dir/$nome_file.html"
	set file_pdf      "$permanenti_dir/$nome_file.pdf"
	set file_pdf_url  "$permanenti_dir_url/$nome_file.pdf"
  
	set file_id       [open $file_html w]
	fconfigure $file_id -encoding iso8859-1

	# imposto le where_condition per la query
	set where_cond ""
        set where_cimp_cond ""
	set des_cond   ""

	if {![string equal $cod_cinc ""]} {
	    append where_cond "
               and cod_cinc = :cod_cinc"
    	    if {[db_0or1row sel_cinc ""] == 1} {
		append des_cond "<b>della campagna:</b> $des_cinc "
		if {[string equal $data_verifica_iniz ""]} {
		    append where_cimp_cond "and data_controllo >= :data_inizio "
		} 
		if {[string equal $data_verifica_fine ""]} {
		    append where_cimp_cond "and data_controllo <= :data_fine "
		}
	    }
	}
    
	if {![string equal $data_verifica_iniz ""]} {
	    append where_cond "
               and data_verifica  >= :data_verifica_iniz"
	    append where_cimp_cond "
               and data_controllo >= :data_verifica_iniz "
	    set data_verifica_iniz_ed [iter_edit_date $data_verifica_iniz]
	    append des_cond "<b>da data ispezione</b> $data_verifica_iniz_ed "
	}

	if {![string equal $data_verifica_fine ""]} {
	    append where_cond "
               and data_verifica <= :data_verifica_fine"
	    append where_cimp_cond "
               and data_controllo <= :data_verifica_fine "
	    set data_verifica_fine_ed [iter_edit_date $data_verifica_fine]
	    append des_cond "<b>a data ispezione</b> $data_verifica_fine_ed "
	}

	set conta_verifiche 0
	set conta_pos       0
	set conta_neg       0
	set cinc_old        ""
	set cinc_list       ""
	db_foreach sel_tano "" {
	    set conta($cod_tano) 0
	}
	set conta_tano      0

	db_foreach sel_inco "" {
	    if {$cinc_old != $cod_cinc_inco} {
		lappend cinc_list $cod_cinc_inco
		set cinc_old $cod_cinc_inco
	    }

	    if {[string equal $cod_cimp ""]} {
		db_foreach sel_cimp_inco "" {
 	            incr conta_verifiche
	    
	            if {$esito == "P"} {
			incr conta_pos
		    } else {
			incr conta_neg
		    };#nic01: ho aggiunto la chiusura della parentesi graffa
			db_foreach sel_anom "" {
			    incr conta($cod_tanom)
			    incr conta_tano
			}
		    #nic01; ho cancellato la chiusura della parentesi graffa
		}
	    } else {
		incr conta_verifiche
	    
		if {$esito == "P"} {
		    incr conta_pos
		} else {
		    incr conta_neg
		};#nic01: ho aggiunto la chiusura della parentesi graffa
		    db_foreach sel_anom "" {
			incr conta($cod_tanom)
			incr conta_tano
		    }
		    #nic01; ho cancellato la chiusura della parentesi graffa
	    }
	}
	set conta_verifiche_ed [iter_edit_num $conta_verifiche 0]
	set conta_pos_ed       [iter_edit_num $conta_pos       0]
	set conta_neg_ed       [iter_edit_num $conta_neg       0]

	set testata "
        <!-- FOOTER LEFT   \"$sysdate_edit\"-->
        <!-- FOOTER RIGHT  \"Pagina \$PAGE(1) di \$PAGES(1)\"-->
        <table width=100%>
              <tr>
                 <td align=center>$nome_ente</td>
              </tr>
              <tr>
                 <td align=center>$tipo_ufficio</td>
              </tr>
              <tr>
                 <td align=center>$assessorato</td>
              </tr>
              <tr>
                 <td align=center><small>$indirizzo</small></td>
              </tr>
              <tr>
                 <td align=center><small>$telefono</small></td>
              </tr>
        </table>
        <p align=center><big>Stampa statistica verifiche effettuate</big>
        "
	puts $file_id $testata
	if {![string equal $des_cond ""]} {
	    puts $file_id "<br>$des_cond"
	}

	puts $file_id  "
        </p>
        <table width=100% border=1>
           <tr>
               <th>Verifiche totali</th>
               <th>di cui positive</th>
               <th>di cui negative</th>"

	puts $file_id "
           </tr>
           <tr>
               <td align=right>$conta_verifiche_ed</td>
               <td align=right>$conta_pos_ed</td>
               <td align=right>$conta_neg_ed</td>"

        puts $file_id "
           </tr>
        </table>
        <p>&nbsp;</p>
        <table align=center border=1 width=100%>
            <tr><th colspan=2>Tipologie e frequenza delle anomalie</th></tr>
            <tr>
                <th align=left>Tipologia</th>
                <th align=left>Frequenza</th>
            </tr>"
    
	db_foreach sel_tano "" {
	    set frequenza [iter_edit_num $conta($cod_tano) 0]
	    puts $file_id "
               <tr>
                   <td align=left  valign=top>$cod_tano - $descr_tano</td>
                   <td align=right valign=top>$frequenza</td>
               </tr>
            "
	}
	puts $file_id "
            <tr>
               <td align=left  valign=top>Totale</td>
               <td align=right valign=top>$conta_tano</td>
            </tr>
        "

	puts $file_id "</table>"

	ns_log Notice "iter_stat_veri-$cod_batc-cod_cinc:$cod_cinc"
	ns_log Notice "iter_stat_veri-$cod_batc-cinc_list:$cinc_list"
	if {[string equal $cod_cinc ""]} {
	    puts $file_id "
            <p>&nbsp;</p>
            <table align=left border=1>
                <tr><th colspan=3>Campagne analizzate</th></tr>
                <tr>
                    <th align=left>Descrizione</th>
                    <th align=left>Data inizio</th>
                    <th align=left>Data fine</th>
                </tr>"
	    foreach cod_cinc $cinc_list {
		if {[db_0or1row sel_cinc ""] == 0} {
 		    set des_cinc    "&nbsp;"
		    set data_inizio_ed "&nbsp;"
		    set data_fine_ed   "&nbsp;"
		    puts $file_id "
                <tr>
                    <td align=left>$des_cinc</td>
                    <td align=left>$data_inizio_ed</td>
                    <td align=left>$data_fine_ed</td>
                </tr>"
		}
	    }
	    puts $file_id "</table>"
	}

	close $file_id
	
	iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --footer ... --bottom 0cm --landscape -f $file_pdf $file_html]

	ns_unlink $file_html

	set esit_list     ""
	set esit_riga     [list "Statistica verifiche" $file_pdf_url $file_pdf]
	lappend esit_list $esit_riga

	iter_batch_upd_flg_sta -fine $cod_batc $esit_list

	# fine with_catch    
    } {
	iter_batch_upd_flg_sta -abend $cod_batc
	ns_log Error "iter_stat_veri: $error_msg"
    }
    return
}
