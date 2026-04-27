ad_page_contract {

    @author Claudio Pasolini
    @cvs-id maintainer-edit.tcl

    USER  DATA       MODIFICHE
    ===== ========== ===============================================================================
    but02 24/07/2024  Aggiunto la funziona trim su ragione sociale.
    
    sim07 24/06/2024 Corretto bug su nome del file disciplinare_bollini

    but01 05/03/2024 Modificato returnredirect.
    
    ric01 07/03/2024 Aggiunta per Palermo i campi relativi alla carta d'identità, visura camerale e autodichiarazione

    rom03 22/12/2023 Provincia di Rieti ha chiesto, durante le sessioni di formazione ai manutentori, che
    rom03            le ditte di manutenzione debbano allegare copia di visura camerale in fase di registrazione.
    rom03            Ho riciclato il campo usato da Armena Sviluppo per il disciplinare bollini usando una label diversa.
    rom03            Sandro ha detto di rendere visibili anche i campi sulla carta d'identita' ma messi non obbligatori.

    rom02 07/12/2023 Per Armena aggiunto campo con link alla domanda di autorizzazione al bollino
    rom02            inserito nel form privacy che le ditte di manutenzione, non precedentemente autorizzate
    rom02            al rilascio del bollino cartaceo, devono stampare, compilare, sottoscrivere ed inoltrare
    rom02            esclusivamente a mezzo pec a Citta' Metropolitana di Napoli.
    rom02bis         26/02/2024 Corretto errore sul campo disciplinare bollini: non era gestito correttamente per tutti gli enti.

    rom01 15/11/2023 Napoli vede i campi della carta d'identità e autodichiarazione come Regione Marche.
    rom01            Aggiunto nuovo campo per disciplinare bollino per Napoli.

    gac03 29/05/2018 Aggiunti campi carta di identità solo per regione marche

    gab03 17/04/2018 Aggiunti i nuovi campi presenti in fase di registrazione del manutentore che non
    gab03            erano stati riportati qui.

    san01 01/03/2018 Modificata label patentino in Patentino Conduz. imp.>232 kW

    gac02 22/02/2018 aggiunta possibilità di vedere allegati e di inserire allegati

    gac01 15/02/2018 modificata label patentino sul manutentore e aggiunto patentino e patentino_fgas 
    gac01            sul rappresentante legale

    sim06 16/01/2017 Rimesso modificabile la pec su richiesta di Ucit

    gab02 27/06/2017 Per i tipi ruolo Manut/Inst solo Clim.Estiva e Manut/Inst solo Biomassa Legnosa
    gab02            rendo accettabile il valore 0 per il campo N° Analizzatori utilizzati

    sim05 15/03/2017 Se cambio il nome del manutentore devo aggiornare anche il nome presente
    sim05            sul portafoglio

    sim04 10/03/2017 Gestito il nuovo campo patentino fgas

    sim03 08/03/2017 Aggiunto opzioni Manut/Inst solo Clim.Estiva e Manut/Inst solo Biomassa Legnosa nel 
    sim03            campo Ruolo 

    sim02 23/01/2017 Messo readonly i campi email e pec perchè altrimenti la loro modifica causa problemi
    sim02            con gli utenti e le autorizzazioni

    gab01 16/11/2016 Ricevo il caller da maintainer-list per mantenere il sel nella lista chiamata come uno zoom
    
    sim01 28/06/2016 Gestito il nuovo campo patentino

    nic02 14/06/2015 Gestito il nuovo campo PEC

    nic01 09/12/2013 Protetto cognome, nome e codice fiscale del rappresentante legale
    nic01            ed aggiunto link "Cambia rappresentante legale"

} {
    maintainer_id:integer,optional

    {caller   ""}
    {mode "edit"}
    documento:trim,optional
    documento.tmpfile:tmpfile,optional
    documento_dpr:trim,optional
    documento_dpr.tmpfile:tmpfile,optional
}

if {[string equal $mode "edit"]} {
    set page_title "Modifica Manutentore"
    set buttons [list [list "Modifica Manutentore" edit]]
    set field_mode display
} else {
    set page_title "Visualizza Manutentore"
    set buttons [list [list "OK" view]]
    set field_mode display
}

set db_name [db_get_database];#gac01
if {[string match "*iter-portal-marche*" $db_name]} {#gab03
    set label_ruolo "Tipologia di attivit&agrave;"
} else {
    set label_ruolo "Ruolo"
}

set user_id [auth::require_login] 

set context [list [list maintainers-list?caller=$caller {Lista Manutentori}] "Lista Manutentori"];#gab01

