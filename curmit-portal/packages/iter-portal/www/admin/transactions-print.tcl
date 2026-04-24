ad_page_contract {

    @author          Gacalin Lufi & Luca Romitti  
    @creation-date   05/10/2017

    @param funzione  I=insert M=edit D=delete V=view
    @param caller    caller della lista da restituire alla lista:
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz identifica l'entrata di menu, server per le autorizzazioni
                     serve se lista e' uno zoom che permetti aggiungi.
    @param nome_funz_caller identifica l'entrata di menu, serve per la 
                     navigazione con navigation bar
    @param extra_par Variabili extra da restituire alla lista
    @cvs-id          coimtarg-layout.tcl

    USER  DATA       MODIFICHE
    ===== ========== ================================================================================================
    rom02 19/10/2023 Corretto il filtro per nome manutentore. Aggiunta colonna con nome della ditta di manutenzione.
    rom02            Corretti vari errori nell'impostazione delle table, tr e td.

    rom01 28/02/2020 Passo il parametro -dbn alla proc iter_get_coimdesc per leggre i dati dell'ente e non del portale.

    sim01 28/01/2019 Corretto errore gac03.

    gac05 23/01/2019 Aggiunta colonna Contributo regionale dopo Contributo ente locale e Totale da erogare alla regione
    gac05            dopo Totale da erogare all'ente.

    gab01 13/04/2018 Aggiunto filtro sul nome ente in caso di multi-portafoglio
    
    gac04 18/10/2017 Aggiunto contatore righe pagina

    gac03 15/10/2017 Aggiunte colonne: Cod. Op., Importo Storno, Cod. Op. Stornata. 
    gac03            Aggiunta tabella alla fine con totale importo, totale storno e totale differenza.
    gac03            Aggiunto da data emissione a data emissione nel formato 'DD/MM/YYYY' al titolo.

    gac02 13/10/2017 modificata query: aggiunto g.group_id is not null per non visualizzare le operazioni di ricarica
 
    gac01 05/10/2017 Creato programma di stampa movimenti
    
} {
    {f_maintainer_id  ""}
    {f_name           ""}
    {f_group_id       ""}
    {from_date        ""}
    {to_date          ""}
    {from_date_ansi   ""}
    {to_date_ansi     ""}
    {ordtarg_id       ""}
} -properties {
    page_title:onevalue
    context_bar:onevalue
    form_name:onevalue
}


set lvl 1
#set id_utente [lindex [iter_check_login $lvl $nome_funz] 1]
set id_utente [ad_conn user_id]

# Controllo se il Database e' Oracle o Postgres
set id_db     [iter_get_parameter database]

# imposto variabili usate nel programma:
set sysdate_edit  [iter_edit_date [iter_set_sysdate]]

# imposto la directory degli spool ed il loro nome.
set spool_dir       [iter_set_spool_dir]
set spool_dir_url   [iter_set_spool_dir_url]

set logo_dir       "[ns_info pageroot]/resources/img"


# imposto codice Regione Lombardia come utilizzato nei movimenti
set id_regione "3"

# imposto il nome dei file
set nome_file     "stampa movimenti"
set nome_file     [iter_temp_file_name $nome_file]
set file_html     "$spool_dir/$nome_file.html"
set file_pdf      "$spool_dir/$nome_file.pdf"
set file_pdf_url  "$spool_dir_url/$nome_file.pdf"

set file_id       [open $file_html w]
fconfigure $file_id -encoding iso8859-1

# Personalizzo la pagina
set titolo       "Stampa movimenti"
set page_title   "Stampa movimenti"

set logo [parameter::get_from_package_key -package_key iter-portal -parameter stampe_logo_nome]

set height_logo ""

set sw_multi_portafoglio [parameter::get_from_package_key -package_key wallet -parameter sw_multi_portafoglio -default 0];#gab04

if {$sw_multi_portafoglio} {;#gab01 aggiunta if, else e contenuto
    set join_multi_portafoglio "and h.instance_name = m.instance_name"
} else {
    set join_multi_portafoglio ""
}

if {$f_group_id eq ""} {
    set where_instances "1 = 1"
} else {
    set where_instances "instance_id= :f_group_id"
}
    
