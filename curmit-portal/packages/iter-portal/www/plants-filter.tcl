ad_page_contract {

    @author Simone Pesci
    @cvs-id plants-filter.tcl

    Programma che accetta in input le credenziali per richiamare la stampa del libretto
    partendo dal portale (le credenziali sono il codice fiscale ed il codice impianto).
    
    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    rom05 16/05/2023 Corretto bug su segnalazione di Basilicata, il soggetto che si collega potrebbe
    rom05            avere natura giuridica quindi devo prendere in considerazione anche la P.iva e non
    rom05            solo il codice fiscale.

    rom04 07/05/2021 Per Regione Marche ci sono dei casi in cui una  targa ha associato piu'
    rom04            impianti con proprietario, occupante e responsabile differenti.
    rom04            Prima il programma verificava che il cittadino fosse associato solo al primo
    rom04            codice impianto che trovava associato alla targa, bloccando di fatto lgi utenti.
    rom04            Ora verifico che il cod_cittadino figuri come responsabile, occupante o proprietario
    rom04            su almeno un impianto associato alla targa digitata.

    sim01 17/04/2020 Per le Marche i proprietari e gli occupanti possono vedere i loro impianti
    sim01            anche se non sono responsabili

    nic02 08/11/2018 Aggiunta gestione del parametro login_cohesion_marche_p.
    nic02            Ho preferito non buttare via l'utilizzo del parametro login_cittadino_p
    nic02            perche' magari torna utile per qualche altro cliente.
    
    nic01 24/05/2018 Per le Marche, la ricerca deve avvenire per Targa e non per Codice
    nic01            Impianto.
    nic01
    nic01            Ho verificato con Sandro che,
    nic01 
    nic01            per le Marche, la ricerca deve avvenire sulla targa
    nic01            (sia da web che da QRCode).
    nic01            Per le Marche, è possibile anche la stampa del QRCode che, secondo
    nic01            Sandro, non proveranno mai e non verrà usata.
    nic01            Abbiamo condiviso che, per le Marche, se usano il QRCode, facciamo
    nic01            ugualmente il controllo su Cohesion che reindizzerà l'utente alla pagina
    nic01            dei servizi del cittadino e dovrà cliccare sul "Visualizza impianto" e
    nic01            digitare a mano il codice. E' più macchinoso ma almeno chi entra è
    nic01            sempre autenticato.
    nic01
    nic01            Per la Calabria, la ricerca avviene attualmente per targa col QRCode e
    nic01            per codice impianto se si digita il tutto a mano.
    nic01
    nic01            Per UCIT, la ricerca avviene attualmente per codice impianto se si digita
    nic01            tutto a mano e non e' previsto il QRCode.
    nic01
    nic01            Per evitare di rientrare nel caso del campo targa che arriva dal QRCode,
    nic01            creo il campo targa_digitata e lo gestisco.

    rom03 24/05/2018 Modifiche non commentate di Luca Romitti.

    rom02 09/05/2018 Su richiesta di Sandro metto di default il codice fiscale del cittadino
    rom02            loggato e non lo faccio modificare.

    rom01 07/05/2018 Aggiunta la proc iter::script_init_cittadino per il controllo del log-in
    rom01            del cittadino per ipotesi di utilizzo nelle Marche senza Cohesion.

    gab01 24/10/2016 Il programma puo' essere richiamato dal qrcode della targa.
    gab01            In questo caso, al posto del codice impianto e del codice fiscale,
    gab01            ci sara' solo la label della targa valorizzata col codice targa ricevuto.
} {
    {targa ""}
    {mode "edit"}
}


set page_title "ACCEDI AL TUO IMPIANTO INSERENDO I TUOI DATI"
set buttons    [list [list "Visualizza i dati dell'impianto" edit]]
set field_mode "display"

set db_name    [db_get_database];#nic01

if {[string match "*marche*" $db_name]} {#nic01
    set dicitura_per_adp "la Targa dell'Impianto";#nic01
} else {#nic01
    set dicitura_per_adp "il Codice Impianto"
};#nic01

# Non devo controllare se l'utente ha gia' fatto login perche' questa e' una form di
# autenticazione
# set user_id [auth::require_login] 

set login_cohesion_marche_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cohesion_marche_p];#nic02

set login_cittadino_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cittadino_p];#rom01

if {$login_cohesion_marche_p eq "1"} {#nic02
    set codice_fiscale [iter::check_login_cohesion -nome_array_output array_cohesion];#nic02
    # Se in futuro ci sara' bisogno di altri campi useremo i valori di array_cohesion
    set fiscal_code_mode "display";#nic02
    
} else {#nic02
    
    if {$login_cittadino_p} {#rom01: aggiunta if e suo contenuto
	set user_id [iter::script_init_cittadino] 
	#rom02  Su richiesta di Sandro metto di default il codice fiscale del cittadino loggato  e non lo faccio modificare solo per le Marche.
	set codice_fiscale [db_string q "select fiscal_code 
                                          from iter_citizens
                                         where citizen_id = :user_id"]
	set fiscal_code_mode "display"
    } else {
	set codice_fiscale   ""
	set fiscal_code_mode ""
    };#rom02
};#nic02



set context    [list "Visualizza impianti cittadino"]

ad_form -name addedit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	maintainer_id:key
	
    }

