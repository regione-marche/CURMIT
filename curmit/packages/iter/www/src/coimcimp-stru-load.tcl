ad_page_contract {
    Add/Edit/Delete  form per la tabella "coimcimp"
    @author          Adhoc
    @creation-date   03/05/2004

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimcimp-gest.tcl
} {
    
   {cod_cimp         ""}
   {last_cod_cimp    ""}
   {funzione        "V"}
   {caller      "index"}
   {nome_funz        ""}
   {nome_funz_caller ""}
   {extra_par        ""}
   {cod_impianto     ""}
   {url_aimp         ""} 
   {url_list_aimp    ""}
   {gen_prog         ""}
   {flag_cimp        ""}
   {extra_par_inco   ""}
   {cod_inco         ""}
   {flag_inco        ""}
   {flag_tracciato   ""}
   {mode "edit"}

} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user

switch $funzione {
    "V" {set lvl 1}
    "I" {set lvl 2}
    "M" {set lvl 3}
    "D" {set lvl 4}
}

#set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]


iter_get_coimtgen
set flag_ente    $coimtgen(flag_ente)
set denom_comune $coimtgen(denom_comune)
set sigla_prov   $coimtgen(sigla_prov)
set link         [export_ns_set_vars "url"]

set page_title   "Carica Misure rilevate dallo strumento"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

set buttons [list [list "$page_title" new]]

ad_form -name bulkload \
    -action coimcimp-stru-load-2 \
    -mode $mode \
    -html {enctype multipart/form-data} \
    -edit_buttons $buttons \
    -has_edit 1 \
    -export cod_cimp \
    -form {

        {csv_file:file(file)
            {label {File}}
            {help_text {Indicare il percorso del file CSV da caricare.}}
        }

    } -on_request {

        set dry_run_p "t"
    }



