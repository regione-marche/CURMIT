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
   {f_data1           ""}
   {f_data2           ""}
   {f_comune          ""}
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

if {[string equal $f_data1 ""]} {
    set f_data1 "18000101"
    set data1_ok "01/01/1800"
} else {
    set data1_ok [iter_edit_date $f_data1]
}
if {[string equal $f_data2 ""]} {
    set f_data2 "21001231"
    set data2_ok "12/31/2100"
} else {
    set data2_ok [iter_edit_date $f_data2]
}

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file        "Stampa statistica pesi"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set titolo       "Stampa statistica pesi"
set button_label "Stampa"
set page_title   "Stampa statistica pesi"
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

if {![string equal $f_comune ""]} {
    set where_comu "where cod_comune = :f_comune"
} else {
    set where_comu ""
}

# Costruisco descrittivi tabella

append stampa "<center><b>STATISTICA RAGGRUPPAMENTI PESI DAL $data1_ok AL $data2_ok</b>
                       <br><br>
                       <table border width=60% cellspacing=0 cellpadding=0>
                       <tr><td>COMUNE</td>
                           <td>RAGGRUPPAMENTO</td>
                       </tr>"
db_foreach sel_comu "" {

    append stampa "<tr><td><b>$comune</b></td>
                       <td><table border width=100% cellspacing=0 cellpadding=0>"

    db_foreach sel_pesi "" {

	append stampa "<tr><td>$raggruppamento</td>
                           <td>$conta_pesi</td>
                       </tr>"

    }
    append stampa "</table></td></tr>"
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
