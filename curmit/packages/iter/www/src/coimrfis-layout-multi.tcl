ad_page_contract {

    @author          Valentina Catte
    @creation-date   15/03/2012

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimrfis-layout.tcl
} {
    
    {f_da_num_rfis     ""}
    {f_a_num_rfis      ""}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}


#set lvl 1
#set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# Controllo se il Database e' Oracle o Postgres
set id_db     [iter_get_parameter database]

iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)
set cod_comu $coimtgen(cod_comu)


# imposto variabili usate nel programma:
set sysdate_edit  [iter_edit_date [iter_set_sysdate]]

set var_fatt ""

if {$cod_comu == "54018"} {
   set var_fatt "FL"
} 

if {$cod_comu == "41044"} {
   set var_fatt "PS"
} 


# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file     "stampa ricevute"
set nome_file     [iter_temp_file_name $nome_file]
set file_html     "$spool_dir/$nome_file.html"
set file_pdf      "$spool_dir/$nome_file.pdf"
set file_pdf_url  "$spool_dir_url/$nome_file.pdf"

set file_id       [open $file_html w]
fconfigure $file_id -encoding iso8859-1

# Personalizzo la pagina

set titolo       "Stampa ricevuta bollini"
set page_title   "Stampa ricevuta bollini"


if {![string equal $f_da_num_rfis ""]
    && ![string equal $f_a_num_rfis ""]} {
    db_foreach sel_fatture "" {
	
	#if {[db_0or1row sel_boll ""] == 0} {
	#    set num_rfis ""
	#    set data_rfis ""
	#}
	
set pagina ""

set testata "
<table width=100%> 
    <tr><td colspan=3>&nbsp;</td></tr>
    <tr><td colspan=3>&nbsp;</td></tr>
    <tr>
      <td align=right width=46%><big>$num_rfis/$var_fatt</big></td>
      <td width=9%>&nbsp;</td>
      <td align=right width=45%><big>$num_rfis/$var_fatt</big></td>
    </tr>
    <tr><td colspan=3>&nbsp;</td></tr>
    <tr><td colspan=3>&nbsp;</td></tr>
    <tr>
      <td align=right width=46%>$data_rfis</td>
      <td width=9%>&nbsp;</td>
      <td align=right width=45%>$data_rfis</td>
    </tr>
    <tr><td colspan=3>&nbsp;</td></tr>
    <tr><td colspan=3>&nbsp;</td></tr>"

append pagina $testata

if {$tipo_sogg == "M"} {
    if {[db_0or1row sel_manu ""] == 0} {
	set m_nome ""
	set m_cognome ""
	set m_indirizzo ""
	set m_cap ""
        set m_localita ""
	set m_comune ""
	set m_piva ""
	set m_cod_fiscale ""
    }
} 

if {$tipo_sogg == "C"} {
    if {[db_0or1row sel_citt ""] == 0} {
	set c_nome ""
	set c_cognome ""
	set c_indirizzo ""
	set c_cap ""
        set c_localita ""
	set c_comune ""
	set c_piva ""
	set c_cod_fiscale ""
    }
}

if {$tipo_sogg == "M"} {
    append pagina "
           <tr>
             <td width=46%>$m_cognome $m_nome</td>
             <td width=9%>&nbsp;</td>
             <td width=45%>$m_cognome $m_nome</td>
           </tr>
           <tr>
             <td width=46%>$m_piva $m_cod_fiscale</td>
             <td width=9%>&nbsp;</td>
             <td width=45%>$m_piva $m_cod_fiscale</td>
           </tr>
           <tr>
             <td width=46%>$m_indirizzo</td>
             <td width=9%>&nbsp;</td>
             <td width=45%>$m_indirizzo</td>
           </tr>
           <tr>
             <td width=46%>$m_cap $m_localita $m_comune</td>
             <td width=9%>&nbsp;</td>
             <td width=45%>$m_cap $m_localita $m_comune</td>
           </tr>"
}
if {$tipo_sogg == "C"} {
    append pagina "
           <tr>
             <td width=46%>$c_cognome $c_nome</td>
             <td width=9%>&nbsp;</td>
             <td width=45%>$c_cognome $c_nome</td>
           </tr>
           <tr>
             <td width=46%>$c_piva $c_cod_fiscale</td>
             <td width=9%>&nbsp;</td>
             <td width=45%>$c_piva $c_cod_fiscale</td>
           </tr>
           <tr>
             <td width=46%>$c_indirizzo</td>
             <td width=9%>&nbsp;</td>
             <td width=45%>$c_indirizzo</td>
           </tr>
           <tr>
             <td width=46%>$c_cap $c_localita $c_comune</td>
             <td width=9%>&nbsp;</td>
             <td width=45%>$c_cap $c_localita $c_comune</td>
           </tr>"
}
append pagina "</table>"

if {[db_0or1row sel_boll ""] == 0} {
    set matr_da ""
    set matr_a ""
    set n_bollini ""
    set imponibile 0
    set perc_iva 21
    set perc_iva_edit ""
    set flag_pag ""
} 

if {$spe_postali == ""} {
set spe_postali 0
}

if {$spe_legali == ""} {
set spe_legali 0
}
set imp_iva [expr 100 + $perc_iva] 
#set iva [expr $imponibile * $perc_iva / 100]
set totale $imponibile
set imponibile [expr $imponibile / $imp_iva * 100]
set iva [expr $totale - $imponibile]
set imponibile [iter_edit_num $imponibile 2]
set perc_iva [iter_edit_num $perc_iva 2]
set iva_edit [iter_edit_num $iva 2]
set spe_legali [iter_check_num $spe_legali 2]
set spe_postali [iter_check_num $spe_postali 2]
set totale_edit [expr $totale + $spe_postali + $spe_legali]



append pagina "
  <table width=100%> 
    <tr><td colspan=5>&nbsp;</td></tr>
    <tr><td colspan=5>&nbsp;</td></tr>
    <tr>
      <td align=left width=37%>Si emette ricevuta per l'aquisto di Bollini verdi($n_bollini)</td>
      <td align=right width=9%>&#8344; $totale</td>
      <td width=9%>&nbsp;</td>
      <td align=left width=36%>Si emette ricevuta per l'aquisto di Bollini verdi($n_bollini)</td>
      <td align=right width=9%>&#8344; $totale</td>
    </tr>
    <tr>
      <td align=left width=37%>da n. $matr_da al n. $matr_a.</td>
      <td align=right width=9%>&nbsp;</td>
      <td width=9%>&nbsp;</td>
      <td align=left width=36%>da n. $matr_da al n. $matr_a.</td>
      <td align=right width=9%>&nbsp;</td>
    </tr>
     <tr>
      <td align=left width=37%>Spese Postali</td>
      <td align=right width=9%>&#8344; $spe_postali</td>
      <td width=9%>&nbsp;</td>
      <td align=left width=36%>Spese Postali</td>
      <td align=right width=9%>&#8344; $spe_postali</td>
    </tr>
    <tr>
      <td align=left width=37%>Spese Legali</td>
      <td align=right width=9%>&#8344; $spe_legali</td>
      <td width=9%>&nbsp;</td>
      <td align=left width=36%>Spese legali</td>
      <td align=right width=9%>&#8344; $spe_legali</td>
    </tr>
    <tr><td colspan=5>&nbsp;</td></tr>
    <tr><td colspan=5>&nbsp;</td></tr>
    <tr><td colspan=5>&nbsp;</td></tr>
    <tr><td colspan=5>&nbsp;</td></tr>
    <tr><td colspan=5>&nbsp;</td></tr>
    <tr><td colspan=5>&nbsp;</td></tr>
    <tr><td colspan=5>&nbsp;</td></tr>
    <tr>
      <td width=37%>&nbsp;</td>
      <td align=right width=9%>&#8364; $totale_edit</td>
      <td width=9%>&nbsp;</td>
      <td width=36%>&nbsp;</td>
      <td align=right width=9%>&#8364; $totale_edit</td>
    </tr>
    <tr><td colspan=5>&nbsp;</td></tr>
    <tr><td colspan=5>&nbsp;</td></tr>
    <tr>
      <td width=37%>&nbsp;</td>
      <td align=right width=9%>&#8364; $totale_edit</td>
      <td width=9%>&nbsp;</td>
      <td width=36%>&nbsp;</td>
      <td align=right width=9%>&#8364; $totale_edit</td>
    </tr>
  </table>"

puts $file_id "$pagina"
puts $file_id "<!-- PAGE BREAK -->"
 
    }
}

close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --footer ... --bottom 0cm  -f $file_pdf $file_html]

ns_unlink $file_html
ad_returnredirect $file_pdf_url
ad_script_abort



