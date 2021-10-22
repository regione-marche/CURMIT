ad_page_contract {
    @author          Claudio Pasolini
    @creation-date   13/03/2012

    Registro corrispettivi.

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coimreco-filter.tcl     
} {
    {year_and_month    ""}
    {flag_pag          ""}
   {caller       "index"}
   {funzione         "V"}
   {nome_funz         ""}
   {nome_funz_caller  ""}   
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

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}


iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)
set cod_comu $coimtgen(cod_comu)
set sigla_prov $coimtgen(sigla_prov)



set var_fatt ""

if {$cod_comu == "54018"} {
   set var_fatt "Foligno"
} 

if {$cod_comu == "41044"} {
   set var_fatt "Pesaro"
} 

if {$cod_comu == "74077"} {
   set var_fatt "Fasano"
} 

if {$cod_comu == ""} {
   set var_fatt "Pr.$sigla_prov" 
} 


set page_title   "Stampa registro Fatture"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller] 

form create parameters

element create parameters year_and_month \
    -label   "Anno e mese" \
    -widget   text \
    -datatype text \
    -html    "class form_element" \
    -help_text "Digitare nel formato AA-MM"

element create parameters flag_pag \
    -label   "Tipo corrispettivo" \
    -widget   radio \
    -datatype text \
    -html    "class form_element" \
    -options { {"Pagati" "S"} {"Non pagati" "N"}  }

element create parameters caller    -widget hidden -datatype text -optional
element create parameters nome_funz -widget hidden -datatype text -optional
element create parameters submit    -widget submit -datatype text -label "Imposta parametri" -html "class form_submit"

    set stampa ""
    set tota_gen 0
    set tota_leg_gen 0
    set tota_imp_gen 0
    set tota_post_gen 0
    set tota_imp_iva 0
    set tota_importo 0
    set tota_importo_pretty 0
    set tota_imp_pretty 0
    set iva 0

