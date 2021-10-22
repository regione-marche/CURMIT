ad_page_contract {

    @creation-date   14.06.2012

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimstat-boll-usati-layout.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    nic01 05/02/2015 Come chiesto da UCIT, bisogna fare il controllo anche sull'istanza
    nic01            collegata (per ora cablo, in futuro, fare tabella istanze collegate).

} {
    {f_data1           ""}
    {f_data2           ""}
    {f_manu_cogn       ""}
    {f_manu_nome       ""}
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
    if {$id_utente eq ""} {
	set login [ad_conn package_url]
	iter_return_complaint "Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
	return 0
    }
}

set link_filter [export_ns_set_vars url]

# imposto variabili usate nel programma:
set sysdate_edit  [iter_edit_date [iter_set_sysdate]]

iter_get_coimtgen;#nic01


# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# imposto le where_clause per la query
if {[string equal $f_data1 ""]} {
    set f_data1 "19000101"
    set data1_ok "01/01/1900"
} else {
    set data1_ok [iter_edit_date $f_data1]
}
if {[string equal $f_data2 ""]} {
    set f_data2 "21001231"
    set data2_ok "31/12/2100"
} else {
    set data2_ok [iter_edit_date $f_data2]
}
if {$cod_manutentore ne ""} {
    set where_cod_manu "and cod_manutentore= :cod_manutentore"
} else {
    set where_cod_manu ""
}
set where_data_controllo "and data_controllo between :f_data1 and :f_data2"

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file    "Stampa bollini applicati"
set nome_file    [iter_temp_file_name $nome_file]
set file_html    "$spool_dir/$nome_file.html"
set file_pdf     "$spool_dir/$nome_file.pdf"
set file_pdf_url "$spool_dir_url/$nome_file.pdf"

set titolo       "Stampa statistica bollini applicati"
set button_label "Stampa"
set page_title   "Stampa statistica bollini applicati"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

set root        [ns_info pageroot]
set stampa      ""

iter_get_coimdesc
set ente              $coimdesc(nome_ente)
set ufficio           $coimdesc(tipo_ufficio)
set indirizzo_ufficio $coimdesc(indirizzo)
set telefono_ufficio  $coimdesc(telefono)
set assessorato       $coimdesc(assessorato)

# Titolo della stampa
append stampa "<br><br>
               <hr>
               <b>STATISTICA BOLLINI APPLICATI DAL $data1_ok AL $data2_ok</b>
               <hr>
               <br><br>
               <center>
                 <table border=1>
                   <tr>
                     <td><b>Manutentore</b></td>
                     <td><b>Costo unitario</b></td>
                     <td><b>Num.Bollini</b></td>
                   </tr>"

# Costruisco descrittivi tabella
set inizio "S"
set conta 0

db_foreach query "
    select cod_manutentore, costo, count(*) as conta
      from coimdimp
     where 1 = 1
    $where_data_controllo
    $where_cod_manu
  group by cod_manutentore, costo
  order by cod_manutentore
" {
    set array_boll([list $cod_manutentore $costo]) $conta
}

set dbn_ente_collegato "";#nic01
if {$coimtgen(ente) eq "PUD"} {#nic01
    set dbn_ente_collegato "iterprgo";#nic01
} elseif {$coimtgen(ente) eq "PGO"} {#nic01
    set dbn_ente_collegato "iterprud";#nic01
};#nic01

if {$dbn_ente_collegato ne ""} {#nic01 (aggiunta tutta questa if)
    db_foreach -dbn $dbn_ente_collegato query "
    select cod_manutentore, costo, count(*) as conta
      from coimdimp
     where 1 = 1
    $where_data_controllo
    $where_cod_manu
  group by cod_manutentore, costo
  order by cod_manutentore
    " {
	if {![info exists array_boll([list $cod_manutentore $costo])]} {
	    set  array_boll([list $cod_manutentore $costo]) $conta
	} else {
	    incr array_boll([list $cod_manutentore $costo]) $conta
	}
    }
}

set lista_indici [array names array_boll];#Mette gli indici di array_boll in lista_indici
set lista_indici [lsort $lista_indici];#Ordina lista_indici
foreach indice $lista_indici {
    util_unlist $indice cod_manutentore costo
    set costo_pretty [iter_edit_num $costo 2]
    set conta        $array_boll($indice)

    if {![db_0or1row query "select cognome||' '||coalesce(nome, '') as manutentore from coimmanu where cod_manutentore = :cod_manutentore"]} {
	set manutentore "&nbsp;"
    }
    append stampa "<tr>
                     <td valign=top>$cod_manutentore $manutentore</td>
                     <td valign=top>&#8364; $costo_pretty</td>
                     <td valign=top>$conta</td>
                   </tr>"
}


append stampa "</table>
             </center>"

# creo file temporaneo html
set file_id [open $file_html w]
fconfigure $file_id -encoding iso8859-1
puts  $file_id $stampa
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer D / --quiet --landscape --bodyfont arial --left 1cm --right 1cm --top 0cm --bottom  0cm -f $file_pdf $file_html]

ns_unlink $file_html
ad_return_template
