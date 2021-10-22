ad_page_contract {
    Stampa lista bollettini postali

    @author          Simone Pesci
    @creation-date   08/07/2014

    @cvs-id          coimbpos-layout.tcl

} {
    {search_word             ""}
    {f_data_controllo_da     ""}
    {f_data_controllo_a      ""}
    {f_data_emissione_da     ""}
    {f_data_emissione_a      ""}
    {f_data_scarico_da       ""}
    {f_data_scarico_a        ""}
    {f_data_pagamento_da     ""}
    {f_data_pagamento_a      ""}
    {f_flag_pagati           ""}
    {f_quinto_campo          ""}
    {f_resp_cogn             ""}
    {f_resp_nome             ""}
    {f_cod_impianto_est      ""}
    {f_stato                 ""}

    {nome_funz               ""}

}

set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# Imposto variabili usate nel programma
set sysdate_edit  [iter_edit_date [iter_set_sysdate]]

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]

# imposto il nome dei file
set nome_file     "Stampa Bollettini Postali"
set nome_file     [iter_temp_file_name $nome_file]
set file_html     "$spool_dir/$nome_file.html"
set file_pdf      "$spool_dir/$nome_file.pdf"
set file_pdf_url  "$spool_dir_url/$nome_file.pdf"

set file_id       [open $file_html w]
fconfigure $file_id -encoding iso8859-1

iter_get_coimdesc
set nome_ente    $coimdesc(nome_ente)
set tipo_ufficio $coimdesc(tipo_ufficio)
set assessorato  $coimdesc(assessorato)
set indirizzo    $coimdesc(indirizzo)
set telefono     $coimdesc(telefono)

# Imposto filtro
if {![string equal $search_word ""]} {
    set f_resp_nome ""
} else {
    if {![string equal $f_resp_cogn ""]} {
        set search_word $f_resp_cogn
    }
}

if {[string equal $search_word ""]} {
    set where_word ""
} else {
    set search_word_1 [iter_search_word $search_word]
    set where_word  " and coimcitt.cognome like upper(:search_word_1)"
}

if {[string equal $f_resp_nome ""]} {
    set where_nome ""
} else {
    set f_resp_nome_1 [iter_search_word $f_resp_nome]
    set where_nome  " and coimcitt.nome like upper(:f_resp_nome_1)"
}

# imposto filtro per le date
if {![string equal $f_data_controllo_da ""] || ![string equal $f_data_controllo_a ""]} {
    if {[string equal $f_data_controllo_da ""]} {
        set f_data_controllo_da "18000101"
    }
    if {[string equal $f_data_controllo_a ""]} {
        set f_data_controllo_a  "21001231"
    }
    set where_data_controllo    "and coiminco.data_verifica between :f_data_controllo_da
                                                                and :f_data_controllo_a"
} else {
    set where_data_controllo ""
}

if {![string equal $f_data_emissione_da ""] || ![string equal $f_data_emissione_a ""]} {
    if {[string equal $f_data_emissione_da ""]} {
        set f_data_emissione_da "18000101"
    }
    if {[string equal $f_data_emissione_a ""]} {
        set f_data_emissione_a  "21001231"
    }
    set where_data_emissione    "and coimbpos.data_emissione between :f_data_emissione_da
                                                                 and :f_data_emissione_a"
} else {
    set where_data_emissione ""
}

if {![string equal $f_data_scarico_da ""] || ![string equal $f_data_scarico_a ""]} {
    if {[string equal $f_data_scarico_da ""]} {
        set f_data_scarico_da "18000101"
    }
    if {[string equal $f_data_scarico_a ""]} {
        set f_data_scarico_a  "21001231"
    }
    set where_data_scarico    "and coimbpos.data_scarico between :$f_data_scarico_da
                                                             and :$f_data_scarico_a"
} else {
    set where_data_scarico    ""
}