if {[form is_valid parameters]} {

    set gma 01/[string range $year_and_month 5 6]/[string range $year_and_month 0 3]
    set amg [iter_check_date $gma]
    if {$amg == 0} {
	element::set_error parameters year_and_month "Dato non valido!"
	ad_return_template
	return
    }

    set button_label "Stampa"
    
    # imposto la directory degli spool ed il loro nome.
    set spool_dir     [iter_set_spool_dir]
    set spool_dir_url [iter_set_spool_dir_url]
    set logo_dir      [iter_set_logo_dir]

    # imposto il nome dei file
    set nome_file        "stampa registro fattura"
    set nome_file        [iter_temp_file_name $nome_file]
    set file_html        "$spool_dir/$nome_file.html"
    set file_pdf         "$spool_dir/$nome_file.pdf"
    set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

    set   file_id  [open $file_html w]
    fconfigure $file_id -encoding iso8859-1

    set stampa ""
    set fatt ""
    set tota_gen 0
    set tota_leg_gen 0
    set tota_imp_gen 0
    set tota_post_gen 0

    if {$flag_pag eq "S"} {
	set status "pagate"
    } else {
	set status "da pagare"
    }

#ns_return 200 text/html "select distinct perc_iva::integer from coimrfis where to_char(data_rfis, 'YYYY-MM-DD') between '${year_and_month}-01' and '${year_and_month}-31'"; return

    # trovo le aliquote iva del mese
 if {![db_0or1row query "select distinct perc_iva::integer as aliq from coimrfis where to_char(data_rfis, 'YYYY-MM-DD') between '${year_and_month}-01' and '${year_and_month}-31'"]}  {
     set aliq ""
   }

    if {$aliq eq ""} {
        append stampa "<center>
    <h1>I.V.A. Registro delle fatture $status al $year_and_month  - Ente: $var_fatt</h1>
    <table cellpadding=\"3\" cellsoacing=\"3\">
      <tr>
        <th><h1><center>Nessun dato elaborato</center></h1></th>
      </tr>
    </tr>  
 "} else {

   append stampa "<center>
    <h1>I.V.A. Registro dei Corrispettivi $status al $year_and_month Ente: $var_fatt</h1>
    <table cellpadding=\"3\" cellsoacing=\"3\">
      <tr>
        <th> </th>
        <th> </th>
        <th>Corrispettivi</th>
        <th> </th>
         <th> </th>
        <th> </th>
         <th span=\"3\"> Esente Art. 10</th>
      </tr>
      <tr>
        <th>Data</th>
        <th>Descrizione</th>
        <th>   Totale   </th>
        <th>   aliq. ${aliq}%   </th>
        <th>   Importo   </th>
        <th>   IVA      </th>
        <th>   Postali   </th>
        <th>   Legali    </th>
      </tr>
    "
set numeri ""
    db_foreach query "
        select  to_char(data_fatt, 'DD/MM/YYYY') as data_rfis_pretty
              , data_fatt
              , iter_edit_num(sum(imponibile), 2) as imponibile_pretty
              , iter_edit_num(sum(coalesce(spe_postali,0)), 2) as spe_postali_pretty
              , iter_edit_num(sum(coalesce(spe_legali,0)), 2) as spe_legali_pretty
              , iter_edit_num((sum(coalesce(imponibile,0)) + sum(coalesce(spe_legali,0)) + sum(coalesce(spe_legali,0))),2) as tota_pretty
              , sum(imponibile) as tota_imp
              , sum(coalesce(spe_postali,0)) as tota_post
              , sum(coalesce(spe_legali,0)) as tota_leg
              , sum(coalesce(imponibile,0)) + sum(coalesce(spe_legali,0)) + sum(coalesce(spe_legali,0)) as tota
        from coimfatt
        where to_char(data_fatt, 'YYYY-MM-DD') between '${year_and_month}-01' and '${year_and_month}-31'
              and coalesce(flag_pag, 'N') = :flag_pag
        group by data_fatt       
        order by data_fatt
    " {
       set lista_num [db_list query "select num_fatt  from coimfatt where to_char(data_fatt, 'YYYY-MM-DD') between '${year_and_month}-01' and '${year_and_month}-31'
              and coalesce(flag_pag, 'N') = :flag_pag  and data_fatt = :data_fatt"]
       set lista_pag [db_list query "select estr_pag  from coimfatt where to_char(data_fatt, 'YYYY-MM-DD') between '${year_and_month}-01' and '${year_and_month}-31'
              and coalesce(flag_pag, 'N') = :flag_pag  and data_fatt = :data_fatt and estr_pag is not null"]
    #scorporo
        set imp_iva [expr 100 + 21] 
        set importo [expr $tota_imp / $imp_iva * 100]
        set iva [expr $tota_imp - $importo]
        set iva_pretty [db_string query "select iter_edit_num(:iva,2)"]
        set importo [expr $tota_imp /1.21]
        set importo_pretty [db_string query "select iter_edit_num(:importo,2)"]
#scorporo

        append stampa "
      <tr>
         <td>$data_rfis_pretty</td>
        <td>Incasso $lista_pag</td>
        <td align=\"right\">$tota_pretty</td>
        <td align=\"right\">$imponibile_pretty</td>
        <td align=\"right\">$importo_pretty</td>
        <td align=\"right\">$iva_pretty</td>
        <td align=\"right\">$spe_postali_pretty</td>
        <td align=\"right\">$spe_legali_pretty</td>
        <td align=\"right\">&nbsp;</td>
      </tr>
        "
      set tota_gen [expr $tota_gen + $tota] 
      set tota_post_gen [expr $tota_post_gen + $tota_post] 
      set tota_leg_gen [expr $tota_leg_gen + $tota_leg] 
      set tota_imp_gen [expr $tota_imp_gen + $tota_imp] 
      set tota_imp_iva [expr $tota_imp_iva + $iva] 
      set tota_importo [expr $tota_importo + $importo] 
       
   }

}

  set tota_gen_pretty [db_string query "select iter_edit_num(:tota_gen,2)"]
  set tota_imp_pretty [db_string query "select iter_edit_num(:tota_imp_gen,2)"]
  set tota_post_pretty [db_string query "select iter_edit_num(:tota_post_gen,2)"]
  set tota_leg_pretty [db_string query "select iter_edit_num(:tota_leg_gen,2)"]
  set tota_imp_iva_pretty [db_string query "select iter_edit_num(:tota_importo,2)"]
  set tota_importo_pretty [db_string query "select iter_edit_num(:tota_imp_iva,2)"]

   append stampa "
      <tr>
        <td>&nbsp;</td>
        <td>Totali</td>
        <td align=\"right\">$tota_gen_pretty</td>
        <td align=\"right\">$tota_imp_pretty</td>
        <td align=\"right\">$tota_imp_iva_pretty</td>
        <td align=\"right\">$tota_importo_pretty</td>
        <td align=\"right\">$tota_post_pretty</td>
         <td align=\"right\">$tota_leg_pretty</td>
       </tr>
        "

    append stampa "</table>
               </center>"
    puts $file_id $stampa
    close $file_id

    # lo trasformo in PDF
    iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --landscape --bodyfont arial --left 1cm --right 1cm --top 0cm --bottom 0cm -f $file_pdf $file_html]

    ns_unlink $file_html
    ad_return_template

}


