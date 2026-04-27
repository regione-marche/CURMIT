ad_page_contract {

    @author Claudio Pasolini
    @cvs-id maintainer-edit.tcl

    USER  DATA       MODIFICHE
    ===== ========== ========================================================================
    ric01 06/03/2024 Aggiunta per Palermo i campi relativi alla carta d'identità, visura camerale e autodichiarazione

    rom05 22/12/2023 Provincia di Rieti ha chiesto, durante le sessioni di formazione ai manutentori, che
    rom05            le ditte di manutenzione debbano allegare copia di visura camerale in fase di registrazione.
    rom05            Ho riciclato il campo usato da Armena Sviluppo per il disciplinare bollini usando una label diversa.
    rom05            Sandro ha detto di rendere visibili anche i campi sulla carta d'identita' ma messi non obbligatori.

    rom04 07/12/2023 Per Armena aggiunto campo con link alla domanda di autorizzazione al bollino
    rom04            inserito nel form privacy che le ditte di manutenzione, non precedentemente autorizzate
    rom04            al rilascio del bollino cartaceo, devono stampare, compilare, sottoscrivere ed inoltrare
    rom04            esclusivamente a mezzo pec a Citta' Metropolitana di Napoli.

    rom03 15/11/2023 Napoli vede i campi della carta d'identità e autodichiarazione cone Regione Marche.
    rom03            Aggiunto nuovo campo per disciplinare bollino per Napoli.
    
    rom02 10/06/2020 Modificati i campi email e pec mettendoli dello stesso formato del
    rom02            programma user-new: ci sono stati problemi su alcuni manutentori che 
    rom02            avevano lasciato degli spazi in fondo alle mail.

    rom01 27/06/2018 Modificata label N° Operatori impegnati: in N° Tecnici impegnati:

    gac01 29/05/2018 Aggiunti campi carta di identita solo per regione marche

    gab02 18/04/2018 Aggiunti i nuovi campi presenti in fase di registrazione del manutentore 
    gab02            che non erano stati riportati qui.

    gab01 20/07/2017 Aggiunti i campi: patentino, patentino_fgas, role, albo_artigiani

    nic01 14/06/2015 Gestito il nuovo campo PEC

} {
    {mode "edit"}
    documento:trim,optional
    documento.tmpfile:tmpfile,optional
    documento_dpr:trim,optional
    documento_dpr.tmpfile:tmpfile,optional
}

#set maintainer_id [iter::script_init -approved_par "t"]
set maintainer_id [iter::script_init]
if {[string equal $maintainer_id "0"]} {
    ad_returnredirect services
    ad_script_abort
}

db_1row query "select validated_p, approved_p from iter_maintainers where maintainer_id = :maintainer_id"

set num_msg [iter::check_reg -maintainer_id $maintainer_id]
if {[string equal $num_msg ""] && ![string equal $validated_p "t"] && ![string equal $approved_p "t"]} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}

set reg_msg [iter::get_reg_msg -validated_p $validated_p -approved_p $approved_p -num_msg $num_msg]

#gab02 commentato ma messo in tutti i campi della form addedit mode display singolarmente tranne ai campi dei documenti che possono essere usati per caricare i file
# set mode "display"

if {[string equal $mode "edit"]} {
    #gab02 set page_title "Modifica Dati Registrati"
    #gab02 set buttons [list [list "Modifica Dati Registrati" edit]]
    #gab02 il mode edit è quello che verrà usato ma è solo fittizio, permettera di gestire solo i documenti.
    set page_title "Visualizza Dati Registrati"
    set buttons [list [list "Inserisci documenti" edit]]
    set field_mode display
} else {
    set page_title "Visualizza Dati Registrati"
    set buttons [list [list "OK" view]]
    set field_mode display
}

set user_id [auth::require_login] 

set context [list "Dati Registrati"]

set db_name [db_get_database];#gab02
#gab02 aggiunta if e suo contenuto
if {[string match "*iter-portal-marche*" $db_name]} {#gab02
    set label_ruolo "Tipologia di attivit&agrave;"
} else {
    set label_ruolo "Ruolo"
}

