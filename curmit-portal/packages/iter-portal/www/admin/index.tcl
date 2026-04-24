# USER  DATA       MODIFICHE
# ===== ========== =======================================================================
# sim02 08/11/2016 Leggo alcuni parametri che vengono usati nell'adp per vedere se i menù
# sim02            devono essere filtrati per l'appartenenza ai sottogruppi "Amministratore Contabile"
# sim02            e "Amministratore Manutentori" 
#
# sim01 05/09/2016 Leggo alcuni parametri che vengono usati nell'adp per la gestione delle targhe
#
# nic01 10/06/2016 Leggo alcuni parametri che vengono usati nell'adp

set page_title "Amministrazione portale"
set context [list "$page_title"]

set db_name [db_get_database];#nic01

set sw_wallet_usato_dal_portale [parameter::get_from_package_key -package_key wallet -parameter sw_usato_dal_portale -default 0]

set targhe_flag_gest [parameter::get_from_package_key -package_key iter-portal -parameter targhe_flag_gest];#sim01

set controlli_sottogruppi_flag [parameter::get_from_package_key -package_key iter-portal -parameter controlli_sottogruppi_flag];#sim02

set user_id    [auth::require_login];#sim02

if {$controlli_sottogruppi_flag} {;#sim02 if ed else e loro contenuto
    set is_amm_cont [group::member_p -user_id $user_id -group_name "Amministratore Contabile"  -cascade]
    set is_amm_manu [group::member_p -user_id $user_id -group_name "Amministratore Manutentori" -cascade]
} else {
    set is_amm_cont 1
    set is_amm_manu 1
}
