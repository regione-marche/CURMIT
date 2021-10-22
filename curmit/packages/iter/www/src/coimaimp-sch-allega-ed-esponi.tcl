ad_page_contract {

    @author          Nicola Mortoni
    @creation-date   18/04/2013

    @cvs-id          coimaimp-sch-allega-ed-esponi.tcl

    @description     Allega il pdf dell'allegato E1, E2, etc... all'impianto inserendolo
                     nella tabella documenti e poi restituisce il file pdf al client

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    gac01 04/11/2020 Aggiunto if regione marche perchè in fase di stampa della prima pagina del
    gac01            libretto il file veniva salvato sul filesystem e non sui blobs.
    gac01            Per regione marche lascio che il file venga salvato sul filsystem mentre 
    gac01            per le altre istanze salvo i file nei blobs.

} {
    {cod_impianto      ""}
    {nome_funz         ""}
    {path_file_pdf     ""}
    {url_file_pdf      ""}
    {nome_file_est     ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}

if {[db_get_database] eq "iterprmi"} {
    ad_return_if_another_copy_is_running
}

# B80: RECUPERO LO USER - INTRUSIONE
set id_utente  [ad_get_cookie iter_login_[ns_conn location]]
set id_utente_loggato_vero [ad_get_client_property iter logged_user_id]
set session_id [ad_conn session_id]
set adsession  [ad_get_cookie "ad_session_id"]
set referrer   [ns_set get [ad_conn headers] Referer]
set clientip   [lindex [ns_set iget [ns_conn headers] x-forwarded-for] end]

iter_get_coimtgen;#gac01

#if {$id_utente != $id_utente_loggato_vero} {
#    set login [ad_conn package_url]
#    ns_log Notice "********AUTH-CHECK-SCHEDA-KO-USER;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#    iter_return_complaint "Accesso non consentito! Per accedere a questo programma devi prima eseguire la procedura di <a href=$login>Login.</a>"
#    return 0
#} else {
#    ns_log Notice "********AUTH-CHECK-SCHEDA-OK;ip-$clientip;$id_utente;$id_utente_loggato_vero;$session_id;$nome_funz;$adsession;"
#}

set lvl 1
set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]

# Per prima cosa, verifico che path_file_pdf e url_file_pdf siano valorizzati
# Faccio delle iter_return_complaint perchè questo programma non ha un adp
if {[string is space $path_file_pdf]} {
    iter_return_complaint "Impossibile stampare l'allegato: path_file_pdf non valorizzato"
}

if {[string is space $url_file_pdf]} {
    iter_return_complaint "Impossibile stampare l'allegato: url_file_pdf non valorizzato"
}

if {![file exists $path_file_pdf]} {
    iter_return_complaint "Impossibile stampare l'allegato: file_pdf $path_file_pdf non trovato sul server"
}


# Verifico se il file e' gia' presente sulla coimdocu
#   cod_impianto   e' stato ricevuto in input
set tipo_documento "SI";#Scheda identificativa impianto (anche se si tratta dell'allegato E)

# Faccio le query negli xql solo se sono diverse tra oracle e postgres
db_1row query "select max(a.cod_documento)  as cod_documento
                    , max(a.data_documento) as data_documento -- escamotage per estrarla...
                 from coimdocu a
                where a.cod_impianto   = :cod_impianto
                  and a.tipo_documento = :tipo_documento
                  and a.data_documento = (select max(b.data_documento)
                                            from coimdocu b
                                           where b.cod_impianto   = :cod_impianto
                                             and b.tipo_documento = :tipo_documento)"

# Allego il documento alla tabella documenti solo se non e' gia' presente
# oppure, se e' presente, solo se la data di modifica dell'impianto e' >= della data di stampa

