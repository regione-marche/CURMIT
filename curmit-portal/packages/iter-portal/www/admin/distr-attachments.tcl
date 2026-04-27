ad_page_contract {  
    Attachments list

    @author Simone Pesci

    @cvs-id index.tcl 

    USER  DATA       MODIFICHE
    ===== ========== ======================================================================================
    mat03 04/11/2025 Tolto il link al file csv caricato dal fornitore e la descrizione.Aggiunto un pulsante
    mat03            per scaricare in csv le righe mostrate a video. Modifica fatta perchè nel file csv
    mat03            vengono inserite righe riferite a enti diversi e ogni ente deve vedere le proprie.

    mat02 16/04/2025 Corretto il link dell'estrazione in xml

    mat01 24/03/2025 Aggiunto upper nella condizione where del comune in ls_supplies perchè nel db di produzione
    mat01            alcuni nomi sono tutti maiuscoli e altri no.

    but01 15/04/2024 MEV04:step1 aggiunto la lista fornitura con tutti i campi existe nel tracciate
    but01            modificato il file adp con il link di tornare indietro ala lista di filtri.

    rom02 12/10/2021 Sandro ha chiesto di aggiungere anche il nome del distributore altrimenti non si capisce
    rom02            di chi è la fornitura caricata.

    rom01 11/10/2021 Corretto errore sulla multirow: va creata prima della foreach sulla iter_distributors. 

} {
    {f_name_distributor ""}
    {f_comune      ""}
    body_id:optional
    {f_combustibile      ""}
    {f_competente        ""}
    {f_anno_rif          ""}
    {format         "normal"}
    {rows_per_page  "30"}
    {offset         "0"}

    orderby:optional

}

set user_id [auth::require_login]


set package_id [ad_conn package_id]

# get file-storage package id
array set node [site_node::get -url /file-storage]
set package_id $node(package_id)

# get the root folder of the file-storage instance
set folder_id [fs::get_root_folder -package_id $package_id]

set return_url   [ad_conn url]?[ad_conn query]

# grabs all vars 
set url_vars [export_ns_set_vars "url" {}]