#gac02 estraggo il path se esiste e lo faccio vedere
set path_carta_identita [db_string q "select a.path_carta_identita 
                                        from iter_parties a
                                           , iter_maintainers b 
                                       where b.representative_id = a.party_id 
                                         and b.maintainer_id = :maintainer_id"]
#gac02 aggiunta if e suo contenuto
if {$path_carta_identita ne ""} {#gac02
    set file_url "<a href=\"../$path_carta_identita\" target=stampa>Vedi documento</a>"
} else {
    set file_url ""
};#gac02

#gab03 estraggo il path della dichiaraz dpr se esiste e lo faccio vedere
set path_dichiaraz_dpr [db_string q "select path_dichiaraz_dpr
                                       from iter_maintainers
                                      where maintainer_id = :maintainer_id"]

#gab03 aggiunta if e suo contenuto
if {$path_dichiaraz_dpr ne ""} {#gab03
    set file_url_dpr "<a href=\"../$path_dichiaraz_dpr\" target=stampa>Vedi documento</a>"
} else {
    set file_url_dpr ""
};#gac03

#rom01 estraggo il path del disciplinare se esiste e lo faccio vedere
set path_disciplinare_bollini [db_string q "select path_disciplinare_bollini
                                       from iter_maintainers
                                      where maintainer_id = :maintainer_id"]
set stampa_disciplinare "<a href=\"/iter-portal/bollini/disciplinare.pdf\" target=stampa>Stampa disciplinare bollini da compilare e firmare</a>"

if {$path_disciplinare_bollini ne ""} {#rom01
    set file_url_disc "<a href=\"../$path_disciplinare_bollini\" target=stampa>Vedi documento</a>"
} else {
    set file_url_disc ""
};#rom01

#gac01 modificata label patentino sul manutentore e aggiunto patentino e patentino_fgas sul rappresentante legale
ad_form -name addedit \
    -mode $mode \
    -export {caller} \
    -edit_buttons $buttons \
    -html {enctype multipart/form-data} \
    -has_edit 1 \
    -form {
	
	maintainer_id:key

	# Start section2
	{-section "sec2" {legendtext "Dati Anagrafici"} {fieldset {class legend}}}
        {name:text 
            {label {Ragione sociale}}
            {html {size 50 maxlength 200}}
        }
	{address1:text
	    {label {Indirizzo}}
	    {html {size 50 maxlength 200}}
	}
	{city:text
	    {label {Comune}}
	    {html {size 50 maxlength 40}}
	}
	{address2:text,optional 
	    {label {Località}}
	    {html {size 50 maxlength 40}}
	}
	{province:text
	    {label {Provincia}}
	    {html {size 5 maxlength 4}}
	}
	{zipcode:text
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
        {fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }
        {iva_code:text
            {label {P.IVA}}
            {html {maxlength 11}}
        }
	{email:text
	    {label Email}
	    {html {size 50 readonly ""}}
	}
	{pec:text,optional
	    {label PEC}
	    {html {size 50 maxlength 150}}
	}
	{phone:text
	    {label {Telefono}}
	}
	{fax:text,optional 
	    {label {Fax}}
	}
	{mobile:text,optional 
	    {label {Cellulare}}
	}
	{where_registered:text,optional
	    {label {Località Registro Imprese}}
	    {html {size 50}}
	}
	{registration_no:text,optional
	    {label {N. Registro Imprese}}
	    {html {size 50}}
	}
	{where_rea:text,optional
	    {label {Località REA}}
	    {html {size 50}}
	}
	{rea_no:text,optional
	    {label {N. REA}}
	    {html {size 50 maxlength 15}}
	}
	{albo_artigiani:text,optional
	    {label {Albo Artigiani}}
	    {html {size 50 maxlength 15}}
	}
        {titolo1:text(inform)
            {label {}}
            {html {size 50 maxlength 15}}
            {value {Abilitata ad operare per gli impianti di cui alle lettere}}
        }
    }

if {[string match "*iter-portal-marche*" $db_name]} {#gac01

    ad_form -extend -name addedit -form {
        {la:text(checkbox),optional
            {label {}}
            {options { {"a" t}} }
        }
        {lc:text(checkbox),optional
            {label {}}
            {options { {"c" t} }}
        }
        {ld:text(checkbox),optional
            {label {}}
            {options { {"d" t} }}
        }
        {le:text(checkbox),optional
            {label {}}
            {options { {"e" t} }}
        }
	#gac03 aggiunto hidden per non fare andare in errore il programma
	{lb:text(hidden),optional}
        {lf:text(hidden),optional}
        {lg:text(hidden),optional}
    }
} else {
    
    ad_form -extend -name addedit -form {
        {la:text(checkbox),optional
            {label {}}
            {options { {"a" t}} }
        }
        {lb:text(checkbox),optional
            {label {}}
            {options { {"b" t} }}
        }
        {lc:text(checkbox),optional
            {label {}}
            {options { {"c" t} }}
        }
        {ld:text(checkbox),optional
            {label {}}
            {options { {"d" t} }}
        }
        {le:text(checkbox),optional
            {label {}}
            {options { {"e" t} }}
        }
        {lf:text(checkbox),optional
            {label {}}
            {options { {"f" t} }}
        }
        {lg:text(checkbox),optional
            {label {}}
            {options { {"g" t} }}
        }
    }


}

ad_form -extend -name addedit -form {
        {titolo2:text(inform)
            {label {}}
            {html {size 50 maxlength 15}}
            {value {dell'articolo 1 della legge 37/08, ed in possesso dell'ulteriore requisito di:}}
        }
        {uni_iso:text,optional
            {label {UNI ISO EN}}
            {html {size 30 maxlength 30}}
            {help_text "certificazione del Sistem Qualità i sensi della norma UNI ISO EN"}
        }
    }
if {[string match "*iter-portal-marche*" $db_name]} {#gac01
    ad_form -extend -name addedit -form {
	{patentino:text(radio)
            {label {Patentino da conduttore}}
            {options {{"Si" "t"} {"No" "f"}}}
	    {value "f"}
        }
    }
} else { #gac01 
    ad_form -extend -name addedit -form {
        {patentino:text(radio)
            {label {Patentino Conduz. imp.>232 kW}} ;#san01
            {options {{"Si" "t"} {"No" "f"}}}
            {value "f"}
        }
    }
}
ad_form -extend -name addedit \
    -form {
	{patentino_fgas:text(radio)
            {label {Patentino Fgas}}
            {options {{"Si" "t"} {"No" "f"}}}
	    {value "f"}
        }
        {altre_certificazioni:text,optional
            {label {Altre abilitazioni}}
            {html {size 100 maxlength 100}}
        }
    }

if {![string match "*iter-portal-marche*" $db_name]} {#gab03
    ad_form -extend -name addedit -form {
        {role:text(radio)
            {label $label_ruolo}
            {options { {"Manutentore" 1} {"Installatore" 0} {"Installatore/Manutentore" 2} {"Manut/Inst solo Clim.Estiva" 3} {"Manut/Inst solo Biomassa Legnosa" 4}}}
        }
    }
} else {#gab03
    ad_form -extend -name addedit -form {
        {role:text(radio)
            {label $label_ruolo}
            {options { {"Manutentore" 1} {"Installatore" 0} {"Installatore/Manutentore" 2}}}
        }
    }
};#gab03

ad_form -extend -name addedit \
    -form {
	{op_number_pretty:text
	    {label {N° Operatori impegnati:}}
	    {html {size 10}}
	}
	{an_number_pretty:text
	    {label {N° Analizzatori utilizzati:}}
	    {html {size 10}}
	}
	{de_number_pretty:text,optional
	    {label {N° Deprimometri utilizzati:}}
	    {html {size 10}}
	}
	{associated_to:text,optional
	    {label {Associazione di riferimento:}}
	    {html {size 50}}
	}
	{capital_pretty:text,optional
	    {label {Capitale versato}}
	}
        {notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
        }
    }

ad_form -extend -name addedit \
    -form {
        {is_active_p:text(radio)
            {label {Attivo?}}
	    {options {{"S&igrave;" t} {"No" f}}}
        }

        {representative_id:integer(hidden)}

	# Start section3
	{-section "sec3" {legendtext "Rappresentante Legale"} {fieldset {class legend}}}
        
        {rep_name:text 
            {label {Cognome}}
            {html {size 50 maxlength 200 readonly ""}}
	    {after_html "<a href=\"#\" onClick=\"javascript:window.open('/iter-portal/admin/representative-edit?maintainer_id=$maintainer_id', 'listspecial', 'scrollbars=yes,resizable=yes,width=1020,height=760');\"> Cambia Rappresentante Legale</a>"}
        }
        {rep_first_name:text 
            {label {Nome}}
            {html {size 50 maxlength 200 readonly ""}}
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
            {html {maxlength 16 readonly ""}}
        }
    }
#ric01 Aggiunta condizione su Palermo
#gac01 aggiunta if e suo contenuto
#rom01 Aggiunta condizione su napoli
#rom03 Aggiunta condizione su Rieti
if {[string match "*iter-portal-marche*" $db_name] || [string match "*iter-portal-napoli*" $db_name] || [string match "*iter-portal-rieti*" $db_name] || [string match "*iter-portal-palermo*" $db_name]} {#gac01
    ad_form -extend -name addedit -form {
	#gac03 aggiunti campi carta di identità
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

	{titolo3:text(inform)
            {label {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Estremi del documento di identità&nbsp;&nbsp;&nbsp;&nbsp; }}
            {html {size 100 }}
            {value {}}
        }
	{tipo_doc_identita:text,optional
            {label {Tipo documento}}
            {html {size 50 maxlength 100}}
        }
	{num_doc_identita:text,optional
            {label {N.}}
            {html {size 20 maxlength 50}}
        }
        {ente_rilascio_doc_identita:text,optional
            {label {Rilasciato da}}
            {html {size 50 maxlength 100}}
        }
	{data_rilascio_doc_identita_pretty:text,optional
            {label {In data (gg/mm/aaaa)}}
            {html {size 10 maxlength 10}}
        }
        {data_fine_validita_doc_identita_pretty:text,optional
            {label {Valido fino al (gg/mm/aaaa)}}
            {html {size 10 maxlength 10}}
        }
	#gac02 aggiunto documento
	{documento:file(file),optional
	    {label {Carta di identità}}
	    {after_html "$file_url"}
	}
    }
} else {

    ad_form -extend -name addedit -form {

	{documento:file(hidden),optional}
        {patentino_rapp:text(hidden),optional}
	{patentino_fgas_rapp:text(hidden),optional}
	{tipo_doc_identita:text(hidden),optional}
        {num_doc_identita:text(hidden),optional}
        {ente_rilascio_doc_identita:text(hidden),optional}
        {data_rilascio_doc_identita_pretty:text(hidden),optional}
        {data_fine_validita_doc_identita_pretty:text(hidden),optional}
    }
}
ad_form -extend -name addedit \
    -form {

	# Start section4 gab03 aggiunto section
        {-section "sec4" {legendtext "Privacy"} {fieldset {class legend}}}

        {visualizza_company:text(radio)
            {label {La vostra azienda vuole essere visibile nell'elenco ditte dell'ente? }}
            {options {{"Si" "t"} {"No" "f"}}}
            {value "t"}
        }

        {iter_code:text(hidden),optional}
    }

#gab03 aggiunta if e suo contenuto
if {[string match "*iter-portal-marche*" $db_name]} {#gab03
    ad_form -extend -name addedit -form {
        #gab03 aggiunto documento_dpr
        {documento_dpr:file(file),optional
            {label {Autodichiarazione ai sensi del DPR 445/2000}}
	    {help_text {Stampare e caricare l'autodichiarazione firmata}}
            {after_html "$file_url_dpr"}
        }
	{disciplinare_bollini:file(hidden),optional}
    }
} elseif {[string match "*iter-portal-napoli*" $db_name]} {#rom01 Aggiunta elseif e il suo contenuto
    #rom02 Aggiunto campo domanda_rilascio_bollini
    ad_form -extend -name addedit -form {
        {documento_dpr:file(file),optional
            {label {Autodichiarazione ai sensi del DPR 445/2000}}
            {help_text {Stampare e caricare l'autodichiarazione firmata}}
            {after_html "$file_url_dpr "}
        }
	{disciplinare_bollini:file(file),optional
	    {label {Disciplinare bollino}}
	    {help_text {Stampare, compilare e caricare l'autodichiarazione firmata}}
	    {after_html "$file_url_disc $stampa_disciplinare"}
	}
	{domanda_rilascio_bollini:text(inform),optional
            {label {Domanda autorizzazione al bollino}}
	    {help_text {Le ditte di manutenzione, non precedentemente autorizzate al rilascio del bollino cartaceo, devono stampare, compilare, sottoscrivere ed inoltrare esclusivamente a mezzo pec a CMN affinché possano ottenere il rilascio del bollino virtuale. <a href="/iter-portal/doc/domanda-di-autorizzazione-al-bollino-prepagato-agg.-13.09.2021.pdf" target="_blank">SCARICA QUI LA DOMANDA AUTORIZZAZIONE AL BOLLINO</a>}}
	}
    }
} elseif {[string match "*iter-portal-rieti*" $db_name]} {#rom03 Aggiunta elseif e il suo contenuto
    ad_form -extend -name addedit -form {
        {documento_dpr:file(hidden),optional}
	{disciplinare_bollini:file(file),optional
	    {label {Visura camerale}}
	    {help_text {Allegare copia della visura camerale più recente in formato pdf.}}
	    {after_html "$file_url_disc"}
	}
    }
} elseif {[string match "*iter-portal-palermo*" $db_name]} {#ric01 aggiunta elseif e suo contenuto
    ad_form -extend -name addedit -form {
	{disciplinare_bollini:file(file),optional
	    {label {Visura camerale}}
	    {help_text {Allegare copia della visura camerale più recente in formato pdf.}}
	    {after_html "$file_url_disc"}
	}
	{documento_dpr:file(file),optional
            {label {Autodichiarazione ai sensi del DPR 445/2000}}
            {help_text {Stampare e caricare l'autodichiarazione firmata}}
            {after_html "$file_url_dpr "}
        }
    }
} else {

    ad_form -extend -name addedit -form {
        {documento_dpr:file(hidden),optional}
	{disciplinare_bollini:file(hidden),optional}
    }
}

ad_form -extend -name addedit -form {
	{-section ""}

    } -edit_request {

	db_1row get_maintainer "
        select *
        from iter_maintainers_view
        where maintainer_id = :maintainer_id"

	# leggo altri campi non inseriti nella view
	#gab03 estraggo anche visualizza_company
	db_1row get_maintainer "
        select albo_artigiani, visualizza_company from iter_maintainers where maintainer_id = :maintainer_id"

    } -on_submit {

        set errnum 0

        # check email
#        if {[db_0or1row query "select 1 from parties where email = :email and party_id <> :maintainer_id"]} {
#            template::form::set_error addedit email "Utente già registrato (E-mail già presente in archivio)."
#	    incr errnum
#        }

	# controllo codice fiscale del manutentore

	if {[regexp {[^A-Za-z0-9]+} $fiscal_code] > 0 } {
	    template::form::set_error addedit fiscal_code "Contiene caratteri non validi."
	    incr errnum
	}

	set l [string length $fiscal_code]
	if {$l != 16 && $l != 11} {
	    template::form::set_error addedit fiscal_code "Lunghezza errata."
	    incr errnum
	} elseif {$l == 16 && [iter::verifyfc -xcodfis $fiscal_code] == 0} {
	    template::form::set_error addedit fiscal_code "Codice Fiscale errato."
	    incr errnum
	} elseif {$l == 11 && [iter::verifyvc -xcodfis $fiscal_code] == 0} {
	    template::form::set_error addedit fiscal_code "Codice Fiscale errato."
	    incr errnum
	}
	if {[db_0or1row query "select 1 from iter_maintainers where fiscal_code = :fiscal_code and maintainer_id <> :maintainer_id limit 1"]} {
	    template::form::set_error addedit fiscal_code "Codice fiscale già presente in archivio."
	    incr errnum
	}

	set l [string length $iva_code]
	if {$l != 11} {
	    template::form::set_error addedit iva_code "Lunghezza errata."
	    incr errnum
	} elseif {[iter::verifyvc -xcodfis $iva_code] == 0} {
	    template::form::set_error addedit iva_code "Partita IVA errata."
	    incr errnum
	} else {
	    if {[db_0or1row query "select 1 from iter_maintainers where iva_code = :iva_code and maintainer_id <> :maintainer_id"]} {
		template::form::set_error addedit iva_code "Partita IVA già presente in archivio."
		incr errnum
	    }
	}

	if  {$capital_pretty ne ""} {
	    set capital [ah::check_num $capital_pretty 2]
	    if {$capital eq "Error"} {
		template::form::set_error addedit capital_pretty  "Importo errato."
		incr errnum
	    }
	} else {
	    set capital ""
	}

	set op_number [ah::check_num $op_number_pretty 0]
	if {$op_number eq "Error"} {
	    template::form::set_error addedit op_number_pretty  "Numero errato."
	    incr errnum
	} elseif {$op_number == 0} {
	    template::form::set_error addedit op_number_pretty  "Il numero di operatori deve essere maggiore di zero."
	    incr errnum
	}

	set an_number [ah::check_num $an_number_pretty 0]
	if {$an_number eq "Error"} {
	    template::form::set_error addedit an_number_pretty  "Numero errato."
	    incr errnum
	} elseif {$an_number == 0} {
	    if {![string equal $role "0"] && ![string equal $role "3"] && ![string equal $role "4"]} {;#gab02 aggiunte condizioni && ![string equal $role "3"] && ![string equal $role "4"]
		template::form::set_error addedit an_number_pretty  "Il numero di analizzatori deve essere maggiore di zero."
		incr errnum
	    }
	}

	if {$de_number_pretty ne ""} {
	    set de_number [ah::check_num $de_number_pretty 0]
	    if {$de_number eq "Error"} {
		template::form::set_error addedit de_number_pretty  "Numero errato."
		incr errnum
	    }
	} else {
	    set de_number "0"
	}

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
	
	if {[db_0or1row query "select 1 from iter_parties where fiscal_code = :rep_fiscal_code and party_id <> :representative_id limit 1"] > 1} {
	    template::form::set_error addedit rep_fiscal_code "Codice fiscale già presente in archivio."
	    incr errnum
	}

	#gac03 controlli sulla data_rilascio_doc_identita e data_fine_validita_doc_identita
	if {$data_rilascio_doc_identita_pretty ne ""} {
        set data_rilascio_doc_identita [ah::check_date -input_date $data_rilascio_doc_identita_pretty]
	    if {$data_rilascio_doc_identita eq "0"} {
		template::form::set_error addedit data_rilascio_doc_identita_pretty  "Data errata."
		incr errnum
	    }
	} else {
	    set data_rilascio_doc_identita ""
	}
	
	if {$data_fine_validita_doc_identita_pretty ne ""} {
	    set data_fine_validita_doc_identita [ah::check_date -input_date $data_fine_validita_doc_identita_pretty]
	    if {$data_fine_validita_doc_identita eq "0"} {
		template::form::set_error addedit data_fine_validita_doc_identita_pretty  "Data errata."
		incr errnum
	    }
	} else {
	    set data_fine_validita_doc_identita ""
	}
	
	if {$errnum > 0} {
	    break
	}   

	#gab03 inizio
	if {$la eq ""} {
	    set la "f"
	}
	if {$lb eq ""} {
	    set lb "f"
	}
	if {$lc eq ""} {
	    set lc "f"
	}
	if {$ld eq ""} {
	    set ld "f"
	}
	if {$le eq ""} {
	    set le "f"
	}
	if {$lf eq ""} {
	    set lf "f"
	}
	if {$lg eq ""} {
	    set lg "f"
	}
	#gab03 fine
	
	
    } -edit_data {
	#gac02 aggiunta gestione allegati
	set party_id [db_string q "select a.party_id
                                        from iter_parties a
                                           , iter_maintainers b
                                       where b.representative_id = a.party_id
                                         and b.maintainer_id = :maintainer_id"]

	if {$documento ne ""} {
	    set pack_dir [iter_portal_package_key]
	    set root_dir [acs_package_root_dir $pack_dir]
	    set dir_completa "$root_dir/www/doc"
	    
	    #salvo il documento temporaneo
	    set documento_tmpfile [lindex $documento 1]
	    
	    set nome_file [lindex $documento 0]
	
	    #estraggo l'estensione del file caricato
	    set ext ""
	    set ultimo_dot [string last "." $nome_file];# posiz punto piu a dx
	    if {$ultimo_dot < 0} {
		set ext ""
	    } else {
		set ext [string replace $nome_file 0 $ultimo_dot];#elimina i caratteri fino a $ultimo_dot
		if {$ext eq "p7m"} {# estensione doppia file firmati
		    set stringa     [string range $nome_file 0 [expr $ultimo_dot - 1]]
		    set ultimo_dot  [string last "." $stringa]
		    if {$ultimo_dot < 0} {
			set ext ""
		    } else {
			if {$ultimo_dot < 0} {
			    set ext ""
			} else {
			    set ext [string replace $nome_file 0 $ultimo_dot];#elimina i caratteri fino a $ultimo_dot
			}
		    }
		}
		if {$ext ne ""} {
		    set ext "$ext"
		}
	    }
	    
	    #nome del file definitivo
	    set nome_file_definitivo "carta_identita_$party_id.$ext"
	    #directory su cui salverò il mio file
	    set path_assoluto_del_file_archiviato "$dir_completa/$nome_file_definitivo"
	    #path che inserirò sul db
	    set path_relativo "/doc/$nome_file_definitivo"
	    #sposto il file sulla directory decisa in precedenza
	    exec mv $documento_tmpfile $path_assoluto_del_file_archiviato
	}
	#gac02 fine


	if {$documento_dpr ne ""} {;#gab03
	    set pack_dir [iter_portal_package_key]
	    set root_dir [acs_package_root_dir $pack_dir]
	    set dir_completa "$root_dir/www/doc"
	    
	    #salvo il documento temporaneo
	    set documento_tmpfile [lindex $documento_dpr 1]
	    
	    set nome_file [lindex $documento_dpr 0]
	
	    #estraggo l'estensione del file caricato
	    set ext ""
	    set ultimo_dot [string last "." $nome_file];# posiz punto piu a dx
	    if {$ultimo_dot < 0} {
		set ext ""
	    } else {
		set ext [string replace $nome_file 0 $ultimo_dot];#elimina i caratteri fino a $ultimo_dot
		if {$ext eq "p7m"} {# estensione doppia file firmati
		    set stringa     [string range $nome_file 0 [expr $ultimo_dot - 1]]
		    set ultimo_dot  [string last "." $stringa]
		    if {$ultimo_dot < 0} {
			set ext ""
		    } else {
			if {$ultimo_dot < 0} {
			    set ext ""
			} else {
			    set ext [string replace $nome_file 0 $ultimo_dot];#elimina i caratteri fino a $ultimo_dot
			}
		    }
		}
		if {$ext ne ""} {
		    set ext "$ext"
		}
	    }
	    
	    #nome del file definitivo
	    set nome_file_definitivo "autodichiarazione_dpr_$maintainer_id.$ext"
	    #directory su cui salverò il mio file
	    set path_assoluto_del_file_archiviato "$dir_completa/$nome_file_definitivo"
	    #path che inserirò sul db
	    set path_dichiaraz_dpr "/doc/$nome_file_definitivo"
	    #sposto il file sulla directory decisa in precedenza
	    exec mv $documento_tmpfile $path_assoluto_del_file_archiviato
	}
	#gab03 fine
	
    #rom01 Inizio
    set path_disciplinare_bollini "";#rom01
    if {$disciplinare_bollini ne ""} {#rom01 Aggiunta if e il suo contenuto
	set pack_dir [iter_portal_package_key]
	set root_dir [acs_package_root_dir $pack_dir]
	set dir_completa "$root_dir/www/doc"
	
	#salvo il documento temporaneo
	set documento_tmpfile_1 [lindex $disciplinare_bollini 1]
	
	set nome_file_1 [lindex $disciplinare_bollini 0]
	
	#estraggo l'estensione del file caricato
	set ext ""
	set ultimo_dot [string last "." $nome_file_1];# posiz punto piu a dx
	if {$ultimo_dot < 0} {
	    set ext ""
	} else {
	    set ext [string replace $nome_file_1 0 $ultimo_dot];#elimina i caratteri fino a $ultimo_dot
	    if {$ext eq "p7m"} {# estensione doppia file firmati
		set stringa     [string range $nome_file_1 0 [expr $ultimo_dot - 1]]
		set ultimo_dot  [string last "." $stringa]
		if {$ultimo_dot < 0} {
		    set ext ""
		} else {
		    if {$ultimo_dot < 0} {
			set ext ""
		    } else {
			set ext [string replace $nome_file_1 0 $ultimo_dot];#elimina i caratteri fino a $ultimo_dot
		    }
		}
	    }
	    if {$ext ne ""} {
		set ext "$ext"
	    }
	}
	#nome del file definitivo
#sim07	set nome_file_definitivo_1 "disciplinare_bollini_$user_id.$ext"
	set nome_file_definitivo_1 "disciplinare_bollini_$maintainer_id.$ext";#sim07
	#directory su cui salverò il mio file
	set path_assoluto_del_file_archiviato_1 "$dir_completa/$nome_file_definitivo_1"
	#path che inserirò sul db
	set path_disciplinare_bollini "/doc/$nome_file_definitivo_1"
	#sposto il file sulla directory decisa in precedenza
	exec mv $documento_tmpfile_1 $path_assoluto_del_file_archiviato_1
    }
    #rom03 Fine
	db_transaction {

	    if {$documento ne ""} {
		
		db_dml q "update iter_parties set path_carta_identita = :path_relativo where party_id = :party_id" 
	    }

	    if {$documento_dpr ne ""} {;#gab03 if e contenuto

                db_dml q "update iter_maintainers set path_dichiaraz_dpr = :path_dichiaraz_dpr where maintainer_id = :maintainer_id"
            }

	    if {$disciplinare_bollini ne ""} {#rom01 Aggiunta if e il suo contenuto
		db_dml q "update iter_maintainers set path_disciplinare_bollini = :path_disciplinare_bollini where maintainer_id = :maintainer_id"
	    }

	    db_1row get_maintainer "
        select cait_id
        from iter_maintainers_view
        where maintainer_id = :maintainer_id"

	    if {$cait_id  != ""} {
		# modifico manutentore
		db_dml maintainer_edit "
            update iter_maintainers set
                 name             = upper(trim(:name))  --but02
               , address1         = upper(:address1)
               , address2         = upper(:address2)
               , city             = upper(:city)
               , province         = upper(:province)
               , zipcode          = :zipcode
               , fiscal_code      = upper(:fiscal_code)
               , iva_code         = :iva_code
               , phone            = :phone
               , mobile           = :mobile
               , fax              = :fax
               , associated_to    = upper(:associated_to)
               , where_registered = upper(:where_registered)
               , registration_no  = upper(:registration_no)          
               , where_rea        = upper(:where_rea)
               , rea_no           = upper(:rea_no)
               , capital          = :capital
               , role             = :role
               , op_number        = :op_number
               , an_number        = :an_number
               , de_number        = :de_number
               , notes            = upper(:notes)
               , editing_date     = current_date
               , editing_user     = :user_id
               , albo_artigiani   = :albo_artigiani
               , is_active_p      = :is_active_p
               , pec              = :pec -- nic01
               , patentino        = :patentino --sim01
               , patentino_fgas   = :patentino_fgas --sim04
               , la               = :la --gab03
               , lb               = :lb --gab03
               , lc               = :lc --gab03
               , ld               = :ld --gab03
               , le               = :le --gab03
               , lf               = :lf --gab03
               , lg               = :lg --gab03
               , uni_iso          = :uni_iso --gab03
               , altre_certificazioni = :altre_certificazioni --gab03
               , visualizza_company   = :visualizza_company   --gab03
             where maintainer_id  = :maintainer_id"

		db_dml q "update wal_holders
                             set name = upper(trim(:name))  --but02
                           where 'MA'||lpad(cast(holder_id as varchar(10)),6,0) = :iter_code";#sim05

		# modifico rappresentante legale
		db_dml rep_edit "
            update iter_parties set
                name          = upper(trim(:rep_name))  --but02
               ,first_name    = upper(:rep_first_name)
               ,address1      = upper(:rep_address1)
               ,address2      = upper(:rep_address2)
               ,city          = upper(:rep_city)
               ,province      = upper(:rep_province)
               ,zipcode       = :rep_zipcode
               ,fiscal_code   = upper(:rep_fiscal_code)
               ,editing_user  = :user_id
               ,editing_date  = current_date
               ,patentino      = :patentino_rapp      --gac01
               ,patentino_fgas = :patentino_fgas_rapp --gac01
               ,tipo_doc_identita               =  upper(:tipo_doc_identita)          --gac03
               ,num_doc_identita                = :num_doc_identita                   --gac03
               ,ente_rilascio_doc_identita      =  upper(:ente_rilascio_doc_identita) --gac03
               ,data_rilascio_doc_identita      = :data_rilascio_doc_identita         --gac03
               ,data_fine_validita_doc_identita = :data_fine_validita_doc_identita    --gac03

            where party_id = :representative_id"
	    } else {
		# modifico manutentore
		db_dml maintainer_edit "
            update iter_maintainers set
                 name             = upper(trim(:name))  --but01
               , email            = :email
               , address1         = upper(:address1)
               , address2         = upper(:address2)
               , city             = upper(:city)
               , province         = upper(:province)
               , zipcode          = :zipcode
               , fiscal_code      = upper(:fiscal_code)
               , iva_code         = :iva_code
               , phone            = :phone
               , mobile           = :mobile
               , fax              = :fax
               , associated_to    = upper(:associated_to)
               , where_registered = upper(:where_registered)
               , registration_no  = upper(:registration_no)          
               , where_rea        = upper(:where_rea)
               , rea_no           = upper(:rea_no)
               , capital          = :capital
               , role             = :role
               , op_number        = :op_number
               , an_number        = :an_number
               , de_number        = :de_number
               , notes            = upper(:notes)
               , editing_date     = current_date
               , editing_user     = :user_id
               , albo_artigiani   = :albo_artigiani
               , is_active_p      = :is_active_p
               , pec              = :pec -- nic01
               , patentino        = :patentino --sim01
               , patentino_fgas   = :patentino_fgas --sim02
               , la               = :la --gab03
               , lb               = :lb --gab03
               , lc               = :lc --gab03
               , ld               = :ld --gab03
               , le               = :le --gab03
               , lf               = :lf --gab03
               , lg               = :lg --gab03
               , uni_iso          = :uni_iso --gab03
               , altre_certificazioni = :altre_certificazioni --gab03
               , visualizza_company   = :visualizza_company   --gab03
           where maintainer_id  = :maintainer_id"

		db_dml q "update wal_holders
                             set name = upper(:name)
                           where 'MA'||lpad(cast(holder_id as varchar(10)),6,0) = :iter_code";#sim05
		
		# modifico rappresentante legale
		db_dml rep_edit "
            update iter_parties set
                name          = upper(trim(:rep_name)) --but01
               ,first_name    = upper(:rep_first_name)
               ,address1      = upper(:rep_address1)
               ,address2      = upper(:rep_address2)
               ,city          = upper(:rep_city)
               ,province      = upper(:rep_province)
               ,zipcode       = :rep_zipcode
               ,fiscal_code   = upper(:rep_fiscal_code)
               ,editing_user  = :user_id
               ,editing_date  = current_date
               ,patentino      = :patentino_rapp      --gac01
               ,patentino_fgas = :patentino_fgas_rapp --gac01
               ,tipo_doc_identita               =  upper(:tipo_doc_identita)          --gac03
               ,num_doc_identita                = :num_doc_identita                   --gac03
               ,ente_rilascio_doc_identita      =  upper(:ente_rilascio_doc_identita) --gac03
               ,data_rilascio_doc_identita      = :data_rilascio_doc_identita         --gac03
               ,data_fine_validita_doc_identita = :data_fine_validita_doc_identita    --gac03

            where party_id = :representative_id"

		# aggiorno utente OpenACS
		db_dml party "
            update parties set
                email = :email
            where party_id = :maintainer_id"
		db_dml party "
            update users set
                username = :email
            where user_id = :maintainer_id"
	    }

	} on_error {
	    ah::transaction_error
	}

    } -after_submit {
        #gab01 restituisco il caller alla lista
	#but01 modificato caller con il filtro search_iter_code
	#but01ad_returnredirect "maintainers-list?caller=$caller"
	ad_returnredirect "maintainers-list?search_iter_code=$iter_code"
	ad_script_abort
    }



