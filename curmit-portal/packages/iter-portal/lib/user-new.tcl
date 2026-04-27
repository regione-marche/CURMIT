# Expects parameters:
#
# self_register_p - Is the form for users who self register (1) or
#                   for administrators who create other users (0)?
# next_url        - Any url to redirect to after the form has been submitted. The
#                   variables user_id, password, and account_messages will be added to the URL. Optional.
# email           - Prepopulate the register form with given email. Optional.
# return_url      - URL to redirect to after creation, will not get any query vars added
# rel_group_id    - The name of a group which you want to relate this user to after creating the user.
#                   Will add an element to the form where the user can pick a relation among the permissible 
#                   rel-types for the group.

# USER  DATA       MODIFICHE
# ===== ========== ==============================================================================
#but03  30/09/2024  Aggiunto il campo email nel inserimento di tecnico.

# rom08 06/08/2024 Provincia di Rieti ha chiesto, durante le sessioni di formazione ai manutentori, che
# rom08            le ditte di manutenzione debbano allegare copia di visura camerale in fase di registrazione.
# rom08            Ho riciclato il campo usato da Armena Sviluppo per il disciplinare bollini usando una label diversa.
# rom08            Sandro ha detto di rendere visibili anche i campi sulla carta d'identita' ma messi non obbligatori.

# but02  24/07/2024 Aggiunto la funziona trim su ragione sociale.

# rom07 04/04/2024 Armena ha chiesto di togleire il check di default per i campi lc e le.

# ric01 06/03/2024 Aggiunta per Palermo i campi relativi alla carta d'identità, visura camerale e autodichiarazione

# rom06 07/12/2023 Per Armena aggiunto campo con link alla domanda di autorizzazione al bollino
# rom06            inserito nel form privacy che le ditte di manutenzione, non precedentemente autorizzate
# rom06            al rilascio del bollino cartaceo, devono stampare, compilare, sottoscrivere ed inoltrare
# rom06            esclusivamente a mezzo pec a Citta' Metropolitana di Napoli.

# rom05 15/11/2023 Napoli deve vedere i campi della carta d'identita' e autodichiarazione come Regione Marche.
# rom05            Aggiunto nuovo campo per disciplinare bollino per Napoli.

# rom04 04/04/2022 MAC Regione Marche 23. Cambiamento etichetta Analizzatori di combustione: cambiata
# rom04            dicitura "Analizzatori di combustione" in "Analizzatori di Combustione o altra strumentazione"
# rom04            Sandro ha detto che va bene per tutti.

# rom03 28/09/2021 Regione Marche ha richiesto che l'allegato della C.I. sia obbligatorio.
# rom03            Corretto il path_relativo per l'inserimento della C.I., non va messo il /www/.

# sim08 22/09/2020 La Regione Marche, per la privacy, ha un apposito pdf

# sim07 14/01/2020 Sandro ha detto che tutti gli enti devono avere la scelta delle tipologia di impianto su cui si 
# sim07            può operare.

# sim06S28/03/2019 Per motivi di sicurezza è stato aggiunto autocomplete off

# sim06 08/06/2018 Per Ucit abbiamo gestito una privacy differente per i manutentori

# rom02 27/06/2018 Modificata, per le Marche, label patentino in 
# rom02            Patentino da conduttore per impianti superiori a 232 kW

# gac04 29/05/2018 Aggiunti campi carta di identità solo per regione marche

# gab03 20/04/2018 aggiunto campo Autodichiarazione ai sensi del DPR 445/2000

# san01 01/03/2018 Modificata label patentino in Patentino Conduz. imp.>232 kW

# gac03 22/02/2018 aggiunto campo Carta di identità in cui è possibile inserire allegati e gestito path

# rom01 20/02/2018 Aggiunta sections per le tipologie di impianto su cui un manutentore 
#                  può operare solo per iter-portal-marche.

# gac02 14/02/2018 Modificate label Patentino e Altro e aggiunti campi Patentino e 
# gac02            patentino_fgas anche su Rappresentante legale e operatore solo per iter-portal-marche
# gac02            Ho fatto in modo che non solo per la regione marche non ci sia piu il campo Capitale
# gac02            versato, inoltre ho modificato la label solo per regione Marche della Segreteria in 
# gac02            Delegato del Rappresentante Legale

# gac01 03/10/2017 Aggiunti i campi visualizza_company e informativa_privacy

# gab02 27/06/2017 Per i tipi ruolo Manut/Inst solo Clim.Estiva e Manut/Inst solo Biomassa Legnosa
# gab02            rendo accettabile il valore 0 per il campo N° Analizzatori utilizzati

# sim05 28/04/2017 Per Ancona i campi relativi a Analizzatori non sono obbligatori 

# sim04 10/03/2017 Aggiunto campo patentino fgas come chiesto da Sandro (e gestito ovunque)

# sim03 08/03/2017 Aggiunto opzioni Manut/Inst solo Clim.Estiva e Manut/Inst solo Biomassa Legnosa nel
# sim03            campo Ruolo
# sim03            Sandro ha detto che in questi 2 casi, non devono essere obbligatori i dati
# sim03            della sezione Analizzatori di Combustione. Quindi li ho messo optional ed ho
# sim03            gestito il controllo sul salva
  

# ale01 06/12/2016 Aggiunto controllo di uguaglianza sui campi password e password_confirm

# gab01  10/10/2016 cambiato valore del titolo2

# sim02 16/09/2016 Messo la Pec obbligatoria

# sim01 28/06/2016 Aggiunto campo patentino come chiesto da Sandro (e gestito ovunque)
#
# nic01 14/06/2016 Aggiunto campo PEC come chiesto da Sandro (e gestito ovunque)

# Check if user can self register
auth::self_registration

# Set default parameter values
array set parameter_defaults {
    self_register_p 1
    next_url {}
    return_url {}
}
foreach parameter [array names parameter_defaults] { 
    if { ![exists_and_not_null $parameter] } { 
        set $parameter $parameter_defaults($parameter)
    }
}

