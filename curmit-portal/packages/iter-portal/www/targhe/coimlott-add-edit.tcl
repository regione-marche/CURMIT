ad_page_contract {

    @author Simone Pesci

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    sim01 26/01/2021 Per la Basilicata la targa deve essere lunga 13 caratteri

} {
    {coimlott_id ""}
    {mode "edit"}
}

set user_id    [ad_conn user_id]

set select_clause ""
set page_title "Genera Targhe"
set buttons [list [list "$page_title" new]]
set field_mode edit

set context [list [list coimlott-list {Lista Lotti di Targhe}] $page_title]


ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -export coimlott_id \
    -has_edit 1 \
    -form {
	{num_targhe:text
	    {label {Numero targhe}}
	    {html {size 10 maxlength 10}}
	    {mode $field_mode}
	}
} -on_request {

} -on_submit {
    
    #eseguo i controlli
    set targhe_max_per_lotto [parameter::get_from_package_key -package_key iter-portal -parameter targhe_max_per_lotto]
    set targhe_per_plico     [parameter::get_from_package_key -package_key iter-portal -parameter targhe_per_plico]
    set targhe_pref_regione  [parameter::get_from_package_key -package_key iter-portal -parameter targhe_pref_regione]

    if {![string is integer $num_targhe]} {
	template::form::set_error addedit num_targhe "Deve essere un numero intero."
	break
    }

    #controllo che sia multiplo di 100
    set mult 0.00
    set mult [expr ($num_targhe % 100)]
    
    if {$mult != 0} {
	template::form::set_error addedit num_targhe "Deve essere un numero multiplo di 100."
        break
    }
    
    if {$targhe_max_per_lotto < $num_targhe} {
	template::form::set_error addedit num_targhe "Non si può generare più di $targhe_max_per_lotto per lotto"
	break
    }


    #passati i controlli genero le targhe:

    set cont_targhe_gen 0
    set i 0

    #inserisco il lotto
    db_1row get_id_lotto "select nextval('coimlott_s') as lotto_id"
    db_dml ins_lotto "insert into coimlott
                             ( lotto_id
                             , num_targhe
                             , timestamp_ins
                             , user_id)
                      values ( :lotto_id
                             , :num_targhe
                             , current_timestamp
                             , :user_id)"                             

    while {$cont_targhe_gen < $num_targhe} {
    
	incr i
	if {$i > 500000} {
	    break
	}

	if {[db_get_database] eq "iter-portal-basilicata"} {#sim01 if e suo contenuto

	    set matrice [ad_generate_random_string 8]

	} else {#sim01

	    set matrice [ad_generate_random_string 11] 
	    
	};#sim01

	set matrice $targhe_pref_regione$matrice

	#Inserisco solo se la matrice è univoca sulla tabella. 
	#Altrimenti non incremento i contatori e non faccio le insert in modo da ricrearla
	set matrice_num "00"
	if {![db_0or1row q "select matrice_fissa 
                              from coimplic 
                             where matrice_fissa=:matrice"]} {
	    
	    #per ogni matrice faccio N plichi a seconda del valore di targhe_per_plico. 
	    set num_plichi [expr 100 / $targhe_per_plico]
	    set cont_num_plichi 0
	    
	    while {$cont_num_plichi  < $num_plichi} {

		incr cont_num_plichi

		set matrice_da $matrice_num
		set matrice_da [ah::lpad $matrice_da 2 0]
		
		set matrice_a  [expr $matrice_da + $targhe_per_plico - 1]
		
		set matrice_a  [ah::lpad $matrice_a 2 0]

		ns_log notice "simone2 matrice_a:$matrice_a matrice_da:$matrice_da"
		#inserisco il plico	
		db_1row get_id_plico "select nextval('coimplic_s') as plico_id"
		db_dml ins_plico "insert into coimplic
                                     ( plico_id
                                     , lotto_id
                                     , matrice_fissa
                                     , matrice_da
                                     , matrice_a)
                              values ( :plico_id
                                     , :lotto_id
                                     , :matrice
                                     , :matrice_da
                                     , :matrice_a)"

		#inserisco tutte le targhe del plico
		set cont_targhe 0
		while {$cont_targhe < $targhe_per_plico} {

		    set targa $matrice$matrice_num

		    ns_log notice "Simone targa:$targa matrice:$matrice matrice_num:$matrice_num matrice_da:$matrice_da matrice_a:$matrice_a "
 
		    incr cont_targhe_gen
		    incr cont_targhe

		    db_1row get_id_targa "select nextval('coimtarg_s') as targa_id"
		    db_dml ins_targhe "insert into coimtarg
                                            ( targa_id
                                            , plico_id
                                            , targa)
                                     values ( :targa_id
                                            , :plico_id
                                            , :targa)"


		    scan $matrice_num %d matrice_num
		    set matrice_num [expr $matrice_num + 1]
		    set matrice_num [ah::lpad $matrice_num 2 0]
		    
		} 

		#set matrice_num $matrice_a

	    }
	}
    }
    
} -after_submit { 

    ad_returnredirect "coimlott-list"
    ad_script_abort
}




