ad_page_contract {

    Lista distributori

    @author 
    @cvs-id $Id: list-distr.tcl

    USER  DATA       MODIFICHE
    ===== ========== ===============================================================================================
    mat01 22/08/2025 Aggiunto l'attributo "alt" all'icona dell'edit.
    mat01            Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)
} {
    {distributor_id  ""}
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

#set actions   "{Inserisci nuovo distributore}" 
#append actions " {Estrai in csv} transactions?$link_gest&format=csv&rows_per_page=999999 {Estrai in csv}";#rom01

#mat01 aggiunto all'immagine dell'edit l'attributo alt

template::list::create \
    -name transactions \
    -multirow transactions \
    -actions $actions \
    -selected_format $format \
    -key distributor_id \
    -page_query {
	select distributor_id
	from iter_distributors d
	where 1 = 1
    } \
    -elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" alt="Modifica distributore" width="16" height="16" border="0">}
	    link_html {title "Modifica distributore"}
	    sub_class narrow
	}
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
    } \
    -formats {
        normal {
            label "Video"
            layout table
            row {
		edit {}
		name {}
		address1 {}
		city {}
		province {}
		zipcode {}
		email {}
		phone {}
		f_rete_o_extrarete {}
		
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
		
            }
        }
    }

if {![info exists errnum]} {
   		
    db_multirow -extend {edit_url} transactions query "
       select d.distributor_id
            , d.name
            , d.address1
            , d. city
            , d.province
            , d.zipcode
            , d.email
            , d.phone
            , d.f_rete_o_extrarete
            , case when f_rete_o_extrarete='e' then 'Extra_rete' 
                  when f_rete_o_extrarete='r' then 'Rete' 
                  end as f_rete_o_extrarete 
         from iter_distributors d
              where 1 = 1
             [template::list::page_where_clause -name transactions -and]" {
		 set edit_url   [export_vars -base "edit?" {distributor_id}]
    }
    
} else {
    
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