# Log user out if currently logged in, if specified in the includeable chunk's parameters, 
# e.g. not when creating accounts for other users
if { $self_register_p } {
    ad_user_logout 
}

# Pre-generate user_id for double-click protection
set user_id [db_nextval acs_object_id_seq]

# l'utente ha diritti di admin sul package?
set admin_p [permission::permission_p \
                 -no_login \
                 -object_id [ad_conn package_id] \
                 -privilege admin
	    ]

set db_name [db_get_database];#sim05
#gac02 aggiunta if e suo contenuto
if {[string match "*iter-portal-marche*" $db_name]} {#gac02
    set label_ruolo "Tipologia di attivit&agrave;"
} else {
    set label_ruolo "Ruolo"
}

#setto sempre titolo1 e titolo2 come variabili perchè altrimenti non passa i test di onorato
set titolo1 "Abilitata ad operare per gli impianti di cui alle lettere"
set titolo2 "dell'articolo 1 della legge 37/08, ed in possesso dell'ulteriore requisito di:"

set label_privacy "Ha preso visione e accetta l'informativa sulla <a href=\"/privacy\" target=\"_blank\">privacy</a>?";#sim06

if {[db_get_database] eq "ucit"} {#sim06 if e suo contenuto

    set label_privacy "Ho preso visione delle <a href=\"/privacy_manutentori\" target=\"_blank\">informazioni fornite dal Titolare del trattamento dei dati personali U.C.I.T. s.r.l.</a>, ai sensi dell’art. 13 del Regolamento (UE) 679/2016."

}

if {[string match "*iter-portal-marche*" $db_name]} {#sim08
    set label_privacy "Ha preso visione e accetta l'informativa sulla <a href=\"/iter-portal/doc/Informativa_CURMIT_Install_Manut_GDPR.pdf\" target=\"_blank\">privacy</a>?"
}

#gab01 modificato titolo2 "dell'articolo 1 della legge 46/80, ed in possesso dell'ulteriore requisito di:"
ad_form -name register \
    -export {next_url user_id return_url} \
    -edit_buttons [list [list "Avvia Registrazione" new]] \
    -has_edit 1 \
    -html {enctype multipart/form-data} \
    -form {
	
	# Start section1
	{-section "sec1" {legendtext "Dati Utente"} {fieldset {class legend}}}

	{email:email(text)
	    {label Email}
	    {html {size 30}}
	}
	{username:text(hidden),optional
	    value {}
	}
	{first_names:text(text)
	    {label {Nome/i di battesimo}}
	    {html {size 30}}
	}
	{last_name:text(text)
	    {label Cognome}
	    {html {size 30}}
	}
	{password:text(password)
	    {label Password:}
	    {html {size 20 autocomplete off}}
	}
	{password_confirm:text(password)
	    {label {Conferma Password:}}
	    {html {size 20 autocomplete off}}
	}
	{screen_name:text(hidden),optional}
	{url:text(hidden),optional}
	{secret_question:text(hidden),optional value {}}
	{secret_answer:text(hidden),optional value {}}

	# Start section2
	{-section "sec2" {legendtext "Ditta di Manutenzione"} {fieldset {class legend}}}
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
	    {html {size 5 maxlength 2}}
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
	{phone:text
	    {label {Telefono}}
	}
	{fax:text,optional 
	    {label {Fax}}
	}
	{mobile:text,optional 
	    {label {Cellulare}}
	}
        {pec:text
            {label {PEC}}
            {html {size 50 maxlength 150}}
        }
	{where_registered:text
	    {label {Località Registro Imprese}}
	    {html {size 50 maxlength 40}}
	}
	{registration_no:text
	    {label {N. Registro Imprese}}
	    {html {size 50}}
	}
	{where_rea:text
	    {label {Località REA}}
	    {html {size 50 maxlength 40}}
	}
	{rea_no:text
	    {label {N. REA}}
	    {html {size 50 maxlength 15}}
	}
	{albo_artigiani:text,optional
	    {label {Albo Artigiani}}
	    {html {size 50 maxlength 15}}
	}
	{titolo1:text(inform)
	    {label {}}
	    {html {size 50 maxlength 15 disabled true}}
	    {value $titolo1}
	}
    }

