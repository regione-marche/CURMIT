ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: operators.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    ric01 11/09/2025 Punto "Nuova richiesta 2025" MEV regione Marche, aggiunto nuovo campo
    ric01            abilitazione_giuridica_p (upgrade-2.1.22-2.1.23). Solo per regione Marche.

    mat01 22/08/2025 Aggiunto l'attributo "alt" alle incone del modifica e dell'elimina nella lista.
    mat01            Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)
    
    rom02 16/06/2025 Corretto baco di rom01: lato amministratore l'operatore non si vedeva nella lista nei casi in cui non era ancora propagato.

    rom01 11/04/2025 Aggiunto link per resettare le password degli operatori da parte degli utenti amministratori.

    but02 30/09/2024  Aggiunto il campo email.
    
    but01 14/02/2024  Toglto il campo "password" della lista su richiesta di Simone.

    gac01 15/02/2018 Aggiunti campi Patentino e Patentino Fgas

} {
    maintainer_id
}

db_1row query "select name as maintainer_name, validated_p, approved_p from iter_maintainers where maintainer_id = :maintainer_id"

set num_msg [iter::check_reg -maintainer_id $maintainer_id]
if {[string equal $num_msg ""] && ![string equal $validated_p "t"]} {
    set to_approve_p "t"
} else {
    set to_approve_p "f"
}

set reg_msg [iter::get_reg_msg -validated_p $validated_p -approved_p $approved_p -num_msg $num_msg]

set page_title "Lista Operatori di $maintainer_name"
set context [list [list services "Servizi per i manutentori"] "Lista Operatori"]
set db_name [db_get_database];#gac01
# prepare actions buttons
set actions [list \
     "Nuovo Operatore" operator-add-edit?maintainer_id=$maintainer_id "Crea un nuovo operatore" \
		]
#mat01 aggiunto l'attributo alt all'immagine di edit e di delete
#gac01 aggiunti campi patentino e patentino_fgas
set elements ""
append elements {
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0" alt="Modifica operatore">}
	    link_html {title "Modifica operatore"}
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
#but01 toglto il campo password 
#but01 password {
#but01            label "Password"  }

append elements {
        iter_no {
	    label "Cod. Iter"
	}
    azioni {
	label "Azioni"
	link_url_col reset_pswd_url
	link_html {title "Resetta password dell'operatore" target "Reset password"}
	display_template {Reset password}
	html "align left nowrap"
    }
	delete {
	    link_url_col delete_url 
            link_html {title "Cancella l' operatore" onClick "return(confirm('Confermi la cancellazione?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0" alt="Cancella operatore">}
	    sub_class narrow
	}
}

template::list::create \
    -name operators \
    -multirow operators \
    -actions $actions \
    -elements $elements

    db_multirow -extend {edit_url delete_url reset_pswd_url} operators query "
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
          --rom02     , u.user_id                       --rom01
          --rom02     , u.password as pswd_operator     --rom01
                   from iter_operators
          --rom02     , users u                         --rom01
                  where maintainer_id = :maintainer_id
          --rom02   and u.username = iter_no            --rom01
                  order by name
    " {
	set edit_url   [export_vars -base "operator-add-edit" {maintainer_id operator_id}]
	set delete_url [export_vars -base "operator-delete"   {maintainer_id operator_id}]

	if {[db_0or1row q "select u.user_id
                                , u.password as pswd_operator
                             from users u
                            where u.username = :iter_no"]} {#rom02 Aggiunta if e contenuto
	    set reset_pswd_url [export_vars -base "/user/password-reset" {{password_hash $pswd_operator} {user_id $user_id} {caller_admin t}}]
	} else {
	    set reset_pswd_url ""
	}
	
    }

