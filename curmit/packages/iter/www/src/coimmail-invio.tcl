ad_page_contract {
    @author          Romitti Luca
    @creation-date   26/03/2018

    @param funzione  I=insert M=edit D=delete V=view

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @cvs-id          coimestr-filter.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom01 12/07/2018 Aggiunta la pec del manutentore tra i destinatari, la pec del comune
    rom01            viene messa nei destinatari solo se f_invio_comune è "S".

    gab01 29/06/2018 Modificato oggetto e testo dell'email come da richieste.

    sim01 11/06/2018 Se il nome del file contiene degli spazzi non viene inviato quindi li
    sim01            sostituisco con _

} {
    {funzione        "V"}
    {caller      "index"}
    {nome_funz        ""}
    {nome_funz_caller ""}
    {file_pdf_url2    ""}
    {file_pdf_url     ""}
    {mittente         ""}
    {destinatario     ""}
    {copia_conoscenza ""}
    {oggetto          ""}
    {testo            ""}
    {flag_racc         ""}
    {flag_pres         ""}
    {f_invio_comune   ""}
    path_allegato         
    path_allegato_completo
    nome_file_email
    ls_cod_inco

} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}


# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

iter_get_coimtgen
set flag_ente $coimtgen(flag_ente)

# Personalizzo la pagina
set link_list_script {[export_url_vars caller nome_funz]}
set link_list        [subst $link_list_script]
set titolo       "Invio avvisi RCEE tramite Mail PEC"
set button_label "Invio" 
set page_title   "$titolo"

set context_bar [iter_context_bar -nome_funz $nome_funz]

set mittente_mail [db_string q "select indirizzo_pec from coimtgen"]

#gab01 set oggetto_mail  $nome_file_email
if {$flag_racc eq "S" && $flag_pres eq "N"} {;#gab01 if, elseif, else e contenuto 
    set dicitura_oggetto_testo "raccomandazioni"
} elseif {$flag_racc eq "N" && $flag_pres eq "S"} {
    set dicitura_oggetto_testo "prescrizioni"
} else {
    set dicitura_oggetto_testo "raccomandazioni/prescrizioni"
}

set oggetto_mail "Avviso $dicitura_oggetto_testo ai sensi della L.R. 19/2015";#gab01
set testo "Si trasmettono in allegato le richieste di eliminazione delle anomalie/difformità degli impianti termici a seguito di RCEE con $dicitura_oggetto_testo estratti in data odierna. Distinti saluti. M&P Mobilità e Parcheggi Spa.";#gab01