if {$data_documento == ""} {
    # significa che la query precedente non ha estratto nulla (data_documento e' not null)
    set sw_allega_il_documento  "SI"
    set sw_update_coimdocu      "NO";#inserisce una nuova riga nella coimdocu
} else {
    if {[db_0or1row query "select data_mod
                                , data_ins
                             from coimaimp
                            where cod_impianto = :cod_impianto"] == 0
    } {
	iter_return_complaint "Impianto non trovato (cod_impianto: $cod_impianto)"
    }
    if {$data_mod == ""} {
	set data_mod $data_ins
    }

    # data_documento contiene la data di ultima stampa dell'allegato.
    if {$data_mod == ""
    ||  $data_mod >= $data_documento
    } {
	set sw_allega_il_documento "SI"
	if {$data_mod == $data_documento} {
	    set sw_update_coimdocu "SI";#aggiorna la riga gia' esistente di coimdocu
	} else {
	    set sw_update_coimdocu "NO";#inserisce una nuova riga nella tabella coimdocu
	}
    } else {
	set sw_allega_il_documento "NO"
    }
}

if {$sw_allega_il_documento == "SI"} {
    # copiato da coimdocu-g-layout.tcl e migliorato:

    # imposto i campi della tabella coimdocu
    #   cod_documento  e' stato letto prima oppure viene valorizzato piu' avanti
    #   tipo_documento e' stato valorizzato prima
    set tipo_soggetto   "";#non serve
    set cod_soggetto    "";#non serve
    #   cod_impianto    e' stato valorizzato prima
    set data_stampa     [iter_set_sysdate]
    set data_documento  $data_stampa
    set data_prot_01    ""
    set protocollo_01   ""
    set data_prot_02    ""
    set protocollo_02   ""
    set flag_notifica   ""
    set data_notifica   ""
    set contenuto_path  $path_file_pdf
    set tipo_contenuto  [ns_guesstype $path_file_pdf]
    set descrizione     $nome_file_est     
    set note            ""
    set data_ins        [iter_set_sysdate]
    set data_mod        ""
    set utente          $id_utente

    with_catch error_msg {
	db_transaction {
	    if {$sw_update_coimdocu == "NO"} {
                set cod_documento [db_nextval "coimdocu_s"]

		db_dml dml_1 "
                    insert
                      into coimdocu 
                         ( cod_documento  
                         , tipo_documento 
                         , tipo_soggetto  
                         , cod_soggetto   
                         , cod_impianto   
                         , data_stampa    
                         , data_documento 
                         , data_prot_01   
                         , protocollo_01  
                         , data_prot_02   
                         , protocollo_02  
                         , flag_notifica  
                         , data_notifica  
                     --  , contenuto      -- viene valorizzato dopo con le apposite update
                     --  , tipo_contenuto -- viene valorizzato dopo con le apposite update
                         , descrizione    
                         , note           
                         , data_ins       
                         , data_mod       
                         , utente         
                         )
                    values
                         ( :cod_documento  
                         , :tipo_documento 
                         , :tipo_soggetto  
                         , :cod_soggetto   
                         , :cod_impianto   
                         , :data_stampa    
                         , :data_documento 
                         , :data_prot_01   
                         , :protocollo_01  
                         , :data_prot_02   
                         , :protocollo_02  
                         , :flag_notifica  
                         , :data_notifica  
                     --  ,  contenuto      -- viene valorizzato dopo con le apposite update
                     --  ,  tipo_contenuto -- viene valorizzato dopo con le apposite update
                         , :descrizione    
                         , :note           
                         , :data_ins       
                         , :data_mod       
                         , :utente
                         )"
	    } else {
		set data_mod [iter_set_sysdate]
		db_dml dml_2 "
                    update coimdocu
                       set descrizione    = :descrizione
                       --, contenuto      -- viene valorizzato dopo con le update successive
                       --, tipo_contenuto -- viene valorizzato dopo con le update successive
                         , data_mod       = :data_mod
                         , utente         = :utente
                     where cod_documento  = :cod_documento"
	    }


	    # Per allegare il documento, devo usare istruzioni diverse tra Oracle e Postgres.

	    # Controllo se il Database e' Oracle o Postgres
	    set tipo_db [iter_get_parameter database]
	    if {$tipo_db == "postgres"} {
		if {$coimtgen(regione) eq "MARCHE"} {#gac01 per regione marche salvo i file sul filsystem

		    if {[db_0or1row query "select contenuto as docu_contenuto_check
                                             from coimdocu
                                            where cod_documento = :cod_documento"] == 1
		    } {
			if {$docu_contenuto_check != ""} {
			    db_dml dml_3 "update coimdocu
                                        -- set contenuto     = lo_unlink(coimdocu.contenuto)
                                           , path_file       = :contenuto_path
                                       where cod_documento = :cod_documento"
			}
		    }

		    db_dml dml_4 "update coimdocu
                                 set tipo_contenuto = :tipo_contenuto
                                   --, contenuto      = lo_import(:contenuto_path)
                                   , path_file        = :contenuto_path
                               where cod_documento  = :cod_documento"
		} else {#gac01 else e suo contenuto

		    #gac01 per le altre istanze vado a salvare gli allegati sui blobs del db.
		    if {[db_0or1row query "select contenuto as docu_contenuto_check
                                             from coimdocu
                                            where cod_documento = :cod_documento"] == 1
		    } {
			if {$docu_contenuto_check != ""} {
			    db_dml dml_3 "update coimdocu
                                             set contenuto     = lo_unlink(coimdocu.contenuto)
                                           where cod_documento = :cod_documento"
			}
		    }
		    db_dml dml_4 "update coimdocu
                                     set tipo_contenuto = :tipo_contenuto
                                       , contenuto      = lo_import(:contenuto_path)
                                   where cod_documento  = :cod_documento"

		};#gac01
	    } else {
		db_dml dml_5 "update coimdocu
                                 set tipo_contenuto = :tipo_contenuto
                                   --, contenuto      = empty_blob()
                                   , path_file      = ''
                               where cod_documento  = :cod_documento
                           returning contenuto
                                into :1" -blob_files [list $contenuto_path]
	    }
	}
    } {
	iter_return_complaint "Spiacente, ma il DBMS ha restituito il
        seguente messaggio di errore <br><b>$error_msg</b><br>
        Contattare amministratore di sistema e comunicare il messaggio
        d'errore. Grazie."
    }
}

ad_returnredirect $url_file_pdf
ad_script_abort
