ad_library {
    Provide various functions for the package.

    @csv-id iter-init.tcl
}

ad_schedule_proc -schedule_proc ns_schedule_weekly {0 23 00} iter_taratura_scaduta
ad_schedule_proc -schedule_proc ns_schedule_daily {23 30} iter_bonifica_manutentori
