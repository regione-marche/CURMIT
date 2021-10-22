ad_library {
    Provide various functions for the package.

    @author Nicola Mortoni
    @csv-id iter-init.tcl

}

ad_schedule_proc 30 iter_lancia_batch
ad_schedule_proc -schedule_proc ns_schedule_daily {23 00} iter_delete_tmp
ad_schedule_proc -schedule_proc ns_schedule_daily {23 05} iter_delete_permanenti

ad_schedule_proc -schedule_proc ns_schedule_daily {23 30} iter_upd_stato_impianto

# creo la cache usata dal menu dinamico
ns_cache create dynamic_menu_cache
