ad_page_contract {

    @author Claudio Pasolini
    @cvs-id $Id: operators.tcl

    USER  DATA       MODIFICHE
    ===== ========== =========================================================================
    rom01 03/08/2022 Il link per vedere gli allegati lo mostro solo se ho effettivamente un file allegato.

    sim00 24/05/2018 Nuovo programma che visualizza i documenti presenti sugli impianti che hanno
    sim00            una determinata targa

} {
    {cod_impianto ""}
    targa
    dbn_iter
}


set login_cohesion_marche_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cohesion_marche_p]

set login_cittadino_p [parameter::get_from_package_key -package_key iter-portal -parameter login_cittadino_p]

if {$login_cohesion_marche_p eq "1"} {#innes: aggiunta if, else e loro contenuto
    # visto che non ho in input il cod_impianto, passo alla iter::check_login_cohesion la targa
    set codice_fiscale [iter::check_login_cohesion -nome_array_output array_cohesion -dbn_iter $dbn_iter -targa $targa]
    # Se in futuro ci sara' bisogno di altri campi useremo i valori di array_cohesion
} else {
    if {$login_cittadino_p} {
	set user_id [iter::script_init_cittadino]
    }
}


set page_title "Lista Documenti"
set context [list [list services "Servizi per i Cittadini"] "Lista Documenti"]
set db_name [db_get_database];#gac01
# prepare actions buttons
set actions ""


set elements ""
append elements {
    link_vedi {
	link_url_col edit_url  
	display_template {@docu.link_vedi_title;noquote@}
    }
    cod_documento {
	label "Cod. Docu"
    }
    descr_tipo {
	label "Tipo documento"
    }
    data_documento_edit {
	label "Data documento"
    }
    cod_impianto_est {
	label "Impianto"
    }
    nominativo_resp {
	label "Responsabile"
    }
    denom_comune {
	label "Comune Ubic."
    }
    descrizione {
	label "Descrizione"
    }
    data_notifica_edit {
	label "Data Not./Con."
    }
}

db_1row -dbn $dbn_iter query "select flag_portafoglio,flag_gest_targa from coimtgen "

if {$flag_gest_targa eq "F"} {
    set where_aimp "and c.cod_impianto=:cod_impianto"
} else {
    set where_aimp "and c.targa = :targa"
}


template::list::create \
    -name docu \
    -multirow docu \
    -actions $actions \
    -elements $elements

    db_multirow -dbn $dbn_iter -extend {link_vedi link_vedi_title edit_url} docu query "
select a.cod_documento
     , iter_edit_data(a.data_stampa) as data_stampa_edit
     , iter_edit_data(a.data_documento) as data_documento_edit
     , iter_edit_data(a.data_notifica) as data_notifica_edit
     , a.descrizione
     , b.descrizione as descr_tipo
     , c.cod_impianto_est
     , coalesce(d.cognome,'')||' '||coalesce(d.nome,'') as nominativo_resp
     , e.denominazione as denom_comune
     , coalesce(k.cognome, '') || '-' ||coalesce(a.descrizione,'') as descrizione
     , contenuto --rom01
  from coimdocu a
  left outer join coimtdoc b on b.tipo_documento = a.tipo_documento
  left outer join coimaimp c on c.cod_impianto   = a.cod_impianto
  left outer join coimcitt d on d.cod_cittadino  = a.cod_soggetto
  left outer join coimcomu e on e.cod_comune     = c.cod_comune
  left outer join coimmanu k on k.cod_manutentore = a.cod_soggetto
  where 1=1 --c.targa=:targa
    $where_aimp
    and a.tipo_documento='AV' --sandro al momento vuole visualizzare solo gli avvisi di verifica
" {
    if {![string is space $contenuto]} {#rom01 Aggiunta if ma non il suo contenuto
	set edit_url   [export_vars -base "documenti-view" {cod_documento dbn_iter targa}]
	set link_vedi_title "Vedi";#rom01
    } else {#rom01 Aggiunta else e il suo contenuto
	set edit_url        ""
	set link_vedi_title ""
    }

  }

