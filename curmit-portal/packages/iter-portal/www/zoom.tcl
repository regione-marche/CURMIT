ad_page_contract {
    
    Data una stringa di ricerca 'search_word' questo programma propone una lista
    di manutentori che soddisfano la ricerca e restituisce al chiamante:

    1. il codice interno (maintainer_id)
    3. la descrizione (name)

    Notare che i programmi chiamanti devono denominare i campi di form esattamente come indicato
    fra parentesi e che il form deve chiamarsi 'filter'.

    @author Claudio Pasolini
    @cvs-id $Id: zoom.tcl
} {
    {search_word ""}
    {rows_per_page 30}
    orderby:optional
    page:optional    
}

# define JS function for adp page
set javascript "
<script language=JavaScript>
  function sel(a,b) {
    window.opener.document.filter.maintainer_id.value = a;
    window.opener.document.filter.name.value = b;
    window.close();
  }
</script>"


set page_title "Lista Manutentori"
set context [list "Lista $page_title"]


set search_word [string toupper [DoubleApos $search_word]]
set name_clause ""

# creates filters form
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -export {maintainer_id} \
    -form {
	{search_word:text,optional
	    {label {Nominativo manutentore}}
	    {html {length 20} }
	    {value $search_word}
	}

    } -on_request {

} -on_submit {

    set errnum 0

    if {$errnum > 0} {
	break
    } else {
	# per evitare errori nell'esecuzione della query la eseguirò solo se 'errnum' non esiste
	unset errnum
        # imposto flag per sapere se il form è stato inviato
	set submit_p 1
    }

    # recupero l'impostazione dei filtri non compresi nel form
    ah::set_list_filters iter-portal zoom

}

if {$search_word ne ""} {
    set search_word          [string toupper [DoubleApos $search_word]]
    # devo ricercare in 'and' tutti i token presenti e predisporre una opportuna clausola sql
    set name_clause [list]
    foreach token $search_word {
	lappend name_clause "name like '%$token%'"
    }
    set name_clause [join $name_clause "and "]
} else {
    set name_clause "1 = 1"
}

# creo la lista 
template::list::create \
    -name maintainers \
    -multirow maintainers \
    -key maintainer_id \
    -page_flush_p t \
    -page_size $rows_per_page \
    -page_groupsize 10 \
    -page_query {
    select m.maintainer_id
      from iter_maintainers m 
     where 1=1
      [template::list::filter_where_clauses -name maintainers -and]
    } \
    -elements {
	sel {
	    display_template {@maintainers.sel;noquote@}
	    sub_class narrow
	}
        name {
	    label "Descrizione"
	}
        email {
	    label "Email"
	}
        wallet_id {
	    label "Codice portafoglio"
	}
    } \
    -orderby {
	default_value name,asc
	name {
	    label "Nominativo Manutentore"
	    orderby m.name
	}
	wallet_id {
	    label "Codice portafoglio"
	    orderby wallet_id
	}
    } -filters {
	search_word {
	    hide_p 1
	    where_clause {$name_clause}
	}
	rows_per_page {
	    label "Righe per pagina"
	    values {{10 10} {30 30} {100 100}}
	    default_value 30
	}
    } 


db_multirow -extend {sel} maintainers query "
      select maintainer_id,
             name,
             email,
             wallet_id
      from iter_maintainers m 
     where 1=1
      [template::list::page_where_clause -name maintainers  -and]
      [template::list::orderby_clause -name maintainers -orderby]
" {
    set sel "<a href=\"javascript:sel('$maintainer_id', '[ah::js_quote_escape $name]')\">Sel</a>"
}

