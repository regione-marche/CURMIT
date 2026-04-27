ad_page_contract {

    Lista distributori

    @author 
    @cvs-id $Id: list-distr.tcl

    USER  DATA       MODIFICHE
    ===== ========== ===============================================================================================
 
} {
    {object_id  ""}
    {format         "normal"}
    {rows_per_page  "999999"}
    {offset         "0"}

    orderby:optional
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

set page_title "Lista distributori"
set context [list  "$page_title"]

# imposto codice Regione Lombardia come utilizzato nei movimenti
set id_regione "3"
set database [db_get_database];#gab01

set actions ""

source [ah::package_root -package_key ah-util]/paging-buttons.tcl

set actions   "{Inserisci nuovo distributore}" 
#append actions " {Estrai in csv} transactions?$link_gest&format=csv&rows_per_page=999999 {Estrai in csv}";#rom01

template::list::create \
    -name transactions \
    -multirow transactions \
    -actions $actions \
    -selected_format $format \
    -key object_id \
    -elements {
	name {
	     label "Ragione Sociale<br>dell'distributore"
	    }
	address1 {
	    label "Indirizzo "
	}
	city {
	    label "Comune"
	}
	province {
	    label "Provincia"
	}
	zipcode {
	    label "C.A.P."
	}
	email {
	    label "Email"
	}
	phone {
	    label "Telefono"
	}
	f_rete_o_extrarete {
	    label "Rete/Extra rete"
	}
	anno_rif {
	    label "Anno riferimento"
	}
	natura_giurid {
	    label "Ragione Sociale<br>dell'utente"
	}
	utente_cogn_rag_soc { 
	    label "Cognome dell'utente"
	}
        utente_nome {
	    label "Nome dell'utente"
	}
	utente_cf {
	    label "Codice fiscale dell'utente"
	}
	utente_piva {
	    label "Partita Iva dell'utente"
	}
	toponimo_tipo {
	    label "Tipo toponimo"
	}
        toponimo_nome {
	    label "Nome toponimo"
	}
        toponimo_civico {
	    label "Civico"
	    html {align right}
	}
        toponimo_cap {
	    label "Cap"
	}
        comune_nome {
	    label "Comune"
	    html {align right}
	}
        comune_istat {
	    label "Codice Istat del Comune"
	    html {align right}
	}
        catasto_sezione {
	    label "Sezione"
	    html {align right}
	}
        catasto_foglio {
	    label "Foliglio"
	    html {align right}
	}
	catasto_particella {
	    label "Particella"
	    html {align right}
        }
	catasto_subalterno {
	    label "Subalterno"
	}
	pod {
	    label "Codice POD<br>(Point Of Delivery)"
	}
	pdr {
	    label    "Codice PDR<br>(Punto Di Riconsegna)"
	}
        stato_pdr {
            label "Stato PDR"
        }
	matr_contatore {
	    label "N°di matricola contatore"
	    html {align right}
        }
        contratto_tipo {
	    label "Tipo contratto"
	    html {align left}
	}
        combustibile_tipo {
	    label "Combustibile"
	    html {align right}
	}
	combustibile_consumo {
	    label "Consumo annuo"
	    html {align right}
	}
	combustibile_um {
	    label "Unità di misura del consumo"
	    html {align right}
	}
	combustibile_anno {
	    label "Anno del consumo"
	    html {align right}
	}
	} \
    -formats {
        normal {
            label "Video"
            layout table
            row {
		name {}
		address1 {}
		city {}
		province {}
		zipcode {}
		email {}
		phone {}
		f_rete_o_extrarete {}
		anno_rif {}
                natura_giurid {}
		utente_cogn_rag_soc {}
                utente_nome {}
		utente_cf {}
		utente_piva {}
		toponimo_tipo {}
		toponimo_nome {}
                toponimo_civico {}
		catasto_sezione {}
		comune_nome {}
		catasto_foglio {}
		matr_contatore {}
		catasto_particella {}
		pod {}
		pdr {}
                contratto_tipo {}
		combustibile_tipo {}
		combustibile_consumo {}
		combustibile_um {}
		combustibile_anno {}
            }
        }
        csv {
            label "Excel"
            output csv
            row {
		name {}
		address1 {}
		city {}
		province {}
		zipcode {}
		email {}
		phone {}
		f_rete_o_extrarete {}
                anno_rif {}
		natura_giurid {}
		utente_cogn_rag_soc {}
                utente_nome {}
		utente_cf {}
		utente_piva {}
		toponimo_tipo {}
		toponimo_nome {}
                toponimo_civico {}
		comune_nome {}
		comune_istat {}
		catasto_sezione {}
		catasto_foglio {}
		matr_contatore {}
                catasto_particella {}
		pod {}
                contratto_tipo {}
		combustibile_tipo {}
		combustibile_consumo {}                                                      
		combustibile_um {}                                                           
		combustibile_anno {} 
            }
        }
    } 
if {![info exists errnum]} {
    db_multirow -extend {name address1 city province zipcode email phone f_rete_o_extrarete anno_rif natura_giurid utente_cogn_rag_soc utente_nome utente_cf utente_piva toponimo_tipo toponimo_nome toponimo_civico toponimo_cap comune_nome comune_istat catasto_sezione catasto_foglio catasto_particella catasto_subalterno pdr pod stato_pdr matr_contatore contratto_tipo combustibile_tipo combustibile_consumo combustibile_um combustibile_anno} transactions query "
            select a.object_id
            , s.distributor_id
            , anno_rif
            ,  natura_giurid
            , utente_cogn_rag_soc
            , utente_nome
            , utente_cf
            , utente_piva
            , toponimo_tipo
            , toponimo_nome
            , toponimo_civico
            , toponimo_cap
            , comune_nome
            , comune_istat
            , catasto_sezione
            , catasto_foglio
            , catasto_particella
            , catasto_subalterno
            , pdr
            , pod
            , stato_pdr
            , matr_contatore
            , contratto_tipo
            , combustibile_tipo
            , combustibile_consumo
            , combustibile_um
            , combustibile_anno
            , d.name
            , d.address1
            , d. city
            , d.province
            , d.zipcode
            , d.email
            , d.phone
            , d.f_rete_o_extrarete
         from iter_distr_sync s
             , iter_distributors d
             , attachments a
          where d.distributor_id  = a.object_id
          -- and s.distributor_id = d.distributor_id
           limit 10" 
} else {
		    # creo una multirow fittizia 
    template::multirow create transactions dummy
}

if {![info exists submit_p]} {
    # save current url vars for future reuse
    ad_set_client_property iter-portal admin/list-distr [export_vars -entire_form -no_empty]
}

if {[string equal $format "csv"]} {
    template::list::write_csv -name transactions
    ad_script_abort
}