if {$f_invio_comune eq "S"} {#rom01 aggiunta if
    set destinatario_mail [db_list   q "select distinct c.pec
                                          from coimcomu c
                                             , coimaimp a
                                             , coiminco i 
                                         where i.cod_impianto = a.cod_impianto 
                                           and c.cod_comune   = a.cod_comune
                                           and i.cod_inco     in ('[join $ls_cod_inco ',']')"]
} else {#rom01 else e contenuto
    set destinatario_mail ""
}

set destinatario_manu [db_list q "select distinct m.pec                         
                                         from coimaimp a
                                         , coiminco i
                                         , coimmanu m                             
                                     where i.cod_impianto = a.cod_impianto
                                       and m.cod_manutentore = a.cod_manutentore  
                                       and i.cod_inco     in ('[join $ls_cod_inco ',']')"] ;#rom01

set destinatario_manu [join $destinatario_manu ,] ;#rom01
set destinatario_mail [join $destinatario_mail ,]
if {![string equal $destinatario_manu  ""] && ![string equal $destinatario_mail ""]} {#rom01 if e contenuto
    append destinatario_mail ", $destinatario_manu"
};#rom01
if {![string equal $destinatario_manu  ""] && [string equal $destinatario_mail ""]} {#rom01 if e contenuto
    append destinatario_mail $destinatario_manu
};#rom01

# sproteggo la chiave solo in inserimento e gli attributi in inserimento e mod.
set form_name    "coimmail"
set onsubmit_cmd ""
set readonly_key \{\}
set readonly_fld \{\}
set disabled_fld \{\}


  
form create $form_name \
-html    $onsubmit_cmd

element create $form_name mittente \
    -label   "Mittente"  \
    -widget   inform \
    -datatype text \
    -html    "size 70 readonly {} class form_element" \


element create $form_name destinatario \
    -label   "Destinatario" \
    -widget   text \
    -datatype text \
    -html    "size 70 $disabled_fld {} class form_element" \
    -optional \


element create $form_name copia_conoscenza \
    -label   "CC" \
    -widget   text \
    -datatype text \
    -html    "size 70 $disabled_fld {} class form_element" \
    -optional 

element create $form_name oggetto \
    -label   "Oggetto" \
    -widget   text \
    -datatype text \
    -html    "size 70 maxlenght 1000 $readonly_fld {}  class form_element" \
    -optional 

element create $form_name testo \
    -label   "Testo" \
    -widget   textarea \
    -datatype text \
    -html    "cols 70 rows 3 $readonly_fld {} class form_element" \
    -optional

element create $form_name link_allegato \
    -label    mail \
    -widget   inform \
    -datatype text \
    -html    "readonly {} class form_element" \
    -optional \


element create $form_name funzione  -widget hidden -datatype text -optional
element create $form_name caller    -widget hidden -datatype text -optional
element create $form_name nome_funz -widget hidden -datatype text -optional
element create $form_name dummy     -widget hidden -datatype text -optional
element create $form_name path_allegato  -widget hidden -datatype text -optional
element create $form_name path_allegato_completo  -widget hidden -datatype text -optional
element create $form_name nome_file_email -widget hidden -datatype text -optional
element create $form_name submitbut -widget submit -datatype text -label "$button_label" -html "class form_submit"
element create $form_name ls_cod_inco -widget hidden -datatype text -optional

if {[form is_request $form_name]} {
   
    element set_properties $form_name funzione         -value $funzione
    element set_properties $form_name caller           -value $caller
    element set_properties $form_name nome_funz        -value $nome_funz
 
    element set_properties $form_name mittente         -value $mittente_mail
    element set_properties $form_name destinatario     -value $destinatario_mail
    element set_properties $form_name copia_conoscenza -value $copia_conoscenza
    element set_properties $form_name oggetto          -value $oggetto_mail
    element set_properties $form_name testo            -value $testo
    element set_properties $form_name path_allegato    -value $path_allegato
    element set_properties $form_name path_allegato_completo    -value $path_allegato_completo
    element set_properties $form_name nome_file_email  -value $nome_file_email

    set link_allegato "<a href=\"$path_allegato\">$nome_file_email</a>"

    element set_properties $form_name link_allegato         -value $link_allegato
      

}

if {[form is_valid $form_name]} {

    # form valido dal punto di vista del templating system
    set mittente           [element::get_value $form_name mittente]
    set destinatario       [element::get_value $form_name destinatario]
    set copia_conoscenza   [element::get_value $form_name copia_conoscenza]
    set oggetto            [element::get_value $form_name oggetto]
    set testo              [element::get_value $form_name testo]
    set path_allegato      [element::get_value $form_name path_allegato]
    set path_allegato_completo [element::get_value $form_name path_allegato_completo]
    set nome_file_email    [element::get_value $form_name nome_file_email]
    set error_num 0

    regsub -all " " $nome_file_email "_" nome_file_email;#sim01

    #simone qui farà l'invio vero e proprio
    ah::email_w_attachment -name $nome_file_email.pdf -file_path $path_allegato_completo -send_immediately -valid_email -to_addr $destinatario -from_addr $mittente -cc_addr $copia_conoscenza -subject $oggetto -body $testo -from_addr_in_cc "f"

    set id_mail [db_string q "select coalesce(max(id_mail),'0') + 1
                                from coimmail"]

    db_dml q "insert into coimmail
                        ( id_mail      
                        , mittente     
                        , destinatario 
                        , cc           
                        , oggetto      
                        , testo        
                        , allegato     
                        , utente_ins   
                        , data_ins           
                        , nome_file
                        ) values
                        ( :id_mail
                        , :mittente 
                        , :destinatario
                        , :copia_conoscenza
                        , :oggetto
                        , :testo
                        , :path_allegato
                        , :id_utente
                        , current_date
                        , :nome_file_email
                        ) ;"

set link_list [export_url_vars caller funzione  nome_file_email id_mail mittente destinatario copia_conoscenza oggetto testo allegato link_allegato]&path_allegato=$file_pdf_url2 
set return_url "coimmail-list?$link_list&nome_funz=estr-mail-list&nome_funz_caller=estr-mail-list"

ad_returnredirect $return_url
ad_script_abort
}

ad_return_template