set base_url [ad_conn url]
ad_form \
    -name filter \
    -edit_buttons [list [list "Go" go]] \
    -form {
	{f_anno_rif:text,optional
	    {label {Anno}}
	    {value $f_anno_rif}
	}
	{f_name_distributor:text,optional
	    {label {Distributore}}
	    {value $f_name_distributor}
	}
	{f_comune:text,optional
	    {label {Comune}}
	    {value $f_comune}
	}
	    {f_combustibile:text(select),optional
                {options { {"Scegli" ""} [db_list_of_lists q "
                                        select tipo_combustibile
                                              , codice_combustibile
                                         from iter_combustibili"]}}
		{label {Combustibile}}
		    {value $f_combustibile}
	    }
	{f_competente:text(select)
	    {options { {"Scegli" ""} [db_list_of_lists query "
            select g.group_name, i.instance_name
              from groups g, iter_instances i
             where g.group_id = i.instance_id
            "] }}
		{label {Autorità competente}}
		{value $f_competente}
	    }
	    
 } -on_request {

    } -on_submit {

	set errnum 0
	if {$f_competente eq ""} {
	    template::form::set_error filter f_competente "selezionare Autorità competente"
	    incr errnum
	}

	if {$errnum > 0} {
	    break
	} else {
	    # per evitare errori nell'esecuzione della query la eseguirò solo se 'errnum' non esiste
	    unset errnum
	    # imposto flag per sapere se il form è stato inviato
	    set submit_p 1
	}
	# recupero l'impostazione dei filtri non compresi nel form
	ah::set_list_filters iter-portal admin/distr-attachments

    }
set actions ""
set link_gest [export_url_vars f_anno_rif f_name_distributor f_comune  f_combustibile f_competente]
#mat02 set link_actions {<a href="supplies-scar-xml?$link_gest&format=xml" class="button" download="scarica_forniture.xml">Estrai in xml</a>}
set link_actions "<a href=\"supplies-scar-xml?$link_gest&format=xml\" class=\"button\" download=\"scarica_forniture.xml\">Estrai in xml</a> \
                  <a href=\"supplies-scar-xml?$link_gest&format=csv\" class=\"button\" download=\"scarica_forniture.csv\">Estrai in csv</a>" ;#mat03 aggiunto link per csv #mat02
#append actions "{Estrai in xml} supplies-scar-xml?$link_gest&format=xml {Estrai in xml}"

#mat03 tolto dagli elements della lista
#name {
#    label "Nome fornitura"
#    link_url_col view_url
#    link_html {title "Visualizza fornitura"}
#}
#description {
#    label "Descrizione"
#}
template::list::create \
    -name attachments \
    -multirow attachments \
    -actions $actions \
    -elements {
	name_distributor {
	    label "Distributore"
	}
	ente_riferimento {
	    label "Ente locale di riferim."
	    html "align left"
	}
	publish_date {
	    label "Data caricamento"
	    html "align center"
	}
	anno_rif {
	    label "Anno riferimento"
	}
	natura_giurid {
	    label "Ragione Socialedell'utente<br>dell'utente"
	}
	utente_cogn_rag_soc { 
	    label "Cognome dell'utente"
	}
        utente_nome {
	    label "Nome dell'utente"
	}
	utente_cf {
	    label "Codice fiscale dell'utente"
	}
	utente_piva {
	    label "Partita Iva dell'utente"
	}
	toponimo_tipo {
	    label "Tipo toponimo"
	}
        toponimo_nome {
	    label "Nome toponimo"
	}
        toponimo_civico {
	    label "Civico"
	    html {align right}
	}
        toponimo_cap {
	    label "Cap"
	}
        comune_nome {
	    label "Comune"
	    html {align right}
	}
        comune_istat {
	    label "Codice Istat del Comune"
	    html {align right}
	}
        catasto_sezione {
	    label "Sezione"
	    html {align right}
	}
        catasto_foglio {
	    label "Foglio"
	    html {align right}
	}
	catasto_particella {
	    label "Particella"
	    html {align right}
        }
	catasto_subalterno {
	    label "Subalterno"
	}
	pod {
	    label "Codice POD<br>(Point Of Delivery)"
	}
	pdr {
	    label    "Codice PDR<br>(Punto Di Riconsegna)"
	}
        stato_pdr {
            label "Stato PDR"
        }
	matr_contatore {
	    label "N°di matricola contatore"
	    html {align right}
        }
        contratto_tipo {
	    label "Tipo contratto"
	    html {align left}
	}
        combustibile_tipo {
	    label "Combustibile"
	    html {align right}
	}
	combustibile_consumo {
	    label "Consumo annuo"
	    html {align right}
	}
	combustibile_um {
	    label "Unità di misura del consumo"
	    html {align right}
	}
	combustibile_anno {
	    label "Anno del consumo"
	    html {align right}
	}	
    } \
    -filters {
	f_anno_rif {
	    hide_p 1
	    where_clause {anno_rif = :f_anno_rif}
	}
	f_name_distributor {
	    hide_p 1
	    where_clause {upper(d.name) like upper('%$f_name_distributor%')}
	}
       	f_comune {
	    hide_p 1
	    where_clause {upper(comune_nome) like upper('%$f_comune%')}
	}
	f_combustibile {
	    hide_p 1
	    where_clause {combustibile_tipo = :f_combustibile}
	}
	f_competente {
	    hide_p 1
	    where_clause {i.instance_name = :f_competente}
	}
    rows_per_page {
	label "Righe per pagina"
	values {{10 10} {30 30} {100 100} {Tutte 999999}}
	default_value 30
    }
    }
#
## get existing attachments 
#rom02multirow create attachments attachment_id name view_url description publish_date;#rom01
#but01 aggiunto la lista di campi nel file cvs alla lista di fornitura.
#mat03 tolto view_url e description
multirow create attachments attachment_id name name_distributor ente_riferimento publish_date anno_rif natura_giurid utente_cogn_rag_soc utente_nome utente_cf utente_piva toponimo_tipo toponimo_nome toponimo_civico toponimo_cap comune_nome comune_istat catasto_sezione catasto_foglio catasto_particella catasto_subalterno pdr pod stato_pdr matr_contatore contratto_tipo combustibile_tipo combustibile_consumo combustibile_um combustibile_anno;#rom02
#rom02set ls_distributori [db_list q "select distributor_id from iter_distributors"]
set ls_distributori [db_list_of_lists q "select distributor_id
                                              , d.name 
                                         from iter_distributors d"]
#rom02foreach object_id $ls_distributori {}

foreach distributore $ls_distributori {;#rom02
    
    util_unlist $distributore object_id name_distributor;#rom02
    set attach_list [attachments::get_all_attachments -object_id $object_id -base_url /iter-portal/]
    
    #ns_log notice "\nattachments.tcl $attach_list"
    # attach_list is a list of lists where each row contains 1.attachment_id 2.name
    # and 3.url of the attachment
    #rom01multirow create attachments attachment_id name view_url description publish_date
   
    foreach attachment $attach_list {
	
	#sim01 util_unlist $attachment attachment_id name approved_p view_url 
	
	util_unlist $attachment attachment_id name view_url detach_url;#sim01
      
	set approved_p [db_string check "select coalesce(approved_p,'f')  from attachments where object_id = :object_id and item_id = :attachment_id"]

	if {!$approved_p} {
	    continue
	}
#	db_1row query "
#   select description, 
#          to_char(cr.publish_date,'DD/MM/YYYY') as publish_date
#       from cr_items ci
#         , cr_revisions cr
#     where ci.item_id   = :attachment_id 
#      and ci.live_revision = cr.revision_id"

#but01 aggiunto la lista di forniture.
	set ls_supplies [db_list_of_lists q "
                                select distinct
                                       anno_rif
                                     , natura_giurid
                                     , utente_cogn_rag_soc
                                     , utente_nome
                                     , utente_cf
                                     , utente_piva
                                     , toponimo_tipo
                                     , toponimo_nome
                                     , toponimo_civico
                                     , toponimo_cap
                                     , comune_nome 
                                     , comune_istat
                                     , catasto_sezione
                                     , catasto_foglio
                                     , catasto_particella
                                     , catasto_subalterno
                                     , pdr
                                     , pod
                                    -- , stato_pdr
                                     , case when stato_pdr = '1' then 'In prelievo'
                                         else 'Sospeso'
                                        end as stato_pdr
                                     , matr_contatore
                                     , contratto_tipo
                                     , b.tipo_combustibile as combustibile_tipo
                                     , combustibile_consumo
                                    -- , combustibile_um
                                     , case when combustibile_um = '1' then 'Litri'
                                            when combustibile_um = '2' then 'KG'
                                            when combustibile_um = '3' then 'm3'
                                            when combustibile_um = '4' then 'kwh'
                                         end as combustibile_um
                                     , combustibile_anno
                                     , cr.description as description
                                     , to_char(cr.publish_date,'DD/MM/YYYY') as publish_date
                                     , g.group_name as ente_riferimento
                                   from iter_supplies_sync s
                                     , attachments        a
                                     , cr_items           ci
                                     , cr_revisions       cr
                                     , iter_comuni        c
                                     , groups             g
                                     , iter_instances     i
                                     , iter_distributors  d
                                     , iter_combustibili b
                                 where s.distributor_id = a.object_id
                                   and a.item_id        = :attachment_id
                                   and s.item_id        = a.item_id
                                   and ci.item_id       = :attachment_id
                                   and ci.live_revision = cr.revision_id
                                   and UPPER(s.comune_nome)    = UPPER(c.denominazione) --mat01 aggiunto upper
                                   and c.body_id        = g.group_id
                                   and g.group_id       = i.instance_id
                                   and s.distributor_id = d.distributor_id
                                   and b.codice_combustibile = s.combustibile_tipo
                                  [template::list::filter_where_clauses -name attachments -and]
                                  "];#but02
	
	
	foreach supplies $ls_supplies {#but02 aggiunto foreach e suo contenuto
	    util_unlist $supplies anno_rif natura_giurid utente_cogn_rag_soc utente_nome utente_cf utente_piva toponimo_tipo toponimo_nome toponimo_civico toponimo_cap comune_nome comune_istat catasto_sezione catasto_foglio catasto_particella catasto_subalterno pdr pod stato_pdr matr_contatore contratto_tipo combustibile_tipo combustibile_consumo combustibile_um combustibile_anno description publish_date ente_riferimento 
	    #rom02multirow append attachments $attachment_id $name $view_url $description $publish_date
            #but01 aggiunto i campi di file cvs alla lista di fornitura.
	    #mat03 tolto view_url e descriptions
	multirow append attachments $attachment_id $name $name_distributor $ente_riferimento $publish_date $anno_rif $natura_giurid $utente_cogn_rag_soc $utente_nome $utente_cf $utente_piva $toponimo_tipo $toponimo_nome $toponimo_civico $toponimo_cap $comune_nome $comune_istat $catasto_sezione $catasto_foglio $catasto_particella $catasto_subalterno $pdr $pod $stato_pdr $matr_contatore $contratto_tipo $combustibile_tipo $combustibile_consumo $combustibile_um $combustibile_anno;#rom02
       
	}
    }
}
