ad_page_contract {

    @author          Giulio Laurenzi
    @creation-date   09/06/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
    navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimmov2-layout.tcl

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    san01  30/08/2017 Gestito il nuovo campo data_incasso

} {
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {f_data_pag_da     ""}
    {f_data_pag_a      ""}
    {f_importo_da      ""}
    {f_importo_a       ""}
    {f_data_scad_da    ""}
    {f_data_scad_a     ""}
    {f_data_incasso_da    ""}
    {f_data_incasso_a     ""}
    {f_id_caus         ""}
    {f_tipo_pag        ""}
    {search_word       ""}
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
set nome_file        "stampa pagamenti"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set file_id     [open $file_html w]
fconfigure $file_id -encoding iso8859-1

# Personalizzo la pagina
set titolo       "Stampa avvisi di ispezione"
set page_title   "Stampa avvisi di ispezione"

iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set denom_comune $coimtgen(denom_comune)
set cod_prov $coimtgen(cod_provincia)

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

if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and upper(cod_movi) like upper(:search_word_1)"
}

# imposto filtro per data pagamento
if {![string equal $f_data_pag_da ""] || ![string equal $f_data_pag_a ""]} {
    if {[string equal $f_data_pag_da ""]} {
	set f_data_pag_da "18000101"
    }
    if {[string equal $f_data_pag_a ""]} {
	set f_data_pag_a "21001231"
    }
    set where_data_pag "and a.data_pag between :f_data_pag_da and :f_data_pag_a"
} else {
    set where_data_pag ""
}

# imposto filtro per data scadenza
if {![string equal $f_data_scad_da ""] ||  ![string equal $f_data_scad_a ""]} {
    if {[string equal $f_data_scad_da ""]} {
	set f_data_scad_da "18000101"
    }
    if {[string equal $f_data_scad_a ""]} {
	set f_data_scad_a "21001231"
    }
    set where_data_scad "and a.data_scad between :f_data_scad_da and :f_data_scad_a"
} else {
    set where_data_scad ""
}

# imposto filtro per data incasso
if {![string equal $f_data_incasso_da ""]
    ||  ![string equal $f_data_incasso_a ""]
} {#san01 if else e loro contenuto
    if {[string equal $f_data_incasso_da ""]} {
	set f_data_compet_da "18000101"
    }
    if {[string equal $f_data_incasso_a ""]} {
	set f_data_incasso_a "21001231"
    }
    set where_data_incasso "and a.data_incasso between :f_data_incasso_da and :f_data_incasso_a"
} else {
    set where_data_incasso ""
}


# imposto filtro per importo
if {![string equal $f_importo_da ""] || ![string equal $f_importo_a ""]} {
    if {[string equal $f_importo_da ""]} {
	set f_importo_da "0"
    }
    if {[string equal $f_importo_a ""]} {
	set f_importo_a "9999999999"
    }
    set where_importo "and a.importo between :f_importo_da and :f_importo_a"
} else {
    set where_importo ""
}


if {![string equal $f_tipo_pag ""]} {
    set where_tipo_pag "and a.tipo_pag = :f_tipo_pag"
} else {
    set where_tipo_pag ""
}

if {![string equal $f_id_caus ""]} {
    set where_id_caus "and a.id_caus = :f_id_caus"
} else {
    set where_id_caus ""
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
    </table>"

puts $file_id $testata

puts $file_id  "
    <table width=100% border=1>
    <tr>
      <th>Cod.</th>
      <th>Causale<br>Pagamento</th>
      <th>Codice<br>Impianto</th>
      <th>Imp.<br>Pagare</th>
      <th>Imp.<br>Pagato</th>
      <th>Data</th>
      <th>Data<br>Scadenza</th>
      <th>Data<br>Pagamento</th>
      <th>Data<br>Incasso</th><!-- san01 -->
      <th>Tipo<br>Pagamento</th>
      <th>Note</th>
    </tr>"

set ctr 0
set tot_imp_pagato 0
set tot_imp 0
db_foreach sel_movi "" {
    incr ctr
    if {[string equal $importo_pag ""]} {
	set importo_pag 0
    }
    if {[string equal $importo ""]} {
	set importo 0
    }
    set tot_imp_pagato [expr $tot_imp_pagato + $importo_pag]
    set tot_imp [expr $tot_imp + $importo]
    puts $file_id  "
    <tr>
      <td valign=top align=right>$cod_movi</td>
      <td valign=top>$desc_movi</td>
      <td valign=top>$cod_impianto_est</td>
      <td valign=top align=right>$importo_edit</td>
      <td valign=top align=right>$importo_pagato_edit</td>
      <td valign=top>$data_compet</td>
      <td valign=top>$data_scad</td>
      <td valign=top>$data_pag</td>
      <td valign=top>$data_incasso</td><!-- san01 -->
      <td valign=top>$desc_pag</td>
      <td>$nota</td>
    </tr>"
}

puts $file_id "    
       <tr>
         <td colspan=2>Totale mov: $ctr</td>
         <td>&nbsp;</td>
         <td valign=top align=right>$tot_imp</td>
         <td valign=top align=right>$tot_imp_pagato</td>
         <td colspan=5valign=top>&nbsp;</td>
       </tr>
     </table>"

close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --bottom 0cm --landscape -f $file_pdf $file_html]

ns_unlink $file_html
ad_returnredirect $file_pdf_url
ad_script_abort
#ad_return_template
