ad_page_contract {

    @author         Gacalin Lufi
    @creation-date  02/03/2018
 

    USER  DATA       MODIFICHE
    ===== ========== ================================================================================================
    rom02 03/07/2020 Sul server OASI-AMAZON-09 la versione di zint e' più aggiornata rispetto a qella degli altri
    rom02            server, passa dalla versione 2.4.2 alla versione 2.7.0. La versione 2.7.0 non supporta piu' 
    rom02            il comando --directeps, bisogna usare invece --filetype=EPS. Per ovviare il problema delle versioni 
    rom02            differenti tra i vari server utlizziamo il comando with_catch error_msg.

    rom01 19/06/2020 Tolta cablatura presente che faceva comparire sempre il logo del comune di Ancona.
    rom01            Ora utilizzo il parametro master_logo_sx_nome.
    
} {
    cod_impianto   
}


# Controlla lo user
set id_utente [iter_get_id_utente]

db_1row q "select targa
                , cod_impianto_est 
             from coimaimp 
            where cod_impianto=:cod_impianto"

#aggiorno il flag targa stampata
db_dml q "update coimaimp set flag_targa_stampata = 't' where cod_impianto=:cod_impianto"
# save rml in a temporary file

set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set filename "stampa_targa"
set file_html "$spool_dir/$filename.html"
set file_pdf  "$spool_dir/$filename.pdf"
set file_pdf_url "$spool_dir_url/$filename.pdf"

#imposto il logo

#creo il qrcode da usare nella stampa
set bar_eps_output "$spool_dir/test_qrcode.eps" 
set bar_jpg_output "$spool_dir/test_qrcode.jpg"
set url_portale [parameter::get_from_package_key -package_key iter -parameter url_portale]  
set url  "$url_portale/iter-portal/plants-filter?targa=$targa"
#rom02exec zint --directeps --barcode=58 --notext --data=$url > $bar_eps_output
with_catch error_msg {
    #rom02 la versione di Zint 2.4.2 supporta il comando --directeps
    exec zint --directeps --barcode=58 --notext --data=$url > $bar_eps_output
    exec eps2png -jpggray -scale=3 -o=$bar_jpg_output $bar_eps_output
} {
    #rom02 In alcuni server Zint e' piu' aggiornato con la versione 2.7.0
    #rom02 Questa versione non supporta il comando --directeps
    exec zint --direct --filetype=EPS --barcode=58 --notext --data=$url > $bar_eps_output
    exec eps2png -jpggray -scale=1 -height=130 -width=130  -o=$bar_jpg_output $bar_eps_output
}

set qrcode "<img src=$bar_jpg_output>"    

set logo_dir      [iter_set_logo_dir]
set logo_regione  [parameter::get_from_package_key -package_key iter -parameter master_logo_dx_nome]
set logo_ente     [parameter::get_from_package_key -package_key iter -parameter master_logo_sx_nome]
set master_logo_dx_height  [parameter::get_from_package_key -package_key iter -parameter master_logo_dx_height -default "32"]
set master_logo_sx_height  [parameter::get_from_package_key -package_key iter -parameter master_logo_sx_height -default "32"]
set logo_regione "<img src=$logo_dir/$logo_regione height=$master_logo_dx_height>"
set logo_ente    "<img src=$logo_dir/$logo_ente height=$master_logo_sx_height>"
#set logo_ente "<img src=$logo_dir/$logo_ente width=32 height=32>"
set etichetta "
<table width=100% border=0>
   <tr>
     <td width=11%>$logo_ente</td>
     <td width=78%>&nbsp;</td>
     <td width=11%>$logo_regione</td>
   </tr>
   <tr>
     <td colspan=3 align=center><b><big>$targa</big></b></td>
   </tr>
   <tr>
     <td colspan=3 align=center>$qrcode</td>
   </tr> 
</table>"

set html "
<table width=100% border=1>
<tr>
 <td width=50% height=50%>$etichetta</td>
 <td width=50% height=50% align=right>$etichetta</td>
</tr>
<tr>
 <td width=50% height=50%>$etichetta</td>
 <td width=50% height=50% align=right>$etichetta</td>
</tr>
</table>
"

set wfd [open $file_html w]
fconfigure $wfd -encoding "iso8859-15"

puts $wfd $html
close $wfd

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --landscape --bodyfont arial --fontsize 10  --left 0cm --right 0cm --top 0cm --bottom 0cm -f $file_pdf $file_html]



ns_unlink $file_html
ad_returnredirect "$file_pdf_url"
ad_script_abort
