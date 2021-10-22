ad_page_contract {

    @author          Katia Coazzoli
    @creation-date   14/06/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimboll-layout.tcl
} {

    {nome_funz         ""}
    {nome_funz_caller  ""}
    {f_cod_manu        ""}
    {f_data_ril_da     ""}
    {f_data_ril_a      ""}
    {cod_manutentore   ""}
    {cod_bollini       ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# Controllo se il Database e' Oracle o Postgres
set id_db     [iter_get_parameter database]

# imposto variabili usate nel programma:
set sysdate_edit  [iter_edit_date [iter_set_sysdate]]

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file     "stampa bollini"
set nome_file     [iter_temp_file_name $nome_file]
set file_html     "$spool_dir/$nome_file.html"
set file_pdf      "$spool_dir/$nome_file.pdf"
set file_pdf_url  "$spool_dir_url/$nome_file.pdf"

set file_id       [open $file_html w]
fconfigure $file_id -encoding iso8859-1

# Personalizzo la pagina
set titolo       "Stampa lista bollini"
set page_title   "Stampa lista bollini"

iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set sigla_prov  $coimtgen(sigla_prov)
set denom_comune $coimtgen(denom_comune)
set cod_prov     $coimtgen(cod_provincia)

if {$flag_ente == "P"} {
    set logo "[string tolower $flag_ente]r[string tolower $sigla_prov]-stp.gif"
} else {
    set logo "[string tolower $flag_ente][string tolower $denom_comune]-stp.gif"
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

if {$flag_ente == "C"} {
    set luogo $denom_comune
} else {
    if {[db_0or1row get_desc_prov ""] == 0} {
	set luogo ""
    } else {
	set luogo $desc_prov
    }
}

# imposto i filtri ricevuti
if {![string equal $f_cod_manu ""]} {
    set where_manu                "and a.cod_manutentore = :f_cod_manu"
    set cod_manu_per_sel_manu     $f_cod_manu
} else {
    if {![string equal $cod_manutentore ""]} {
	set where_manu            "and a.cod_manutentore = :cod_manutentore"
	set cod_manu_per_sel_manu $cod_manutentore
    } else {
	set where_manu            ""
	set cod_manu_per_sel_manu ""
    }
}

if {![string equal $f_data_ril_da ""]} {
    set where_data_da "and a.data_consegna >= :f_data_ril_da"
} else {
    set where_data_da ""
}

if {![string equal $f_data_ril_a ""]} {
    set where_data_a "and a.data_consegna <= :f_data_ril_a"
} else {
    set where_data_a ""
}

if {![string equal $cod_bollini ""]} {
    set where_code "and a.cod_bollini = :cod_bollini"
} else {
    set where_code ""
}

set data_corrente [iter_edit_date [iter_set_sysdate]]

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
                              <br><b>$tipo_ufficio</b></td>
              </tr>
        </table>
    </td>
    <td width=10%>&nbsp;</td>
    <td width=30%>
          <img src=$logo_dir/$logo>
    </td>
</table>"

puts $file_id $testata

# se i bollini si riferiscono ad un solo manutentore, nell'intestazione
# devo mettere i dati del manutentore.
# se non ho valorizzato cod_manu_per_sel_manu perche' non e' stato
# passato nessun filtro relativo al codice_manutentore, lo reperisco
# dall'unico blocchetto da stampare se e' stato passato cod_bollini
if {[string equal $cod_manu_per_sel_manu ""]} {
    if {[string equal $cod_bollini       ""]
    ||  [db_0or1row sel_boll_cod_manu    ""] == 0
    } {
	set boll_cod_manu ""
    }
    set cod_manu_per_sel_manu $boll_cod_manu
}

if {[string equal $cod_manu_per_sel_manu ""]
||  [db_0or1row sel_manu ""] == 0
} {
    set manutentore    ""
    set manu_indirizzo ""
    set manu_tel       ""
    set manu_comune    ""
}

# se non ho trovato il manutentore o se alcuni suoi dati sono vuoti
# li valorizzo con degli underscore in modo che possano essere scritti
# a mano sul foglio stampato
if {[string is space $manutentore]} {
    set manutentore "______________________"
}
if {[string is space $manu_indirizzo]} {
    set manu_indirizzo "Via _____________________"
}
if {[string is space $manu_tel]} {
    set manu_tel "___________________"
}
if {[string is space $manu_comune]} {
    set manu_comune "__________________"
}

puts $file_id "
     <br>
     Il sottoscritto ______________________ titolare/rappresentante della 
     ditta $manutentore albo n. __________ <br>
     $manu_indirizzo comune $manu_comune telefono $manu_tel <br>
     Richiede e riceve la fornitura di \"Bollini\" come di seguito 
     specificato
     <br><br>
"

puts $file_id  "
    <table width=100% border=1>
    <tr>
        <th><small>Manutentore</small></th>
        <th><small>Data<br>Consegna</small></th>
        <th><small>Nr.<br>Bollini</small></th>
        <th><small>Nr.<br>Bollini<br>Resi</small></th>
        <th><small>Da<br>Matricola</small></th>
        <th><small>A<br>Matricola</small></th>
        <th><small>Costo<br>Unitario</small></th>
        <th><small>Pagati</small></th>
        <th><small>Data<br>Scadenza Pag.</small></th>
        <th><small>Tipologia</small></th>
        <th><small>Importo dovuto</small></th>
        <th><small>Importo Pagato</small></th>
        <th><small>Utente</small></th>
    </tr>"

set ctr            0
set tot_imp_dovuto 0
set tot_bollini    0
set tot_resi       0
db_foreach sel_boll "" {
    incr ctr

    if {[string is space $tipologia]} {
	set tipologia        "&nbsp;"
    }
    if {[string is space $manutentore]} {
	set manutentore        "&nbsp;"
    }

    if {[string is space $data_consegna_edit]} {
	set data_consegna_edit "&nbsp;"
    }

    if {[string is space $nr_bollini]} {
	set nr_bollini          0
    }
    set nr_bollini_edit        [iter_edit_num $nr_bollini 0]

    if {[string is space $nr_bollini_resi]} {
	set nr_bollini_resi     0
    }
    set nr_bollini_resi_edit   [iter_edit_num $nr_bollini_resi 0]

    if {[string is space $matricola_da]} {
	set matricola_da       "&nbsp;"
    }
    
    if {[string is space $matricola_a]} {
	set matricola_a        "&nbsp;"
    }

    if {[string is space $costo_unitario]} {
	set costo_unitario      0
    }
    set costo_unitario_edit    [iter_edit_num $costo_unitario 2]

    switch $pagati {
        "S" {set pagati_edit   "S&igrave;"}
        "N" {set pagati_edit   "No"}
    default {set pagati_edit   "&nbsp;"}
    }

    if {[string is space $data_scadenza_edit]} {
	set data_scadenza_edit "&nbsp;"
    }

    set importo [expr ($nr_bollini - $nr_bollini_resi) * $costo_unitario]
    set importo_edit           [iter_edit_num $importo 2]

    if {[string equal $nr_bollini ""]} {
	set nr_bollini          0
    }
    if {[string equal $nr_bollini_resi ""]} {
	set nr_bollini_resi     0
    }

    set tot_imp_dovuto [expr $tot_imp_dovuto + $importo]
    set tot_bollini    [expr $tot_bollini    + $nr_bollini]
    set tot_resi       [expr $tot_resi       + $nr_bollini_resi]

    puts $file_id  "
    <tr>
        <td valign=top align=center><small>$manutentore</small></td>
        <td valign=top align=center><small>$data_consegna_edit</small></td>
        <td valign=top align=right ><small>$nr_bollini_edit</small></td>
        <td valign=top align=right ><small>$nr_bollini_resi_edit</small></td>
        <td valign=top align=left  ><small>$matricola_da</small></td>
        <td valign=top align=left  ><small>$matricola_a</small></td>
        <td valign=top align=right ><small>$costo_unitario_edit</small></td>
        <td valign=top align=center><small>$pagati_edit</small></td>
        <td valign=top align=center><small>$data_scadenza_edit</small></td>
        <td valign=top align=center><small>$tipologia</small></td>
        <td valign=top align=right ><small>$importo_edit</small></td>
        <td valign=top align=right ><small>$imp_pagato</small></td>
         <td valign=top align=right ><small>$utente</small></td>
    </tr>
    "
}

if {![string equal $imp_sconto ""]
    && ![string equal $cod_bollini ""]} {
    set sconto_txt "<br><b>Importo da portare in detrazione: $imp_sconto</b>
                    <br><b>Note: $note</b><br>"
} else {
    set sconto_txt ""
}

if {$flag_ente == "P"
 && $sigla_prov == "MN"} {
    
    set tot_imp_dovuto_edit [iter_edit_num $tot_imp_dovuto 2]
    puts $file_id "
    <tr>
        <td colspan=2>Totale consegne: $ctr</td>
        <td valign=top align=right>$tot_bollini</td>
        <td valign=top align=right>$tot_resi</td>
        <td colspan=6 valign=top>&nbsp;</td>
        <td valign=top align=right>$tot_imp_dovuto_edit</td>
    </tr>
    </table>
     $sconto_txt
    <br>
     Pagamento: <br>
     - Presso Cassa Economato Provincia di Mantova;<br>
     - Ricevuta bollettino postale c/c13812466
       intestato: \"Provincia di Mantova\" Servizio Energia Via Principe
       Amedeo, 30
      Causale: \"Rilascio bollini verdi\"
    <br>
    <br>
    <table width=100%>
        <tr><td width=80%>&nbsp;</td>
            <td align=center wodth=20%>Il manutentore</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td align=right>_________________________</td>
        </tr>
    </table>
   "
} else {
    set tot_imp_dovuto_edit [iter_edit_num $tot_imp_dovuto 2]
    puts $file_id "    
    <tr>
        <td colspan=2>Totale consegne: $ctr</td>
        <td valign=top align=right>$tot_bollini</td>
        <td valign=top align=right>$tot_resi</td>
        <td colspan=6 valign=top>&nbsp;</td>
        <td valign=top align=right>$tot_imp_dovuto_edit</td>
    </tr>
</table>
<br>
<table width=100%>
    <tr><td width=80%>&nbsp;</td>
        <td align=center wodth=20%>Il manutentore</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td align=right>_________________________</td>
    </tr>
</table>
"
}

close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --footer ... --bottom 0cm --landscape -f $file_pdf $file_html]

ns_unlink $file_html
ad_returnredirect $file_pdf_url
ad_script_abort