if {[string match "*iter-portal-marche*" $db_name]} {

    ad_form -extend -name register -form {
	
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
	#gac04 il programma andava in errore perche non erano stati settati hidden i campi sotto riportati
	{lb:text(hidden),optional}
	{lf:text(hidden),optional}
	{lg:text(hidden),optional}
    }
} elseif {[string match "*iter-portal-napoli*" $db_name]} {#rom05 Aggiunta elseif e il suo contenuto

    #rom07 Su richiesta di Armena tolto {value t} per i campi lc, le

    ad_form -extend -name register -form {
	
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
    
} else {
    
    ad_form -extend -name register -form {
	
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

ad_form -extend -name register -form {
    {titolo2:text(inform)
	{label {}}
	{html {size 50 maxlength 15 disabled true}}
	{value $titolo2}
    }
    {uni_iso:text,optional
	{label {UNI ISO EN}}
	{html {size 30 maxlength 30}}
	{help_text "certificazione del Sistem Qualità i sensi della norma UNI ISO EN"}
    }
}

#gac02 aggiunta if else e suo contenuto
if {![string match "*iter-portal-marche*" $db_name]} {#gac02
    #san01	Modificata label patentino in Patentino Conduz. imp.>232 kW
    ad_form -extend -name register -form {
	{patentino:text(radio)
            {label {Patentino Conduz. imp.>232 kW}}
            {options {{"Si" "t"} {"No" "f"}}}
	    {value "f"}
        }
    }
} else {
    ad_form -extend -name register -form {
        {patentino:text(radio)
            {label {Patentino da conduttore per impianti superiori a 232 kW}} ;#rom02
            {options {{"Si" "t"} {"No" "f"}}}
            {value "f"}
        }
    }
}
ad_form -extend -name register \
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
#gac02 aggiunta if else e suo contenuto
if {![string match "*iter-portal-marche*" $db_name]} {#gac02
    ad_form -extend -name register -form {
	{role:text(radio)
	    {label $label_ruolo}
	    {options { {"Manutentore" 1} {"Installatore" 0} {"Installatore/Manutentore" 2} {"Manut/Inst solo Clim.Estiva" 3} {"Manut/Inst solo Biomassa Legnosa" 4}}}
	}
    }
} else {#gac02
    ad_form -extend -name register -form {
        {role:text(radio)
            {label $label_ruolo}
            {options { {"Manutentore" 1} {"Installatore" 0} {"Installatore/Manutentore" 2}}}
        }
    }
};#gac02


ad_form -extend -name register \
    -form {
	{op_number_pretty:text
	    {label {N° Operatori impegnati:}}
	    {html {size 10}}
	}
	{an_number_pretty:text
	    {label {N° Analizzatori o altri strumenti utilizzati:}}
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
    }
#gac02 aggiunta if else e suo contenuto
if {![string match "*iter-portal-marche*" $db_name]} {#gac02
    ad_form -extend -name register -form {
	{capital_pretty:text,optional
	    {label {Capitale versato}}
	}
    }
} else {
    ad_form -extend -name register -form {
        {capital_pretty:text(hidden),optional}
    }
};#gac02
ad_form -extend -name register \
    -form {
        {notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
        }
    }

#rom01 inizio
#sim07 if {[string match "*iter-portal-marche*" $db_name]} {#rom01 if else e loro contenuto
    set tipi_impianti_abilitati [db_list_of_lists q "select installation_type_id
                                                   , installation_type_code        as codice
                                                   , installation_type_description as descrizione
                                                from iter_installation_types "]
    
    foreach tipo_impianti $tipi_impianti_abilitati { 
	
	util_unlist $tipo_impianti installation_type_id codice descrizione

	ad_form -extend -name register -form {
	    {-section "sec8" {legendtext "Tipologia degli impianti su cui l'impresa opera."} {fieldset {class legend}}}

	    {label_$installation_type_id:text(inform)
		{label {}}
		{after_html $descrizione}
	    }

	    {$codice:text(radio)
		{label {}}
		{options {{"Si" "t"} {"No" "f"}}}
		{value "t"}
	    }
	}

    }

    ad_form -extend -name register -form {
	{label_dicitura:text(inform)
	    {label {}}
	    {after_html "<b>N.B.: Si possono selezionare solo le tipologie di impianti per le quali si possiedono le necessarie abilitazioni ai sensi del D.M. 37/08</b> "}
	}
    }
    
#sim07} ;#rom01
#rom01 fine
ad_form -extend -name register -form {
    # Start section3
    {-section "sec3" {legendtext "Rappresentante Legale"} {fieldset {class legend}}}
	
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
	    {html {size 5 maxlength 2}}
	}
	{rep_zipcode:text
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
	}
        {rep_fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }
}
#ric01 aggiunta condizione su palermo
#gac02 aggiunta if es suo contenuto
#rom05 Aggiunta condizione su napoli
#rom08 Aggiunta condizione su Rieti
if {[string match "*iter-portal-marche*" $db_name] || [string match "*iter-portal-napoli*" $db_name] || [string match "*iter-portal-rieti*" $db_name] || [string match "*iter-portal-palermo*" $db_name]} {#gac01
    ad_form -extend -name register -form {
        {patentino_rapp:boolean(radio)
            {label {Patentino da conduttore per impianti superiori a 232 kW}} ;#rom02
            {options {{"Si" "t"} {"No" "f"}}}
            {value "f"}
        }
        {patentino_fgas_rapp:boolean(radio)
            {label {Patentino Fgas}}
            {options {{"Si" "t"} {"No" "f"}}}
            {value "f"}
        }

	#gac04 aggiunti campi carta di identità
	{titolo3:text(inform)
            {label {Estremi del documento di identità}}
            {html {size 100 }}
            {value {}}
        }
	{tipo_doc_identita:text,optional
	    {label {Tipo documento}}
	    {html  {size 50 maxlength 100}}
	}
	{num_doc_identita:text,optional
            {label {N.}}
            {html  {size 20 maxlength 50}}
	}
	{ente_rilascio_doc_identita:text,optional
            {label {Rilasciato da}}
            {html  {size 50 maxlength 100}}
        }
	{data_rilascio_doc_identita_pretty:text,optional
            {label {In data (gg/mm/aaaa)}}
            {html  {size 10 maxlength 10}}
        }
	{data_fine_validita_doc_identita_pretty:text,optional
            {label {Valido fino al (gg/mm/aaaa)}}
            {html  {size 10 maxlength 10}}
        } 
    }
    if {[string match "*iter-portal-rieti*" $db_name]} {#rom08 Aggiunta if e il suo contenuto
	ad_form -extend -name register -form {
	    {documento:file(file),optional
		{label {Carta di Identità}}
		{help_text {Caricare la copia del documento d'identità}}
	    }
	}
    } else {#rom08 Aggiunta else ma non il suo contenuto
	#gac03 aggiunto documento per poter caricare i file
	ad_form -extend -name register -form {
	    {documento:file(file)
		{label {Carta di Identità}}
		{help_text {Caricare la copia del documento d'identità}}
	    }
	}
    }
} else {

    ad_form -extend -name register -form {
        {patentino_rapp:text(hidden),optional {value "f"}}
        {patentino_fgas_rapp:text(hidden),optional {value "f"}}
	{tipo_doc_identita:text(hidden),optional}
	{num_doc_identita:text(hidden),optional}
	{ente_rilascio_doc_identita:text(hidden),optional}
	{data_rilascio_doc_identita_pretty:text(hidden),optional}
	{data_fine_validita_doc_identita_pretty:text(hidden),optional}
	{documento:file(hidden),optional}
    }
};#gac02
#gac02 aggiunta ad_form
#but03 aggiunto il campo email.
ad_form -extend -name register \
    -form {
        # Start section4
        {-section "sec4" {legendtext "Tecnico - (Registrare un solo tecnico - altri tecnici potranno essere inseriti successivamente)"} {fieldset {class legend}}}  
    
        {op_name:text 
            {label {Cognome}}
            {html {size 50 maxlength 200}}
        }
        {op_first_name:text 
            {label {Nome}}
            {html {size 50 maxlength 100}}
        }
        {op_no:text 
            {label {Matricola}}
            {html {size 50}}
        }
        {op_fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
        }
        {op_phone:text,optional 
            {label {Telefono}}
        }
        {op_mobile:text,optional 
            {label {Cellulare}}
        }
	{email_operator:email(text)
	    {label {Email}}
	}
        {op_address:text,optional
            {label {Recapito}}
            {html {size 50 maxlength 200}}
        }
    }
#gac02 aggiunta if else e suo contenuto
if {![string match "*iter-portal-marche*" $db_name]} {#gac02
    ad_form -extend -name register -form {
        {op_role:text(radio),optional
            {label {Ruolo}}
	    {options { {"Tecnico" 0} {"Segreteria" 1}}}
        }
    }
} else {
    ad_form -extend -name register -form {
	{op_role:text(radio),optional
            {label {Ruolo}}
            {options { {"Tecnico" 0} {"Delegato del Rappresentante Legale" 1}}}
        }
    }
};#gac02
ad_form -extend -name register \
    -form {
        {op_notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
        }
    }
#gac02 aggiunta if else e suo contenuto
if {[string match "*iter-portal-marche*" $db_name]} {#gac01
    ad_form -extend -name register -form {
	{patentino_op:boolean(radio),optional
	    {label {Patentino da conduttore per impianti superiori a 232 kW}} ;#rom02
	    {options {{"Si" "t"} {"No" "f"}}}
	    {value "f"}
	}
	{patentino_fgas_op:boolean(radio),optional
	    {label {Patentino Fgas}}
	    {options {{"Si" "t"} {"No" "f"}}}
	    {value "f"}
	}
    }
} else {
    ad_form -extend -name register -form {
        {patentino_op:text(hidden),optional {value "f"}}
        {patentino_fgas_op:text(hidden),optional {value "f"}}
    }
};#gac02
#gac02 aggiunta ad_form
ad_form -extend -name register \
    -form {
	# Start section5
	{-section "sec5" {legendtext "Analizzatori di Combustione o altra strumentazione (registrarne almeno 1)"} {fieldset {class legend}}}

        {an_brand:text,optional 
            {label {Marca}}
            {html {size 50 maxlength 200}}
        }
        {an_model:text,optional 
            {label {Modello}}
            {html {size 50 maxlength 200}}
        }
        {an_no:text,optional 
            {label {Matricola}}
            {html {size 50 maxlength 200}}
        }
        {an_last_calibration_date_pretty:text,optional 
            {label {Data Ultima Taratura (gg/mm/aaaa)}}
            {html {size 10 maxlength 10}}
        }

	# Start section6
	{-section "sec6" {legendtext "Deprimometri (registrarne almeno 1)"} {fieldset {class legend}}}

        {de_brand:text,optional
            {label {Marca}}
            {html {size 50 maxlength 200}}
        }
        {de_model:text,optional
            {label {Modello}}
            {html {size 50 maxlength 200}}
        }
        {de_no:text,optional
            {label {Matricola}}
            {html {size 50 maxlength 200}}
        }
        {de_last_calibration_date_pretty:text,optional
            {label {Data Ultima Taratura (gg/mm/aaaa)}}
            {html {size 10 maxlength 10}}
        }

	 # Start section7 gac01 aggiunto section,visualizza_company,informativa_privacy
        {-section "sec7" {legendtext "Privacy"} {fieldset {class legend}}}
	
	{visualizza_company:text(radio)
            {label {La vostra azienda vuole essere visibile nell'elenco ditte dell'ente? }}
            {options {{"Si" "t"} {"No" "f"}}}
            {value "t"}
        }
	#sim06 gestito la label con una variabile
	{informativa_privacy:text(checkbox),optional
	    {label $label_privacy}
	    {options { {"Si accetta?" "t"}}}
	}
	
    }
    
#gab03 aggiunta if e suo contenuto
if {[string match "*iter-portal-marche*" $db_name]} {#gab03
    ad_form -extend -name register -form {
	#gab03 aggiunto documento_dpr
	#{documento_dpr:file(file),optional
	#    {label {Autodichiarazione ai sensi del DPR 445/2000}}
	#    {help_text {Stampare e Caricare l'autodichiarazione firmata}}
	#}
	{documento_dpr:text(inform),optional
	    {label {Autodichiarazione ai sensi del DPR 445/2000}}
	    {help_text {Una volta avviata la registrazione sarà necessario andare nella sezione \"Visualizza i Dati Anagrafici\" e stampare e caricare l'autodichiarazione firmata}}
	} 
	{disciplinare_bollini:file(hidden),optional}

    }
} elseif {[string match "*iter-portal-napoli*" $db_name]} {#rom05 Aggiunta elseif e il suo contenuto
    #rom06 Aggiunto campo domanda_rilascio_bollini
    ad_form -extend -name register -form {
	{documento_dpr:text(inform),optional
	    {label {Autodichiarazione ai sensi del DPR 445/2000}}
	    {help_text {Una volta avviata la registrazione sarà necessario andare nella sezione \"Visualizza i Dati Anagrafici\" e stampare e caricare l'autodichiarazione firmata}}
	} 
	{disciplinare_bollini:text(inform),optional
	    {label {Disciplinare bollino}}
	    {help_text {Una volta avviata la registrazione sarà necessario andare nella sezione \"Visualizza i Dati Anagrafici\" e stampare e caricare il disciplinare compilato e firmato}}
	}
	{domanda_rilascio_bollini:text(inform),optional
            {label {Domanda autorizzazione al bollino}}
	    {help_text {Le ditte di manutenzione, non precedentemente autorizzate al rilascio del bollino cartaceo, devono stampare, compilare, sottoscrivere ed inoltrare esclusivamente a mezzo pec a CMN affinché possano ottenere il rilascio del bollino virtuale. <a href="/iter-portal/doc/domanda-di-autorizzazione-al-bollino-prepagato-agg.-13.09.2021.pdf" target="_blank">SCARICA QUI LA DOMANDA AUTORIZZAZIONE AL BOLLINO</a>}}
        }
    }
} elseif {[string match "*iter-portal-rieti*" $db_name]} {#rom08 Aggiunta elseif e il suo contenuto

    ad_form -extend -name register -form {
	{disciplinare_bollini:file(file)
	    {label {Visura camerale}}
	    {help_text {Allegare copia della visura camerale più recente in formato pdf.}}
	}
	{documento_dpr:file(hidden),optional}
    }
} elseif {[string match "*iter-portal-palermo*" $db_name]} {#ric01 aggiunta elseif e suo contenuto

    ad_form -extend -name register -form {
	
	{disciplinare_bollini:file(file)
	    {label {Visura camerale}}
	    {help_text {Allegare copia della visura camerale più recente in formato pdf.}}
	}
	{documento_dpr:text(inform),optional
	    {label {Autodichiarazione ai sensi del DPR 445/2000}}
	    {help_text {Una volta avviata la registrazione sarà necessario andare nella sezione \"Visualizza i Dati Anagrafici\" e stampare e caricare l'autodichiarazione firmata}}
	}
    }
} else {
    
    ad_form -extend -name register -form {
	{documento_dpr:file(hidden),optional}
	{disciplinare_bollini:file(hidden),optional}
    }
    
}

ad_form -extend -name register -form {

	# Reset section
	{-section ""}
    }

if { [exists_and_not_null rel_group_id] } {
    ad_form -extend -name register -form {
        {rel_group_id:integer(hidden),optional}
    }
    
    if { [permission::permission_p -object_id $rel_group_id -privilege "admin"] } {
        ad_form -extend -name register -form {
            {rel_type:text(select)
                {label "Role"}
                {options {[group::get_rel_types_options -group_id $rel_group_id]}}
            }
        }
    } else {
        ad_form -extend -name register -form {
            {rel_type:text(hidden)
                {value "membership_rel"}
            }
        }
    }
}

ad_form -extend -name register -on_request {
    # Populate elements from local variables
    set is_active_p t    
} -on_submit {

    set errnum 0

    # check email
    if {[db_0or1row query "select 1 from parties where email = :email"]} {
        template::form::set_error register email "Utente già registrato (E-mail già presente in archivio)."
	incr errnum
    }

    #ale01 Controllo uguaglianza "password" e "conferma password"
    if {$password ne $password_confirm} {
        template::form::set_error register password "Le password inserite non coincidono tra loro."
        incr errnum
    }

    set l [string length $fiscal_code]
    if {$l != 16 && $l != 11} {
	template::form::set_error register fiscal_code "Lunghezza errata."
	incr errnum
    } elseif {$l == 16 && [iter::verifyfc -xcodfis $fiscal_code] == 0} {
	template::form::set_error register fiscal_code "Codice Fiscale errato."
	incr errnum
    } elseif {$l == 11 && [iter::verifyvc -xcodfis $fiscal_code] == 0} {
	template::form::set_error register fiscal_code "Codice Fiscale errato."
	incr errnum
    } else {
	if {[db_0or1row check_fiscal_code "select 1 from iter_maintainers where fiscal_code = :fiscal_code limit 1"]} {
	    template::form::set_error register fiscal_code "Codice fiscale già presente in archivio."
	    incr errnum
	}
    }

    set l [string length $iva_code]
    if {$l != 11} {
	template::form::set_error register iva_code "Lunghezza errata."
	incr errnum
    } elseif {[iter::verifyvc -xcodfis $iva_code] == 0} {
	template::form::set_error register iva_code "Partita IVA errata."
	incr errnum
    } else {
	if {[db_0or1row check_iva_code "select 1 from iter_maintainers where iva_code = :iva_code"]} {
	    template::form::set_error register iva_code "Partita IVA già presente in archivio."
	    incr errnum
	}
    }

    if  {$capital_pretty ne ""} {
	set capital [ah::check_num $capital_pretty 2]
	if {$capital eq "Error"} {
	    template::form::set_error register capital_pretty  "Importo errato."
	    incr errnum
	}
    } else {
        set capital ""
    }

    set op_number [ah::check_num $op_number_pretty 0]
    if {$op_number eq "Error"} {
	template::form::set_error register op_number_pretty  "Numero errato."
	incr errnum
    } elseif {$op_number == 0} {
	template::form::set_error register op_number_pretty  "Il numero di operatori deve essere maggiore di zero."
	incr errnum
    }

    set an_number [ah::check_num $an_number_pretty 0]
    if {$an_number eq "Error"} {
	template::form::set_error register an_number_pretty  "Numero errato."
	incr errnum
    } elseif {$an_number == 0} {
	if {![string equal $role "0"] && ![string equal $role "3"] && ![string equal $role "4"] && $db_name ne "iter-portal-pran"} {;#gab02 aggiunte condizioni && ![string equal $role "3"] && ![string equal $role "4"]
	    template::form::set_error register an_number_pretty  "Il numero di analizzatori deve essere maggiore di zero."
	    incr errnum
	}
    }

    if {$de_number_pretty ne ""} {
	set de_number [ah::check_num $de_number_pretty 0]
	if {$de_number eq "Error"} {
	    template::form::set_error register de_number_pretty  "Numero errato."
	    incr errnum
	}
    } else {
	set de_number 0
    }
    # controllo codice fiscale del rappresentante legale
    set l [string length $rep_fiscal_code]
    if {$l != 16} {
	template::form::set_error register rep_fiscal_code "Lunghezza errata."
	incr errnum
    } elseif {$l == 16 && [iter::verifyfc -xcodfis $rep_fiscal_code] == 0} {
	template::form::set_error register rep_fiscal_code "Codice Fiscale errato."
	incr errnum
    } elseif {$l == 11 && [iter::verifyvc -xcodfis $rep_fiscal_code] == 0} {
	template::form::set_error register rep_fiscal_code "Codice Fiscale errato."
	incr errnum
    } else {
        # elimino controllo (27/10/2009) su richiesta DeVincenzis
	#if {[db_0or1row check_rep_fiscal_code "select 1 from iter_parties where fiscal_code = :rep_fiscal_code"]} {
	#   template::form::set_error register rep_fiscal_code "Codice fiscale già presente in archivio."
	#   incr errnum
	#}
    }

    # controllo codice fiscale dell'operatore
    set l [string length $op_fiscal_code]
    if {$l != 16} {
	template::form::set_error register op_fiscal_code "Lunghezza errata."
	incr errnum
    } elseif {[iter::verifyfc -xcodfis $op_fiscal_code] == 0} {
	template::form::set_error register op_fiscal_code "Codice Fiscale errato."
	incr errnum
    } else {
	#	if {[db_0or1row check_op_fiscal_code "select 1 from iter_operators where fiscal_code = :op_fiscal_code"]} {
	#	    template::form::set_error register op_fiscal_code "Codice fiscale già presente in archivio."
	#	    incr errnum
	#	}
    }

    if {$an_last_calibration_date_pretty ne ""} {
	set an_last_calibration_date [ah::check_date -input_date $an_last_calibration_date_pretty]
	if {$an_last_calibration_date eq "0"} {
	    template::form::set_error register an_last_calibration_date_pretty  "Data errata."
	    incr errnum
	}
    } else {
	set an_last_calibration_date ""
    }

    if {$de_last_calibration_date_pretty ne ""} {
	set de_last_calibration_date [ah::check_date -input_date $de_last_calibration_date_pretty]
	if {$de_last_calibration_date eq "0"} {
	    template::form::set_error register de_last_calibration_date_pretty  "Data errata."
	    incr errnum
	}
    } else {
	set de_last_calibration_date ""
    }

    if {[string equal $op_role ""]} {
	set op_role "0"
    }

    if {$informativa_privacy ne "t"} {#gac01 if e suo contenuto
	template::form::set_error register informativa_privacy "E' necessaria la presa visione della privacy"
	incr errnum
    }

    # questi campi sono obbligatori nel caso di inserimento o modifica da parte del manutentore
    if {$admin_p ne "1"} {
	if {$where_registered eq ""} {
	    template::form::set_error register where_registered "Campo obbligatorio"
	    incr errnum
	}
	if {$registration_no eq ""} {
	    template::form::set_error register registration_no "Campo obbligatorio"
	    incr errnum
	}
	if {$where_rea eq ""} {
	    template::form::set_error register where_rea "Campo obbligatorio"
	    incr errnum
	}
	if {$rea_no eq ""} {
	    template::form::set_error register rea_no "Campo obbligatorio"
	    incr errnum
	}
    }
    
    #sim05 aggiunta and su Ancona
    if {[string equal $an_brand ""] && $role != 3 && $role != 4 && $db_name ne "iter-portal-pran"} {;#sim03 if e suo contenuto
	template::form::set_error register an_brand "Inserire Marca"
	incr errnum
    }
    
    #sim05 aggiunta and su Ancona
    if {[string equal $an_model ""] && $role != 3 && $role != 4 && $db_name ne "iter-portal-pran"} {;#sim03 if e suo contenuto
	template::form::set_error register an_model "Inserire Modello"
	incr errnum
    }
    
    #sim05 aggiunta and su Ancona
    if {[string equal $an_no ""] && $role != 3 && $role != 4 && $db_name ne "iter-portal-pran"} {;#sim03 if e suo contenuto
	template::form::set_error register an_no "Inserire Matricola"
	incr errnum
    }
    
    #sim05 aggiunta and su Ancona
    if {[string equal $an_last_calibration_date_pretty ""] && $role != 3 && $role != 4 && $db_name ne "iter-portal-pran"} {;#sim03 if e suo contenuto
	template::form::set_error register an_last_calibration_date_pretty "Inserire Data Ultima Taratura"
	incr errnum
    }
    
    #gac04 controlli sulla data_rilascio_doc_identita e data_fine_validita_doc_identita
    if {$data_rilascio_doc_identita_pretty ne ""} {
        set data_rilascio_doc_identita [ah::check_date -input_date $data_rilascio_doc_identita_pretty]
        if {$data_rilascio_doc_identita eq "0"} {
            template::form::set_error register data_rilascio_doc_identita_pretty  "Data errata."
            incr errnum
        }
    } else {
        set data_rilascio_doc_identita ""
    }

    if {$data_fine_validita_doc_identita_pretty ne ""} {
        set data_fine_validita_doc_identita [ah::check_date -input_date $data_fine_validita_doc_identita_pretty]
        if {$data_fine_validita_doc_identita eq "0"} {
            template::form::set_error register data_fine_validita_doc_identita_pretty  "Data errata."
            incr errnum
        }
    } else {
        set data_fine_validita_doc_identita ""
    }

#rom03    if {$errnum > 0} {
#rom03	break
#rom03    }

if {[string match "*iter-portal-napoli*" $db_name]} {#rom05 Aggiunta if e il suo contenuto
    if {$lc eq ""} {
	template::form::set_error register lc "Campo obbligatorio."
	incr errnum
    }
    if {$le eq ""} {
	 template::form::set_error register le "Campo obbligatorio."
        incr errnum
    }
}

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



	
    set party_id [db_string query "select coalesce(max(party_id) + 1, 1) from iter_parties"]
    #gac03 inizio gestione allegato carta di identita, decido la directory su cui salvare il file
    set path_relativo ""
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
	#rom03set path_relativo "/www/doc/$nome_file_definitivo"
	set path_relativo "/doc/$nome_file_definitivo";#rom03
	#sposto il file sulla directory decisa in precedenza
	exec mv $documento_tmpfile $path_assoluto_del_file_archiviato
	#gac03 fine
	
    } else {#rom03 aggiunta else e suo contenuto

	if {[string match "*iter-portal-marche*" $db_name]} {
	    template::form::set_error register documento "Campo obbligatorio."
	    incr errnum
	}
    }

    if {$errnum > 0} {#rom03 spostato qua perche' serve per il controllo sul documento.
	break
    }
        
    #gab03 inizio
    set path_dichiaraz_dpr ""
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
	set nome_file_definitivo "autodichiarazione_dpr_$user_id.$ext"
	#directory su cui salverò il mio file
	set path_assoluto_del_file_archiviato "$dir_completa/$nome_file_definitivo"
	#path che inserirò sul db
	set path_dichiaraz_dpr "/doc/$nome_file_definitivo"
	#sposto il file sulla directory decisa in precedenza
	exec mv $documento_tmpfile $path_assoluto_del_file_archiviato
    }
    #gab03 fine

    #rom05 Inizio
    set path_disciplinare_bollini "";#rom05
    if {$disciplinare_bollini ne ""} {#rom05 Aggiunta if e il suo contenuto
	set pack_dir [iter_portal_package_key]
	set root_dir [acs_package_root_dir $pack_dir]
	set dir_completa "$root_dir/www/doc"
	
	#salvo il documento temporaneo
	set documento_tmpfile_1 [lindex $disciplinare_bollini 1]
	
	set nome_file1 [lindex $disciplinare_bollini 0]
	
	#estraggo l'estensione del file caricato
	set ext ""
	set ultimo_dot [string last "." $nome_file1];# posiz punto piu a dx
	if {$ultimo_dot < 0} {
	    set ext ""
	} else {
	    set ext [string replace $nome_file1 0 $ultimo_dot];#elimina i caratteri fino a $ultimo_dot
	    if {$ext eq "p7m"} {# estensione doppia file firmati
		set stringa     [string range $nome_file1 0 [expr $ultimo_dot - 1]]
		set ultimo_dot  [string last "." $stringa]
		if {$ultimo_dot < 0} {
		    set ext ""
		} else {
		    if {$ultimo_dot < 0} {
			set ext ""
		    } else {
			set ext [string replace $nome_file1 0 $ultimo_dot];#elimina i caratteri fino a $ultimo_dot
		    }
		}
	    }
	    if {$ext ne ""} {
		set ext "$ext"
	    }
	}
	#nome del file definitivo
	set nome_file_definitivo_1 "disciplinare_bollini_$user_id.$ext"
	#directory su cui salverò il mio file
	set path_assoluto_del_file_archiviato_1 "$dir_completa/$nome_file_definitivo_1"
	#path che inserirò sul db
	set path_disciplinare_bollini "/doc/$nome_file_definitivo_1"
	#sposto il file sulla directory decisa in precedenza
	exec mv $documento_tmpfile_1 $path_assoluto_del_file_archiviato_1
    }
    #rom05 Fine
    
    db_transaction {
	
        # anticipo la creazione dello user OpenACS
        array set creation_info [auth::create_user \
                                     -user_id $user_id \
                                     -verify_password_confirm \
                                     -username $username \
                                     -email $email \
                                     -first_names $first_names \
                                     -last_name $last_name \
                                     -screen_name $screen_name \
                                     -password $password \
                                     -password_confirm $password_confirm \
                                     -url $url \
                                     -secret_question $secret_question \
                                     -secret_answer $secret_answer]

        ns_log notice "\nuser-new: creation_info=$creation_info(creation_status)"
	
        if { [string equal $creation_info(creation_status) "ok"] && [exists_and_not_null rel_group_id] } {
            group::add_member \
                -group_id $rel_group_id \
                -user_id $user_id \
                -rel_type $rel_type
        }
	
	# Handle registration problems
	if {$creation_info(creation_status) ne "ok"} {
	    # abort
	    nonsense
	}

        ns_log notice "\nuser-new: iter_parties"

	# inserisco rappresentante legale
	db_dml query "
            insert into iter_parties (
                 party_id
               , name
               , first_name
               , address1
               , address2
               , city
               , province
               , zipcode
               , fiscal_code                                                                                                
               , creation_date
               , patentino       --gac02
               , patentino_fgas  --gac02
               , path_carta_identita  --gac03
               , tipo_doc_identita               --gac04
               , num_doc_identita                --gac04
               , ente_rilascio_doc_identita      --gac04
               , data_rilascio_doc_identita      --gac04
               , data_fine_validita_doc_identita --gac04
            ) values (
                 :party_id
               , upper(trim(:rep_name))    --but01
               , upper(:rep_first_name)
               , upper(:rep_address1)
               , upper(:rep_address2)
               , upper(:rep_city)
               , upper(:rep_province)
               , :rep_zipcode
               , upper(:rep_fiscal_code) 
               , current_date                                                                
               , :patentino_rapp      --gac02
               , :patentino_fgas_rapp --gac02
               , :path_relativo       --gac03
               , upper(:tipo_doc_identita)          --gac04
               ,:num_doc_identita                   --gac04
               , upper(:ente_rilascio_doc_identita) --gac04
               ,:data_rilascio_doc_identita         --gac04
               ,:data_fine_validita_doc_identita    --gac04
            )"

        ns_log notice "\nuser-new: iter_maintainers"
	
	# inserisco manutentore
	db_dml maintainer_add "
            insert into iter_maintainers (
                 maintainer_id
               , name
               , address1
               , address2
               , city
               , province
               , zipcode
               , fiscal_code                                                                                                
               , iva_code
               , phone
               , mobile
               , email
               , fax
               , associated_to                                                                
               , where_registered                
               , registration_no                                
               , where_rea
               , rea_no
               , capital
               , role
               , op_number
               , an_number
               , de_number
               , is_active_p
               , representative_id                                                
               , notes
               , creation_date                                                                
               , validated_p
               , approved_p
               , la
               , lb
               , lc
               , ld
               , le
               , lf
               , lg
               , uni_iso
               , altre_certificazioni
               , albo_artigiani
               , pec -- nic01
               , patentino --sim01
               , patentino_fgas --sim04
               , visualizza_company --gac01
               , path_dichiaraz_dpr --gab03
               , path_disciplinare_bollini --rom05
            ) values (
                 :user_id
               , upper(trim(:name)) --but01
               , upper(:address1)
               , upper(:address2)
               , upper(:city)
               , upper(:province)
               , upper(:zipcode)
               , upper(:fiscal_code)
               , :iva_code
               , :phone
               , :mobile
               , :email
               , :fax
               , upper(:associated_to)
               , upper(:where_registered)
               , upper(:registration_no)
               , upper(:where_rea)
               , upper(:rea_no)
               , :capital
               , :role
               , :op_number
               , :an_number
               , :de_number
               , 't'
               , :party_id
               , upper(:notes)
               , current_date                                                                
               , 'f'
               , 'f'
               ,:la
               ,:lb
               ,:lc
               ,:ld
               ,:le
               ,:lf
               ,:lg
               ,:uni_iso
               ,:altre_certificazioni
               ,:albo_artigiani
               ,:pec -- nic01
               ,:patentino --sim01
               ,:patentino_fgas --sim04
               ,:visualizza_company --gac01
               ,:path_dichiaraz_dpr --gab03
               ,:path_disciplinare_bollini --rom05
            )"

        ns_log notice "\nuser-new: iter_operators"
	
	set operator_id [db_string query "select coalesce(max(operator_id) + 1, 1) from iter_operators"]
	# inserisco operatore
	db_dml operator_add "
            insert into iter_operators (
                 operator_id   
               , maintainer_id 
               , name          
               , first_name    
               , no            
               , phone         
               , mobile        
               , address       
               , is_active_p   
               , fiscal_code   
               , role
               , notes
               , patentino        --gac02
               , patentino_fgas   --gac02
               , email_operator   --but03
            ) values (
                 :operator_id
               , :user_id 
               , upper(trim(:op_name))       --but01          
               , upper(trim(:op_first_name)) --but01
               , upper(:op_no)            
               , :op_phone         
               , :op_mobile        
               , upper(:op_address)
               , 't'
               , upper(:op_fiscal_code)
               , :op_role
               , upper(:op_notes)
               , :patentino_op      --gac02
               , :patentino_fgas_op --gac02
               , :email_operator    --but03
               )"

	    set tool_id [db_string query "select coalesce(max(tool_id) + 1, 1) from iter_tools"]
	    # inserisco analizzatore di combustione
	db_dml query "
            insert into iter_tools (
                 tool_id   
               , type
               , maintainer_id
               , brand
               , model
               , no
               , last_calibration_date
               , creation_date
            ) values (
                 :tool_id
               , '0'
               , :user_id 
               , upper(:an_brand)
               , upper(:an_model)
               , upper(:an_no)            
               , :an_last_calibration_date
               , current_date
            )"

	set tool_id [db_string query "select coalesce(max(tool_id) + 1, 1) from iter_tools"]
	# inserisco analizzatore di combustione
	db_dml query "
            insert into iter_tools (
                 tool_id   
               , type
               , maintainer_id
               , brand
               , model
               , no
               , last_calibration_date
               , creation_date
            ) values (
                 :tool_id
               , '1'
               , :user_id 
               , upper(:de_brand)
               , upper(:de_model)
               , upper(:de_no)            
               , :de_last_calibration_date
               , current_date
            )"

#sim07	if {[string match "*iter-portal-marche*" $db_name]} {#rom01 if e suo contenuto
	    set ls_tipi_installazione_save [db_list_of_lists q "select installation_type_id
                                                                     , installation_type_code as codice
                                                                  from iter_installation_types"] 
	    
	    foreach tipi_installazione_save $ls_tipi_installazione_save {
		
		util_unlist $tipi_installazione_save installation_type_id codice
		
		set valore_codice [set $codice]
		
		if {$valore_codice eq "t"} {
		    set maintainer_installations_id [db_string q "select coalesce (max(maintainer_installations_id) + 1, 1) 
                                                                    from iter_maintainer_installations"]
		    
		    db_dml query "
               insert into iter_maintainer_installations 
                         ( maintainer_installations_id
                         , maintainer_id
                         , installation_type_id
                         , creation_user
                         , creation_date)
                  values ( :maintainer_installations_id
                         , :user_id
                         , :installation_type_id
                         , :user_id
                         , current_date)"  
		}
	    }
#sim07	};#rom01
    } on_error {
##	ad_return_template 
	$errmsg
   }
    
} -after_submit {
    
    if { ![empty_string_p $next_url] } {
        # Add user_id and account_message to the URL
        
        ad_returnredirect [export_vars -base $next_url {user_id password {account_message $creation_info(account_message)}}]
        ns_log notice "\nUSER-NEW 1"
        ad_script_abort
    } 
    
    
    # User is registered and logged in
    if { ![exists_and_not_null return_url] } {
        # Redirect to subsite home page.
        set return_url [subsite::get_element -element url]
        ns_log notice "\nUSER-NEW 2"
    }
    
    # If the user is self registering, then try to set the preferred
    # locale (assuming the user has set it as a anonymous visitor
    # before registering).
    if { $self_register_p } {
	# We need to explicitly get the cookie and not use
	# lang::user::locale, as we are now a registered user,
	# but one without a valid locale setting.
	set locale [ad_get_cookie "ad_locale"]
	if { ![empty_string_p $locale] } {
	    lang::user::set_locale $locale
	    ad_set_cookie -replace t -max_age 0 "ad_locale" ""
	}
    }
    
    # Handle account_message
    if { ![empty_string_p $creation_info(account_message)] && $self_register_p } {
        # Only do this if user is self-registering
        # as opposed to creating an account for someone else
        ad_returnredirect [export_vars -base "[subsite::get_element -element url]register/account-message" { { message $creation_info(account_message) } return_url }]
        ns_log notice "\nUSER-NEW 3"
        ad_script_abort
    } else {
        # No messages
        ad_returnredirect "/iter-portal/services"
        ns_log notice "\nUSER-NEW 4"
        ad_script_abort
    }
}
