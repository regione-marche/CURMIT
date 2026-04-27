ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: operators.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    sim00 24/05/2018 Nuovo programma che visualizza i documenti presenti sugli impianti che hanno
    sim00            una determinata targa

} {
    cod_documento
    dbn_iter
    targa
}

set login_cohesion_marche_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cohesion_marche_p]

set login_cittadino_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cittadino_p]

if {$login_cohesion_marche_p eq "1"} {#innes: aggiunta if, else e loro contenuto
    # visto che non ho in input il cod_impianto, passo alla iter::check_login_cohesion la targa
    set codice_fiscale [iter::check_login_cohesion -nome_array_output array_cohesion -dbn_iter $dbn_iter -targa $targa]
    # Se in futuro ci sara' bisogno di altri campi useremo i valori di array_cohesion
} else {
    if {$login_cittadino_p} {
	set user_id [iter::script_init_cittadino]
    }
}


set file_name [iter_set_spool_dir]/$cod_documento-coimdocu-gest
db_0or1row -dbn $dbn_iter q "select lo_export(coimdocu.contenuto, :file_name)
                                       , tipo_contenuto
                                    from coimdocu
                                   where cod_documento = :cod_documento"
 
ns_returnfile 200 $tipo_contenuto $file_name
ns_unlink $file_name
ad_script_abort
return