set dbn_iter [db_string q "select instance_name
                             from iter_instances
                            where $where_instances"];#rom01
#rom01 aggiunto parametro -dbn
iter_get_coimdesc -dbn $dbn_iter
#set nome_ente    $coimdesc(nome_ente)
set nome_ente "Tutti"
db_0or1row q "select group_name as nome_ente
                from groups 
               where group_id=:f_group_id"

set tipo_ufficio $coimdesc(tipo_ufficio)
set assessorato  $coimdesc(assessorato)
set indirizzo    $coimdesc(indirizzo)
set telefono     $coimdesc(telefono)
set resp_uff     $coimdesc(resp_uff)
set uff_info     $coimdesc(uff_info)
set dirigente    $coimdesc(dirigente)

set data_corrente [iter_edit_date [iter_set_sysdate]]
set height_logo "height=60"

#gac03 editata data nel formato giusto come titolo
set from_date_pretty [db_string q "select to_char(:from_date_ansi::date, 'DD/MM/YYYY')"];#gac03
set to_date_pretty   [db_string q "select to_char(:to_date_ansi::date, 'DD/MM/YYYY')"];#gac03

#set utente [db_string query "select first_names ||' '|| last_name from persons where person_id = :editing_user"] 

#set editing_date_pretty [ah::ansi_to_pretty_date $editing_date] 

set testata "

<!-- FOOTER RIGHT  \"Pagina \$PAGE(1) di \$PAGES(1)\"--> <!--#gac04 aggiunte contatore righe pagina-->
<table width=100%>
  <tr>
    <td valign=top align=left>
      <table width=100%>
        <tr>
          <td><small>  $indirizzo
                               <br>$telefono
                               <br>$uff_info
              </small>
          </td>
        </tr>
      </table>
    </td>
    <td align=right>
         <img src=$logo_dir/$logo $height_logo>
    </td>
  </tr>
  <tr>
    <td valign=top align=left colspan=2>
      <table width=100%>
        <tr>
          <td align=center><b>$nome_ente <br>Stampa del $data_corrente Periodo dal $from_date_pretty al $to_date_pretty</td>
        </tr>
      </table>
    </td>
  </tr>
</table>"


puts $file_id $testata

#gac03 aggiunte colonne Cod. op., Importo Storno, Cod. op. Stornata
#gac05 aggiunta colonna Contributo Regionale
puts $file_id "
    <table width=100% border=1>
    <tr>
        <th><small>Cod. op.</small></th>
	<th><small>Cod. manu.</small></th> <!-- rom02 -->
        <th><small>Manutentore</small></th>
        <th><small>Codice impianto</small></th>
        <th><small>Potenza (Kw)</small></th>
        <th><small>Stato</small></th>
        <th><small>Contributo Ente Locale</small></th>
        <th><small>Contributo Regionale</small></th>
        <th><small>Importo storno</small></th>
        <th><small>Causale storno</small></th>
        <th><small>Cod. op. stornata</small></th>
    </tr>"


if {$f_maintainer_id eq ""} { 
    set where_maintainer_id ""
} else {
    set where_maintainer_id " and 'MA' || lpad(cast(h.holder_id as varchar(10)),6,0) = :f_maintainer_id"
}
if {$f_name eq ""} {
    set where_name ""
} else {
    set f_name2 [db_quote $f_name];#rom02
    #rom02set where_name " and  h.name = :f_name"
    set where_name " and  upper(h.name) like upper('%$f_name%')"
}
if {$f_group_id eq ""} {
    set where_f_group_id ""
} else {
    set where_f_group_id " and group_id = :f_group_id"
}
if {$from_date eq ""} {
    set where_from_date ""
} else {
    set where_from_date " and m.creation_date >= :from_date_ansi"
}
if {$to_date eq ""} {
    set where_to_date ""
} else {
    set where_to_date " and m.creation_date <= :to_date_ansi"
}

set filters {
    {f_maintainer_id
	hide_p 1
    }
    {f_name
	hide_p 1
    }
    {f_group_id
	hide_p 1
    }
    {from_date
        hide_p 1
    }
    {to_date
        hide_p 1
    }
    {ordtarg_id
        hide_p 1
    }
}

set cened_source_id [db_string cened "select source_id from wal_sources where source_name = 'CENED'"]
set ctr 0
set tot_imp_storno 0;#gac03
set tot_imp 0;#gac03
set tot_diff 0;#gac03
set tot_imp_contr_reg 0;#gac05
set tot_imp_pretty 0;#sim01
set tot_imp_storno_pretty 0;#sim01
set tot_diff_pretty 0;#sim01
set tot_imp_contr_reg_pretty 0;#sim01

#gac02 aggiunto nella where g.group_id is not null per non visualizzare le operazioni di ricarica
db_foreach q "select m.tran_id,   --gac03
                     m.holder_id,          
                     m.body_id as body_id_multi,
                     m.tran_type_id,      
                     m.pay_type_id,       
                     m.payment_date,      
                     m.creation_date,     
                     m.currency_date,     
                     m.description,       
                     m.reference,         
                     m.amount,            
                     m.currency,          
                     m.currency_amount,   
                     m.filename,          
                     m.reason,              
                     m.ref_tran_id,       
                     m.status,              
                     m.num_reversale,     
                     m.anno_reversale,    
                     m.cro,               
                     m.num_ordine,        
                     'MA' || lpad(cast(h.holder_id as varchar(10)),6,0) as manutentore,
                     h.name, h.source_id
                    ,h.wallet_id
                    , case when status = 'L' then 'In lavorazione'
                     when status = 'A' then 'Accreditato'
                     when status = 'K' then 'Annullato'
                     end as status_desc
               from wal_transactions m
          left join iter_instances i 
                 on i.instance_name = split_part(m.reference,' ',2)
          left join groups g 
                 on i.instance_id = g.group_id
                  , wal_holders h
              where m.holder_id = h.holder_id
                  $join_multi_portafoglio  --gab01
    --            and g.group_id is not null --gac02
             $where_maintainer_id
             $where_name
             $where_f_group_id
             $where_from_date
             $where_to_date

" {
    set cod_impianto_est ""
    set potenza          ""

    set tot_imp_storno    0
    set importo_storno    0
    set importo           0
    set importo_contr_reg 0

    if {[llength $reference] == 2 && [string range [lindex $reference 1] 0 3] eq "iter"} {
	# dovrebbe essere un movimento generato da iter
	util_unlist $reference cod_dimp dbn
	
	# determino l'ente di competenza in base all'istamza Iter
	set group_id [db_string ente "
                select g.group_name
                from iter_instances i, groups g
                where i.instance_name = :dbn
                  and i.instance_id   = g.group_id" -default ""]
    	
	# leggo i dati da iter, se ho ottenuto un dbn
	if {$dbn ne ""} {
	    
	    if {![db_0or1row -dbn $dbn iter "
                select i.cod_impianto_est || '/' || cod_dimp as cod_impianto_est 
                   --i.cod_impianto_est
                      , i.potenza
                from coimdimp d, coimaimp i
                where d.cod_dimp         = :cod_dimp
                  and d.cod_impianto     = i.cod_impianto
                "]} {
		
		# prendo l'impianto passando da coimdimp_stn se coimdimp è stato stornato
		if {![db_0or1row -dbn $dbn iter "
                            select i.cod_impianto_est
                                  , i.potenza
                              from coimdimp_stn d, coimaimp i
                             where d.cod_dimp         = :cod_dimp
                               and d.cod_impianto     = i.cod_impianto
                    "]} {
		    # scarto i movimenti provenienti da iter per i quali non trovo l'impianto
		    # B80 *** 07/07/2010 andrebbe commentato il continue in modo da visualizzare i movimenti che corrispondono a dichiarazioni non inserite - DB CRASH
		    # continue
		}
	    }
	} else {
	    
	    # scarto i movimenti provenienti da iter per i quali non dispongo del database
	    continue
	}

	#gac03 aggiunto importo storno, importo (contributo ente locale), totale importo storno, tot importo e totale differenza
	if {$tran_type_id == 1 && $body_id_multi != "" && $body_id_multi != 3} {#gac03 if else e loro contenuto
	    set tot_imp_storno [expr $tot_imp_storno + $amount]
	    set importo_storno    $amount
	    set importo           ""
	    set importo_contr_reg "";#gac05
	} else {
	    #gac05 aggiunta if else e contenuto di if per valorizzare le colonne contributo regionale e Totale da erogare alla regione
	    if {$body_id_multi eq $id_regione} {
                if {$tran_type_id == 1} {
                    set tot_imp_storno [expr $tot_imp_storno + $amount]
                    set importo_storno    $amount
                    set importo           ""
                    set importo_contr_reg "";#gac05
                } else {
                    set tot_imp_contr_reg [expr $tot_imp_contr_reg + $amount]
                    set importo_contr_reg $amount
                    set importo           ""
                    set importo_storno    ""
                }
	    } else { 
		set tot_imp [expr $tot_imp + $amount]
		set importo           $amount
		set importo_storno    ""
		set importo_contr_reg "";#gac05
	    }
	}
	
	set tot_diff [expr $tot_imp - $tot_imp_storno];#gac03
    
    }

    if {$source_id eq "$cened_source_id"} {
	set cod_impianto_est $reference
    }

    # edito date e campi numerici
    set tot_imp_storno_pretty [ah::edit_num $tot_imp_storno 2]; #gac03
    set importo_storno_pretty [ah::edit_num $importo_storno 2]; #gac03
    set importo_pretty [ah::edit_num $importo 2]; #gac03
    set tot_imp_pretty [ah::edit_num $tot_imp 2]; #gac03
    set tot_diff_pretty [ah::edit_num $tot_diff 2]; #gac03
    set amount_pretty [ah::edit_num $amount 2]
    set payment_date  [string range $payment_date 8 9]/[string range $payment_date 5 6]/[string range $payment_date 0 3]
    set currency_date [string range $currency_date 8 9]/[string range $currency_date 5 6]/[string range $currency_date 0 3]
    set tot_imp_contr_reg_pretty [ah::edit_num $tot_imp_contr_reg];#gac05
    set importo_contr_reg_pretty [ah::edit_num $importo_contr_reg];#gac05

    if {$tran_type_id == 1} {
	# ricarica
	set amount_plus          $amount_pretty
	set amount_minus_regione ""
	set amount_minus_ente    ""
	set amount_minus_regione_c ""
	
	# isolo il canale di provenienza
	if {[string range $filename 0 4] eq "LOTTO"} {
	    set canale "Lottomatica"
	} elseif {[string range $filename 0 2] eq "RH_"} {
	    set canale "Bonifico"
	} else {
	    set canale "Non definito"
	}
    } else {
	set amount_plus_pretty ""
	if {$body_id_multi == $id_regione} {
	    if {$description eq "CONGUAGLIO"} {
		set amount_minus_regione_c $amount_pretty
		set amount_minus_regione ""
	    } else {
		set amount_minus_regione $amount_pretty
		set amount_minus_regione_c ""
	    }
	    set amount_minus_ente    ""
	    
	} else {
	    set amount_minus_regione ""
	    set amount_minus_regione_c ""
	    set amount_minus_ente    $amount_pretty
	}
    }  
    incr ctr
    
    if {[string is space $tran_id]} {; #gac03 aggiunta colonna cod. op
        set tran_id        "&nbsp;"
    }

    if {[string is space $manutentore]} {
	set manutentore        "&nbsp;"
    }

    if {[string is space $name]} {
        set name        "&nbsp;"
    }

    if {[string is space $cod_impianto_est]} {
	set cod_impianto_est "&nbsp;"
    }
    
    if {[string is space $potenza]} {
	set potenza       "&nbsp;"
    }

    #gac03 if {[string is space $amount_minus_ente]} {
	#gac03 set amount_minus_ente       "&nbsp;"
    #gac03}    

    if {[string is space $status_desc]} {
	set status_desc        "&nbsp;"
    }
    if {[string is space $importo_storno_pretty]} {; #gac03 aggiunta colonna importo stornato
        set importo_storno_pretty       "&nbsp;"
    }
    if {[string is space $importo_pretty]} {; #gac03 aggiunta colonna importo
        set importo_pretty       "&nbsp;"
    }
    if {[string is space $reason]} {
	set reason        "&nbsp;"
    }
    if {[string is space $ref_tran_id]} {; #gac03 aggiunta colonna cod. op. stornata
        set ref_tran_id        "&nbsp;"
    }

    #gac05 aggiunto importo_contr_reg_pretty
    puts $file_id  "
 <tr>
        <td valign=top align=center><small>$tran_id</small></td>
        <td valign=top align=center><small>$manutentore</small></td>
        <td valign=top align=center><small>$name</small></td> <!-- rom02 -->
        <td valign=top align=center><small>$cod_impianto_est</small></td>
        <td valign=top align=center><small>$potenza</small></td>
        <td valign=top align=center><small>$status_desc</small></td>
        <td valign=top align=center><small>$importo_pretty</small></td>
        <td valign=top align=center><small>$importo_contr_reg_pretty</small></td>
        <td valign=top align=center><small>$importo_storno_pretty</small></td>
        <td valign=top align=center><small>$reason</small></td>
        <td valign=top align=center><small>$ref_tran_id</small></td>
    </tr>   
"
}

#gac03 creata tabella con totale Contributo Ente Locale, totale importo stornato e totale differenza
#gac05 aggiunto Totale da erogare alla regione e tot_imp_contr_reg_pretty 
puts $file_id "
<table width=100% border=1>
 <tr>
  <th><small>Contributo Ente Locale</small></th>
  <th><small>Importo Storno</small></th> 
  <th><small>Totale da erogare all'Ente</small></th>
  <th><small>Totale da erogare alla regione</small></th>
 </tr>
 <tr>
  <td valign=top align=center><small>$tot_imp_pretty</small></td>
  <td valign=top align=center><small>$tot_imp_storno_pretty</small></td>
  <td valign=top align=center><small>$tot_diff_pretty</small></td>
  <td valign=top align=center><small>$tot_imp_contr_reg_pretty</small></td>
 </tr>
</table>

"

close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0.5cm --footer ... --bottom 0cm --landscape -f $file_pdf $file_html]

ns_unlink $file_html
ad_returnredirect $file_pdf_url
ad_script_abort
