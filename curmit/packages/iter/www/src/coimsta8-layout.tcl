ad_page_contract {
    @author          Giulio Laurenzi
    @creation-date   10/05/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coiminco-filter.tcl     
} {
    {da_data_cons      ""}
    {a_data_cons       ""}
    {da_data_scad      ""}
    {a_data_scad       ""}
    {nome_manu         ""}
    {cognome_manu      ""}
    {cod_manutentore   ""}
    {caller       "index"}
    {funzione         "V"}
    {nome_funz         ""}
    {nome_funz_caller  ""}   
}  -properties {
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

set link_filter [export_ns_set_vars url]

# imposto variabili usate nel programma:
set sysdate_edit  [iter_edit_date [iter_set_sysdate]]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file        "Stampa statistica bollini non pagati"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set titolo       "Stampa statistica "
set button_label "Stampa"
set page_title   "Stampa statistica bollini"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 
 
set root       [ns_info pageroot]
set stampa ""

iter_get_coimdesc
set ente              $coimdesc(nome_ente)
set ufficio           $coimdesc(tipo_ufficio)
set indirizzo_ufficio $coimdesc(indirizzo)
set telefono_ufficio  $coimdesc(telefono)
set assessorato       $coimdesc(assessorato)
# Titolo della stampa

set where_cond ""

if {![string equal $da_data_cons ""]} {
    append where_cond " and a.data_consegna >= :da_data_cons"
}
if {![string equal $a_data_cons ""]} {
    append where_cond " and a.data_consegna <= :a_data_cons"
}
if {![string equal $da_data_scad ""]} {
    append where_cond " and a.data_scadenza >= :da_data_scad"
}
if {![string equal $a_data_scad ""]} {
    append where_cond " and a.data_scadenza <= :a_data_scad"
}
if {![string equal $cod_manutentore ""]} {
    append where_cond " and a.cod_manutentore = :cod_manutentore"
}

# Costruisco descrittivi tabella

append stampa "<center><b>STATISTICA BOLLINI NON PAGATI</b>
                       <br><br>
                       <table border width=100% cellspacing=0 cellpadding=0>
                       <tr><td width=20%><b>Manutentore</b></td>
                           <td width=11%><b>Data consegna</b></td>
                           <td width=11%><b>Data scadenza</b></td>
                           <td width=11%><b>Nr. bollini</b></td>
                           <td width=11%><b>Costo unitario</b></td>
                           <td width=11%><b>Matr. da</b></td>
                           <td width=12%><b>Matr. a</b></td>
                           <td width=12%><b>Costo totale</b></td>
                       </tr>"

db_foreach sel_boll "" {

    set costo_tot [expr $nr_bollini * $costo_unitario]
    set costo_tot [iter_edit_num $costo_tot 2]
    append stampa "<tr><td width=20%>$manutentore</td>
                           <td width=11%>$data_consegna</td>
                           <td width=11%>$data_scadenza</td>
                           <td width=11%>$nr_bollini</td>
                           <td width=11%>$costo_unitario_ed</td>
                           <td width=11%>$matricola_da</td>
                           <td width=12%>$matricola_a</td>
                           <td width=12%>$costo_tot</td>
                       </tr>"

}
append stampa "</table></center>"

# creo file temporaneo html

set   file_id  [open $file_html w]
fconfigure $file_id -encoding iso8859-1
puts  $file_id $stampa
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer D / --quiet --landscape --bodyfont arial --left 1cm --right 1cm --top 2cm --bottom  2cm -f $file_pdf $file_html]

ns_unlink $file_html
#ad_returnredirect $file_pdf_url
#ad_script_abort
ad_return_template
