ad_page_contract {

    @author          Paolo Formizzi Adhoc
    @creation-date   21/05/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimveta-layout.tcl
} {
    {funzione        "V"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {cod_cinc         ""}
    {cod_enve         ""}
    {cod_opve         ""}
    {da_data_app      ""}
    {a_data_app       ""}
    {da_data_spe      ""}
    {a_data_spe       ""}
    {cod_comune       ""}
    {cod_area         ""}
    {flag_stato_appuntamento ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

#cod_opve, cod_cinc, cod_enve, da_data, a_data
#ns_return 200 text/html "$cod_opve|$cod_cinc|$cod_enve|$da_data_app|$a_data_app"; return

set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set link_filter [export_ns_set_vars url]

set cd_tecn  [iter_check_uten_opve $id_utente]

set opve_descrizione [db_string query "select cognome || ' ' || nome from coimopve where cod_opve=:cod_opve"]

# imposta le class css della barra delle funzioni
iter_set_func_class $funzione

# Personalizzo la pagina
set titolo       "Stampa estratto conto"
set page_title   "Stampa estratto conto"

set context_bar  [iter_context_bar -nome_funz $nome_funz]

# imposto variabili usate nel programma:
set sysdate_edit  [iter_edit_date [iter_set_sysdate]]


iter_get_coimtgen
set flag_viario $coimtgen(flag_viario)
set flag_ente   $coimtgen(flag_ente)
set sigla_prov  $coimtgen(sigla_prov)

iter_get_coimdesc
set nome_ente    $coimdesc(nome_ente)
set tipo_ufficio $coimdesc(tipo_ufficio)
set assessorato  $coimdesc(assessorato)
set indirizzo    $coimdesc(indirizzo)
set telefono     $coimdesc(telefono)
set resp_uff     $coimdesc(resp_uff)
set uff_info     $coimdesc(uff_info)
set dirigente    $coimdesc(dirigente)

set da_data_app_edit [iter_edit_date $da_data_app]
set a_data_app_edit  [iter_edit_date $a_data_app]

if {$da_data_app_edit == ""} {
    set da_data_app_edit "01/01/1900"
}

if {$a_data_app_edit == ""} {
    set a_data_app_edit "01/01/2100"
}

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
      <tr>
         <td align=center>&nbsp;</td>
      </tr>
</table>
<p align=center><b>Riepilogo verifiche eseguite da: $opve_descrizione nel periodo da $da_data_app_edit a $a_data_app_edit</b>
<p align=center><b>Decodifica : R = Ricaldamento, C = Cogenerazione , F = Raffreddamento, T = Teleriscaldamento</b>
"

set ctr 0

if {$flag_viario == "T"} {
    set sel_inco "sel_inco_si_viae"
} else {
    set sel_inco "sel_inco_no_viae"
}

set stampa ""


if {[db_0or1row sel_cinc ""] == 0} {
    iter_return_complaint "Campagna non trovata"
}

append stampa ""

if {$flag_ente == "P"
 && $sigla_prov == "LI"} {
    set order_by " order by a.data_verifica, a.ora_verifica"
} else {
    set order_by " order by c.ragione_01, nome_opve, a.data_verifica, a.ora_verifica"
}

if {![string equal $cod_comune ""]
&&  $flag_ente == "P"
} {
    if {[db_0or1row sel_desc_comu ""] == 0} {
	iter_return_complaint "Comune non presente in anagrafica"
    } else {
	append stampa "nel comune $desc_comune "
    }
    set where_comune "and d.cod_comune = :cod_comune "
} else {
    set where_comune ""
}
if {![string equal $cod_enve ""]} {
    if {[db_0or1row sel_enve ""] == 0} {
	iter_return_complaint "Ente verificatore non trovato"
    }
    append stampa ""
    set flag_enve "S"
} else {
    set flag_enve "N"
}

if {![string equal $cod_opve ""]} {
    if {[db_0or1row sel_opve ""] == 0} {
	iter_return_complaint "Ispettore non trovato"
    }

    if {[string equal $cod_enve ""]} {
	append stampa ""
    }
    append stampa ""
    set flag_opve "S"
} else {
    set flag_opve "N"
}

if {![string equal $flag_stato_appuntamento ""]} {
    set where_stato " and a.stato = :flag_stato_appuntamento"
    db_1row sel_desc_stato  ""
    append stampa "in stato $desc_stato "
} else {
    # se sono provincia di mantova e sono il manutentore, permetto di
    # estrarre solo gli incontri con lo stato superiore a quello spedito.

    if {$flag_ente == "P"
    &&  $sigla_prov == "MN"
    && ![string equal $cd_tecn ""]
    } {
	set where_stato "and a.stato >= 3"
    } else {
        set where_stato ""
    }
}

if {![string equal $cod_area ""]} {
    set where_area "and i.cod_area = :cod_area"
} else {
    set where_area ""
}

set where_data_app ""
set da_data_app_edit [iter_edit_date $da_data_app]
set a_data_app_edit  [iter_edit_date $a_data_app]

if {![string equal $da_data_app ""]
&&   [string equal $a_data_app ""]
} {
    append stampa ""
    set where_data_app " and a.data_verifica >= :da_data_app"
}

if { [string equal $da_data_app ""]
&&  ![string equal $a_data_app ""]
} {
    append stampa ""
    set where_data_app " and a.data_verifica <= :a_data_app"
} 

if {![string equal $da_data_app ""]
&&  ![string equal $a_data_app ""]
} {
    append stampa ""
    set where_data_app " and a.data_verifica between :da_data_app and :a_data_app"
}

set where_data_spe ""
set da_data_spe_edit [iter_edit_date $da_data_spe]
set a_data_spe_edit  [iter_edit_date $a_data_spe]

if {![string equal $da_data_spe ""]
&&   [string equal $a_data_spe ""]
} {
    append stampa "con data spedizione Dal $da_data_spe_edit "
    set where_data_spe " and a.data_avviso_01 >= :da_data_spe"
}

if { [string equal $da_data_spe ""]
&&  ![string equal $a_data_spe ""]
} {
    append stampa "con data spedizione fino a $a_data_spe_edit "
    set where_data_spe " and a.data_avviso_01 <= :a_data_spe"
} 

if {![string equal $da_data_spe ""]
&&  ![string equal $a_data_spe ""]
} {
    append stampa "con data spedizione compresa tra $da_data_spe_edit e $a_data_spe_edit "
    set where_data_spe " and a.data_avviso_01 between :da_data_spe and :a_data_spe"
}

append stampa "
</td></tr>
<tr>
   <td>&nbsp;</td>
</tr>
</table>
<table align=center border=1 cellspacing=0 celpadding=0>"

set enve_join_pos "inner join"
set enve_join_ora ""
set where_enve    " and c.cod_enve = :cod_enve"
set opve_join_pos "inner join"
set opve_join_ora ""
set where_opve " and a.cod_opve = :cod_opve"
set n_colspan 9
append stampa "<tr><th>Tipo Impianto</th><th>Data controllo</th><th>Impianto</th><th>Responsabile</th><th>Comune</th><th>Importo</th></tr>"

set conta_inco 0
db_foreach sel_costi "" {
    incr conta_inco
  
#dpr74  
     if {[string is space $flag_tipo_impianto]} {
	set flag_tipo_impiantot "&nbsp;"
    }
#dpr74
    if {[string is space $cod_impianto_est]} {
	set cod_impianto_est "&nbsp;"
    }

    if {[string is space $data_verifica]} {
	set data_verifica  "&nbsp;"
    }

    if {[string is space $denominazione]} {
	set denominazione "&nbsp;"
    }

    if {[string is space $responsabile]} {
	set responsabile "&nbsp;"
    }
    append stampa " 
        <tr>
           <td>$flag_tipo_impianto</td>
           <td>$data_verifica_edit</td>
           <td>$cod_impianto_est</td>
           <td>$responsabile</td>
           <td>$denominazione</td>
           <td align=\"right\">$importo</td>
        </tr>"
#     if {[string equal $conta_inco 16]} {
# 	append stampa "<tr><th>Data controllo</th><th>Impianto</th><th>Responsabile</th><th>Comune</th><th>Importo</th></tr>"	
#     }
} if_no_rows {
    if {$flag_enve == "S"
    &&  $flag_opve == "N"
    } {
	append stampa "
        <tr>
           <td colspan=$n_colspan align=center><b>Nessun appuntamento selezionato</b></td>
        </tr>"
    }
    if {$flag_opve == "S"} {
	append stampa "
        <tr>
           <td colspan=$n_colspan align=center><b>Nessun appuntamento selezionato</b></td>
        </tr>"
    }
    if {$flag_enve == "N"
    &&  $flag_opve == "N"
    } {
	append stampa "
        <tr>
           <td colspan=$n_colspan align=center><b>Nessun appuntamento selezionato</b></td>
        </tr>
        "
    }
}

db_foreach sel_totale "" {
    append stampa "<tr><td colspan=4 align=right>Numero controlli:</td><td align=right> <b>$conta_inco</b></td></tr>"
    append stampa "<tr><td colspan=4 align=right>Importo totale: </td><td align=right><b>$totale</b></td></tr>"
}
append stampa "</table>"
if {$conta_inco > 0} {
    set conta_inco [iter_edit_num $conta_inco]
    set conta "
    <br>
    <table width=100%><tr>
    <th align=center>"
} else {
    set conta "
    <br>
    <table width=100%><tr>
    <th align=center>"
}
set stampa_tot $testata
append stampa_tot  $conta 
append stampa_tot $stampa
set stampa $stampa_tot

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file        "stampa statistiche incontri-appuntamenti"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set file_id   [open $file_html w]
fconfigure $file_id -encoding iso8859-1
puts $file_id $stampa
close $file_id

# lo trasformo in PDF
# per ruotare il foglio inserire il parametro --landscape
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 10 --left 1cm --right 1cm --top 1cm --bottom 1cm -f $file_pdf $file_html]

ad_return_template
