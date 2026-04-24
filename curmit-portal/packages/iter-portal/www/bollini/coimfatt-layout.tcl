ad_page_contract {

    @author          Valentina Catte
    @creation-date   13/10/2005

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
    navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimfatt-layout.tcl

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================
    sim01  25/07/2017 Gestito split payment


} {
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {cod_fatt          ""}
    {cod_sogg          ""}
    {tipo_sogg         ""}
    {is_admin_p        ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
set id_utente [auth::require_login]

db_1row query "select id_utente as id_utente_fatt from coimfatt where cod_fatt = :cod_fatt"
if {$id_utente_fatt eq "1522"} {
    ad_return_complaint 1 "Fattura importata: stampa non possibile"
}


# Controllo se il Database e' Oracle o Postgres
set id_db     [iter_get_parameter database]

iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)
set cod_comu $coimtgen(cod_comu)

set var_fatt ""
if {$cod_comu eq "54018"} {
    set var_fatt "FL"
} 
if {$cod_comu eq "41044"} {
    set var_fatt "PS"
} 

# imposto variabili usate nel programma:
set sysdate_edit  [iter_edit_date [iter_set_sysdate]]

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file     "stampa fattura"
set nome_file     [iter_temp_file_name $nome_file]
set file_html     "$spool_dir/$nome_file.html"
set file_pdf      "$spool_dir/$nome_file.pdf"
set file_pdf_url  "$spool_dir_url/$nome_file.pdf"

set file_id       [open $file_html w]
#fconfigure $file_id -encoding iso8859-1
fconfigure $file_id -encoding iso8859-15

# Personalizzo la pagina
set titolo       "Stampa fattura bollini"
set page_title   "Stampa fattura bollini"

if {[db_0or1row sel_boll ""] == 0} {
    set num_fatt ""
    set data_fatt ""
}

set testata "
<table width=100% > 
    <tr>   
      <td align=left width=100%>
        <img height=80 src=[ns_info pageroot]/resources/ucit.jpeg>
      </td>
   </tr>
    <tr>
       <td><font size=2><i>Società controllata e coordinata dalla Provincia di Udine</i></font></td>
    </tr>
</table>"

puts $file_id $testata

if {$tipo_sogg eq "M"} {
    if {[db_0or1row sel_manu ""] == 0} {
	set m_manutentore ""
	set m_indirizzo ""
	set m_cap ""
        set m_localita ""
	set m_comune ""
	set m_provincia ""
	set m_piva ""
	set m_cod_fiscale ""
    }
} elseif {$tipo_sogg eq "C"} {
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


puts $file_id "
<table width=100%>
   <tr>
      <td width=50%>&nbsp;</td>
      <td width=20%>&nbsp;</td>
      <td width=30%>&nbsp;</td>
   </tr> 
   <tr>
      <td align=left width=50%>Udine, $data_fatt
                           <br>Fattura n. 00$num_fatt/B/$anno</td>
      <td width=20%>&nbsp;</td>
      <td align=left width=30%></td>
   </tr>"

if {$tipo_sogg eq "M"} {
    if {$m_provincia eq ""} {
	set provincia ""
    } else {
	set provincia "($m_provincia)"
    }
    puts $file_id "
  <table width=100%>
    <tr>
      <td width=60%>&nbsp;</td>
      <td width=20%>&nbsp;</td>
      <td width=20%>&nbsp;</td>
    </tr> 
    <tr>
      <td width=60%>&nbsp;</td>
      <td valign=top colspan=2 align=left>Spett.le &nbsp;&nbsp;</td>
    </tr> 
    <tr>
      <td width=60%>&nbsp;</td>
       <td align=left colspan=2><b>[ad_quotehtml $m_manutentore]</b>
                     <br>$m_indirizzo
                     <br><u>$m_cap $m_comune</u> $provincia
    </tr>
    <tr>
      <td width=60%>&nbsp;</td>
      <td width=20%>&nbsp;</td>
      <td width=20%>&nbsp;</td>
    </tr>
    <tr>
      <td width=60% align=left>P.I. $m_piva
                <br>C.F. $m_cod_fiscale</td>
      <td width=20%>&nbsp;</td>
      <td width=20%>&nbsp;</td>
    </tr>"
} elseif {$tipo_sogg eq "C"} {
    puts $file_id "
  <table width=100%>
    <tr>
      <td width=50%>&nbsp;</td>
      <td width=20%>&nbsp;</td>
      <td width=30%>&nbsp;</td>
    </tr>
    <tr>
      <td width=50%>&nbsp;</td>
      <td width=20%>&nbsp;</td>
      <td width=30%>&nbsp;</td>
    </tr> 
    <tr>
      <td width=50%>&nbsp;</td>
      <td valign=top colspan=2 align=left>Spett.le &nbsp;&nbsp;</td>
    </tr> 
    <tr>
      <td width=50%>&nbsp;</td>
      <td valign=top colspan=2 align=left><b>$c_cognome $c_nome</b>
                                      <br>$c_indirizzo
                                      <br>$c_cap $c_localita $c_comune
                                      <br>$c_piva
                                      <br>$c_cod_fiscale
    </tr>"
}

puts $file_id "
 <table width=100%>
   <tr>
     <td width=100% align=justify>&nbsp;</td>
   </tr>
   <tr>
     <td width=100% align=justify>Progettazione, installazione, esercizio e manutenzione degli impianti termici degli edifici ai fini del contenimento dei consumi di energia. Contributo a carico degli utenti ai sensi dell'art. 4 comma 4 della L. 9 gennaio 1991 n. 10.</td>
   </tr>
   <tr>
     <td width=100%>&nbsp;</td>
   </tr>
 </table> "

if {[db_0or1row sel_boll ""] == 0} {
    set matr_da       ""
    set matr_a        ""
    set n_bollini     ""
    set imponibile     0
    set importo        0
    set perc_iva       0
    set perc_iva_edit "0,00"
    set flag_pag      ""
} 

if {$spe_postali eq ""} {
    set spe_postali 0
} else {
    set spe_postali [iter_check_num $spe_postali 2]
}
if {$spe_legali eq ""} {
    set spe_legali 0
} else {
    set spe_legali [iter_check_num $spe_legali 2]
}

#set imp_iva [expr 100 + $perc_iva] 
#set totale $imponibile
#set imponibile [expr $imponibile / $imp_iva * 100]
set totale $importo
set imp_iva [expr $importo - $imponibile]

set iva [expr $totale - $imponibile]
set imponibile [iter_edit_num $imponibile 2]
set perc_iva_edit [iter_edit_num $perc_iva 0]
set iva_edit [iter_edit_num $iva 2]

set spe_legali  0
set spe_postali 0
set totale_edit [expr $totale + $spe_postali + $spe_legali]
set totale_pretty [iter_edit_num $totale_edit 2]

set tabella_bollini "
  <table width=100% border=1>
    <tr>
        <td align=center valign=center width=12%>QUANTIT&Agrave;</td>
        <td align=center valign=center width=55%>DESCRIZIONE</td>
        <td align=center valign=center width=20%>PREZZO UNITARIO</td>
        <td align=center valign=center width=13%>IMPORTO</td>
    </tr>"

# ciclo sui bollini
db_foreach query "
    select iter_edit_data(o.data_prenotazione) as data_prenotazione
         , b.nr_bollini as num_bollini
         , lpad(matricola_da, 6, '0') as matricola_da
         , lpad(matricola_a, 6, '0')  as matricola_a
         , costo_unitario
         , b.cod_tpbo
         , c.descr_tpbo as tipo_bollino
         , consegna
      from coimboll b
           left outer join iter_ordboll o on b.ordboll_id = o.ordboll_id
           left outer join coimtpbo c on c.cod_tpbo = b.cod_tpbo
     where b.cod_fatt = :cod_fatt
" {
    set costo_unitario_netto 0
    set costo_totale 0

    set imp_iva [expr 100 + $perc_iva]
    set costo_unitario_netto [expr $costo_unitario * 100 / $imp_iva]

    set costo_totale [expr $num_bollini * $costo_unitario_netto]
    
    set costo_totale_pretty  [iter_edit_num $costo_totale 2]
    set costo_unitario_netto_pretty [iter_edit_num $costo_unitario_netto 2]
    if {$cod_tpbo eq "1"} {
	set tipo_bollino "G"
    } elseif {$cod_tpbo eq "2"} {
	set tipo_bollino "F1"
    } elseif {$cod_tpbo eq "3"} {
	set tipo_bollino "F2"
    } elseif {$cod_tpbo eq "4"} {
	set tipo_bollino "E"
    }

    append tabella_bollini "
    <tr>
        <td align=center align=center>$num_bollini</td>
        <td align=center align=left>&nbsp;&nbsp;Bollino $tipo_bollino * dal n. $matricola_da al n. $matricola_a</td>
        <td align=right align=center>$costo_unitario_netto_pretty</td>
        <td align=right align=center>&#8364; $costo_totale_pretty</td>
    </tr>"
}
append tabella_bollini "
  </table>
  <table width=100% border=0>
    <tr>
        <td align=center valign=center width=12%>&nbsp;</td>
        <td align=center valign=center width=55%>&nbsp;</td>
        <td align=center valign=center width=20%>&nbsp;</td>
        <td align=center valign=center width=13%>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align=right valign=top>IMPONIBILE
        </td>
        <td align=right valign=top>&#8364; $imponibile
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align=right valign=top>IVA $perc_iva_edit %
        </td>
        <td align=right valign=top>&#8364; $iva_edit
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align=right valign=center><b>TOTALE FATTURA</b></td>
        <td align=right valign=top><b>&#8364; $totale_pretty</b></td>
    </tr>
  </table>"
#<tr>
#<td></td>
#<td align=right valign=top >SPESE POSTALI (Es.art.10)
#</td>
#<td align=right valign=top>&#8364; $spe_postali
#</td>
#</tr>
#<tr>
#<td></td>
#<td align=right valign=top >SPESE LEGALI (Es.art.10)
#</td>
#<td align=right valign=top>&#8364; $spe_legali
#</td>
#</tr>


if {$consegna eq "1"} {
    db_1row query "
    select address_ass_posta||' -  '||coalesce(zipcode_ass_posta, '')||' '||coalesce(city_ass_posta, '') as indirizzo_consegna
      from iter_ordboll o, coimboll b
     where b.ordboll_id = o.ordboll_id
       and b.cod_fatt   = :cod_fatt
     limit 1"
    set ritiro "consegnati mezzo assicurata con spese postali in contrassegno al seguente indirizzo: $indirizzo_consegna"
} else {
    set ritiro "ritirati presso OASI Software S.r.l. "
}

if {$flag_split_payment eq "S"} {;#sim01
    set dicitura_split_payment "
   <tr>
     <td>Fattura soggetta a Split payment  di cui all'art. 17-ter del Dpr. n. 633/7</td>
   </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>   
"
} else {
    set dicitura_split_payment ""
}

puts $file_id  "$tabella_bollini"
puts $file_id "
 <table width=100%>  
   <tr>
     <td>&nbsp;</td>
   </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
   $dicitura_split_payment
   <tr>
     <td>Bollini prenotati il $data_prenotazione, $ritiro.</td>
   </tr>
   <tr>
     <td>&nbsp;</td>
   </tr>
   <tr>
     <td>Pagamento a mezzo bonifico bancario 60 gg d.f.f.m. presso gli istituti:</td>
   </tr>
   <tr>
     <td>- Banca di Cividale C/C IT 57 Z 05484 63740 025570412145;
     <br>- Banca Pop. di Vicenza C/C IT 77 Y 05728 12302 702570481703.</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
   </tr>
   <tr>
     <td>&nbsp;</td>
   </tr>
   <tr>
     <td><small>Note:</small></td>
   </tr>
   <tr>
     <td><small>* G : impianto con potenzialità fino a 35 KW
     <br>* F1 : impianto con potenzialità da 35 a 350 KW
     <br>* F2 : impianto con potenzialità superiore a 350 KW
     <br>* E : allegati F successivi al primo sullo stesso impianto</small></td>
   </tr>
   <tr>
     <td>&nbsp;</td>
   </tr>
   <tr>
     <td>&nbsp;</td>
   </tr>
   <tr>
     <td>&nbsp;</td>
   </tr>
 </table>"

puts $file_id "
<hr size=1>
<table width=100%>
    <tr>
      <td align=center width=100%><small>Oasi Software s.r.l. Sede: Via Pradamano, 2 - 33100 UDINE - Tel. 0432/421769 - Fax 0432/45766
      <br>C.F. e P.IVA 02431160304 - Capitale soc. &#8364; 30.000 i.v. - sito web: www.oasisoftware.it - email: info@oasisoftware.it</small></td>
    </tr>
</table>"

close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --footer ... --bottom 0cm  -f $file_pdf $file_html]

ns_unlink $file_html
ad_returnredirect $file_pdf_url
ad_script_abort
