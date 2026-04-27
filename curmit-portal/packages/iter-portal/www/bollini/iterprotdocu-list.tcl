ad_page_contract {
    Lista tabella "iterprotdocu"

    @author            Nelson Secco
    @creation-date     13/06/2013

    @cvs-id            iterprotdocu-list.tcl 
} { 
    {search_word       ""}
    {rows_per_page     ""}
    {caller       "index"}
    {receiving_element ""}
    {last_id_documento ""}
    {prot_id           ""}
    {last_cognome      ""}
    {extra_par_occu    ""}
}  -properties {
    page_title:onevalue
    context_bar:onevalue
    list_head:onevalue
    table_result:onevalue
}

# Controlla lo user
#set utn_cde [tosa_check_login 1]

set main_directory  [ad_conn package_url]
set page_title      "Lista Allegati Protocolli"

set context_bar [iter_context_bar \
		     [list ${main_directory} Home] \
		     "$page_title"]

#set occu_menu [tosa_occu_menu $prot_id $last_cognome $caller $extra_par_occu]

# leggo parametri
#set cmm_email_allegati [parameter::get -parameter cmm_email_allegati]
set cmm_email_allegati "0"
#set cmm_plichi         [parameter::get -parameter cmm_plichi]
set cmm_plichi "0"

# imposto le variabili da usare nel frammento html di testata della lista.
set curr_prog       [file tail [ns_conn url]]
set gest_prog       "iterprotdocu-gest"
set form_di_ricerca ""
set col_di_ricerca  ""

set extra_par     [list rows_per_page    $rows_per_page \
		       receiving_element $receiving_element]
set link "\[export_url_vars id_documento prot_id last_id_documento extra_par last_cognome extra_par_occu caller\]"
set rows_per_page ""
set link_righe    ""

if {$cmm_plichi eq "1"} {
    db_1row query "select prot_pratica from tosaprat p, tosaoccu o where o.id_pratica = p.id_pratica and o.prot_id = :prot_id"
    set link_plico "<a href=\"/tosap/plichi/docu-list?prot_pratica=$prot_pratica&[export_url_vars last_id_documento caller extra_par prot_id last_cognome extra_par_occu]\">Crea Plico</a>"
} else { 
    set link_plico ""
}

set js_function ""

# imposto la struttura della tabella
if {$cmm_email_allegati eq "1"} {
    # con gestione invio email
    set actions "
    <td nowrap>
    \\\[<a href=\"$gest_prog?function=V&$link\">Dett. </a>
      | <a href=\"$gest_prog?function=E&$link\">Mod. </a>
      | <a href=\"iterprotdocu-delete?$link\">Canc.</a>
      | <a href=\"iterprotdocu-email?$link\">Da inviare</a>\\\]
    </td>"
    set table_def [list \
		       [list actions           "Azioni"      no_sort  $actions] \
		       [list id_documento      "Cod.Doc."    no_sort       {r}] \
		       [list descrizione       "Tipo"        no_sort       {l}] \
		       [list oggetto           "Oggetto"     no_sort       {l}] \
		       [list da_inviare_pretty "Da Inviare"  no_sort       {c}] \
		      ]
} else {
    # gestione normale
    set actions "
    <td nowrap>
    \\\[<a href=\"$gest_prog?function=V&$link\">Dett. </a>
      | <a href=\"$gest_prog?function=E&$link\">Mod. </a>
      | <a href=\"iterprotdocu-delete?$link\">Canc.</a>\\\]
    </td>"
    set table_def [list \
		       [list actions         "Azioni"    no_sort $actions] \
		       [list id_documento    "Cod.Doc."  no_sort      {r}] \
		       [list descrizione     "Tipo"      no_sort      {l}] \
		       [list oggetto         "Oggetto"   no_sort      {l}] \
		      ]
}

# imposto la query SQL 
# imposto la condizione per la prossima pagina
if {![string is space $last_id_documento]} {
    set where_last " and id_documento >= :last_id_documento"
} else {
    set where_last ""
}

# imposto la condizione per l'prot_id
if {![string equal $prot_id ""]} {
    set where_id_occu " and a.prot_id = :prot_id"
} else {
    set where_id_occu ""
}

set sql_query "
select a.id_documento
     , a.prot_id
     , a.tipo_doc
     , b.descrizione
     , a.oggetto
  from iterprotdocu a , coimtdoc b
 where a.tipo_doc = b.id_tipo_documento
   and documento is not null
   and a.flag_attivo = 't'
$where_id_occu
$where_last
order by id_documento desc"

set table_result [ad_table -Tmissing_text "Nessun dato corrisponde ai criteri impostati." -Textra_vars {prot_id id_documento last_id_documento extra_par last_cognome extra_par_occu caller} go $sql_query $table_def]

# preparo url escludendo last_id_documento che viene passato esplicitamente
# per poi preparare il link alla prima ed eventualmente alla prossima pagina
set url_vars [export_ns_set_vars "url" "last_id_documento search_word"]
set link_altre_pagine ""
set link_aggiungi "<a href=\"$gest_prog?function=I&[export_url_vars last_id_documento caller extra_par prot_id last_cognome extra_par_occu]\">Aggiungi</a>"

# preparo link a pagina successiva
set ctr_rec [expr [regsub -all <tr $table_result <tr comodo] -1]
if {$ctr_rec == $rows_per_page} {
    set last_id_documento $id_documento
    append url_vars "&[export_url_vars last_id_documento]"
    append link_altre_pagine " o alla <a href=\"$curr_prog?$url_vars\">pagina successiva</a>"
}

# creo testata della lista
# creo testata della lista
set list_head [iter_list_head  $form_di_ricerca $col_di_ricerca \
		   $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]
#set list_head [tosa_list_head $form_di_ricerca $col_di_ricerca \
#		   $link_plico $link_aggiungi $link_altre_pagine $link_righe "Righe per pagina"]

db_release_unused_handles
ad_return_template 
