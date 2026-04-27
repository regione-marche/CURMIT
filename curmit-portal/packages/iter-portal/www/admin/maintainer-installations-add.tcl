ad_page_contract {

  @author         Gacalin Lufi
  @creation_date  19/02/2018

  USER  DATA       MODIFICHE
  ===== ========== ===============================================================================================

} {
    maintainer_id
    {mode "edit"}
}

set user_id    [ad_conn user_id]

set page_title "Aggiungi una nuova Tipologia associata al manutentore"
set buttons [list [list "$page_title" new]]

set context [list [list maintainer-installations-list?maintainer_id=$maintainer_id {Lista Tipologie Impianto associate al manutentore}] $page_title]

# trovo i gruppi corrispondenti agli enti
set maintainer_installations_list [db_list q "
    select a.installation_type_id
      from iter_maintainer_installations a
         , iter_installation_types b
     where a.installation_type_id = b.installation_type_id
       and a.maintainer_id        = :maintainer_id"]

if {$maintainer_installations_list ne ""} {
    set where_gia_presenti "where installation_type_id not in ([join $maintainer_installations_list ,])"
} else {
    set where_gia_presenti ""
}

ad_form -name edit \
    -mode $mode \
    -edit_buttons $buttons \
    -has_edit 1 \
    -export {maintainer_id} \
    -form {

	{installation_type_id:integer(select)
	    {options { {"Scegli ..." ""} [db_list_of_lists query "
            select installation_type_description
                 , installation_type_id
              from iter_installation_types                  
                 $where_gia_presenti
             order by installation_type_id
            "] }}
	    {label {Scegli Tipologia Impianto}}
	}

} -on_submit {

    db_transaction {
	#tiro fuori il piu alto valore di maintainer_installations_id
        db_1row q "
           select coalesce(max(maintainer_installations_id),0) +1 as maintainer_installations_id
             from iter_maintainer_installations"

	#inserisco i valori nella tabella
	db_dml q "insert 
	  into iter_maintainer_installations
             ( maintainer_installations_id
             , maintainer_id
             , installation_type_id
             , creation_user
             , creation_date
	     )
	values
	     (:maintainer_installations_id
             ,:maintainer_id
             ,:installation_type_id
             ,:user_id
             ,current_date 
	     )"
	#rom01 aggiorno l'editing_date del manutentore per il batch li legga come modificati.
	db_dml upd "update iter_maintainers
                       set editing_date = current_date
                     where maintainer_id = :maintainer_id"


    } on_error {
        ah::transaction_error
    }

} -after_submit { 

    ad_returnredirect "maintainer-installations-list?maintainer_id=$maintainer_id"
    ad_script_abort
}




