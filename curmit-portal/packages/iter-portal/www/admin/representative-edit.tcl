ad_page_contract {
    Cambio rappresentante legale di una ditta di manutenzione (storicizzandolo)
    per permettere poi la propagazione della modifica su I.Ter. ed il cambio del terzo resp.
    
    @author        Nicola Mortoni
    @creation-date 17/05/2004

    @cvs-id        representative-edit.tcl (clonato da maintainer-edit.tcl)

    USER  DATA       MODIFICHE
    ===== ========== ===============================================================================
    rom01 21/05/2020 Per gli enti diversi da Regione Marche metto di default a 'f' i campi patentino
    rom01            e patentino_fgas perche' sono dei campi hidden e andava in errore l'inserimento.

    gac01 15/02/2018 modificata label patentino sul manutentore e aggiunto patentino_rapp e  
    gac01            patentino_fgas_rapp sul rappresentante legale

} {
    maintainer_id:integer
}


if {![db_0or1row query "select name
                             , representative_id
                          from iter_maintainers
                         where maintainer_id = :maintainer_id"]
} {
    ad_return_complaint 1 "<li>Manutentore con maintainer_id = $maintainer_id non trovato in anagrafica manutentori</li>"
    ad_script_abort
}

set page_title "Cambia rappresentante legale del manutentore $name"
set buttons    [list [list "Cambia rappresentante legale" edit]]

set db_name [db_get_database];#gac01

set user_id    [auth::require_login] 

set context    [list [list maintainers-list {Lista Manutentori}] "Cambia Rappresentante Legale"]

#gac01 aggiunto patentino_rapp e patentino_fgas_rapp sul rappresentante legale
ad_form -name addedit \
    -mode edit \
    -edit_buttons $buttons \
    -has_edit 1 \
    -form {
	
	maintainer_id:key

        {rep_name:text 
            {label {Cognome}}
            {html {size 50 maxlength 200}}
        }
        {rep_first_name:text 
            {label {Nome}}
            {html {size 50 maxlength 200}}
        }
	{rep_address1:text
	    {label {Indirizzo}}
	    {html {size 50 maxlength 200}}
	}
	{rep_city:text
	    {label {Comune}}
	    {html {size 50 maxlength 40}}
	}
	{rep_address2:text,optional 
	    {label {Località}}
	    {html {size 50 maxlength 40}}
	}
	{rep_province:text
	    {label {Provincia}}
	    {html {size 5 maxlength 4}}
	}
	{rep_zipcode:text
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
        {rep_fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
            {help_text "Cliccando su \"Cambia rappresentante legale\", oltre ad aggiornare i dati, questa notte verrà cambiato anche il terzo responsabile dei relativi impianti"}
        }
    }

#gac01 aggiunta if else e suo contenuto
if {[string match "*iter-portal-marche*" $db_name]} {#gac01
    ad_form -extend -name addedit -form {
	{patentino_rapp:boolean(radio)
	    {label {Patentino}}
	    {options {{"Si" "t"} {"No" "f"}}}
	    {value "f"}
	}
	{patentino_fgas_rapp:boolean(radio)
	    {label {Patentino Fgas}}
	    {options {{"Si" "t"} {"No" "f"}}}
	    {value "f"}
	}
    }
} else { #gac01
    #rom01 aggiunti i value "f" ai campi patentino_rapp e patentino_fgas_rapp
    ad_form -extend -name addedit -form {
	{patentino_rapp:text(hidden),optional
	    {value "f"}
	}
	{patentino_fgas_rapp:text(hidden),optional
	    {value "f"}
	}
    }
};#gac01
ad_form -extend -name addedit \
    -form {
    } -edit_request {
	# non precompilo nessun campo, visto che deve cambiare
	
    } -on_submit {

        set errnum 0

	# stessi controlli fatti in maintainers-edit.tcl:

	# controllo codice fiscale del rappresentante legale
	if {[regexp {[^A-Za-z0-9]+} $rep_fiscal_code] > 0 } {
	    template::form::set_error addedit rep_fiscal_code "Contiene caratteri non validi."
	    incr errnum
	}

	set l [string length $rep_fiscal_code]
	if {$l != 16 && $l != 11} {
	    template::form::set_error addedit rep_fiscal_code "Lunghezza errata."
	    incr errnum
	} elseif {$l == 16 && [iter::verifyfc -xcodfis $rep_fiscal_code] == 0} {
	    template::form::set_error addedit rep_fiscal_code "Codice Fiscale errato."
	    incr errnum
	} elseif {$l == 11 && [iter::verifyvc -xcodfis $rep_fiscal_code] == 0} {
	    template::form::set_error addedit rep_fiscal_code "Codice Fiscale errato."
	    incr errnum
	}

	# Non faccio questo controllo perchè gestisco la possibilità di inserire o modificare
	# il soggetto
	#if {[db_0or1row query "select 1 from iter_parties where fiscal_code = :rep_fiscal_code and party_id <> :representative_id limit 1"] > 1} {
	#    template::form::set_error addedit rep_fiscal_code "Codice fiscale già presente in archivio."
	#    incr errnum
	#}

	# verifico che sia cambiato almeno il codice fiscale o il cognome o il nome
	if {![db_0or1row query "select *
                                  from iter_parties
                                 where party_id = :representative_id" -column_array old_rep]
	} {
	    ad_return_complaint 1 "<li>Rappresentante legale con party_id = $representative_id non trovato in anagrafica</li>"
	    ad_script_abort
	}

	if {[string equal $rep_fiscal_code $old_rep(fiscal_code)]
	&&  [string equal $rep_name        $old_rep(name)]
	&&  [string equal $rep_first_name  $old_rep(first_name)]
	} {
	    template::form::set_error addedit rep_name "Non è possibile cambiare il rappresentante legale se non cambia nè il Cognome, nè il Nome e nè il Codice Fiscale rispetto al rappresentante legale valido in questo momento."
	    incr errnum
	}

	if {$errnum > 0} {
	    break
	}

    } -edit_data {

	db_transaction {
	    # Per prima cosa, verifico se esiste già un altro record di iter_parties con lo
            # stesso codice fiscale, cognome e nome.
	    if {[db_0or1row query "select party_id
                                     from iter_parties
                                    where upper(trim(fiscal_code)) = upper(trim(:rep_fiscal_code))
                                      and upper(trim(name))        = upper(trim(:rep_name))
                                      and upper(trim(first_name))  = upper(trim(:rep_first_name))
                                 order by party_id desc
                                    limit 1"]
	    } {
		# in questo caso, modifico gli altri dati del soggetto
		db_dml upd_iter_parties "
                update iter_parties
                   set name         = upper(:rep_name)
                     , first_name   = upper(:rep_first_name)
                     , address1     = upper(:rep_address1)
                     , address2     = upper(:rep_address2)
                     , city         = upper(:rep_city)
                     , province     = upper(:rep_province)
                     , zipcode      = :rep_zipcode
                     , fiscal_code  = upper(:rep_fiscal_code)
                     , editing_user = :user_id
                     , editing_date = current_date
                     , patentino    = :patentino_rapp
                     , patentino_fgas = :patentino_fgas_rapp
                 where party_id     = :party_id"
	    } else {
		# in questo caso, inserisco un nuovo soggetto (come fa il programma user-new.tcl):
		set party_id [db_string query "select coalesce(max(party_id) + 1, 1) from iter_parties"]

		db_dml ins_iter_parties "
                insert
                  into iter_parties
                     ( party_id
                     , name
                     , first_name
                     , address1
                     , address2
                     , city
                     , province
                     , zipcode
                     , fiscal_code
                     , creation_user
                     , creation_date
                     , patentino       --gac01
                     , patentino_fgas  --gac01
                     )
              values ( :party_id
                     , upper(:rep_name)
                     , upper(:rep_first_name)
                     , upper(:rep_address1)
                     , upper(:rep_address2)
                     , upper(:rep_city)
                     , upper(:rep_province)
                     , :rep_zipcode
                     , upper(:rep_fiscal_code)
                     , :user_id
                     , current_date
                     , :patentino_rapp      --gac01
                     , :patentino_fgas_rapp --gac01

                     )"
	    }


	    # Storicizzo il vecchio rappresentante legale del manutentore

	    # Per ora non facciamo gestire dall'utente la data fine validità e quindi la
	    # calcolo come oggi - 1 gg
	    set end_date [db_string query "select current_date - 1"]

	    # Non posso inserire sullo storico due record con la stessa data di fine validità:
	    # prima devo leggere se esiste già.
	    if {[db_0or1row query "select hist_representative_id
                                     from iter_hist_representatives
                                    where maintainer_id = :maintainer_id
                                      and end_date      = :end_date"]
	    } {
		# Se esiste già, non faccio niente perchè così rimane nello storico quello
                # che era in vigore fino all'end_date.
	    } else {
		# In questo caso, inserisco il record
		db_1row query "select coalesce(max(hist_representative_id),0) + 1 as hist_representative_id
                                 from iter_hist_representatives"

		db_dml ins_iter_hist_representatives "
                insert
                  into iter_hist_representatives
                     ( hist_representative_id
                     , maintainer_id        
                     , end_date             
                     , representative_id    
                     , creation_user        
                     , creation_timestamp   
                     )
              values (:hist_representative_id
                     ,:maintainer_id        
                     ,:end_date             
                     ,:representative_id    
                     ,:user_id
                     , current_timestamp   
                     )"
	    }


	    # Ora cambio il rappresentante legale del manutentore
	    db_dml maintainer_edit "
            update iter_maintainers
               set representative_id = :party_id
                 , editing_date      = current_date
                 , editing_user      = :user_id
             where maintainer_id     = :maintainer_id"

	} on_error {
	    ah::transaction_error
	}

    } -after_submit {
	ns_return 200 text/html "
        <script type=\"text/javascript\">
        try {
             window.opener.document.addedit.representative_id.value = '$party_id';
             window.opener.document.addedit.rep_name.value          = '[ah::js_quote_escape $rep_name]';
             window.opener.document.addedit.rep_first_name.value    = '[ah::js_quote_escape $rep_first_name]';
             window.opener.document.addedit.rep_address1.value      = '[ah::js_quote_escape $rep_address1]';
             window.opener.document.addedit.rep_city.value          = '[ah::js_quote_escape $rep_city]';
             window.opener.document.addedit.rep_address2.value      = '[ah::js_quote_escape $rep_address2]';
             window.opener.document.addedit.rep_province.value      = '[ah::js_quote_escape $rep_province]';
             window.opener.document.addedit.rep_zipcode.value       = '[ah::js_quote_escape $rep_zipcode]';
             window.opener.document.addedit.rep_fiscal_code.value   = '[ah::js_quote_escape $rep_fiscal_code]';
             window.opener.document.addedit.patentino_rapp.value         = '[ah::js_quote_escape $patentino_rapp]';
             window.opener.document.addedit.patentino_fgas_rapp.value    = '[ah::js_quote_escape $patentino_fgas_rapp]';
             window.opener.scrollTo(0,999999);
             window.close();

        } catch (err) {
             alert('Aggiornamento avvenuto correttamente. C\\'è stato un problema nel chiudere questa finestra e nel riportare i dati nella pagina di modifica manutentore. Si prega di chiudere la finestra e di tornare alla lista manutentori');
        }

        </script>
	"
	ad_script_abort
    }
