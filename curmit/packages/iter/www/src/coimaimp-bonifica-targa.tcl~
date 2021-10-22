ad_page_contract {

    @author        Romitti Luca
    @creation-date 18/05/2020

    @cvs-id 
}

db_transaction {
    iter_get_coimtgen
    set lun_num_cod_imp_est $coimtgen(lun_num_cod_imp_est)
    set sigla_est "CMPS"
    set count 0

    db_foreach sel_aimp "select cod_impianto from coimaimp where targa is null" {

	set progressivo_est [db_string sel "select nextval('coimaimp_est_s')"]
	set progressivo_est [db_string sel "select lpad(:progressivo_est,:lun_num_cod_imp_est,'0')"]

	incr count

	set targa "$sigla_est$progressivo_est"
	db_dml upd_targa "update coimaimp set targa = :targa where cod_impianto = :cod_impianto"
    }
}



ns_return 200 text/html " bonificate $count targhe"
return
