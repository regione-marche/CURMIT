ad_page_contract {

    Convalida una fornitura di un distributore.

    @author Claudio Pasolini
    @creation-date 2008-03-03
    @cvs-id validate.tcl

    @param object_id     Id del distributore
    @param attachment_id Id della fornitura

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    mat02 23/03/2026 Corretto mat01 e in accordo con Sandro uniformati i controlli a quelli
    mat02            del validate dei csv. Ho uniformato usando beyond compare, quindi ho
    mat02            sovrascritto i vecchi controlli presenti in questo programma, ÅË possibile
    mat02            trovarli nell'orig validate-xml.tcl.orig-2026-03-23. Per lo stesso motivo
    mat02            ci sono dei commenti nel programma senza un riferimento nella sezione qui
    mat02            in alto, i commenti originali si trovano nel validate.tcl.
    
    mat01 31/03/2025 Corretto il controllo sul valore della colonna consumo

    but10 22/04/2024 MEV04 Regione Marche step1:valorizzato il campo anno riferimento con il
    but10            valore del anno di caricamento.
    
    but09 17/04/2024 MEV04 Regione Marche Punto 1.dopo tutti controllo ho aggiunto l'inserimento
    but09            della nuova fornitura nella tabella nuova.
    
    but00 08/03/2024 MEV3 Regione Marche Punto 7: caricamento forniture distributori tramite xml.
    but00            Programma copiato da validate.tcl e gestito il file xml.
} {
    object_id
    attachment_id
    {force_p "0"}
}

set user_id [auth::require_login]

if {$user_id != $object_id} {
    ad_returnredirect -message "Non puoi confermare la fornitura di un altro distributore." [export_vars -base attachments {object_id}]
    ad_script_abort
}

set approved_p [db_string check "select approved_p from attachments where object_id = :object_id and item_id = :attachment_id"]

if {$approved_p && !$force_p} {
    ad_returnredirect -message "Fornitura giÅ‡ confermata: impossibile procedere." [export_vars -base attachments {object_id}]
    ad_script_abort
}

#set name [db_string query "select name from iter_distributors where distributor_id = :object_id"]
db_1row q "select name
                , f_rete_o_extrarete as rete
             from iter_distributors
            where distributor_id = :object_id";#but02

