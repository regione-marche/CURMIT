ad_page_contract {

    @author          Simone Pesci  
    @creation-date   06/09/2016

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimtarg-layout.tcl

    USER  DATA       MODIFICHE
    ===== ========== ==============================================================================================
    sim01 03/05/2018 Solo per Reggio Calabria visualizzo anche i logo della provincia nella stampa delle targhe

    gab01 27/12/2016 Aggiunta indicazione dell'utente che ha evaso l'ordine e della data di evasione nella stampa

} {

    {ordtarg_id ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

set lvl 1
#set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set id_utente [ad_conn user_id]

# Controllo se il Database e' Oracle o Postgres
set id_db     [iter_get_parameter database]

# imposto variabili usate nel programma:
set sysdate_edit  [iter_edit_date [iter_set_sysdate]]

# imposto la directory degli spool ed il loro nome.
set spool_dir       [iter_set_spool_dir]
set spool_dir_url   [iter_set_spool_dir_url]
#sim01 set logo_dir [iter_set_logo_dir]
set logo_dir       "[ns_info pageroot]/resources/img";#sim01


# imposto il nome dei file
set nome_file     "stampa targhe"
set nome_file     [iter_temp_file_name $nome_file]
set file_html     "$spool_dir/$nome_file.html"
set file_pdf      "$spool_dir/$nome_file.pdf"
set file_pdf_url  "$spool_dir_url/$nome_file.pdf"

set file_id       [open $file_html w]
fconfigure $file_id -encoding iso8859-1

# Personalizzo la pagina
set titolo       "Stampa lista targhe"
set page_title   "Stampa lista targhe"

set logo [parameter::get_from_package_key -package_key iter-portal -parameter stampe_logo_nome]

set height_logo "";#sim01

iter_get_coimdesc
set nome_ente    $coimdesc(nome_ente)
set tipo_ufficio $coimdesc(tipo_ufficio)
set assessorato  $coimdesc(assessorato)
set indirizzo    $coimdesc(indirizzo)
set telefono     $coimdesc(telefono)
set resp_uff     $coimdesc(resp_uff)
set uff_info     $coimdesc(uff_info)
set dirigente    $coimdesc(dirigente)

set data_corrente [iter_edit_date [iter_set_sysdate]]
set height_logo "height=60"

set db_name [db_get_database];#sim01

if {$db_name ne "iter-portal-prrc"} {#sim01 if e else e loro contenuto
    set logo_prov ""
} else {

    set logo_prov "<td width=40%>
         <img src=$logo_dir/logo_provincia_reggiocalabria1.jpg $height_logo>
    </td>"
}


#gab01
db_0or1row q "select editing_user
                   , editing_date 
                from iter_ordtarg 
                where ordtarg_id = :ordtarg_id"


set utente [db_string query "select first_names ||' '|| last_name from persons where person_id = :editing_user"] ;#gab01

set editing_date_pretty [ah::ansi_to_pretty_date $editing_date] ;#gab01

set testata "
<table width=100%>
<tr><td valign=top align=left width=40%><table width=100%>
              <tr><td><small>$indirizzo
                               <br>$telefono
                               <br>$uff_info
                               <br>Consegnato da $utente</small> <!-- gab01 -->
                  </td>
              </tr>
        </table>
    </td>
    <td valign=top align=left width=20%><table width=100%>
              <tr>
                 <td align=left>$nome_ente
                              <br><b>$tipo_ufficio</b></td>
              </tr>
        </table>
    </td>
   
    <td width=40%>
         <img src=$logo_dir/$logo $height_logo>
    </td>
    $logo_prov
</table>"


puts $file_id $testata

db_1row q "select maintainer_id
                , num_targhe as num_targhe_richieste 
                , delegato
                , vettore
                , consegna
             from iter_ordtarg 
            where ordtarg_id = :ordtarg_id"

if {$consegna eq "1"} {
    set dicitura_ritiro "Il sottoscritto* $vettore rappresentante"
    set nota_asterisco "* ovvero il vettore incaricato della ditta per la consegna mezzo posta assicurata"
} else {
    set dicitura_ritiro "Il sottoscritto* $delegato delegato"
    set nota_asterisco "* ovvero il delegato con delega"
}


if {![db_0or1row q "select name        as manutentore
                         , address1    as manu_indirizzo
                         , city        as manu_comune
                         , phone       as manu_tel
                     from iter_maintainers
                     where maintainer_id = :maintainer_id"]} {
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
     $dicitura_ritiro della 
     ditta $manutentore albo n. __________ <br>
     $manu_indirizzo comune $manu_comune telefono $manu_tel <br>
     Riceve le \"Targhe\" come di seguito 
     specificato
     <br><br>
"


puts $file_id  "
    <table width=100% border=1>
    <tr>
        <th><small>Manutentore</small></th>
        <th><small>Data<br>Consegna</small></th>
        <th><small>Nr. Targhe<br>Consegnate</small></th>
        <th><small>Nr. Targhe<br>Richieste</small></th>
        <th><small>Matrice</small></th>
        <th><small>Da</small></th>
        <th><small>A</small></th>
    </tr>"

set ctr            0
set tot_targhe    0
db_foreach q "select a.plico_id 
                   , b.name as manutentore
                   , iter_edit_data(a.data_consegna)     as data_consegna_edit
                   , a.matrice_fissa 
                   , a.matrice_da
                   , a.matrice_a
                   , count(c.*) as num_targhe
                from coimplic a
                   , iter_maintainers b
                   , coimtarg c
               where a.ordtarg_id    = :ordtarg_id
                 and b.maintainer_id = a.maintainer_id
                 and c.plico_id      = a.plico_id
            group by a.plico_id
                   , b.name                 
                   , iter_edit_data(a.data_consegna)
                   , a.matrice_fissa                          
                   , a.matrice_da
                   , a.matrice_a    
                   
" {
    incr ctr

    set tot_targhe    [expr $tot_targhe    + $num_targhe]

    if {[string is space $manutentore]} {
	set manutentore        "&nbsp;"
    }

    if {[string is space $data_consegna_edit]} {
	set data_consegna_edit "&nbsp;"
    }

    if {[string is space $matrice_fissa]} {
        set matrice_fissa       "&nbsp;"
    }

    if {[string is space $matrice_da]} {
	set matrice_da       "&nbsp;"
    }
    
    if {[string is space $matrice_a]} {
	set matrice_a        "&nbsp;"
    }

    puts $file_id  "
    <tr>
        <td valign=top align=left><small>$manutentore</small></td>
        <td valign=top align=center><small>$data_consegna_edit</small></td>
        <td valign=top align=center><small>$num_targhe</small></td>
        <td valign=top align=center><small>$num_targhe_richieste</small></td>
        <td valign=top align=center><small>$matrice_fissa</small></td>
        <td valign=top align=center><small>$matrice_da</small></td>
        <td valign=top align=center><small>$matrice_a</small></td>
    </tr>
    "
}

puts $file_id "    
    <tr>
        <td colspan=2><b>Totale consegne per plichi: $ctr</b></td>
        <td valign=top align=right>$tot_targhe</td>
    </tr>
</table>
<br>
<table width=100%>
    <tr>
        <td align=center width=20%>Per autorità competente</td>
        <td width=60%>&nbsp;</td>  
        <td align=center wodth=20%>Per la ditta</td>
    </tr>
    <tr>
        <td align=right>_________________________</td>
        <td>&nbsp;</td>
        <td align=right>_________________________</td>
    </tr>
</table>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
$nota_asterisco
<br>
<br>
<br>
Data di consegna: $editing_date_pretty
"

close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --footer ... --bottom 0cm --landscape -f $file_pdf $file_html]

ns_unlink $file_html
ad_returnredirect $file_pdf_url
ad_script_abort