if {![string equal $f_data_pagamento_da ""] || ![string equal $f_data_pagamento_a ""]} {
    if {[string equal $f_data_pagamento_da ""]} {
        set f_data_pagamento_da "18000101"
    }
    if {[string equal $f_data_pagamento_a ""]} {
        set f_data_pagamento_a  "21001231"
    }
    set where_data_pagamento    "and coimbpos.data_pagamento between :f_data_pagamento_da
                                                                 and :f_data_pagamento_a"
} else {
    set where_data_pagamento    ""
}

if {![string equal $f_flag_pagati ""]} {
    if {[string equal $f_flag_pagati "S"]} {
	set where_pagati "and coimbpos.importo_pagato  > 0"
    }
    if {[string equal $f_flag_pagati "N"]} {
	set where_pagati "and coimbpos.importo_pagato <= 0"
    }
} else {
    set where_pagati ""
}

if {![string equal $f_quinto_campo ""]} {
    set where_quinto_campo "and coimbpos.quinto_campo = :f_quinto_campo"
} else {
    set where_quinto_campo ""
}

# I filtri su f_resp_cogn e f_resp_nome sono gia' stati impostati prima

if {![string equal $f_cod_impianto_est ""]} {
    set where_codimp_est " and coimaimp.cod_impianto_est = upper(:f_cod_impianto_est)"
} else {
    set where_codimp_est ""
}

if {![string equal $f_stato ""]} {
    set where_stato      " and coimbpos.stato = :f_stato"
} else {
    set where_stato      ""
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
      <th>Data<br>Estraz.</th>
      <th>Quinto campo</th>
      <th>Codice<br>Impianto</th>
      <th>Responsabile</th>
      <th>Data<br>Appuntamento</th>
      <th>Importo<br>Da Pagare</th>
      <th>Importo<br>Pagato</th>
      <th>Data<br>Pagamento</th>
      <th>Stato</th>
    </tr>"

set num_bpos           0
set tot_importo_emesso 0.0
set tot_importo_pagato 0.0
db_foreach sel_bpos "" {
    incr num_bpos
    set tot_importo_emesso [expr $tot_importo_emesso + $importo_emesso]
    set tot_importo_pagato [expr $tot_importo_pagato + $importo_pagato]

    if {[string is space $nominativo_resp]} {
	set nominativo_resp    "&nbsp;"
    }

    if {[string is space $data_verifica_edit]} {
	set data_verifica_edit "&nbsp;"
    }

    if {[string is space $data_pagamento_edit]} {
	set data_pagamento_edit "&nbsp;"
    }

    puts $file_id  "
    <tr>
      <td valign=top align=center>$data_emissione_edit</td>
      <td valign=top align=left  >$quinto_campo</td>
      <td valign=top align=left  >$cod_impianto_est</td>
      <td valign=top align=left  >$nominativo_resp</td>
      <td valign=top align=center>$data_verifica_edit</td>
      <td valign=top align=right >$importo_emesso_edit</td>
      <td valign=top align=right >$importo_pagato_edit</td>
      <td valign=top align=center>$data_pagamento_edit</td>
      <td valign=top align=left  >$stato</td>
    </tr>"
}

set tot_importo_emesso_edit [iter_edit_num $tot_importo_emesso 2]
set tot_importo_pagato_edit [iter_edit_num $tot_importo_pagato 2]

puts $file_id "
    <tr>
      <td valign=top colspan=5>Totale bollettini postali: $num_bpos</td>
      <td valign=top align=right>$tot_importo_emesso_edit</td>
      <td valign=top align=right>$tot_importo_pagato_edit</td>
      <td valign=top colspan=2>&nbsp;</td>
    </tr>
</table>"

close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --fontsize 10 --headfootfont arial --headfootsize 10 --landscape --left 1cm --right 1cm --top 1cm --bottom 1cm -f $file_pdf $file_html]

ns_unlink         $file_html
ad_returnredirect $file_pdf_url
ad_script_abort
