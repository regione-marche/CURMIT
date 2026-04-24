ad_page_contract {
    Menu servizi dei cittadini
    
    @author Romitti Luca
    @cvs-id $Id: citizen-documents.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
} {
    {caller ""}
    {cod_cittadino    ""}
    {cod_impianto_est ""}
    {cod_impianto     ""}
    {dbn_iter         ""}
    {targa            ""}
    
}

set page_title "Lista moduli per il cittadino."
set context [list "Servizi"]

#set user_id    [auth::require_login] 
set user_id [iter::script_init_cittadino]
set reg_msg "Registrazione avvenuta con successo"

set link_list_aimp     [export_vars {cod_cittadino cod_impianto_est cod_impianto dbn_iter targa}]
