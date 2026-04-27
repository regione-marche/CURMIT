ad_page_contract {

    Lista script

    @author Claudio Pasolini
    @cvs-id index.tcl

    @param expand   Lista di nodi che devono essere 'aperti' nell'esposizione

} {
    {root_id:integer ""}
    {expand:integer,multiple ""}

}

set package_id [apm_package_id_from_key ah-util]

set page_title "Programmi"
set context [list $page_title]


template::list::create \
    -name explode \
    -multirow explode \
    -elements {
	url {
            label ""
            html "align left"
	    display_template {
		<if @explode.expand_mode gt 0><a name="@explode.script_id@"></a></if>
		<if @explode.expand_mode@ eq 1>
		<a href="?@explode.expand_url@#@explode.script_id@"><img src="/resources/acs-templating/plus.gif" border=0></a>
		</if>
		<if @explode.expand_mode@ eq 2>
                <a href="?@explode.expand_url@#@explode.script_id@"><img src="/resources/acs-templating/minus.gif" border=0></a>
                </if>
	    }
	}
	edit {
	    link_url_col edit_url
	    display_template {<img src="/resources/acs-subsite/Edit16.gif" width="16" height="16" border="0">}
	    link_html {title "Modifica script"}
	    sub_class narrow
	}
        add_child {
	    display_template {<img src="/resources/acs-subsite/Add16.gif" height="16" width="16" alt="Add" style="border:0">}
	    link_url_col add_url
	    link_html { title "Aggiungi uno script a questa cartella" }
	    sub_class narrow
        }
	level {
	    label "Lvl"
	}
	title {
	    label "Nome"
	}
	description {
	    label "Descrizione"
	}
	permission {
	    link_url_col permission_url 
            link_html {title "Gestisci i permessi di questo script"}
	    display_template {Permessi}
	}
	delete {
	    link_url_col delete_url 
            link_html {title "Cancella questo script" onClick "return(confirm('Confermi la cancellazione?'));"}
	    display_template {<img src="/resources/acs-subsite/Delete16.gif" width="16" height="16" border="0">}
	    sub_class narrow
	}
    }

set return_url [ad_conn url]?[ad_conn query]

# defines multirow
multirow create explode expand_url expand_mode script_id title level description edit_url add_url permission_url delete_url 

if {$root_id eq ""} {
    # inizio la query dal main site
    array set nodes [site_node::get -url /]
    set root_id $nodes(object_id)
}

set parents [concat $root_id $expand]

db_foreach query "
        select s.script_id,
               s.title, 
               s.level,
               s.description,
               (select count(*) from mis_fast_scripts s2 where s2.context_id = s.script_id) as has_childs_p  
        from mis_fast_scripts s
        where s.context_id in ([join $parents ,])
        order by s.title
" {

    # indento codice in funzione del livello
    set title [string repeat . [expr $level * 4]]$title
    
    set expand_mode 0
    if {$has_childs_p} {
	set expand_mode 1
	set urlvars [list]

	foreach n $expand {
	    if {$n == $script_id} {
		set expand_mode 2
	    } else {
		# trascino i nodi da espandere, ma solo se non sono discendenti
		# di quello che sto elaborando
		if {![db_0or1row is_child "
                    select 1
                    from  mis_fast_scripts
                    where context_id = :script_id
                      and script_id  = :n 
                "]} {
		    lappend urlvars "expand=$n"
		}
	    }
	}
	
	if { $expand_mode == 1} {
	    lappend urlvars "expand=$script_id"
	}
	
	lappend urlvars "root_id=$root_id"
	
	set expand_url "[join $urlvars "&"]"

    } else {
	set expand_url ""
    }

    set edit_url       [export_vars -base "../script-add-edit" {{item_id $script_id} return_url}]
    set add_url        [export_vars -base "../script-add-edit" {{parent_id $script_id} return_url}]
    set delete_url     [export_vars -base "../script-delete"   {{item_id $script_id} return_url}]
    set permission_url [export_vars -base "permissions"        {{object_id $script_id} return_url}]

    multirow append explode $expand_url $expand_mode $script_id $title $level $description $edit_url $add_url $permission_url $delete_url

}