#gab02 estraggo il path se esiste e lo faccio vedere
set path_carta_identita [db_string q "select a.path_carta_identita
                                        from iter_parties a
                                           , iter_maintainers b
                                       where b.representative_id = a.party_id
                                         and b.maintainer_id = :maintainer_id"]

#gab02 aggiunta if e suo contenuto
if {$path_carta_identita ne ""} {#gab02
    set file_url "<a href=\"./$path_carta_identita\" target=stampa>Vedi documento</a>"
} else {
    set file_url ""
};#gab02

#gab02 estraggo il path della dichiaraz dpr se esiste e lo faccio vedere
set path_dichiaraz_dpr [db_string q "select path_dichiaraz_dpr
                                       from iter_maintainers
                                      where maintainer_id = :maintainer_id"]

set stampa_dpr "<a href=\"/iter-portal/bollini/maintainer-print\" target=stampa>Stampa autodichiarazione da firmare</a>"

#gab02 aggiunta if e suo contenuto
if {$path_dichiaraz_dpr ne ""} {#gab02
    set file_url_dpr "<a href=\"./$path_dichiaraz_dpr\" target=stampa>Vedi documento</a>"
} else {
    set file_url_dpr ""
};#gab02

#rom03 estraggo il path del disciplinare se esiste e lo faccio vedere
set path_disciplinare_bollini [db_string q "select path_disciplinare_bollini
                                       from iter_maintainers
                                      where maintainer_id = :maintainer_id"]
set stampa_disciplinare "<a href=\"/iter-portal/bollini/disciplinare.pdf\" target=stampa>Stampa disciplinare bollini da compilare e firmare</a>"

if {$path_disciplinare_bollini ne ""} {#rom03
    set file_url_disc "<a href=\"./$path_disciplinare_bollini\" target=stampa>Vedi documento</a>"
} else {
    set file_url_disc ""
};#rom03

ad_form -name addedit \
    -mode $mode \
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
	    {mode display}
        }
	{address1:text
	    {label {Indirizzo}}
	    {html {size 50 maxlength 200}}
            {mode display}
	}
	{city:text
	    {label {Comune}}
	    {html {size 50 maxlength 40}}
            {mode display}
	}
	{address2:text,optional 
	    {label {Località}}
	    {html {size 50 maxlength 40}}
            {mode display}
	}
	{province:text
	    {label {Provincia}}
	    {html {size 5 maxlength 4}}
            {mode display}
	}
	{zipcode:text
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
            {mode display}
	}
        {fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
            {mode display}
        }
        {iva_code:text
            {label {P.IVA}}
            {html {maxlength 11}}
            {mode display}
        }
	{email:email(text)
	    {label Email}
	    {html {size 50}}
            {mode display}
	}
	{pec:text
	    {label PEC}
	    {html {size 50}}
            {mode display}
	}
	{phone:text
	    {label {Telefono}}
            {mode display}
	}
	{fax:text,optional 
	    {label {Fax}}
            {mode display}
	}
	{mobile:text,optional 
	    {label {Cellulare}}
            {mode display}
	}
	{where_registered:text,optional
	    {label {Località Registro Imprese}}
	    {html {size 50}}
            {mode display}
	}
	{registration_no:text,optional
	    {label {N. Registro Imprese}}
	    {html {size 50}}
            {mode display}
	}
	{where_rea:text,optional
	    {label {Località REA}}
	    {html {size 50}}
            {mode display}
	}
	{rea_no:text,optional
	    {label {N. REA}}
	    {html {size 50 maxlength 15}}
            {mode display}
	}
	{albo_artigiani:text,optional
            {label {Albo Artigiani}}
            {html {size 50 maxlength 15}}
            {mode display}
        }
	{titolo1:text(inform)
            {label {}}
            {html {size 50 maxlength 15}}
            {value {Abilitata ad operare per gli impianti di cui alle lettere}}
            {mode display}
        }
    }

if {[string match "*iter-portal-marche*" $db_name]} {
    ad_form -extend -name addedit -form {
	{la:text(checkbox),optional
            {label {}}
            {options { {"a" t}} }
            {mode display}
        }
        {lc:text(checkbox),optional
            {label {}}
            {options { {"c" t} }}
            {mode display}
        }
        {ld:text(checkbox),optional
            {label {}}
            {options { {"d" t} }}
            {mode display}
        }
	{le:text(checkbox),optional
            {label {}}
            {options { {"e" t} }}
            {mode display}
        }
    }    
} else {

    ad_form -extend -name addedit -form {
        {la:text(checkbox),optional
            {label {}}
            {options { {"a" t}} }
            {mode display}
        }
        {lb:text(checkbox),optional
            {label {}}
            {options { {"b" t} }}
            {mode display}
        }
        {lc:text(checkbox),optional
            {label {}}
            {options { {"c" t} }}
            {mode display}
        }
        {ld:text(checkbox),optional
            {label {}}
            {options { {"d" t} }}
            {mode display}
        }
	{le:text(checkbox),optional
            {label {}}
            {options { {"e" t} }}
            {mode display}
        }
        {lf:text(checkbox),optional
            {label {}}
            {options { {"f" t} }}
            {mode display}
        }
        {lg:text(checkbox),optional
            {label {}}
            {options { {"g" t} }}
            {mode display}
        }
    }
}

ad_form -extend -name addedit -form {
	{titolo2:text(inform)
            {label {}}
            {html {size 50 maxlength 15}}
            {value {dell'articolo 1 della legge 37/08, ed in possesso dell'ulteriore requisito di:}}
            {mode display}
        }
        {uni_iso:text,optional
            {label {UNI ISO EN}}
            {html {size 30 maxlength 30}}
            {help_text "certificazione del Sistem Qualità i sensi della norma UNI ISO EN"}
            {mode display}
        }
    }
#gab02 aggiunta if else e suo contenuto
if {![string match "*iter-portal-marche*" $db_name]} {#gac02
    ad_form -extend -name addedit -form {
        {patentino:text(radio)
            {label {Patentino Conduz. imp.>232 kW}} ;#san01
            {options {{"Si" "t"} {"No" "f"}}}
            {value "f"}
            {mode display}
        }
    }
} else {
    ad_form -extend -name addedit -form {
        {patentino:text(radio)
            {label {Patentino da conduttore}}
            {options {{"Si" "t"} {"No" "f"}}}
            {value "f"}
            {mode display}
        }
    }
}
ad_form -extend -name addedit \
    -form {
        {patentino_fgas:text(radio)
            {label {Patentino Fgas}}
	    {options { {"Si" "t"} {"No" "f"} }}
            {mode display}
        }
	{altre_certificazioni:text,optional
            {label {Altre abilitazioni}}
            {html {size 100 maxlength 100}}
            {mode display}
        }
    }

#gab02 aggiunta if else e suo contenuto
if {![string match "*iter-portal-marche*" $db_name]} {#gab02
    ad_form -extend -name addedit -form {
        {role:text(radio)
            {label $label_ruolo}
            {options { {"Manutentore" 1} {"Installatore" 0} {"Installatore/Manutentore" 2} {"Manut/Inst solo Clim.Estiva" 3} {"Manut/Inst solo Biomassa Legnosa" 4}}}
	    {mode display}
        }
    }
} else {#gab02
    ad_form -extend -name addedit -form {
        {role:text(radio)
            {label $label_ruolo}
            {options { {"Manutentore" 1} {"Installatore" 0} {"Installatore/Manutentore" 2}}}
	    {mode display}
        }
    }
};#gab02
#rom01 modificata label N° Operatori impegnati:
ad_form -extend -name addedit -form {
	{op_number_pretty:text
	    {label {N° Tecnici impegnati:}}
	    {html {size 10}}
            {mode display}
	}
	{an_number_pretty:text
	    {label {N° Analizzatori utilizzati:}}
	    {html {size 10}}
            {mode display}
	}
	{de_number_pretty:text
	    {label {N° Deprimometri utilizzati:}}
	    {html {size 10}}
            {mode display}
	}
	{associated_to:text,optional
	    {label {Associazione di riferimento:}}
	    {html {size 50}}
            {mode display}
	}
	{capital_pretty:text,optional
	    {label {Capitale versato}}
            {mode display}
	}
        {notes:text(textarea),optional,nospell 
            {label Note}
            {html {rows 5 cols 50 wrap soft}}
            {mode display}
        }
    }

#gab02 inizio
if {[string match "*iter-portal-marche*" $db_name]} {#gab02 if else e loro contenuto
    set tipi_impianti_abilitati [db_list_of_lists q "select a.installation_type_id
                                                   , a.installation_type_code        as codice
                                                   , a.installation_type_description as descrizione
                                                   , case when b.maintainer_id is null then 'f'
                                                 else 't' end as installation_maintainer_y_n
                                                from iter_installation_types a
                                           left join iter_maintainer_installations b
                                                  on a.installation_type_id= b.installation_type_id
                                                 and b.maintainer_id = :maintainer_id
                                            order by a.installation_type_id"]

    foreach tipo_impianti $tipi_impianti_abilitati {

        util_unlist $tipo_impianti installation_type_id codice descrizione installation_maintainer_y_n

        ad_form -extend -name addedit -form {
            {-section "sec5" {legendtext "Tipologia degli impianti su cui l'impresa opera"} {fieldset {class legend}}}

            {label_$installation_type_id:text(inform)
                {label {}}
                {after_html $descrizione}
                {mode display}
            }

            {$codice:text(radio)
                {label {}}
                {options {{"Si" "t"} {"No" "f"}}}
                {value $installation_maintainer_y_n}
                {mode display}
            }
        }
    }
}
#gab02 fine

ad_form -extend -name addedit \
    -form {
        {representative_id:integer(hidden)}

	# Start section3
	{-section "sec3" {legendtext "Rappresentante Legale"} {fieldset {class legend}}}
        
        {rep_name:text 
            {label {Cognome}}
            {html {size 50 maxlength 200}}
            {mode display}
        }
        {rep_first_name:text 
            {label {Nome}}
            {html {size 50 maxlength 200}}
            {mode display}
        }
	{rep_address1:text
	    {label {Indirizzo}}
	    {html {size 50 maxlength 200}}
            {mode display}
	}
	{rep_city:text
	    {label {Comune}}
	    {html {size 50 maxlength 40}}
            {mode display}
	}
	{rep_address2:text,optional 
	    {label {Località}}
	    {html {size 50 maxlength 40}}
	    {mode display}
	}
	{rep_province:text
	    {label {Provincia}}
	    {html {size 5 maxlength 4}}
            {mode display}
	}
	{rep_zipcode:text
	    {label {C.A.P.}}
	    {html {size 10 maxlength 5}}
            {mode display}
	}
        {rep_fiscal_code:text
            {label {Codice fiscale}}
            {html {maxlength 16}}
            {mode display}
        }
    }

#ric01 Aggiunta condizione su Palermo
#gab02 aggiunta if es suo contenuto
#rom03 Aggiunta condizione su Napoli
#rom05 Aggiunta condizione su Rieti
if {[string match "*iter-portal-marche*" $db_name] || [string match "*iter-portal-napoli*" $db_name] || [string match "*iter-portal-rieti*" $db_name] || [string match "*iter-portal-palermo*" $db_name]} {#gab02
    ad_form -extend -name addedit -form {
        {patentino_rapp:boolean(radio)
            {label {Patentino da conduttore}}
            {options {{"Si" "t"} {"No" "f"}}}
            {value "f"}
            {mode display}
        }
        {patentino_fgas_rapp:boolean(radio)
            {label {Patentino Fgas}}
            {options {{"Si" "t"} {"No" "f"}}}
            {value "f"}
            {mode display}
        }

	#gac01 aggiunti campi carta di idetità 
	{titolo3:text(inform)
            {label {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Estremi del documento di identità&nbsp;&nbsp;&nbsp;&nbsp; }}
            {html {size 100 }}
            {value {}}
        }
	{tipo_doc_identita:text,optional
	    {label {Tipo documento}}
	    {html  {size 50 maxlength 100}}
	    {mode display}
	}
	{num_doc_identita:text,optional
            {label {N.}}
            {html  {size 20 maxlength 50}}
	    {mode display}
	}
	{ente_rilascio_doc_identita:text,optional
            {label {Rilasciato da}}
            {html  {size 50 maxlength 100}}
	    {mode display}
        }
	{data_rilascio_doc_identita_pretty:text,optional
            {label {In data (gg/mm/aaaa)}}
            {html  {size 10 maxlength 10}}
	    {mode display}
        }
	{data_fine_validita_doc_identita_pretty:text,optional
            {label {Valido fino al (gg/mm/aaaa)}}
            {html  {size 10 maxlength 10}}
	    {mode display}
        } 
        #gab02 aggiunto documento per poter caricare i file
        {documento:file(file),optional
            {label {Carta di Identità}}
            {after_html "$file_url"}
        }
    }
} else {

    ad_form -extend -name addedit -form {
        {patentino_rapp:text(hidden),optional {value "f"}}
        {patentino_fgas_rapp:text(hidden),optional {value "f"}}
	{tipo_doc_identita:text(hidden),optional}
	{num_doc_identita:text(hidden),optional}
	{ente_rilascio_doc_identita:text(hidden),optional}
	{data_rilascio_doc_identita_pretty:text(hidden),optional}
	{data_fine_validita_doc_identita_pretty:text(hidden),optional}
	{documento:file(hidden),optional}
    }
};#gab02

ad_form -extend -name addedit \
    -form {
	# Start section4 gab02 aggiunto section,visualizza_company
        {-section "sec4" {legendtext "Privacy"} {fieldset {class legend}}}

        {visualizza_company:text(radio)
            {label {La vostra azienda vuole essere visibile nell'elenco ditte dell'ente? }}
            {options {{"Si" "t"} {"No" "f"}}}
            {value "t"}
            {mode display}
        }
    }

#gab02 aggiunta if e suo contenuto
if {[string match "*iter-portal-marche*" $db_name]} {#gab02
    ad_form -extend -name addedit -form {
        #gab02 aggiunto documento_dpr
        {documento_dpr:file(file),optional
            {label {Autodichiarazione ai sensi del DPR 445/2000}}
            {help_text {Stampare e caricare l'autodichiarazione firmata}}
            {after_html "$file_url_dpr $stampa_dpr"}
        }
	{disciplinare_bollini:file(hidden),optional}
	
    }
} elseif {[string match "*iter-portal-napoli*" $db_name]} {#rom03 Aggiunta elseif e il suo contenuto
    #rom04 Aggiunto campo domanda_rilascio_bollini
    ad_form -extend -name addedit -form {
        {documento_dpr:file(file),optional
            {label {Autodichiarazione ai sensi del DPR 445/2000}}
            {help_text {Stampare e caricare l'autodichiarazione firmata}}
            {after_html "$file_url_dpr $stampa_dpr"}
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
} elseif {[string match "*iter-portal-rieti*" $db_name]} {#rom05 Aggiunta elseif e il suo contenuto
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
            {after_html "$file_url_dpr $stampa_dpr"}
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
	#gab02 aggiunto visualizza_company
        db_1row get_maintainer "
        select albo_artigiani, visualizza_company from iter_maintainers where maintainer_id = :maintainer_id";#gab01

    } -after_submit {
	ad_returnredirect user-view
	ad_script_abort
    } -edit_data {
	
	#gab02 aggiunta gestione allegati
        set party_id [db_string q "select a.party_id
                                        from iter_parties a
                                           , iter_maintainers b
                                       where b.representative_id = a.party_id
                                         and b.maintainer_id = :maintainer_id"]


	if {$documento ne ""} {;#gab02 inizio
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
        #gab02 fine

	if {$documento_dpr ne ""} {;#gab02
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
        #gab02 fine

    #rom03 Inizio
    set path_disciplinare_bollini "";#rom03
    if {$disciplinare_bollini ne ""} {#rom03 Aggiunta if e il suo contenuto
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
	set nome_file_definitivo_1 "disciplinare_bollini_$user_id.$ext"
	#directory su cui salverò il mio file
	set path_assoluto_del_file_archiviato_1 "$dir_completa/$nome_file_definitivo_1"
	#path che inserirò sul db
	set path_disciplinare_bollini "/doc/$nome_file_definitivo_1"
	#sposto il file sulla directory decisa in precedenza
	exec mv $documento_tmpfile_1 $path_assoluto_del_file_archiviato_1
    }
    #rom03 Fine

	db_transaction {;#gab02
	    if {$documento ne ""} {

                db_dml q "update iter_parties set path_carta_identita = :path_relativo where party_id = :party_id"
            }

            if {$documento_dpr ne ""} {
		
                db_dml q "update iter_maintainers set path_dichiaraz_dpr = :path_dichiaraz_dpr where maintainer_id = :maintainer_id"
            }

	    if {$disciplinare_bollini ne ""} {#rom03 Aggiunta if e il suo contenuto
		db_dml q "update iter_maintainers set path_disciplinare_bollini = :path_disciplinare_bollini where maintainer_id = :maintainer_id"
	    }
	}

    }

template::list::create \
    -name operators \
    -multirow operators \
    -elements {
	name {
	    label "Cognome"
	}
	first_name {
	    label "Nome"
	}
	iter_no {
	    label "Codice I.Ter"
	}
	password {
	    label "Password"
	}
	no {
	    label "Matricola"
	}
	fiscal_code {
	    label "Cod. fiscale"
	}
	phone {
	    label "Telefono"
	}
	mobile {
	    label "Cellulare"
	}
	address {
	    label "Recapito"
	}
	notes {
	    label "Note"
	}
    }

    db_multirow -extend {} operators query "
                   select *
                   from iter_operators
                   where maintainer_id = :maintainer_id
                   order by name
    " {
	
    }

template::list::create \
    -name detools \
    -multirow detools \
    -elements {
	brand {
	    label "Marca"
	}
	model {
	    label "Modello"
	}
	no {
	    label "Matricola"
	}
	last_calibration_date_pretty {
	    label "Data ultima taratura"
	}
    }

    db_multirow -extend {} detools query "
                   select *, to_char(last_calibration_date, 'DD/MM/YYYY') as last_calibration_date_pretty
                   from iter_tools
                   where maintainer_id = :maintainer_id
                     and type = '1'
                   order by brand
    " {
	
    }

template::list::create \
    -name antools \
    -multirow antools \
    -elements {
	brand {
	    label "Marca"
	}
	model {
	    label "Modello"
	}
	no {
	    label "Matricola"
	}
	last_calibration_date_pretty {
	    label "Data ultima taratura"
	}
    }

    db_multirow -extend {} antools query "
                   select *, to_char(last_calibration_date, 'DD/MM/YYYY') as last_calibration_date_pretty
                   from iter_tools
                   where maintainer_id = :maintainer_id
                     and type = '0'
                   order by brand
    " {
	
    }



template::list::create \
    -name maintainer_installations \
    -multirow maintainer_installations \
    -elements {
	installation_type_description {
	    label "Tipologia Impianto"
	}
    }

db_multirow -extend {} maintainer_installations query "
    select b.installation_type_description
      from iter_maintainer_installations a 
         , iter_installation_types b
     where a.installation_type_id = b.installation_type_id
       and a.maintainer_id = :maintainer_id
    " {
    }
