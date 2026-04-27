ad_page_contract {

  @author   Nelson Secco
  @cvs-id   adjust-3.tcl
  @commenti Bonifica degli impianti del manutentore passato come paramentro ( da 'old' a 'new' )

} {
    {cod_impianto:integer,multiple ""}
    maintainer_id
    iter_code
    new_iter_code
    instance_name
    password
}

# ====================================================================================================================
# (*) Stesse logiche e stesse query del 'core' del programma di 'ITER': 'coimbman-gest.tcl' ... con + filtro anche sui
#     singoli 'cod_impianto' selezionati (...)
# ====================================================================================================================

# ( Variabili utilizzate nelle vari QUERY 'postresql' di Update ... )
#### [join $cod_impianto ","]

set cods_impianto_list ""
set ctr 0
foreach cod $cod_impianto {
    incr ctr
    if {$ctr == 1} {
	set cods_impianto_list "'$cod'"
    } else {
	append cods_impianto_list ", '$cod'"
    }
}

# ns_log notice "\n Nelson(START) |cods_impianto_list = $cods_impianto_list|maintainer_id=$maintainer_id|old_iter_code=$iter_code|new_iter_code=$new_iter_code|instance_name=$instance_name|"

if {[string equal $cods_impianto_list ""]} {
    ad_returnredirect -message "Nessun impianto selezionato. Nessuna azione e' stata eseguita." "adjust-2?maintainer_id=$maintainer_id&iter_code=$iter_code&instance_name=$instance_name"
    db_release_unused_handles
    ad_script_abort
}

set validating_date [db_string query "select to_char(current_date, 'YYYY-MM-DD')"]

set destinazione $new_iter_code
set cod_manu     $iter_code

db_transaction {

  # =========================================================================
  # ( 'UPDATE' con filtro anche sui 'cod_impianto' in ( :cods_impianto_list )
  # =========================================================================
  # ns_log notice "\n Nelson(1)|cods_impianto_list = $cods_impianto_list|destinazione = $destinazione|cod_manu = $cod_manu|"
    set dml_upd_aimp [db_map upd_aimp]
    set dml_upd_coma [db_map upd_coma]
    set dml_upd_dimp [db_map upd_dimp]
  # =========================================================================

    set dml_upd_mtar [db_map upd_mtar]
    set dml_upd_manu [db_map upd_manu]
    set dml_del_opma [db_map del_opma]

    # ( Se manca inserisce l'operatore nella ditta ........................ )
    db_foreach -dbn $instance_name sel_opma "" {
	if {[db_0or1row -dbn $instance_name sel_opma_check ""] == 0} {
	    db_1row -dbn $instance_name sel_opma_s ""
	    db_dml  -dbn $instance_name ins_opma ""
	}
    }

    db_dml -dbn $instance_name dml_aimp $dml_upd_aimp
    db_dml -dbn $instance_name dml_coma $dml_upd_coma
   
    # ====================================================================================
    # ( Se manca inserisce l'operatore nella XXXXXXX ........................ )
    # ====================================================================================
    # ( 'SELECT' & 'UPDATE' con filtro anche sui 'cod_impianto' in ( :cods_impianto_list )
    # ====================================================================================
    db_foreach  -dbn $instance_name sel_opma_dimp "" {
	db_1row -dbn $instance_name sel_opma_dest ""
	db_dml  -dbn $instance_name upd_dimp_opma ""
    }

    db_dml -dbn $instance_name dml_dimp $dml_upd_dimp
    db_dml -dbn $instance_name dml_mtar $dml_upd_mtar
    db_dml -dbn $instance_name dml_manu $dml_upd_manu
    db_dml -dbn $instance_name dml_opma $dml_del_opma

    # ==============================================================================================================
    # ( 19.02.2009 - Nelson ) La bonifica e' fattibile una ed una sola volta ... Come richiesto da CESTEC stessa ...
    # ==============================================================================================================
    set user_id [ad_conn user_id]

    # ns_log notice "\n Nelson (END) |ITER_MAINTAINERS_TO_ADJUST|$validating_date|$user_id|$maintainer_id|"
    # ( e se non trova dati e non aggiorna nulla !!?? ... )
    db_dml query "update iter_maintainers_to_adjust set f_one_time     = 't', 
                                                        one_time_date  = :validating_date,
                                                        one_time_user  = :user_id     
                                              where iter_code          = :iter_code
                                                and password           = :password
                                                and instance_name      = :instance_name"

} on_error {
    ah::transaction_error
}

ad_returnredirect -message "Gli impianti precedentemente selezionati sono stati 'BONIFICATI'." "../services"

# ad_returnredirect -message "Gli impianti precedentemente selezionati sono stati 'BONIFICATI'." "adjust"
# ad_returnredirect -message "Gli impianti precedentemente selezionati sono stati 'BONIFICATI'." "adjust-2?maintainer_id=$maintainer_id&iter_code=$iter_code&instance_name=$instance_name&password=$password"
# ad_script_abort

db_release_unused_handles
ad_return_template 
