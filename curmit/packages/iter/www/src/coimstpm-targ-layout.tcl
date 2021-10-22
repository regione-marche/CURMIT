ad_page_contract {

    @author          giulio Laurenzi
\    @creation-date   09/06/2006

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

# Personalizzo la pagina
set titolo       "Stampa etichetta impianti"
set page_title   "Stampa etichetta impianti"
#[iter_context_bar -nome_funz $nome_funz_caller]

set pack_key     [iter_package_key]
set pack_dir     [apm_package_url_from_key $pack_key]
set context_bar  "<a href=\"$pack_dir/main\">Home</a>"
append pack_dir  "src"

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]
set logo_url      [apm_package_url_from_key $pack_key]/logo


# imposto il nome dei file
set nome_file        "stampa_etichette_impianti"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set file_id     [open $file_html w]
fconfigure $file_id -encoding iso8859-1

set data_corrente [iter_set_sysdate] 

iter_get_coimdesc
set nome_ente    $coimdesc(nome_ente)

iter_get_coimtgen

if {$coimtgen(flag_ente) eq "P"} {
    set logo_ente "pr[string tolower $coimtgen(sigla_prov)]-stp.gif"
} else {
    set logo_ente "c[string tolower $coimtgen(denom_comune)]-stp.gif"
}
set logo_regione "logo_regione_etichette.jpg"

set etichetta_aimp {
    append stampa_file "<table align=center border=0 width=100% cellspacing=2 cellpadding=2>"
    append stampa_file "<tr>
                          <td align=left valign=top height=40>
                            <img src=$logo_dir/$logo_regione border=0 height=31 width=30>
                          </td>
                          <td align=center><b>Regione Lombardia - $nome_ente</b></td>
                          <td align=right valign=top>
                            <img src=$logo_dir/$logo_ente border=0 height=30 width=35>
                          </td>
                        </tr>
                        <tr>
                           <td colspan=3 align=center><b>Impianto Termico N. $cod_impianto_est</b></td>
                        </tr>
                        <tr>
                           <td colspan=3 align=center><b>$indirizzo - $comune</b></td>
                        </tr>
                        <tr>
                           <td colspan=3 align=center height=60><img src=$jpg_output width=190 height=92></td>
                        </tr>
                   "
    append stampa_file "</table>"
}


set page_divider_number 10


set testata "<tr>
                <td align=center width=\"50%\"><b>Codice Impianto</b></td>
                <td align=center width=\"50%\"><b>Indirizzo</b></td>
             </tr>
             "

set stampa_web ""
set stampa_file ""
set conta_aimp 0

if {[exists_and_not_null conferma]} {
    append stampa_web "<table border=\"1\" align=\"center\">"
    append stampa_web $testata

    append stampa_file "<table border=1 cellspacing=\"6\" cellpadding=\"6\"align=\"center\" width=\"100%\">"
    foreach {cod_impianto} $conferma {
	db_1row sel_aimp ""
	incr conta_aimp

	db_dml upd_targa [db_map upd_aimp_targa]
       
	append stampa_web "<tr>
                             <td>$cod_impianto_est</td>
                             <td>$indirizzo $comune</td>
                           </tr>"
	
	set eps_output "$spool_dir/barcode_temp/$cod_impianto_est.eps"
	set jpg_output "$spool_dir/barcode_temp/$cod_impianto_est.jpg"
	set jpg_output_url "$spool_dir_url/barcode_temp/$cod_impianto_est.jpg"

	exec barcode -b $cod_impianto_est -e 128 -E -g 124x50 -o $eps_output
	exec eps2png -jpggray -scale=3 -o=$jpg_output $eps_output

	if {[expr $conta_aimp % 2] == 1} {
	    append stampa_file "<tr>"
	    append stampa_file "<td align=center width=50%>"
	    eval $etichetta_aimp
	    append stampa_file "</td>"
	} else {
	    append stampa_file "<td align=center width=50%>"
	    eval $etichetta_aimp
	    append stampa_file "</td>"
	    append stampa_file "</tr>"
	}
	if {[expr $conta_aimp /  $page_divider_number] == 1} {
	    set conta_aimp 0
	    append stampa_file "<!-- PAGE BREAK -->"
	}
	
    }
    append stampa_web "</table>"
    append stampa_file "</table>"

} else {
    set stampa_web "Nessun dato corrisponde ai criteri impostati."
}


#ns_return 200 text/html $stampa_file; return
puts $file_id $stampa_file
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 0.1cm --right 0.1cm --top 0.1cm --bottom 0.1cm -f $file_pdf $file_html]

ns_unlink $file_html

ad_return_template
