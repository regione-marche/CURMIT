ad_page_contract {

    @author Simone Pesci
    @cvs-id

    Dato che i vari enti della Regione Marche partono a scaglioni, è necessario importare ogni volta i manutentori già
    presenti sul portale. Sarà poi compito dell'ente bonificarli con quelli già presenti.
    In input il programma richiede il nome della istanza su cui operare.
} {
    istances
}

set user_id    [ad_conn user_id]


# azzero liste
set maintainers               [list]
set representatives           [list]
set operators                 [list]
set to_notify                 [list]
set maintainers_installations [list] ;#rom01
set num_manu 0
# leggo manutentori da propagare: devono avere il flag validated_p=t e iter_code=null
db_foreach query "
            select * 
            from iter_maintainers 
            where iter_code is not null
            order by creation_date, maintainer_id
    " {

	incr num_manu
	
	lappend maintainers [list [list $iter_code $maintainer_id] $name $address1 $address2 $province $zipcode $city $fiscal_code $iva_code $phone $mobile $fax $email $registration_no $where_registered $rea_no $where_rea $capital $role $pec $patentino $patentino_fgas];#sim06

        # popolo lista soggetti da notificare
        lappend to_notify [list $maintainer_id $cait_id]

	# leggo rappresentante legale
	db_1row query "
            select p.name as rep_name, 
               p.first_name as rep_first_name, 
               p.address1 as rep_address1, 
               p.city as rep_city, 
               p.address2 as rep_address2, 
               p.province as rep_province, 
               p.zipcode as rep_zipcode, 
               p.fiscal_code as rep_fiscal_code,
               p.patentino as patentino_rapp,            --gac01
               p.patentino_fgas as patentino_fgas_rapp   --gac01
               
            from iter_parties p
           where p.party_id = :representative_id"

	# popolo lista rappresentanti legali
	lappend representatives [list $iter_code $rep_name $rep_first_name $rep_address1 $rep_city $rep_address2 $rep_province $rep_zipcode $rep_fiscal_code $patentino_rapp $patentino_fgas_rapp]

	# leggo operatori
	set ops [db_list_of_lists operators "
                select operator_id, 
                       name, 
                       first_name, 
                       no, 
                       fiscal_code, 
                       phone, 
                       mobile, 
                       address, 
                       notes,
                       patentino as patentino_op,              --gac01
                       patentino_fgas as patentino_op_fgas     --gac01
                     , iter_no 
                 from iter_operators 
                 where maintainer_id = :maintainer_id 
                 order by operator_id"]

	set iter_no_num 0

	foreach op $ops {

	    util_unlist $op operator_id name first_name no fiscal_code phone mobile address notes patentino_op patentino_op_fgas iter_no

	    set password ""

	    if {$istances eq "itercman"} {
		#se sto lavorando sul comune di ancona (primo a partire in produzione) vuol dire che sto importando solo i casi di test e vado a settare la psw a cambiami
		set password "cambiami"
		
	    } else {
		#la password sarà quella già inserita sul comune di ancona
		db_0or1row -dbn "itercman" q "select password from coimuten where id_utente=:iter_no"
	    }
	    
	    # popolo lista operatori
	    lappend operators [list $iter_no $name $first_name $no $fiscal_code $phone $mobile $address $notes $password $operator_id $patentino_op $patentino_op_fgas]

	}
	
	#rom01: Leggo maintainer_installations
	set man_inst [db_list_of_lists maintainers_installations "
                select maintainer_installations_id
                     , :iter_code
                     , installation_type_code
                     , 'batch'      as creation_user
                     , current_date as creation_date
                  from iter_maintainer_installations i
                     , iter_installation_types t
                 where maintainer_id = :maintainer_id
                   and t.installation_type_id = i.installation_type_id
              order by maintainer_installations_id"]

	set iter_no_num 0

	foreach manut_in $man_inst {

	    util_unlist $manut_in maintainer_installations_id maintainer_id installation_type_code creation_user creation_date 

	    incr iter_no_num

	    #rom01 Popolo lista maintainer_installations
	    lappend maintainers_installations [list $maintainer_installations_id $iter_code $installation_type_code $creation_user $creation_date]

	}
    }

    foreach instance $istances {

        ns_log notice "\n importa_manutentori_da_portale ... processing instance=$instance"

	# nuovi manutentori
	iter::maintainers_new -dbn $instance -maintainers $maintainers

	# nuovi operatori
	iter::operators_new -dbn $instance -operators $operators

	# nuovi rappresentanti legali
	iter::representatives_new -dbn $instance -representatives $representatives

	ns_log notice "simone importa_manutentori_da_portale maintainers_installations=$maintainers_installations maintainers=$maintainers"

	iter::maintainer_installations_new -dbn $instance -maintainers_installations $maintainers_installations
    }


ns_return 100 text/plain "Importato $num_manu manutentori"