#gab01 solo se ricevo la targa non dovranno esserci le label del codice impianto e codice fiscale.
if {$targa eq ""} {#gab01 aggiunta solo la if

    #rom02: aggiunto $fiscal_code_mode

    ad_form -extend -name addedit -form {
	
	# Start section1
	{-section "sec1" {legendtext "Dati Anagrafici"} {fieldset {class legend}}}
        
	# Codice fiscale, codice impianto e f_instance_name sono obbligatori
	{fiscal_code:text
            {label {Codice fiscale / P.IVA}}
            {html  {maxlength 16 size 20}}
	    {mode  {$fiscal_code_mode}}
        }
	
    }

    if {[string match "*marche*" $db_name]} {#nic01
	#nic01 Per evitare di rientrare nel caso del campo targa che arriva dal QRCode,
	#nic01 creo il campo targa_digitata e lo gestisco.

        #nic01: aggiunta ad_form -extend
	ad_form -extend -name addedit -form {
	    {targa_digitata:text
		{label {Targa}}
		{html  {maxlength 16 size 20}}
	    }
	}
    } else {#nic01
	# caso standard pre-esistente
	ad_form -extend -name addedit -form {
	    {cod_impianto_est:text
		{label {Codice Impianto}}
		{html  {maxlength 20 size 20}}
	    }
	}
    };#nic01
    
} else {#gab01 aggiunta else e suo contenuto

    ad_form -extend -name addedit -form {

	{-section "sec1" {legendtext "Dati della targa"} {fieldset {class legend}}}

        {targa:text(inform)
            {label {Targa}}
            {html  {maxlength 16 size 20}}
	    {value $targa}
        }
	
    }
}

ad_form -extend -name addedit -form {
    
    {f_instance_name:text(select)
	{label {Ente di competenza}}
	{options {{"" ""} [db_list_of_lists query {
	    select g.group_name
	    , i.instance_name
	    from acs_rels       r
	    , groups         g
	    , parties        p
	    , iter_instances i
	    where r.rel_type      = 'composition_rel'
	    and r.object_id_two = g.group_id
	    and g.group_id      = p.party_id
	    and g.group_id      = i.instance_id
	    order by group_name}] }}
    }

}

if {$login_cohesion_marche_p ne "1" && 1==0} {#nic02 (la section esisteva gia')
    ad_form -extend -name addedit -form {
    
	# Start section2
	{-section "sec2" {legendtext "SPID (in fase in implementazione)"} {fieldset {class legend}}}
    
	{SmartCard:text,optional
	    {label {SPID}}
	    {html  {maxlength 50 readonly ""}}
	}

    }
};#nic02

