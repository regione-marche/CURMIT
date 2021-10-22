ad_page_contract {
    Lista tabella "coimdimp"

    @author                  Giulio Laurenzi
    @creation-date           22/04/2005
    @param nome_funz         identifica l'entrata di menu,
                             serve per le autorizzazioni
    @cvs-id coimstat-manu-list
} {
     nome_funz
    {nome_funz_caller  ""}
    {da_data_ins       ""} 
    {a_data_ins        ""}
    {f_manu_cogn       ""}
    {f_manu_nome       ""}
    {f_cod_manu        ""}
    {f_comune          ""}
    {flag_tipo_impianto ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
}

# Controlla lo user
set lvl        1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

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

set page_title  "Lista modelli non conformi"
set context_bar [iter_context_bar -nome_funz $nome_funz_caller]

set where_manu ""
if {![string equal $f_cod_manu ""]} {
    set where_manu "and a.cod_manutentore = :f_cod_manu"
}

#dpr 74
set where_tipo_imp ""
if {![string equal $flag_tipo_impianto ""]} {
    set where_tipo_imp "and b.flag_tipo_impianto = :flag_tipo_impianto"
}

#dpr74
set table "<center>
           <table border=1 cellpadding=3 cellspacing=0>
           <tr>
               <td align=center><b>Cod. impianto</b></td>
               <td align=center><b>Responsabile</b></td>
               <td align=center><b>Ubicazione</b></td>
               <td align=center><b>Data controllo</b></td>
               <td align=center><b>Modello</b></td>
               <td align=center><b>Manutentore</b></td>
               <td align=center><b>TI</b></td>
           </tr>"

db_foreach sel_dimp "select b.cod_impianto_est
                            , case b.flag_tipo_impianto
                              when 'R' then 'Risc.'
                              when 'C' then 'Cog.'
                              when 'F' then 'Raf.'
                              when 'T' then 'Tel.'
                              else '&nbsp;'
                              end as flag_tipo_impianto
                          , coalesce(c.cognome, '&nbsp;')||' '||coalesce(c.nome, '') as responsabile
                          , coalesce(f.cognome, '&nbsp;')||' '||coalesce(f.nome, '') as cogn_manu
                          , coalesce(d.descr_topo, '&nbsp;')||' '||coalesce(d.descrizione, '&nbsp;')||' '||coalesce(b.numero, '') as ubicazione
                          , iter_edit_data(a.data_controllo) as data_controllo_ed
                          , a.flag_tracciato
                       from coimdimp a
            left outer join coimmanu f on f.cod_manutentore = a.cod_manutentore
                          , coimaimp b
            left outer join coimcitt c on c.cod_cittadino = b.cod_responsabile
            left outer join coimviae d on d.cod_via       = b.cod_via
                                      and d.cod_comune    = b.cod_comune
                      where b.cod_impianto    = a.cod_impianto
                        and a.data_controllo  = (select max(e.data_controllo)
                                                   from coimdimp e
                                                  where e.cod_impianto = b.cod_impianto)
                        and a.conformita       = 'N'
                        and (a.flag_tracciato  <> 'G' or a.flag_tracciato <> 'F')
                        and a.data_ins  between :da_data_ins and :a_data_ins
                        and b.cod_comune      = :f_comune
                   $where_manu
                   $where_tipo_imp
                   order by ubicazione
" {

    append table "<tr>
                     <td>$cod_impianto_est</td>
                     <td>$responsabile</td>
                     <td>$ubicazione</td>
                     <td>$data_controllo_ed</td>
                     <td>$flag_tracciato</td>
                     <td>$cogn_manu</td>
                     <td>$flag_tipo_impianto</td>
                  </tr>"
}

append table "</table>"

set logo_dir     "../logo"

set stampa "<table width=100% valign=top cellpadding=0 cellspacing=0>
        <tr><td align=center valign=top colspan=2><font size=4><b>$ente</b></font></td></tr>
        <tr><td align=center valign=top colspan=2><font size=2><b>$ufficio</b></font></td></tr>
        <tr><td align=center valign=top colspan=2 height=5></td></tr>
        <tr><td align=center valign=top colspan=2 height=5></td></tr>
        <tr><td align=center valign=top colspan=2 height=5></td></tr>
        </table>"
append stampa $table

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file        "stampa modelli non conformi"
set nome_file        [iter_temp_file_name $nome_file]
set file_html        "$spool_dir/$nome_file.html"
set file_pdf         "$spool_dir/$nome_file.pdf"
set file_pdf_url     "$spool_dir_url/$nome_file.pdf"

set   file_id  [open $file_html w]
fconfigure $file_id -encoding iso8859-1
puts  $file_id $stampa
close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont times --left 1cm --right 1cm --top 1.5cm --bottom 1.5cm -f $file_pdf $file_html]

ns_unlink $file_html

db_release_unused_handles
ad_return_template 