set page_title "Distributore: $name - Validazione della fornitura"
set context [list [list services {Servizi per i distributori}] $page_title]
#but01 imposto la tabella di toponimi
set list_topo [db_list_of_lists q "select tipo_toponimo 
                                      --  , id_toponimo 
                                 from iter_toponimi"];#but01


# imposto un array con i toponimi validi
#array set topo [list \
#		    BORGO     1 \
#		    CONTRADA  1 \
#		    CORSO     1 \
#		    CORTE     1 \
#		    GALLERIA  1 \
#		    GIARDINI  1 \
#		    LARGO     1 \
#		    LUNGOLAGO 1 \
#		    LOCALITA' 1 \
#		    PARCO     1 \
#		    PASS.     1 \
#		    PIAZZA    1 \
#		    PIAZZALE  1 \
#		    PORTICI   1 \
#		    P.ZTA     1 \
#		    SOTTOPOR  1 \
#		    STATALE   1 \
#		    STRADA    1 \
#		    VIA       1 \
#		    VIALE     1 \
#		    VICOLO    1 \
#		   ]

# imposto un array con i combustibili validi
#array set fuel [list \
#		    GASOLIO               KG \
#		    METANO                MC \
#		    GPL                   MC \
#		    GPL                   KG \
#		    OLIO                  KG \
#		    "COMBUSTIBILE SOLIDO" KG \
#		    LEGNA                 KG \
#		    KEROSENE              KG \
#		    TELERISCALDAMENTO     MC \
#		    BIODIESEL             KG \
#		   ]

# array set fuel [list \
#		    1  1 \
#		    2  1 \
#		    3  1 \
#		    4  1 \
#		    5  1 \
#		    6  1 \
#		    7  1 \
#		    8  1 \
#		    9  1 \
#		    10  1 \
#		    11  1 \
#		    12  1 \
#		    13  1 \
#		    14  1 \
#		    15  1 \
#		    16  1 \
#		    17  1 \
#		    18  1 \
#     ]	

#but04 imposto la tabella di combustibili
set list_fuel [db_list_of_lists q "select codice_combustibile
                                          tipo_combustibile
                                    from iter_combustibili"];#but04

array set um [list \
	      1 1 \
	      2 1 \
	      3 1 \
	      4 1 \
		  ]
	      
# imposto un array con i tipi contratto validi
# array set ctype [list C1 1 C2 1 C3 1 C6 1 C7 1 C8 1 C9 1 C10 1 C11 1 C12 1 C13 1]
set list_ctype [db_list_of_lists q "select codice_contratto 
                                    --   , tipo_contratto
                                     from iter_contratti"];#but03
set count         0  ;# lines count
set errors        0  ;# wrong lines
set success_count 0  ;# loaded lines
set error_descr   "" ;# one line error descriptions
set error_p       0  ;# one line error flag
# leggo il contenuto della fornitura
set content [cr_write_content -string -item_id $attachment_id]
 
with_catch msg_err_curl {
    #verifico se mi ÅË stato restituito un errore:
    set root_id  [ah_xml_get_root_id $content];#equivale a caricamento_forniture
} {
    iter_return_complaint "Il file &egrave; stato scartato in quanto il tracciato non ÅË nel formato/ordine corretto."
    set root_id ""
    return
}

if {[string equal $error_descr ""]} {
    with_catch msg_err_curl {
	#verifico se mi ÅË stato restituito un errore:
	set node_ids [ah_xml_get_node_id $root_id "fornitura"]
    } {
	iter_return_complaint "Il file &egrave; stato scartato in quanto il tracciato non ÅË nel formato/ordine corretto."
	set node_ids ""
	return
    }
}
#but10 aggiunto aano_rif alla lista di campi 
set elenco_campi [list "natura_giurid" \
		      "utente_cogn_rag_soc" \
		      "utente_nome" \
		      "utente_cf" \
		      "utente_piva" \
		      "toponimo_tipo" \
		      "toponimo_nome" \
		      "toponimo_civico" \
		      "toponimo_cap" \
		      "comune_nome" \
		      "comune_istat" \
		      "catasto_sezione" \
		      "catasto_foglio" \
		      "catasto_particella" \
		      "catasto_subalterno" \
		      "pdr" \
		      "pod" \
		      "stato_pdr" \
		      "matr_contatore" \
		      "contratto_tipo" \
		      "combustibile_tipo" \
		      "combustibile_consumo" \
		      "combustibile_um" \
		      "combustibile_anno"]

if {![string equal $error_descr ""]} {

    iter_return_complaint "Il file &egrave; stato scartato in quanto il tracciato non ÅË nel formato/ordine corretto."
    return
}

set num_fornitura 0
foreach node_id $node_ids {

    incr num_fornitura

    foreach child [$node_id childNodes] {

	set nome_tag [$child nodeName]

	if {$nome_tag ni $elenco_campi} {
	    iter_return_complaint "Il file &egrave; stato scartato in quanto il tracciato non ÅË nel formato/ordine corretto. Fornitura N. $num_fornitura: non ÅË previsto il tag $nome_tag"
	    return
	}
    }
}

set anno_rif [db_string q "select to_char(cr.publish_date,'YYYY') as anno_rif
		              from cr_items ci
		                 , cr_revisions cr
		              where ci.item_id       = :attachment_id
		                and ci.live_revision = cr.revision_id"];#mat02

set ls_suppl [list ]
foreach node_id $node_ids {

    incr count
    set error_p       0  ;# one line error flag
    set error_descr   "" ;# one line error descriptions

    foreach nome_colonna_nodo $elenco_campi {
	ns_log notice "node_id $node_id nome_colonna_nodo $nome_colonna_nodo"
	set $nome_colonna_nodo [ah_xml_get_text_value -optional $node_id $nome_colonna_nodo]

    }
    
    #chiedi a Sandro per volume
    
    # trimmo i campi codificati
    set error_descr ""
    set topo_type      [string toupper [string trimright $toponimo_tipo]];#but08
    set user_fuel      [string toupper [string trimright $combustibile_tipo]];#but08
    set contract       [string trimright $contratto_tipo];#but08
    set number         [string trimright $toponimo_civico];#but08
    set zip_code       [string trimright $toponimo_cap];#but08
    set consumption    [string trimright $combustibile_consumo];#but08
    set um_code        [string trimright $combustibile_um];#but08
    set matr_contatore [string trimright $matr_contatore];#rom01
    set utente_cf      [string trim $utente_cf];#rom03
    set utente_piva    [string trim $utente_piva];#rom03
    
    set len_pdr [string length $pdr];#but05
    set segno "";#but07
    set len [string length $number];#but07
    set max_decimali 2
    set ctr_virgole [regsub -all "," $consumption "," campo_consum];#but06
    set pos_virg [string first "," $consumption];#but06
    set decimali [string range $consumption [expr $pos_virg + 1] end];#but06
    set len_decimali [string length $decimali];#but06
    set natura_giurid [string trimright $natura_giurid];#but11
    # controllo tutti i campi obbligatori
    #but11 if {$natura_giurid eq ""} {;#but02 aggiunto if e suo contenuto
    #but11	set error_p 1
    #but11	append error_descr "Errore! Natura giuridica obbligatoria.<br>"}
    
    if {$natura_giurid eq ""  && $utente_nome eq ""} {;#but11
	set natura_giurid "PPG"
    }
    if {$natura_giurid eq "" && $utente_cogn_rag_soc ne "" && $utente_nome ne "" && $utente_piva ne ""} {;#but11
	set natura_giurid "PG"
    }
    if {$natura_giurid eq "" && $utente_nome ne "" && $utente_cf ne ""} {;#but11
	set natura_giurid "PF"
    }
    if {$utente_cogn_rag_soc eq ""} {
	set error_p 1
	append error_descr "Errore! Ragione Sociale obbligatoria.<br>"
    }
    if {$topo_type eq ""} {
	set error_p 1
	append error_descr "Errore! Tipo toponimo obbligatorio.<br>"
    } 
    
    if {$toponimo_nome eq ""} {
	set error_p 1
	append error_descr "Errore! Toponimo obbligatori.<br>"
    }

    if {$number eq ""} {
	set error_p 1
	append error_descr "Errore! Civico obbligatorio.<br>"
    }

    if {[string index $number [expr $len - 1]] == "-"} {;#but07 aggiunto if e suo contenuto
	set number [string trimright $number "-"]
	set segno "-"
    }
    if {$segno == "-"} {;#but07 aggiunto if e suo contenuto
	set number "-$number"
    } else {
	set number $number
    }
    if {$zip_code eq ""} {
	set error_p 1
	append error_descr "Errore! CAP obbligatorio.<br>"
    }

    if {$comune_nome eq ""} {
	set error_p 1
	append error_descr "Errore! Comune obbligatorio.<br>"
    } else {#but01 aggiunto else e suo contenuto
	db_1row q "select count(*) as num_comuni
                     from iter_comuni
                    where upper(denominazione) = upper(:comune_nome)
                      and flag_val             = 'T'";#rom02
	
	if {$num_comuni == 0} {
	    set error_p 1
	    append error_descr "Errore! $comune_nome non ÅË presente nell'elenco dei Comuni.<br>"
	}
	if {$num_comuni > 1 } {
	    set error_p 1
	    append error_descr "Errore! Sono stati trovati $num_comuni Comuni con questo $comune_nome.<br>"
	}
    }
    if {$comune_istat ne ""} {
	if {![db_0or1row q "select 1
                              from iter_comuni
                             where cod_istat            = :comune_istat
                               and upper(denominazione) = upper(:comune_nome)
                               and flag_val             = 'T'"]} {
	    set error_p 1
	    append error_descr "Errore! Codice ISTAT del Comune non valido.<br>"
	}
    }

    if {$utente_cf eq "" && $utente_piva eq ""} {;#but02 aggiunto if e suo contenuto
	#rom01 set error_p 1
	#rom01 append error_descr "Errore! ÅË obbligatorio almeno uno tra Codice fiscale e P.IVA.<br>"
    } else {
	#ns_log notice "distr validate: utente_cf $utente_cf utente_piva $utente_piva"
	if {$utente_cf ne ""} {
	    set l [string length $utente_cf]
	    #rom02if {$l != 16 || $l != 11} {}
	    if {$l ni [list "16" "11"]} {#rom02 Modificata if ma non il contenuto
		set error_p 1
		append error_descr "Errore! Codice fiscale deve essere di 16 o 11 caratteri.<br>"
	    } elseif {$l == 16 && [iter::verifyfc -xcodfis $utente_cf] == 0} {#but11 modificato la variable fiscal_code
		set error_p 1
		append error_descr "Errore! Codice Fiscale errato.<br>"
	    }
	}
	
	if {$utente_piva ne ""} {
	    set li [string length $utente_piva]
	    if {$li != 11} {
		set error_p 1
		append error_descr "Errore! Partita IVA deve essere di 11 caratteri.<br>"
	    } elseif {$li == 11 && [iter::verifyvc -xcodfis $utente_piva] == 0} {
		set error_p 1
		append error_descr "Errore!Partita IVA errata.<br>"
	    }
	}
    }

    # controlli di validitÅ‡ dei valori
    # 09/04/2009 controllo rimosso su indicazione CESTEC
    #but01 controllo su topo_type
    if {$topo_type ni $list_topo} {;#but01 aggiunto if e suo contenuto
	set error_p 1
	append error_descr "Errore! Tipo toponimo $topo_type non valido. <br>"
    }
    if {![string is integer $zip_code]} {
	set error_p 1
	append error_descr "Errore! CAP non numerico.<br>"
    }
   
    if {$user_fuel eq ""} {
	set error_p 1
	append error_descr "Errore! Combustibile obbligatorio.<br>"
    } else {
	
	if {$user_fuel ni $list_fuel} {;#but04 modificato if e non suo contenuto
	    set error_p 1
	    append error_descr "Errore! Combustibile non valido.<br>"
	}
    }
    
    if {$consumption ne ""} {;#but06 controllo se i decimali sono 2.
      	if {$len_decimali > $max_decimali} {
	    set error_p 1
	    append error_descr "Errore! Consumo Deve avere max 2 dec.<br>"
	}
	if {$ctr_virgole == 1} {;#but06 imposto la parte intera del numero
	    set intero [string range $consumption 0 [expr $pos_virg - 1]]
	    
	} else {
	    set intero $consumption
	}
	
	if {[string length $intero]>9} {;#but06 aggiunto if e suo contenuto #mat01 tolto [string length $intero]<9
	    set error_p 1
	    append error_descr "Errore! Consumo annuo deve essere di massimo 9 cifre.<br>" ;#mat01 aggiunto "massimo" e cambiato da combustibile consumo a consumo annuo
	}
    }

    if  {$combustibile_um ne "" && !([string is integer -strict $combustibile_um] && $combustibile_um >= 1 && $combustibile_um <= 4)} {;#but05 aggiunto if e non suo contenuto
	set error_p 1
	append error_descr "Errore! Il campo UnitÅ‡ di misura deve essere un numero tra 1 e 4.<br>"
    }
    if {$consumption ne "" && $combustibile_um eq ""} { #mat01 aggiunto if e contenuto
	set error_p 1
	append error_descr "Errore! Se il campo consumo annuo non ÅË vuoto, bisogna indicare l'unitÅ‡ di misura.<br>"
    }
    if {$rete eq "r"} {;#but02 aggiunto if e non suo contenuto
	if {$contract ni $list_ctype} {;#but03 modificato if e non suo contenuto
	    set error_p 1
	    append error_descr "Errore! Tipo contratto non valido.<br>"
	}

	if {$pdr eq "" && $pod eq ""} {#rom01 Aggiunta if e contenuto
	    set error_p 1
	    append error_descr "Errore!  Almeno uno tra codice PDR e POD ÅË obbligatorio.<br>"

	} else {#rom01 Aggiunta else ma non il contenuto
	
	    if {$pdr ne ""} {#rom01 Agggiunta if ma non il contenuto
		if {!(($len_pdr==8) || ($len_pdr==10) || ($len_pdr==14))} {#but05 aggiunto if e non suo contenuto
		    set error_p 1
		    append error_descr "Errore! La lunghezza di PDR deve essere in 8,10,14 caractteri.<br>"
		}
	    };#rom01

	    #rom01 if {$pod eq ""} {;#but02 aggiunto if e suo contenuto
	    #rom01 	set error_p 1
	    #rom01 	append error_descr "Errore! Codice POD obbligatorio.<br>"
	    #rom01 }

	    if {$pod ne ""} {#rom01 Agggiunta if ma non il contenuto
		if {[string length $pod]>15 || [string length $pod]<14} {;#but05 aggiunto if e non suo contenuto
		    set error_p 1
		    append error_descr "Errore! La lunghezza di POD deve essere 14 o 15 caractteri.<br>"
		}
	    };#rom01
	    
	};#rom01
    }

    if {$matr_contatore eq "" && $pdr ne ""} {;#but02 aggiunto if e suo contenuto
	#set error_p 1
	#append error_descr "Errore! N. Matricola contatore obbligatorio.<br>"
    }
    if {$matr_contatore ne "" && [string length $matr_contatore] > 50} {#rom01 Aggiunta if e contenuto
	set error_p 1
	append error_descr "Errore! N. Matricola contatore deve essere minore di 50 caratteri.<br>"	
    }
    

    # Create the line if no errors
    
    if {!$error_p} {
	# line line is completed, increase counter
	incr success_count
	
    } else {
	incr errors
	# write the error
	append html_errors "<p>Riga N. $count<br>"
	append html_errors "$error_descr"
    }	
    #but10 aggiunto anno_rif e l'anno di caricamento del distributore
    #mat02 set anno_rif [db_string q "select to_char(cr.publish_date,'YYYY') as anno_rif
    #		              from cr_items ci
    #		                 , cr_revisions cr
    #		              where ci.item_id       = :attachment_id
    #		                and ci.live_revision = cr.revision_id"]
    
    # in assenza di errori aggiorno il flag di approvazione della fornitura
    ns_log notice "DISTR validate.tcl: object_id $object_id item_id $attachment_id errors $errors"
    
    if {$error_p == 0} {#mat02 cambiato il controllo da errors a error_p, poi il blocco sull'errore in generale ÅË nell'if sotto  #but09 modificato il contenuto di if aggiunto db_transaction

	#mat02 vecchio lappend
	#lappend ls_suppl [list $object_id $attachment_id $natura_giurid $utente_cogn_rag_soc $utente_nome $utente_cf $utente_piva $toponimo_tipo $toponimo_nome $toponimo_civico $toponimo_cap $comune_nome $comune_istat $catasto_sezione $catasto_foglio $catasto_particella $catasto_subalterno $pdr $pod $stato_pdr $matr_contatore $contratto_tipo $combustibile_tipo $combustibile_consumo $combustibile_um $combustibile_anno]

	lappend ls_suppl [list $object_id $attachment_id $anno_rif $natura_giurid $utente_cogn_rag_soc $utente_nome $utente_cf $utente_piva $topo_type $toponimo_nome $number $zip_code $comune_nome $comune_istat $catasto_sezione $catasto_foglio $catasto_particella $catasto_subalterno $pdr $pod $stato_pdr $matr_contatore $contract $user_fuel $consumption $um_code $combustibile_anno]

    }
}

# in assenza di errori aggiorno il flag di approvazione della fornitura
if {$errors == 0 && [llength $ls_suppl] > 0} {#but09 modificato il contenuto di if aggiunto db_transaction
    db_transaction {
	db_dml update "update attachments 
                          set approved_p = 't' 
                        where object_id = :object_id
                          and item_id   = :attachment_id"

	#mat02 db_1row q "select current_date
        #                , to_char(current_date, 'YYYY') as current_anno_rif"
    
	foreach supply $ls_suppl {
	    
	    set object_id            [lindex [lindex $supply 0]]
	    set attachment_id        [lindex [lindex $supply 1]]
	    set anno_rif             [lindex [lindex $supply 2]]   
	    set natura_giurid        [lindex [lindex $supply 3]]
	    set utente_cogn_rag_soc  [lindex [lindex $supply 4]]
	    set utente_nome          [lindex [lindex $supply 5]]
	    set utente_cf            [lindex [lindex $supply 6]]
	    set utente_piva          [lindex [lindex $supply 7]]
	    set toponimo_tipo        [lindex [lindex $supply 8]]
	    set toponimo_nome        [lindex [lindex $supply 9]]
	    set toponimo_civico      [lindex [lindex $supply 10]]
	    set toponimo_cap         [lindex [lindex $supply 11]]
	    set comune_nome          [lindex [lindex $supply 12]]
	    set comune_istat         [lindex [lindex $supply 13]]
	    set catasto_sezione      [lindex [lindex $supply 14]]
	    set catasto_foglio       [lindex [lindex $supply 15]]
	    set catasto_particella   [lindex [lindex $supply 16]]
	    set catasto_subalterno   [lindex [lindex $supply 17]]
	    set pdr                  [lindex [lindex $supply 18]]
	    set pod                  [lindex [lindex $supply 19]]
	    set stato_pdr            [lindex [lindex $supply 20]]
	    set matr_contatore       [lindex [lindex $supply 21]]
	    set contratto_tipo       [lindex [lindex $supply 22]]
	    set combustibile_tipo    [lindex [lindex $supply 23]]
	    set combustibile_consumo [lindex [lindex $supply 24]]
	    set combustibile_um      [lindex [lindex $supply 25]]
	    set combustibile_anno    [lindex [lindex $supply 26]]
	    
	    db_dml iter_suppl "
       insert into iter_supplies_sync (
                                    supply_id
                                   ,distributor_id
                                   ,item_id
				   ,anno_rif
				   ,natura_giurid
				   ,utente_cogn_rag_soc
				   ,utente_nome
				   ,utente_cf
				   ,utente_piva
				   ,toponimo_tipo
				   ,toponimo_nome
				   ,toponimo_civico
				   ,toponimo_cap
				   ,comune_nome
				   ,comune_istat
				   ,catasto_sezione
				   ,catasto_foglio
				   ,catasto_particella
				   ,catasto_subalterno
				   ,pdr
				   ,pod
				   ,stato_pdr
				   ,matr_contatore
				   ,contratto_tipo
				   ,combustibile_tipo
				   ,combustibile_consumo
				   ,combustibile_um
				   ,combustibile_anno
                                   ,data_ins
  			 	   ) values (
                                   [db_nextval acs_object_id_seq]
                                  ,:object_id
                                  ,:attachment_id
                                  ,:anno_rif
                                  ,:natura_giurid
                                  ,:utente_cogn_rag_soc
                                  ,:utente_nome
                                  ,:utente_cf
                                  ,:utente_piva
                                  ,:toponimo_tipo
                                  ,:toponimo_nome
                                  ,:toponimo_civico
                                  ,:toponimo_cap
                                  ,:comune_nome
                                  ,:comune_istat
                                  ,:catasto_sezione
                                  ,:catasto_foglio
                                  ,:catasto_particella
                                  ,:catasto_subalterno
                                  ,:pdr
                                  ,:pod
                                  ,:stato_pdr
                                  ,:matr_contatore
                                  ,:contratto_tipo
                                  ,:combustibile_tipo
                                  ,:combustibile_consumo
                                  ,:combustibile_um
                                  ,:combustibile_anno
                                  , current_timestamp
                                 )"
	}
    } on_error {
	ah::transaction_error
    }
}

