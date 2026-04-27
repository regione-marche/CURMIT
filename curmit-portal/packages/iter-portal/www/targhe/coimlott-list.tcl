ad_page_contract {

    @author Simone Pesci

} {
}

set user_id    [ad_conn user_id]

set page_title "Lista Lotti di Targhe"
set context [list "$page_title"]

# prepare actions buttons
set actions { "Genera Targhe" coimlott-add-edit "Genera Targhe" }

template::list::create \
    -name coimlott \
    -multirow coimlott \
    -actions $actions \
    -elements {	
	lotto_id {
	    label "Num Lotto"
	}
	date_ins {
	    label "Data Generazione"
	}
	time_ins {
	    label "Ora Generazione"
	}
	num_targhe {
	    label "Numero Targhe"
	}
	user_name {
	    label "Utente Generazione"
	}
	estrai_targhe {
	    link_url_col link_estrai_targhe
	    label ""
	    display_template {Estrai targhe}
	}
    }

db_multirow -extend {link_estrai_targhe} coimlott query "
    select l.lotto_id
         , l.num_targhe
         , to_char(l.timestamp_ins, 'DD/MM/YYYY') as date_ins
         , to_char(l.timestamp_ins, 'HH24:MI')      as time_ins
         , first_names || ' ' || last_name as user_name
    from coimlott l
       , registered_users u
   where l.user_id = u.user_id
    order by lotto_id
    " {
	set link_estrai_targhe [export_vars -base "coimlott-csv" {lotto_id}]
    }


