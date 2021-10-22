ad_page_contract {
    Stampa modello H impianto
    
    @author Giulio Laurenzi
    @creation-date 13/04/2004

    @cvs-id coimdimp-layout.tcl

    @param codice_dimp                 codice dimp
    
} {
    {cod_nove             ""}
    {funzione            "V"}
    {caller          "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}
    {extra_par            ""}
    {cod_impianto         ""}
    {url_aimp             ""} 
    {url_list_aimp        ""}
    {cod_impianto         ""}
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
    #set id_utente [ad_get_cookie iter_login_[ns_conn location]]
    set id_utente [iter_get_id_utente]
    if {$id_utente  == ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

set link_tab      [iter_links_form $cod_impianto $nome_funz_caller $url_list_aimp $url_aimp]
set dett_tab      [iter_tab_form $cod_impianto]
set logo_dir      [iter_set_logo_dir]
#set logo_dir "/www/logo"

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
set link_list_script {[export_url_vars last_cod_dimp caller nome_funz_caller nome_funz cod_impianto  url_list_aimp url_aimp]&[iter_set_url_vars $extra_par]}
set link_list        [subst $link_list_script]
set page_title       "Stampa Allegato IX"

set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

set checked "<img src=$logo_dir/check-in.gif>"
set not_checked "<img src=$logo_dir/check-out.gif>"

iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)

if {$flag_viario == "T"} {
    set sel_aimp_2 "sel_aimp_si_viae"
} else {
    set sel_aimp_2 "sel_aimp_no_viae"
}

if {[db_0or1row $sel_aimp_2 ""] == 0} {
    iter_return_complaint "Impianto non trovato"
} else {
    if {[db_0or1row sel_nove ""] == 0} {
	iter_return_complaint "Allegato non trovato"
    } else {

	if {[string range $cod_manutentore 0 1] == "MA"} {
	    db_0or1row sel_dati_manu ""
	} else {
	    db_0or1row sel_dati_citt ""
	}

	if {$flag_art_109 == "t"} {
	    set flag_art_109 $checked
	} else {
	    set flag_art_109 $not_checked
	}
	if {$flag_art_11 == "t"} {
	    set flag_art_11 $checked
	} else {
	    set flag_art_11 $not_checked
	}
	if {$flag_installatore == "t"} {
	    set flag_installatore $checked
	} else {
	    set flag_installatore $not_checked
	}
	if {$flag_manutentore == "t"} {
	    set flag_manutentore $checked
	} else {
	    set flag_manutentore $not_checked
	}
	if {[string equal $pot_termica_mw ""]} {
	    set pot_termica_mw "&nbsp"
	}
	if {[string equal $n_focolari ""]} {
	    set n_focolari "&nbsp"
	}
	if {[string equal $n_bruciatori ""]} {
	    set n_bruciatori "&nbsp"
	}
	if {[string equal $n_canali_fumo ""]} {
	    set n_canali_fumo "&nbsp"
	}
	if {[string equal $sez_min_canali ""]} {
	    set sez_min_canali "&nbsp"
	}
	if {[string equal $svil_totale ""]} {
	    set svil_totale "&nbsp"
	}
	if {[string equal $n_camini ""]} {
	    set n_camini "&nbsp"
	}
	if {[string equal $sez_min_camini ""]} {
	    set sez_min_camini "&nbsp"
	}

	#allegato IX
	set stampa2 "
    <font size = 2>
    <table width=100%>
        <tr><td align=center><b>ALLEGATO IX</b></td></tr>
        <tr><td align=center><b>Impianti termici civili</b></td></tr>
        <tr><td align=center><b>Parte 1</b></td></tr>
        <tr><td align=center><b>Modulo di denuncia</b></td></tr>
        <tr><td align=center><b>Cod. Impianto: $cod_impianto_est</b></td></tr>
        <tr><td>&bnsp;</td></tr>
        <tr><td>&nbsp;</td></tr>
        <tr><td align=left>Io sottoscritto $cognome_manu $nome_manu</td></tr>
        <tr><td align=left>in possesso dei requisiti di cui</td></tr>
        <tr><td>&nbsp;</td></tr>
        <tr><td align=left>$flag_art_109 all'articolo 109 del decreto del Presidente della Repubblica 6 giugno 2001, n. 380,</td></tr>
        <tr><td align=left>$flag_art_11 all'articolo 11 del decreto del Presidente della Repubblica 26 agosto 1993, n. 412,</td></tr>
        <tr><td>&nbsp;</td></tr>
        <tr><td align=left>dichiaro:</td></tr>
        <tr><td>&nbsp;</td></tr>
        <tr><td align=left>$flag_installatore di aver installato un impianto termico civile avente le seguenti caratteristiche, presso $indir</td></tr>
        <tr><td align=left>$flag_manutentore di essere responsabile dell'esercizio e della manutenzione di un impianto termico civile avente le seguenti caratteristiche presso $indir</td></tr>
        <tr><td>&nbsp;</td></tr>
    </table>
    <table width=100% border>
        <tr><td align=left colspan=2><b>1. Potenza termica nominale dell'impianto (MW): $pot_termica_mw</b></td></tr>
        <tr><td align=left colspan=2><b>2. Combustibili utilizzati: $combustibili</b></td></tr>
        <tr><td align=left colspan=2><b>3. Focolari:</b></td></tr>
        <tr><td align=left width=40%>numero totale:</td>
            <td align=left width=60%>$n_focolari</td>
        </tr>
        <tr><td align=left>potenza termica nominale di ogni singolo focolare (MW):</td>
            <td align=left>$pot_focolari_mw</td>
        </tr>
        <tr><td align=left colspan=2><b>4. Bruciatori e griglie mobili:</b></td></tr>
        <tr><td align=left>numero totale:</td>
            <td align=left>$n_bruciatori</td>
        </tr>
        <tr><td align=left>potenzialit&agrave; e tipo del singolo dispositivo (MW):</td>
            <td align=left>$pot_tipi_bruc</td>
        </tr>
        <tr><td align=left>apparecchi accessori:</td>
            <td align=left>$apparecchi_acc</td>
        </tr>
        <tr><td align=left colspan=2><b>5. Canali da fumo: </b>$n_canali_fumo</td></tr>
        <tr><td align=left>sezione minima (m<sup><small>2</small></sup>):</td>
            <td align=left>$sez_min_canali</td>
        </tr>
        <tr><td align=left>sviluppo complessivo (m):</td>
            <td align=left>$svil_totale</td>
        </tr>
        <tr><td align=left>aperture di ispezione:</td>
            <td align=left>$aperture_ispez</td>
        </tr>
        <tr><td align=left colspan=2><b>6. Camini:</b> $n_camini </td></tr>
        <tr><td align=left>sezioni minime (cm<sup><small>2</small></sup>):</td>
            <td align=left>$sez_min_camini</td>
        </tr>
        <tr><td align=left>altezze delle bocche in relazione agli ostacoli e alle strutture circostanti:</td>
            <td align=left>$altezze_bocche</td>
        </tr>
        <tr><td align=left><b>7. Durata del ciclo di vita dell'impianto:</b></td>
            <td align=left>$durata_impianto</td>
        </tr>
        <tr><td align=left><b>8. Manutenzioni ordinarie</b> che devono essere effettuate per garantire il rispetto dei valori limite di emissione per l'intera durata del ciclo di vita dell'impianto:</td>
            <td align=left>$manut_ordinarie</td>
        </tr>
        <tr><td align=left><b>9. Manutenzioni straordinarie:</b> che devono essere effettuate per garantire il rispetto dei valori limite di emissione per l'intera durata del ciclo di vita dell'impianto:</td>
            <td align=left>$manut_straord</td>
        </tr>
        <tr><td align=left><b>Varie:</b></td>
            <td align=left>$varie</td>
        </tr>
    </table>
    </font>
    <font size = 2>
    <table width=100%>
        <tr><td>&nbsp;</td></tr>
        <tr><td align=left>Dichiaro che tale impianto &egrave; conforme ai requisiti previsti dalla legislazione vigente in materia di prevenzione e limitazione dell'inquinamento atmosferico ed &egrave; idoneo a rispettare i valori limite di emissione previsti da tale legislazione per tutto il relativo ciclo di vita, ove siano effettuate le manutenzioni necessarie.</td></tr>
        <tr><td>$luogo_consegna, l&igrave; $data_consegna</td></tr>
        <tr><td>&nbsp;</td></tr>
        <tr><td align=right>$firma</td></tr>
</table>
</font>
"
	set nome_file2        "ALLEGATO IX"
	set nome_file2        [iter_temp_file_name $nome_file2]
	set file_html2        "$spool_dir/$nome_file2.html"
	set file_pdf2         "$spool_dir/$nome_file2.pdf"
	set file_pdf_url2     "$spool_dir_url/$nome_file2.pdf"
	
	set file_id2   [open $file_html2 w]
	fconfigure $file_id2 -encoding iso8859-1
	
	puts $file_id2 $stampa2
	close $file_id2
	
	# lo trasformo in PDF
	iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 1cm --bottom 0.2cm -f $file_pdf2 $file_html2]
	
	ns_unlink $file_html2
	ad_returnredirect $file_pdf_url2
    }
}

ad_script_abort

