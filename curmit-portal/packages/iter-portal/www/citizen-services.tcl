ad_page_contract {
    Menu servizi dei cittadini
    
    @author Gacalin Lufi
    @cvs-id $Id: citizen-services.tcl

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    nic01 08/11/2018 Aggiunta gestione del parametro login_cohesion_marche_p.
    nic01            Ho preferito non buttare via l'utilizzo del parametro login_cittadino_p
    nic01            perche' magari torna utile per qualche altro cliente.
    
} {
    {caller ""}
}

set page_title "Servizi per i cittadini registrati."
set context [list "Servizi"]

#set user_id    [auth::require_login]

set login_cohesion_marche_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cohesion_marche_p];#nic01

if {$login_cohesion_marche_p eq "1"} {#nic01
    set fiscal_code [iter::check_login_cohesion -nome_array_output array_cohesion];#nic01
    # Se in futuro ci sara' bisogno di altri campi useremo i valori di array_cohesion
} else {#nic01
    set user_id [iter::script_init_cittadino]
};#nic01

set reg_msg "Registrazione avvenuta con successo"
