ad_page_contract {

    @author Claudio Pasolini
    @cvs-id help-ae.tcl

} {
    file
    url
    {mode "edit"}
}

set page_title "Gestione testi Help"
set context [list "Gestione testi Help"]

ad_form -name addedit -export {file url} -form {
    {help:richtext
        {html {rows 20 cols 100} }
        {label "Help"} 
    }
} -on_request {

    if {[file exists $file]} {
	set inp [open $file r]
        fconfigure $inp -encoding utf-8
	set help_text [read $inp]
	close $inp

	# rimuovo il prologo, che verrà reinserito
	regsub {.+<!-- Inizio testo -->} $help_text {} help_text
	set help [template::util::richtext::create $help_text "text/html"]
    }

} -on_submit {

    set help [template::util::richtext::get_property contents $help]

    set help_context [list [list $url "Ritorna"] Help]
    set pretty_url [db_string query "
        select coalesce(description, '$url')
        from mis_fast_scripts
        where title = '[string range $url 1 end]'"] 

    # controllo che esistano le directory superiori, altrimenti le creo
    set dirs [file split $file]
    # scarto l'ultimo elemento, che è il file da creare
    set dirs [lrange $dirs 0 [expr [llength $dirs] - 2]]
    foreach dir $dirs {
	append new $dir
	if {![file exists $new]} {
	    ns_mkdir $new
	}
	append new "/"
    }

    # rimuovo la root del servizio dal path completo del file
    set service_root [ah::service_root]
    regsub $service_root $file {} file_tail

    set out [open $file w]
    puts $out "<% set admin_p \[acs_user::site_wide_admin_p\] %>\n
<% set path \[ah::service_root\]$file_tail %>\n
<master src=\"/packages/mis-base/www/alter-master\">\n
<property name=\"title\">Help di $pretty_url</property>\n
<property name=\"context\">$help_context</property>\n
<if @admin_p@ eq 1><a href=\"/ah-util/help-ae?file=@path@&url=$url\"> Modifica</a><p></if>\n
<!-- Inizio testo -->$help"
    close $out

    ad_returnredirect $url
    ad_script_abort
}
