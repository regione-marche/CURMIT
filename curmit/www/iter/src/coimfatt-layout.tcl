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

    USER   DATA         MODIFICHE
    ====   ==========  ======================================================
    gab01  15/03/2016  Aggiunte spese postali
    
    
} {
    
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {cod_fatt          ""}
    {cod_sogg          ""}
    {tipo_sogg         ""}

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
set nome_file     "stampa fattura"
set nome_file     [iter_temp_file_name $nome_file]
set file_html     "$spool_dir/$nome_file.html"
set file_pdf      "$spool_dir/$nome_file.pdf"
set file_pdf_url  "$spool_dir_url/$nome_file.pdf"

set file_id       [open $file_html w]
fconfigure $file_id -encoding iso8859-1

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
       <td>&nbsp;</td>
    </tr>
    <tr>
       <td>&nbsp;</td>
    </tr>
    <tr>   
      <td align=left width=100%>
        <img height=150 src=$logo_dir/mp.jpg>
      </td>
    
      <td valign=top align=right width=10%>
         &nbsp;
      </td>
   </tr>
    <tr>
       <td>&nbsp;</td>
    </tr>
    <tr>
       <td>&nbsp;</td>
    </tr>
</table>"

puts $file_id $testata

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

puts $file_id "
<table width=100%>
   <tr>
      <td align=left width=50%><big>FATTURA</big><br>Numero Fattura: $num_fatt</br>
                                                 <br>Ancona, l&igrave; $data_fatt</br></td>
      <td width=20%></td>
      <td align=left width=30%></td>
   </tr>"
if {$tipo_sogg == "M"} {
    puts $file_id "
<table width=100%>
    <tr>
       <td align=left width=50%>&nbsp;<td/>
       <td valign=top align=left>Spett.le </td>
       <td align=left>$m_cognome $m_nome
                     <br>$m_indirizzo
                     <br>$m_cap $m_localita $m_comune
                     <br><b>P.IVA n.</b> $m_piva
     </tr>
    "
}
if {$tipo_sogg == "C"} {
    puts $file_id "
     <tr>
       <td valign=top align=right >Spett.le</td>
       <td valign=top colspan=2 align=left >$c_cognome $c_nome
                                       <br>$c_indirizzo
                                       <br>$c_cap $c_localita $c_comune
                                       <br><b>P.IVA n.</b> $c_piva
     </tr>
"
}
puts $file_id "
    <tr>
       <td>&nbsp;</td>
    </tr>
    <tr>
       <td>&nbsp;</td>
    </tr>
    <tr>
</table> 
"
if {[db_0or1row sel_boll ""] == 0} {
    set matr_da ""
    set matr_a ""
    set n_bollini ""
    set imponibile 0
    set perc_iva 0
    set perc_iva_edit ""
    set flag_pag ""
    set spe_postali "" ;#gab01 
}

if {$spe_postali ne ""} {;#gab01 aggiunta if e contenuto

    set imponibile_spe_post     [expr 1.00 * $spe_postali * 100/(100 + 22)];#gab01
    set iva_spe_post            [expr 1.00 * $spe_postali - $imponibile_spe_post];#gab01
    
} else {
    set imponibile_spe_post 0
    set iva_spe_post 0
}

#sim01 set imp_iva [expr 100 + $perc_iva] 
#set iva [expr $imponibile * $perc_iva / 100]
#sim01 set totale $imponibile
#sim01 set imponibile [expr $imponibile / $imp_iva * 100]
#sim01 set iva [expr $totale - $imponibile]
#sim01 set imponibile [iter_edit_num $imponibile 2]
#sim01 set perc_iva [iter_edit_num $perc_iva 2]
#sim01 set iva_edit [iter_edit_num $iva 2]
#sim01 set totale_edit [iter_edit_num $totale 2]

set n_bollini1 ""
set n_bollini2 ""
set n_bollini3 ""
set n_bollini4 ""
set n_bollini5 ""
set n_bollini6 ""
set n_bollini7 ""

set tot_iva_10 0;#sim01
set tot_iva_22 0;#sim01
set tot_imponibile_10 0;#sim01
set tot_imponibile_22 0;#sim01
set totale 0;#sim01

puts $file_id  "
<table width=100% border=1>
    <tr>
        <td align=center valign=center width=15%>QUANTIT&Agrave;</td>
        <td align=center valign=center width=65%>DESCRIZIONE</td>
        <td align=center valign=center width=20%>IMPORTO</td>
    </tr>"

db_foreach query { 
    select nr_bollini  
    ,matricola_da
    ,matricola_a 
    ,imp_pagato   
    ,cod_tpbo    
    ,pagati
    ,perc_iva --sim01     
    from coimboll
    where cod_fatt = :cod_fatt
      and cod_tpbo is not null
    order by perc_iva,cod_tpbo --sim01  
} {

    set n_bollini1 ""
    set n_bollini2 ""
    set n_bollini3 ""
    set n_bollini4 ""
    set n_bollini5 ""
    set n_bollini6 ""
    set n_bollini7 ""
    
    set imponibile     [expr 1.00 * $imp_pagato * 100/(100 + $perc_iva)];#sim01
    set iva            [expr 1.00 * $imp_pagato - $imponibile];#sim01  
    set totale         [expr $totale + $imp_pagato];#sim01

    if {$perc_iva == 10} {;#sim01
	set tot_iva_10 [expr $iva + $tot_iva_10]
        set tot_imponibile_10 [expr $imponibile + $tot_imponibile_10]
    } else {
	set tot_iva_22 [expr $iva + $tot_iva_22]
        set tot_imponibile_22 [expr $imponibile + $tot_imponibile_22]
    }

    switch $cod_tpbo {
	"1" {
	    set n_bollini1 $nr_bollini
	    set matr_da1   $matricola_da
	    set matr_a1    $matricola_a
	    set perc_iva1  [iter_edit_num $perc_iva];#sim01
	    #sim01 set imp_pagato1 [expr $imp_pagato / $imp_iva * 100]
	    #sim01 set imp_pagato1 [iter_edit_num $imp_pagato1 2]
	    set imp_pagato1 [iter_edit_num $imponibile 2];#sim01

	}
	"2" { 
	    set n_bollini2 $nr_bollini
	    set matr_da2   $matricola_da
	    set matr_a2    $matricola_a
	    set perc_iva2  [iter_edit_num $perc_iva];#sim01
	    #sim01 set imp_pagato2 [expr $imp_pagato / $imp_iva * 100]
	    #sim01 set imp_pagato2 [iter_edit_num $imp_pagato2 2]
	    set imp_pagato2 [iter_edit_num $imponibile 2];#sim01
	}
	"3" { 
	    set n_bollini3 $nr_bollini
	    set matr_da3   $matricola_da
	    set matr_a3    $matricola_a
	    set perc_iva3  [iter_edit_num $perc_iva];#sim01
	    #sim01 set imp_pagato3 [expr $imp_pagato / $imp_iva * 100]
	    #sim01 set imp_pagato3 [iter_edit_num $imp_pagato3 2]
	    set imp_pagato3 [iter_edit_num $imponibile 2];#sim01
	}
	"4" {
	    set n_bollini4 $nr_bollini
	    set matr_da4   $matricola_da
	    set matr_a4    $matricola_a
	    set perc_iva4  [iter_edit_num $perc_iva];#sim01
	    #sim01 set imp_pagato4 [expr $imp_pagato / $imp_iva * 100]
	    #sim01 set imp_pagato4  [iter_edit_num $imp_pagato4 2]
	    set imp_pagato4 [iter_edit_num $imponibile 2];#sim01
	}
	"5" {
	    set n_bollini5 $nr_bollini
	    set matr_da5   $matricola_da
	    set matr_a5    $matricola_a
	    set perc_iva5  [iter_edit_num $perc_iva];#sim01
	    #sim01 set imp_pagato5 [expr $imp_pagato / $imp_iva * 100]
	    #sim01 set imp_pagato5  [iter_edit_num $imp_pagato5 2]
	    set imp_pagato5 [iter_edit_num $imponibile 2];#sim01
	}
	"6" {
	    set n_bollini6 $nr_bollini
	    set matr_da6   $matricola_da
	    set matr_a6    $matricola_a
	    set perc_iva6  [iter_edit_num $perc_iva];#sim01
	    #sim01 set imp_pagato6 [expr $imp_pagato / $imp_iva * 100]
	    #sim01 set imp_pagato6  [iter_edit_num $imp_pagato6 2]
	    set imp_pagato6 [iter_edit_num $imponibile 2];#sim01
	}
	"7" {
	    set n_bollini7 $nr_bollini
	    set matr_da7   $matricola_da
	    set matr_a7    $matricola_a
	    set perc_iva7  [iter_edit_num $perc_iva];#sim01
	    #sim01 set imp_pagato7 [expr $imp_pagato / $imp_iva * 100]
	    #sim01 set imp_pagato7  [iter_edit_num $imp_pagato7 2]
	    set imp_pagato7 [iter_edit_num $imponibile 2];#sim01
	}
    }

    set dicitura_uso ""
    if {$perc_iva == 10} {
       set dicitura_uso "uso abitativo" 
    } elseif {$perc_iva == 22} {
	set dicitura_uso "uso non abitativo"
    } 

if {$n_bollini1 ne ""} {
    puts $file_id  "
    <tr>
        <td align=center valign=center>$n_bollini1</td>
        <td align=center valign=center>Segno identificativo per impianto termico ai sensi della LR 19/2015, Regione Marche dal n. $matr_da1 al n. $matr_a1. (potenza maggiore o uguale a 10 e inferiore a 100 KW $dicitura_uso - IVA $perc_iva1%)</td>
        <td align=right valign=center>&#8364; $imp_pagato1</td>
    </tr>"
}
if {$n_bollini2 ne ""} {
    puts $file_id  "
    <tr>
        <td align=center valign=center>$n_bollini2</td>
        <td align=center valign=center>Segno identificativo per impianto termico ai sensi della LR 19/2015, Regione Marche dal n.  $matr_da2 al n. $matr_a2.(potenza maggiore a 100 KW e minore o uguale di 200 KW $dicitura_uso - IVA $perc_iva2%)</td>
        <td align=right valign=center>&#8364; $imp_pagato2</td>
    </tr>"
}

if {$n_bollini3 ne ""} {
    puts $file_id  "
    <tr>
        <td align=center valign=center>$n_bollini3</td>
        <td align=center valign=center>Segno identificativo per impianto termico ai sensi della LR 19/2015, Regione Marche dal n. $matr_da3 al n. $matr_a3.(potenza maggiore a 200 KW e minore o uguale di 300 KW $dicitura_uso - IVA $perc_iva3%)</td>
        <td align=right valign=center>&#8364; $imp_pagato3</td>
    </tr>"
}
if {$n_bollini4 ne ""} {
    puts $file_id  "
    <tr>
        <td align=center valign=center>$n_bollini4</td>
        <td align=center valign=center>Segno identificativo per impianto termico ai sensi della LR 19/2015, Regione Marche dal n.. $matr_da4 al n. $matr_a4. (potenza maggiore 300 KW $dicitura_uso - IVA $perc_iva4%)</td>
        <td align=right valign=center>&#8364; $imp_pagato4</td>
    </tr>"
}
if {$n_bollini5 ne ""} {
    puts $file_id  "
    <tr>
        <td align=center valign=center>$n_bollini5</td>
        <td align=center valign=center>Segno identificativo per impianto con macchine frigorifere/pompe di calore ai sensi della LR 19/2015, Regione Marche dal n. $matr_da5 al n. $matr_a5. (potenza maggiore a 12 KW e minore o uguale a 100 KW $dicitura_uso - IVA $perc_iva5%)</td>
        <td align=right valign=center>&#8364; $imp_pagato5</td>
    </tr>"
}
#if {$n_bollini6 ne ""} {
#    puts $file_id  "
#    <tr>
#        <td align=center valign=center>$n_bollini6</td>
#        <td align=center valign=center>Segno identificativo per impianto termico ai sensi della LR 19/2015, Regione Marche dal n. $matr_da6 al n. $matr_a6. (potenza maggiore a 12 KW e minore o uguale di 100 KW  - IVA $perc_iva6%)</td>
#        <td align=right valign=center>&#8364; $imp_pagato6</td>
#    </tr>"
#}
if {$n_bollini7 ne ""} {
    puts $file_id  "
    <tr>
        <td align=center valign=center>$n_bollini7</td>
        <td align=center valign=center>Segno identificativo per impianto con macchine frigorifere/pompe di calore ai sensi della LR 19/2015, Regione Marche dal n. $matr_da7 al n. $matr_a7. (potenza maggiore a 100 KW $dicitura_uso - IVA $perc_iva7%)</td>
        <td align=right valign=center>&#8364; $imp_pagato7</td>
    </tr>"
}
}

if {$imponibile_spe_post ne "0"} {;#gab01 aggiunta if e suo contenuto
    set imponibile_spe_post_edit [iter_edit_num $imponibile_spe_post 2]
    puts $file_id  "
    <tr>
        <td align=center valign=center></td>
        <td align=center valign=center>Spese postali</td>
        <td align=right valign=center>&#8364; $imponibile_spe_post_edit</td>
    </tr>"
    set tot_imponibile_22 [expr $imponibile_spe_post + $tot_imponibile_22] 
}

if {$iva_spe_post ne "0"} {;#gab01
    set tot_iva_22 [expr $iva_spe_post + $tot_iva_22]
}

if {$spe_postali ne ""} {;#gab01
    set totale [expr $spe_postali + $totale]
}


set totale_edit         [iter_edit_num $totale 2];#sim01
set dicitura_iva "";#sim01
set dicitura_tot_iva "";#sim01
set dicitura_imponibile "";#sim01
set dicitura_tot_imponibile "";#sim01

if {$tot_iva_10 != 0 } {;#sim01
    
    append dicitura_iva "<br>IVA 10 %"
    set tot_iva_10_edit [iter_edit_num $tot_iva_10 2]
    append dicitura_tot_iva "<br>&#8364; $tot_iva_10_edit"

}
if {$tot_iva_22 != 0 } {;#sim01
    
    append dicitura_iva "<br>IVA 22 %"
    set tot_iva_22_edit [iter_edit_num $tot_iva_22 2]
    append dicitura_tot_iva "<br>&#8364; $tot_iva_22_edit"

}

if {$tot_imponibile_10 != 0 } {;#sim01

    append dicitura_imponibile "<br>IMPONIBILE 10 %"
    set tot_imponibile_10_edit [iter_edit_num $tot_imponibile_10 2]
    append dicitura_tot_imponibile "<br>&#8364; $tot_imponibile_10_edit"

}
if {$tot_imponibile_22 != 0 } {;#sim01

    append dicitura_imponibile "<br>IMPONIBILE 22 %"
    set tot_imponibile_22_edit [iter_edit_num $tot_imponibile_22 2]
    append dicitura_tot_imponibile "<br>&#8364; $tot_imponibile_22_edit"

}

puts $file_id  "
    <tr>
        <td></td>
        <td align=right valign=top >$dicitura_imponibile
                                    <br>
                                    $dicitura_iva
        </td>
        <td align=right valign=top> $dicitura_tot_imponibile
                                    <br>
                                    $dicitura_tot_iva
        </td>
    </tr>
    <tr>
        <td></td>
        <td align=right valign=center><b>TOTALE FATTURA</b></td>
        <td align=right valign=top>&#8364; $totale_edit</td>
    </tr>
</table> 
"

puts $file_id "
 
<table width=100%>  
    <tr>
       <td>&nbsp;</td>
    </tr>
    <tr>
       <td>&nbsp;</td>
    </tr>
   <tr>
      <td>&nbsp;</td>
   </tr>
</table>
"

switch $flag_pag {
    "S" {set pag_edit   "PAGATO"}
    "N" {set pag_edit   ""}
    default {set pag_edit   ""}
}

puts $file_id "
 
    <table width=100%>  
         <tr>
            <td valign=center align=left>Modalit&agrave; Pagamento:</td>
            <td valign=center align=left><b><u><big>$mod_pag</big></u></b></td>
            <td valign=center align=right>&nbsp;</td> 
         </tr>
    </table>

    "

puts $file_id "

<table width=100%>
    <tr>
       <td>&nbsp;</td>
    </tr>
    <tr>
       <td>&nbsp;</td>
    </tr>
    <tr>
       <td valign=center align=left></td>
    </tr>
</table>
"

puts $file_id "

<table width=100%>
<tr>
  <td colspan=3>il sottoscritto dichiara: </td>
  <ul>
    <li>di aver ricevuto i bollini sopraindicati nelle quantità sopra riportate,</li>
    <li>che i quantitativi richiesti per uso abitativo e uso diverso da abitativo corrispondono alle richieste ed alle attività da svolgere presso gli impianti di sua competenza,</li>
    <li>si impegna a non utilizzare i bollini di colore verde per le certificazioni relative ad impianti per uso diverso dall'abitativo.</li>
  </ul>
</tr>
<tr>
  <td valign=center align=left><i></i></td>
  <td valign=center align=center><i>FIRMA __________</i></td>
  <td valign=center align=right><i></i></td>
</tr>
</table>

"

close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --footer ... --bottom 0cm  -f $file_pdf $file_html]

ns_unlink $file_html
ad_returnredirect $file_pdf_url
ad_script_abort
