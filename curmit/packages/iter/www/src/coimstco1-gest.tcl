ad_page_contract {
    Lista tabella "coimdimp"

    @author                  Giulio Laurenzi
    @creation-date           22/04/2005
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @cvs-id coimstco-aimp-gest.tcl 
} {
     nome_funz
    {nome_funz_caller  ""}
    {da_data           ""} 
    {a_data            ""}
    {cod_cind          ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
}

# Controlla lo user
set lvl        1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

set id_utente_modh [iter_check_uten_modh $id_utente]
if {![string equal $id_utente_modh ""]} {
    set where_id_utente "and id_utente = :id_utente_modh"
} else {
    set where_id_utente ""
}

iter_get_coimdesc
set ente              $coimdesc(nome_ente)
set ufficio           $coimdesc(tipo_ufficio)
set indirizzo_ufficio $coimdesc(indirizzo)
set telefono_ufficio  $coimdesc(telefono)
set assessorato       $coimdesc(assessorato)
set sysdate_edit  [iter_edit_date [iter_set_sysdate]]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

set page_title  "Numero Modelli"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]


if {![string equal $cod_cind ""]} {
    set where_cind "and a.cod_cind = :cod_cind"
} else {
    set where_cind ""
}
set campagna [db_string query "select descrizione from coimcind where cod_cind = :cod_cind" -default ""] 


if {![string equal $da_data ""]} {
    set where_da_data "and to_char(a.data_ins,'yyyymmdd') >= :da_data"
} else {
    set where_da_data ""
}
set da_data_edit [iter_edit_date $da_data]

if {![string equal $a_data ""]} {
    set where_a_data  "and to_char(a.data_ins,'yyyymmdd') <= :a_data"
    set where_a_data_nove  "and to_char(data_consegna,'yyyymmdd') <= :a_data"
} else {
    set where_a_data  ""
    set where_a_data_nove  ""
}
set a_data_edit [iter_edit_date $a_data]
if {[string equal $a_data_edit ""]} {
    set a_data_edit [iter_edit_date [iter_set_sysdate]]
}

set table "<table border=1 cellpadding=0 cellspacing=0>
           <tr>
               <td align=center><b>Utente di inserimento</b></td>
               <td align=center><b>Numero modelli</b></td>
           </tr>"

set save_settore ""
set tot_dimp_settore 0
set tot_dimp 0
db_foreach sel_count_dimp "" {
    if {[string equal $save_settore ""]} {
	set save_settore $id_settore
    } 
    
    if {$save_settore != $id_settore} {
	append table "<tr>
                          <td>Totale settore $save_settore</td>
                          <td>$tot_dimp_settore_edit</td>
                      </tr>"
	set save_settore $id_settore
	set tot_dimp [expr $tot_dimp + $tot_dimp_settore]
	set tot_dimp_settore $num_dimp
	set tot_dimp_settore_edit [iter_edit_num $tot_dimp_settore 0]
	append table "<tr>
                          <td>$nome_soggetto</td>
                          <td>$num_dimp</td>
                      </tr>"
    } else {
	append table "<tr>
                          <td>$nome_soggetto</td>
                          <td>$num_dimp</td>
                      </tr>"
	set tot_dimp_settore [expr $tot_dimp_settore + $num_dimp]
	set tot_dimp_settore_edit [iter_edit_num $tot_dimp_settore 0]
    }   
    
}
set tot_dimp [expr $tot_dimp + $tot_dimp_settore]
set tot_dimp_edit [iter_edit_num $tot_dimp 0]

if {$tot_dimp_settore > 0} {
    append table "<tr>
                      <td>Totale settore $save_settore</td>
                      <td>$tot_dimp_settore_edit</td>
                  </tr>
                 "
}
append table "
              <tr> 
                  <td>Totale modelli</td>
                  <td>$tot_dimp_edit</td>
              </tr>
              </table>"

db_1row sel_count_aimp ""
set num_aimp [iter_edit_num $num_aimp]
set current_date [iter_edit_date [iter_set_sysdate]]

append table "
<tr><td>&nbsp;</td></tr>
<tr><td align=center><b>Sul database sono presenti $num_aimp impianti attivi in data $current_date</b></td></tr>"

db_1row sel_count_nove ""
set num_nove [iter_edit_num $num_nove]

append table "
<tr><td>&nbsp;</td></tr>
<tr><td align=center><b>Sul database sono presenti $num_nove allegati IX in data $current_date</b></td></tr>"


set testata2 "<!-- FOOTER LEFT   \"$sysdate_edit\"-->
              <!-- FOOTER RIGHT  \"Pagina \$PAGE(1) di \$PAGES(1)\"-->
              <table width=100%>
              <tr>
                  <td width=100% align=center>
                  <table><tr>
                    <td align=center><b>$ente</b></td>
                  </tr><tr>
                     <td align=center>$ufficio</td>
                  </tr><tr>
                     <td align=center>$assessorato</td>
                  </tr><tr>
                     <td align=center><small>$indirizzo_ufficio</small></td>
                  </tr><tr>
                     <td align=center><small>$telefono_ufficio</small></td>
                  </tr></td>
                  </table></tr></table> 
"

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file        "stampa statistica"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set stampa2 $testata2
append stampa2 "<small>"
append stampa2 $table
append stampa2 "</small>"

set   file_id  [open $file_html w]
fconfigure $file_id -encoding iso8859-1
puts  $file_id $stampa2
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --landscape  --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --bottom 0cm -f $file_pdf $file_html]

ns_unlink $file_html

db_release_unused_handles
ad_return_template 
