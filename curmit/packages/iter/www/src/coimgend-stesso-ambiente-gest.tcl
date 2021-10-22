ad_page_contract {
    @author          Paolo Formizzi Adhoc
    @creation-date   23/04/2004

    @param caller    caller della lista da restituire alla lista:
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
    @                serve se lista e' uno zoom che permetti aggiungi.

    @param extra_par Variabili extra da restituire alla lista

    @cvs-id          coimestr-gest.tcl

    USER   DATA       MODIFICHE
    ====== ========== =======================================================================

} {
    {caller            ""}
    {nome_funz         ""}
    {nome_funz_caller  ""}
    {extra_par         ""}
    {gen_prog ""}
    {cod_impianto ""}
    {link         ""}
    associato:multiple,optional
} -properties {
    page_title:onevalue
    context_bar:onevalue

}



# Controlla lo user
set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# controllo il parametro di "propagazione" per la navigation bar
if {[string is space $nome_funz_caller]} {
    set nome_funz_caller $nome_funz
}

# Personalizzo la pagina
#set context_bar  [iter_context_bar -nome_funz $nome_funz_caller]
#set link_filter  [export_url_vars caller nome_funz]&[iter_set_url_vars $extra_par]


    
db_dml del_gen_stesso_ambiente "delete 
                                  from coimgend_stesso_ambiente 
                                 where cod_impianto = :cod_impianto
                                   and gen_prog = :gen_prog"

if {[exists_and_not_null associato]} {

foreach gen_da_associare $associato {

    set cod_stesso_ambiente [db_string q "select coalesce(max(cod_stesso_ambiente::integer), '0') + 1 
                                            from coimgend_stesso_ambiente"]

    db_dml ins_gen_stesso_ambiente "insert into coimgend_stesso_ambiente
                                         ( cod_stesso_ambiente   
                                         , cod_impianto          
                                         , gen_prog              
                                         , cod_impianto_collegato
                                         , gen_prog_collegato    
                                         )
                                  values ( :cod_stesso_ambiente
                                         , :cod_impianto
                                         , :gen_prog
                                         , :cod_impianto 
                                         , :gen_da_associare
                                         )"
}

}

set return_url "coimgend-stesso-ambiente?cod_impianto=$cod_impianto&gen_prog=$gen_prog&nome_funz=datigen&nome_funz_caller=impianti"
#set return_url "coimgend-stesso-ambiente?$link"
ad_returnredirect $return_url
ad_script_abort
ad_return_template
