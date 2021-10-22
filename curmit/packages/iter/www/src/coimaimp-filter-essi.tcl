ad_page_contract {
    @author          Giulio Laurenzi
    @creation-date   18/03/2004

    @param funzione  V=view
    @param caller    caller della lista da restituire alla lista:
    serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, serve per le autorizzazioni
    serve se lista e' uno zoom che permetti aggiungi.
    @cvs-id          coiminco-filter.tcl
} {
    
    {funzione            "V"}
    {caller          "index"}
    {nome_funz            ""}
    {nome_funz_caller     ""}

    {f_cod_impianto_est   ""}

    {f_resp_cogn          ""} 
    {f_resp_nome          ""} 

    {f_comune             ""}
    {f_quartiere          ""}

    {f_cod_via            ""}
    {f_desc_via           ""}
    {f_desc_topo          ""}
    {f_civico_da          ""}
    {f_civico_a           ""}

    {f_manu_cogn          ""}
    {f_manu_nome          ""}

    {f_data_mod_da        ""}
    {f_data_mod_a         ""}
    {f_utente             ""}

    {f_potenza_da         ""}
    {f_potenza_a          ""}
    {f_data_installaz_da  ""}
    {f_data_installaz_a   ""}
    {f_flag_dichiarato    ""}
    {f_stato_conformita   ""}
    {f_cod_combustibile   ""}
    {f_cod_cost           ""}
    {f_cod_tpim           ""}
    {f_cod_tpdu           ""}
    {f_stato_aimp         ""}
    {f_mod_h              ""}

    {f_dpr_412            ""}
    {f_cod_utenza         ""}
    {f_cod_impianto_old   ""}
    {f_matricola          ""}
    {f_prov_dati          ""}
    {cerca_multivie       ""}
    {f_da_data_verifica   ""}
    {f_a_data_verifica    ""}
    {f_bollino            ""}
    {f_flag_tipo_impianto ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

ad_returnredirect coimaimp-filter?nome_funz=essi
ad_script_abort
