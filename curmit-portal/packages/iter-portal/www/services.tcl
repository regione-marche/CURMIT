ad_page_contract {
    Menu servizi dei manutentori.

    @cvs-id $Id: services.tcl,v 1.9 2025/10/08 14:06:43 nsadmin Exp $

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    ric01 19/09/2025 Aggiunto estrazione ruolo per gestire nell'adp i menu per la visualizzazione delle deleghe.
    
    gab01 10/04/2018 In caso di gestione del multiportafoglio il link per consultare i
    gab01            Movimenti di Portafoglio punta a un pre-filtro per scegliere l'ente
    gab01            portafoglio prima di arrivare alla lista.

    sim01 05/09/2016 Leggo alcuni parametri che vengono usati nell'adp per la gestione delle targhe

} {

}


set maintainer_id [iter::script_init]

#set maintainer_id ""
set page_title "Servizi per i Manutentori/Installatori/Terzi Responsabili"
set context [list "Servizi"]

set sw_multi_portafoglio [parameter::get_from_package_key -package_key wallet -parameter sw_multi_portafoglio -default 0];#gab01

db_1row query "select name as maintainer_name, validated_p, approved_p 
,cait_id
,role --ric01
from iter_maintainers where maintainer_id = :maintainer_id"

set num_msg [iter::check_reg -maintainer_id $maintainer_id]

set nome_db [db_get_database]

if {[string equal $validated_p "t"] && [string equal $approved_p "f"]} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}
if {[string equal $validated_p "t"] || [string equal $approved_p "f"]} {
    set to_modify_p "t"
} else {
    set to_modify_p "f"
}

set reg_msg [iter::get_reg_msg -validated_p $validated_p -approved_p $approved_p -num_msg $num_msg]

set sw_wallet_usato_dal_portale [parameter::get_from_package_key -package_key wallet -parameter sw_usato_dal_portale -default 0]

set targhe_flag_gest [parameter::get_from_package_key -package_key iter-portal -parameter targhe_flag_gest];#sim01


