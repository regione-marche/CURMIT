ad_page_contract {  
    Attachments list

    @author Claudio Pasolini

    @cvs-id index.tcl 

    USER  DATA       MODIFICHE
    ===== ========== =======================================================================
    mat03 03/09/2025 Modifiche fatte per l'accessibilità.(ho usato mauve++ per vedere gli errori)
    mat03            Aggiunto l'attributo "alt" all'immagine del delete.
    mat03            Sostituito il tag b con strong. Sostituito il tag font con span.
    
    mat02 18/03/2025 Aggiunto il recupero del nome db e una variabile usata nell'adp

    mat01 21/02/2025 Aggiunto parametro from_forniture nell'url del bottone actions.Lo faccio
    mat01            per tutti anche se per ora non serve.  
    mat01            Lo mando per tutti e poi faccio il controllo al momento di invio mail 
    mat01            in file-add-2 per controllare che sia salerno. 
    
    but01 13/03/2024 MEV3 Regione Marche Punto 7: Aggiunto il controllo su il carecamento
    but01            di un file XML.

} {
    object_id
}

set user_id [auth::require_login]

if {$user_id != $object_id} {
    ad_returnredirect -message "Non puoi gestire le forniture di un altro distributore." [export_vars -base attachments {object_id}]
    ad_script_abort
}

set msg_di_prova ""
if {[db_0or1row q "select 1
                    where current_date <= '2024-05-31'"]} {

    set msg_di_prova "<br><br><big><span style=\"color:red\"><strong>I CARICAMENTI EFFETTUATI DAL 08/05/2024 AL 31/05/2024 SONO CONSIDERATI DI PROVA E VERRANNO POI CANCELLATI.</strong></span></big><br>"
}

# decode object
set object_description [db_string query "select name from iter_distributors where distributor_id = :object_id"]

set package_id [ad_conn package_id]

# get file-storage package id
array set node [site_node::get -url /file-storage]
set package_id $node(package_id)

# get the root folder of the file-storage instance
set folder_id [fs::get_root_folder -package_id $package_id]

set return_url   [ad_conn url]?[ad_conn query]
set pretty_name  [ad_convert_to_text $object_description]

if {[string match "*iter-portal-marche*" [db_get_database]]} { #mat02 aggiunta if e contenuto
    set check_marche 1
} else {
    set check_marche 0
}


# creates attachments url
set attachment_add_url "/iter-portal/attach/file-add?pretty_object_name=[ns_urlencode $pretty_name]&folder_id=$folder_id&object_id=$object_id&return_url=[ns_urlencode $return_url]&from_forniture=t" ;#mat01 aggiunto from_forniture=t

# prepare actions buttons
set actions [list "Aggiungi una fornitura" "$attachment_add_url" "Aggiunge una nuova fornitura" ]

# grabs all vars 
set url_vars [export_ns_set_vars "url" {}]

set base_url [ad_conn url]

template::list::create \
    -name attachments \
    -multirow attachments \
    -actions $actions \
    -elements {
	name {
	    label "Nome"
	    link_url_col view_url
	    link_html {title "Visualizza fornitura"}
	}
	description {
	    label "Descrizione"
	}
	publish_date {
	    label "Data caricamento"
	    html "align center"
	}
        approved_p {
	    label "Confermato"
	    html "align center"
            display_template {<if @attachments.approved_p@ eq "No"><a href="@attachments.approve_url@" title="Conferma fornitura" onClick="return(confirm('Sei sicuro? Questa azione non è revocabile.'));">No</a></if><else>Si</else>}
	}
	delete {
	    html "align center"
	    display_template {<if @attachments.approved_p@ eq "No"><a href="@attachments.delete_url@" title="Cancella questa fornitura" onClick="return(confirm('Confermi la cancellazione?'));"><img src="/resources/acs-subsite/Delete16.gif" alt="Cancella questa fornitura" width="16" height="16" border="0"></a></if><else></else>}
	    sub_class narrow
	}
    }

#
## get existing attachments 
#

#sim01 set attach_list [attachments::get_attachments -object_id $object_id -base_url /iter-portal/]
set attach_list [attachments::get_all_attachments -object_id $object_id -base_url /iter-portal/]

ns_log notice "\nattachments.tcl $attach_list"
# attach_list is a list of lists where each row contains 1.attachment_id 2.name
# and 3.url of the attachment
multirow create attachments attachment_id name view_url approve_url description publish_date approved_p delete_url

foreach attachment $attach_list {
    
    #sim01 util_unlist $attachment attachment_id name approved_p view_url 

    util_unlist $attachment attachment_id name view_url detach_url;#sim01
     
    set approved_p [db_string check "select coalesce(approved_p,'f')  from attachments where object_id = :object_id and item_id = :attachment_id"];#sim01
    
    db_1row query "
    select description
         , to_char(publish_date,'DD/MM/YYYY') as publish_date
         , ci.name as file_name  --but01
      from cr_items ci
         , cr_revisions cr
     where ci.item_id       = :attachment_id
       and ci.live_revision = cr.revision_id"
    
    set delete_url [export_vars -base "unattach" {object_id attachment_id}]
    #sim01 set approved_p [ad_decode $approved_p f No t Si No]
    set approved_p [ad_decode $approved_p f No t Si];#sim01
    
    if {!$approved_p} {
	set extension [file extension $file_name];#but01
	if {$extension != ".xml"} {#but01 Aggiunta if ma non il contenuto
	    set approve_url [export_vars -base "validate" {object_id attachment_id}]
	} else {#but01 Aggiunta else e il contenuto
	    set approve_url [export_vars -base "validate-xml" {object_id attachment_id}]
	}
    } else {
	set approve_url "#"
    }
    
    
    multirow append attachments $attachment_id $name $view_url $approve_url $description $publish_date $approved_p $delete_url

}