ad_form -extend -name addedit -form {
    # Fine section
    {-section ""}
    
} -on_request {
    #rom02: questo e' il punto corretto dove valorizzare i default
    set fiscal_code $codice_fiscale;#rom02
    
} -on_submit {


    set error_num  0
	
    # Il dbn e' identico ad iter_instances.instance_name
    set dbn_iter $f_instance_name
	
    # Faccio le query sul db dell'ente collegato (dbn).
    
    if {[string match "*marche*" $db_name]} {#nic01
	# nic01 Per le Marche, devo gestire il campo targa_digitata in ogni caso.
	# nic01 Ho aggiunto il contenuto di questa if ma il contenuto della else era
	# nic01 gia' esistente

	# In modo simile alla gestione della targa (modifica gab01), recupero un
	# cod_impianto_est ma non il fiscal_code perche' ricoprirebbe quello ricevuto da
	# Cohesion.
	if {![db_0or1row -dbn $dbn_iter query "
            select 1 --rom04
           --rom04 cod_impianto_est
              from coimaimp
             where targa    = :targa_digitata
          order by flag_tipo_impianto desc
             limit 1"]
	} {
	    template::form::set_error addedit targa_digitata "La targa indicata non &egrave; censita"
	    incr error_num
	    break
	}

	# Controllo il codice fiscale
	db_1row -dbn $dbn_iter query "
        select count(*) as count_coimcitt
          from coimcitt
         where cod_fiscale = upper(:fiscal_code)"

	if {$count_coimcitt == 0}	{
	    template::form::set_error addedit fiscal_code "Il codice fiscale indicato non &egrave; censito"
	    incr error_num 
	}
	
	# Controllo il codice impianto
#rom04	if {![db_0or1row -dbn $dbn_iter query "
#rom04       select cod_impianto
#rom04            , cod_responsabile
#rom04            , coalesce(cod_proprietario,'') as cod_proprietario --sim01
#rom04            , coalesce(cod_occupante,'')    as cod_occupante    --sim01
#rom04         from coimaimp
#rom04        where cod_impianto_est = upper(:cod_impianto_est)
#rom04       "]
#rom04	} {
#rom04	    template::form::set_error addedit targa_digitata "La targa indicata non &egrave; censita"
#rom04       incr error_num
#rom04   }

	if {$error_num == 0} {
#rom04	    if {![db_0or1row -dbn $dbn_iter query "
#rom04           select 1 as dummy
#rom04             from coimcitt
#rom04            where cod_cittadino in (:cod_responsabile,:cod_proprietario,:cod_occupante) --sim01
#rom04              --sim01 cod_cittadino = :cod_responsabile
#rom04              and cod_fiscale   = upper(:fiscal_code)
#rom04           "]
#rom04	    } {
#rom04		template::form::set_error addedit targa_digitata "Il soggetto e la targa indicati non sono correlati"
#rom04		incr error_num
#rom04	    }
	
	    if {![db_0or1row -dbn $dbn_iter q "select a.cod_responsabile
                                                    , a.cod_occupante
                                                    , a.cod_proprietario
                                                    , a.cod_impianto_est 
                                                    , a.cod_impianto
                                                 from coimaimp a
                                                    , coimcitt c
                                                where a.targa = :targa_digitata 
                                                  and upper(c.cod_fiscale) = upper(:fiscal_code)
                                                  and ( a.cod_responsabile = c.cod_cittadino or
                                                        a.cod_occupante    = c.cod_cittadino or
                                                        a.cod_proprietario = c.cod_cittadino)
                                                limit 1"]} {#rom04 Aggiunta if e suo contenuto
		template::form::set_error addedit targa_digitata "Il soggetto e la targa indicati non sono correlati"
		incr error_num
	    }
	}
	
	if {$error_num > 0} {
	    break
	}

    } else {#nic01

	# nic01 Il contenuto di questa else era gia' esistente

	if {$targa ne ""} {#gab01 aggiunta if e suo contenuto

	    #gab01 due impianti (uno caldo e un freddo) possono avere la stessa targa quindi li conto preventivamente.

	    db_0or1row -dbn $dbn_iter query "  
                          select count(*) as num_imp_targ
                            from coimaimp 
                            where targa = :targa"

            if {$num_imp_targ == 0} {
		template::form::set_error addedit targa "La targa indicata non &egrave; censita"
                break
	    }

	    #gab01: con la targa ottengo il cod_impianto_est ed il fiscal_code per poter
	    #       superare i controlli.
	    if {$num_imp_targ == 1} {
                set sql " select cod_impianto_est
                     -- rom05 , cod_fiscale as fiscal_code
                               , coalesce(cod_fiscale,cod_piva) as fiscal_code -- rom05
                            from coimaimp a,
                                 coimcitt b
                           where a.cod_responsabile = b.cod_cittadino
                             and a.targa            = :targa"
            } else {
                set sql " select cod_impianto_est
                     -- rom05 , cod_fiscale as fiscal_code
                               , coalesce(cod_fiscale,cod_piva) as fiscal_code -- rom05
                            from coimaimp a,
                                 coimcitt b
                           where a.cod_responsabile = b.cod_cittadino
                             and a.targa            = :targa
                 -- rom03    and a.flag_tipo_impianto = 'R'
                        order by a.flag_tipo_impianto desc -- rom03
                           limit 1 --nic01"
            }
     	    
	    db_0or1row -dbn $dbn_iter query $sql

	}


	# Controllo il codice fiscale
	db_1row -dbn $dbn_iter query "
        select count(*) as count_coimcitt
          from coimcitt
         where ( cod_fiscale = upper(:fiscal_code)
              or cod_piva    = upper(:fiscal_code))"

	if {$count_coimcitt == 0}	{
	    template::form::set_error addedit fiscal_code "Il codice fiscale indicato non &egrave; censito"
	    incr error_num 
	}
	
	# Controllo il codice impianto
	if {![db_0or1row -dbn $dbn_iter query "
            select cod_impianto
                 , cod_responsabile
              from coimaimp
             where cod_impianto_est = upper(:cod_impianto_est)
            "]
	} {
	    template::form::set_error addedit cod_impianto_est "Il codice impianto indicato non &egrave; censito"
            incr error_num
        }


	if {$error_num == 0} {
	    if {![db_0or1row -dbn $dbn_iter query "
                select 1 as dummy
                  from coimcitt
                 where cod_cittadino = :cod_responsabile
                   and ( cod_fiscale = upper(:fiscal_code)
                      or cod_piva    = upper(:fiscal_code))    
                "]
	    } {
		template::form::set_error addedit cod_impianto_est "Il soggetto e il codice impianto indicati non sono correlati"
		incr error_num
	    }
	}

	if {$error_num > 0} {
	    break
	}
    };#nic01

} -edit_data {

} -after_submit {
    
    set cod_cittadino $cod_responsabile
    #rom03 set link_list [export_vars {cod_cittadino cod_impianto_est cod_impianto dbn_iter}]&nome_funz=impianti
    
    set link_list        [export_vars {cod_cittadino cod_impianto_est cod_impianto dbn_iter targa}]&nome_funz=dimp;#rom03
    ad_returnredirect "coimaimp-sche?$link_list"
    ad_script_abort
}
