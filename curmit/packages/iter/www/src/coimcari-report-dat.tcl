ad_page_contract {

    Lettura di 3 file sequenziali contenenti gli impianti, le autocertificazioni e i rapporti di verifica
    analizzati per togliere eventuali caratteri non compatibili con i connettori
    Il programma restituisce un report visivo con il riassunto delle anomalie riscontrate, 
    tre file csv contenenti gli stessi dati dei file di partenza, purificati delle anomalie, pronti per essere
    analizzati dai connettori

    @creation-date   18/10/2006

    @cvs-id          coimcari-dati-report.tcl
} {
    {funzione         "V"}
    {caller       "index"}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {cod_topo          ""}
    {cod_comb          ""}
    {n_comuni_cod      ""}
    {codice_via        ""}
    {count_citt        ""}
    {count_manu        ""}
    {count_prog        ""}
    {count_cost        ""}
    {count_gend        ""}
    {aimp_corretti     ""}
    {count_cimp        ""}
    {count_dimp        ""}
    {count_anom        ""}
    {count_opve        ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}
# Controlla lo user
 set lvl 1
 set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
 if {[string equal $nome_funz_caller ""]} {
     set nome_funz_caller $nome_funz
 }

set link_gest [export_url_vars nome_funz nome_funz_caller caller]
set spool_dir [iter_set_spool_dir]
set spool_url [iter_set_spool_dir_url]

# Setto le variabili per i link di scarico e per il proseguimento del procedimento
set dat_link "$spool_url/coimdat.tar.gz"


# Personalizzo la pagina
set page_title   "Caricamento dati -- Fase 2"
set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]

ad_return_template
