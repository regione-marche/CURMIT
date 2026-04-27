ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: operators.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    ric01 11/09/2025 Punto "Nuova richiesta 2025" MEV regione Marche, aggiunto nuovo campo
    ric01            abilitazione_giuridica_p (upgrade-2.1.22-2.1.23). Solo per regione Marche.

    mat01 03/09/2025 Aggiunto l'attributo "alt" all' incona del modifica.
    mat01            Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)

    but01 30/09/2024 Aggiunto il campo email_operator.
    
    rom01 27/06/2018 Modificate label e diciture che contenevano Operatore in Tecnico

    gac01 15/02/2018 Aggiunti campi Patentino e Patentino Fgas

} {
}
#ric01 set maintainer_id [iter::script_init]
set maintainer_id [iter::script_init -caller "operators"];#ric01

if {[string equal $maintainer_id "0"]} {
    ad_returnredirect services
}

db_1row query "select name as maintainer_name, validated_p, approved_p from iter_maintainers where maintainer_id = :maintainer_id"

set num_msg [iter::check_reg -maintainer_id $maintainer_id]
if {[string equal $num_msg ""] && ![string equal $validated_p "t"]} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}

set reg_msg [iter::get_reg_msg -validated_p $validated_p -approved_p $approved_p -num_msg $num_msg]

#rom01 set page_title "Lista Operatori di $maintainer_name"
set page_title "Lista Tecnici di $maintainer_name" ;#rom01
#rom01 set context [list [list services "Servizi per i manutentori"] "Lista Operatori"]
set context [list [list services "Servizi per i manutentori"] "Lista Tecnici"] ;#rom01
set db_name [db_get_database];#gac01
# prepare actions buttons
#rom01 sostituito termine Operatore con tecnico
set actions [list \
     "Nuovo Tecnico" operator-add-edit?maintainer_id=$maintainer_id "Crea un nuovo tecnico" \
		 ]
#gac01 aggiunti campi patentino e patentino_fgas
set elements ""
#rom01 cambiato link_html {title "Modifica operatore"} in "Modifica tecnico"
#but01 aggiunto il campo email_operator.
append elements {
    edit {
	link_url_col edit_url
	display_template {<img src="/resources/acs-subsite/Edit16.gif" alt="Modifica tecnico" width="16" height="16" border="0">}
	link_html {title "Modifica tecnico"}
	sub_class narrow
    }
    name {
	label "Cognome"
    }
    first_name {
	label "Nome"
    }
    no {
	label "Matricola"
    }
    iter_no {
	label "Codice Iter"
    }
    password {
	label "Password"
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
    email_operator {
	label "Email"
    }
}

#ric01 aggiunto abilitazione_giuridica_p
#gac01 aggiunta if e suo contenuto
if {[string match "*iter-portal-marche*" $db_name]} { #gac01
    append elements {
        patentino {
            label "Patentino"
        }
        patentino_fgas {
            label "Patentino Fgas"
        }
	abilitazione_giuridica_p {
	    label "Ha titolo giuridico<br>per operare?"
	}
    }
};#gac01
#rom01 cambiato title "Cancella l'operatore"
append elements {
    attivo {
	label "Attivo ?"
    }
}
#    delete {
#	link_url_col delete_url 
#	link_html {title "Cancella il tecnico" onClick "return(confirm('Confermi la cancellazione?'));"}
#	display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
#	sub_class narrow
#    }

template::list::create \
    -name operators \
    -multirow operators \
    -actions $actions \
    -elements $elements
	

    db_multirow -extend {edit_url delete_url attivo} operators query "
                   select *,
                          case patentino               --gac01
                             when 't' then 'Si'
                             else 'No'
                          end as patentino
                         ,case patentino_fgas          --gac01
                             when 't' then 'Si'
                             else 'No'
                          end as patentino_fgas
                        , case abilitazione_giuridica_p   --ric01
                          when 't' then 'Si'
                          when 'f' then 'No'
                          else 'Inserire abilitazione'
                           end as abilitazione_giuridica_p  
                   from iter_operators
                   where maintainer_id = :maintainer_id
                   order by name
    " {
	if {[string equal $is_active_p "t"]} {
	    set attivo "Si"
	} else {
	    set attivo "No"
	}
	set edit_url   [export_vars -base "operator-add-edit" {maintainer_id operator_id}]
	set delete_url [export_vars -base "operator-delete"   {maintainer_id operator_id}]
	
    }

