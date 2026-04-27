ad_page_contract {

    @author          Serena Saccani
    @creation-date   21.09.2012

    @cvs-id          maintainer-print.tcl

    USER  DATA       MODIFICHE
    ===== ========== ===============================================================================
    rom03 17/05/2023 I campi patentino_op e patentino_fgas_op vanno gestiti per tutti e non solo per le Marche.

    rom02 19/10/2020 Per il logo dell'ente uso il parametro stampe_logo_nome del package iter-portal.
    rom02            Per il nome dell'ente uso il campo nome_ente della coimdesc.
    rom02            In questo modo il programma non va cablato per ogni ente.
    
    rom01 14/11/2018 Cablata la stampa per iter-portal-marche

    gac01 29/05/2018 Aggiunti campi carta di identita solo per regione marche

    gab02 13/04/2018 Rivista stampa che non riportava tutte le informazioni inserite in fase di 
    gab02            registrazione.

    gab01 20/07/2017 Aggiunti campi: pec, albo_artigiani

} {
    {maintainer_id   ""}
}

# Controlla lo user
set id_utente [auth::require_login]
if {$maintainer_id eq ""} {
#    set maintainer_id [iter::script_init -approved_par "t"]
    set maintainer_id [iter::script_init]
    if {[string equal $maintainer_id "0"]} {
	ad_returnredirect services
	ad_script_abort
    }
}

set db_name [db_get_database]

# imposto variabili usate nel programma:
set sysdate_edit  [iter_edit_date [iter_set_sysdate]]

# imposto la directory degli spool ed il loro nome.
set spool_dir     [iter_set_spool_dir]
set spool_dir_url [iter_set_spool_dir_url]
set logo_dir      [iter_set_logo_dir]

# imposto il nome dei file
set nome_file     "SchedaManutentore"
set nome_file     [iter_temp_file_name $nome_file]
set file_html     "$spool_dir/$nome_file.html"
set file_pdf      "$spool_dir/$nome_file.pdf"
set file_pdf_url  "$spool_dir_url/$nome_file.pdf"

set file_id       [open $file_html w]
#fconfigure $file_id -encoding iso8859-1
fconfigure $file_id -encoding iso8859-15

# Personalizzo la pagina
set titolo     "Scheda Manutentore"
set page_title "Scheda Manutentore"

set img_url [iter_set_logo_dir]
set img_checked "<img src=\"$img_url/checked.bmp\" height=12 width=12>"
set img_unchecked "<img src=\"$img_url/unchecked.bmp\" height=12 width=12>"


# leggo dati del manutentore
db_1row get_maintainer "
 select m.name
      , m.address1
      , m.address2
      , m.city
      , m.province
      , m.zipcode
      , m.fiscal_code
      , m.iva_code
      , m.phone
      , m.mobile
      , m.email
      , m.pec -- gab01
      , m.fax
      , m.associated_to
      , m.where_registered
      , m.registration_no
      , m.where_rea
      , m.rea_no
      , m.albo_artigiani -- gab01
      , m.capital
      , m.representative_id
      , m.notes
      , m.iter_code
      , m.company_type
      , m.op_number
      , m.an_number
      , m.de_number
      , m.cait_id
      , m.wallet_id
      , m.cc_name
      , ah_edit_num(m.op_number::double precision, 0) as op_number_pretty
      , ah_edit_num(m.an_number::double precision, 0) as an_number_pretty
      , ah_edit_num(m.de_number::double precision, 0) as de_number_pretty
      , ah_edit_num(m.capital, 2)                     as capital_pretty
      , case m.role
            when '0' then 'Installatore'
            when '1' then 'Manutentore'
            when '2' then 'Installatore/Manutentore'
            when '3' then 'Manut/Inst solo Clim.Estiva'
            when '4' then 'Manut/Inst Biomassa solo Legnosa'
        end                          as role_pretty
      , p.name                       as rep_name
      , p.first_name                 as rep_first_name
      , p.address1                   as rep_address1
      , p.city                       as rep_city
      , p.address2                   as rep_address2
      , p.province                   as rep_province
      , p.zipcode                    as rep_zipcode
      , p.fiscal_code                as rep_fiscal_code
      , case when m.patentino = 'f' then 'NO' else 'SI' end as patentino
      , case when m.patentino_fgas = 'f' then 'NO' else 'SI' end as patentino_fgas
      , case when :db_name = 'iter-portal-marche' and p.patentino = 't' then 'Si'
             when :db_name = 'iter-portal-marche' and p.patentino = 'f' then 'No'
             else '' end as patentino_rapp

      , case when :db_name = 'iter-portal-marche' and p.patentino_fgas = 't' then 'Si'
             when :db_name = 'iter-portal-marche' and p.patentino_fgas = 'f' then 'No'
             else '' end as patentino_fgas_rapp

      , case when m.la = 't' then 'a' else '' end as la
      , case when m.lb = 't' then 'b' else '' end as lb
      , case when m.lc = 't' then 'c' else '' end as lc
      , case when m.ld = 't' then 'd' else '' end as ld
      , case when m.le = 't' then 'e' else '' end as le
      , case when m.lf = 't' then 'f' else '' end as lf
      , case when m.lg = 't' then 'g' else '' end as lg
      , m.uni_iso
      , m.altre_certificazioni
      , case when m.visualizza_company = 't' then 'Si'
             when m.visualizza_company = 'f' then 'No'
             else '' end as visualizza_company
      , p.tipo_doc_identita                                                                  --gac01
      , p.num_doc_identita                                                                   --gac01
      , p.ente_rilascio_doc_identita                                                         --gac01
      , iter_edit_data(p.data_rilascio_doc_identita) as data_rilascio_doc_identita           --gac01
      , iter_edit_data(p.data_fine_validita_doc_identita) as data_fine_validita_doc_identita --gac01
   from iter_maintainers m
      , iter_parties p
  where m.representative_id = p.party_id
    and maintainer_id       = :maintainer_id"

set impianti_lettere ""

set img_la $img_unchecked
set img_lb $img_unchecked
set img_lc $img_unchecked
set img_ld $img_unchecked
set img_le $img_unchecked
set img_lf $img_unchecked
set img_lg $img_unchecked

if {$la ne ""} {
    append impianti_lettere "$la - "
    set img_la $img_checked
}

if {$lb ne ""} {
    append impianti_lettere "$lb - "
    set img_lb $img_checked
}

if {$lc ne ""} {
    append impianti_lettere "$lc - "
    set img_lc $img_checked
}

if {$ld ne ""} {
    append impianti_lettere "$ld - "
    set img_ld $img_checked
}

if {$le ne ""} {
    append impianti_lettere "$le - "
    set img_le $img_checked
}

if {$lf ne ""} {
    append impianti_lettere "$lf - "
    set img_lf $img_checked
}

if {$lg ne ""} {
    append impianti_lettere "$lg - "
    set img_lg $img_checked
}

if {$impianti_lettere ne ""} {
    set impianti_lettere [string range $impianti_lettere 0 [string length $impianti_lettere]-4]    
}


if {[string match "*iter-portal-marche*" $db_name]} {
    set label_ruolo "Tipologia di attivit&agrave;"
} else {
    set label_ruolo "Ruolo"
}


set tipologie_impianti_html ""
set tipologie_dichiarazione_marche ""
if {[string match "*iter-portal-marche*" $db_name]} {

    append tipologie_impianti_html "
             
               <tr>
                 <td colspan=2>&nbsp;</td>
               </tr>
               <tr>
                 <td colspan=2><b>Tipologia degli impianti su cui l'impresa opera</b></td>
               </tr>

    "

    set tipologie_dichiarazione_marche "-che la ditta sopra citata opera sulle seguenti tipologie di impianto, per le quali è in possesso dei requisiti previsti dal DM 37/08:<br>"

    set tip_imp_list [db_list_of_lists q "select a.installation_type_description
                                               , case when b.maintainer_id is null then 'NO' 
                                                 else 'SI' end as installation_maintainer_y_n
                                            from iter_installation_types a
                                       left join iter_maintainer_installations b
                                              on a.installation_type_id= b.installation_type_id
                                             and b.maintainer_id = :maintainer_id"]

    foreach tip_imp $tip_imp_list {
	util_unlist $tip_imp installation_type_description installation_maintainer_y_n

	if {$installation_maintainer_y_n eq "SI"} {
	    append tipologie_dichiarazione_marche "<br>&nbsp;&nbsp;&nbsp;-$installation_type_description<br>"
	}

	append tipologie_impianti_html "
                       
               <tr>
                 <td width=50%>$installation_type_description</td>
                 <td width=50%>$installation_maintainer_y_n</td>
               </tr> 

        "
    }
}

set dichiarazione_marche "<!--rom01<!-- PAGE BREAK 
<br> -->
<br>
Il sottoscritto $rep_name $rep_first_name in qualità di rappresentante legale della ditta $name, codice fiscale: $fiscal_code P.IVA: $iva_code con sede in via/piazza $address1, a $city $province, iscritta al Registro delle Imprese di $where_registered con il n. $registration_no, N. REA $where_rea, N. iscrizione all'Albo Artigiani $albo_artigiani,<br>
<br>
consapevole che la dichiarazione mendace e la falsità in atti costituiscono reati ai sensi dell'articolo 76 del D.P.R. 445/2000 e comportano l'applicazione della sanzione penale <b>dichiara</b>:<br>
<br>
<br>
- che la ditta sopra citata è abilitata ad operare per gli impianti di cui alle lettere<br>
$img_la a<br>
$img_lc c<br>
$img_ld d<br>
$img_le e<br>
dell'articolo 1 della legge 37/08,<br><br>
- che la ditta sopra citata è in possesso dell'ulteriore requisito di:<br>
UNI ISO EN $uni_iso certificazione del Sistema Qualità ai sensi della norma UNI ISO EN<br><br>
"

set stampa_logo_nome [parameter::get_from_package_key -package_key iter-portal -parameter stampe_logo_nome];#rom02
set nome_logo "[ns_info pageroot]/resources/img/$stampa_logo_nome";#rom02
iter_get_coimdesc;#rom02
set nome_ente      $coimdesc(nome_ente);#rom02
set telefono_ente  $coimdesc(telefono);#rom02
set indirizzo_ente $coimdesc(indirizzo);#rom02

set testata "
<table width=100% > 
    <tr>   
      <td align=left width=100%>
        <img height=80 src=$nome_logo>
      </td>
   </tr>
"

if {![string match "*iter-portal-basilicata*" $db_name]} {
append testata "
   <tr>
       <td><font size=6><b>$nome_ente</b></font></td>
   </tr>"
}

append testata "
   <tr>
      <td>&nbsp;</td>
   </tr>
"
if {![string match "*iter-portal-marche*" $db_name]} {
    append testata "
    <tr>
      <td>I dati inseriti vengono resi in forma di autodichiarazione ai sensi del DPR 445/2000 e come tali saranno sottoposti a verifica. La dichiarazione mendace e la falsità in atti costituiscono reati ai sensi dell'articolo 76 del D.P.R. 445/2000 e comportano l'applicazione della sanzione penale. Le informazioni indicate nella presente dichiarazione verranno utilizzate unicamente per le finalità per le quali sono state acquisite.</td>
   </tr>
"
}

append testata "<tr>
      <td>&nbsp;</td>
   </tr>
</table>"

puts $file_id $testata

if {![string match "*iter-portal-marche*" $db_name]} {#rom01 aggiunta if
    puts $file_id "
  <table width=100%>
    <tr>
      <td colspan=2><b>Dati anagrafici</b></td>
    </tr> 
    <tr>
      <td>Ragione sociale</td>
      <td>$name</td>
    </tr> 
    <tr>
      <td>Indirizzo</td>
      <td>$address1</td>
    </tr> 
    <tr>
      <td>Comune</td>
      <td>$city</td>
    </tr> 
    <tr>
      <td>Località</td>
      <td>$address2</td>
    </tr> 
    <tr>
      <td>Provincia</td>
      <td>$province</td>
    </tr> 
    <tr>
      <td>Cap</td>
      <td>$zipcode</td>
    </tr> 
    <tr>
      <td>Codice Fiscale</td>
      <td>$fiscal_code</td>
    </tr>
    <tr>
      <td>P.IVA</td>
      <td>$iva_code</td>
    </tr> 
    <tr>
      <td>Email</td>
      <td>$email</td>
    </tr>
    <tr>
      <td>Pec</td>
      <td>$pec</td>
    </tr> 
    <tr>
      <td>Telefono</td>
      <td>$phone</td>
    </tr> 
    <tr>
      <td>Fax</td>
      <td>$fax</td>
    </tr> 
    <tr>
      <td>Cellulare</td>
      <td>$mobile</td>
    </tr> 
    <tr>
      <td>Località Reg.Imprese</td>
      <td>$where_registered</td>
    </tr> 
    <tr>
      <td>N.Reg.Imprese</td>
      <td>$registration_no</td>
    </tr> 
    <tr>
      <td>Località REA</td>
      <td>$where_rea</td>
    </tr> 
    <tr>
      <td>Num.REA</td>
      <td>$rea_no</td>
    </tr> 
    <tr>
      <td>Albo Artigiani</td>
      <td>$albo_artigiani</td>
    </tr>
    <tr>
      <td>Abilitata ad operare per gli impianti di cui alle lettere</td>
      <td>$impianti_lettere</td>
    </tr>
    <tr>
      <td>UNI ISO EN</td>
      <td>$uni_iso</td>
    </tr>
    <tr>
      <td>Patentino</td>
      <td>$patentino</td>
    </tr>
    <tr>
      <td>Patentino Fgas</td>
      <td>$patentino_fgas</td>
    </tr>
    <tr>
      <td>Altre abilitazioni</td>
      <td>$altre_certificazioni</td>
    </tr>
    <tr>
      <td>$label_ruolo</td>
      <td>$role_pretty</td>
    </tr> 
    <tr>
      <td>N.Operatori impegnati</td>
      <td>$op_number_pretty</td>
    </tr> 
    <tr>
      <td>N.Analizzatori usati</td>
      <td>$an_number_pretty</td>
    </tr> 
    <tr>
      <td>N.Deprimometri usati</td>
      <td>$de_number_pretty</td>
    </tr> 
    <tr>
      <td>Associazione di riferimento</td>
      <td>$associated_to</td>
    </tr> 
    <tr>
      <td>Capitale versato</td>
      <td>$capital_pretty</td>
    </tr> 
    <tr>
      <td>Note</td>
      <td>$notes</td>
    </tr>
    $tipologie_impianti_html
    <tr>
      <td colspan=2>&nbsp;</td>
    </tr> 
    <tr>
      <td colspan=2><b>Rappresentante legale</b></td>
    </tr> 
    <tr>
      <td>Cognome/Nome</td>
      <td>$rep_name $rep_first_name</td>
    </tr> 
    <tr>
      <td>Indirizzo</td>
      <td>$rep_address1</td>
    </tr> 
    <tr>
      <td>Comune</td>
      <td>$rep_city</td>
    </tr> 
    <tr>
      <td>Località</td>
      <td>$rep_address2</td>
    </tr> 
    <tr>
      <td>Provincia</td>
      <td>$rep_province</td>
    </tr> 
    <tr>
      <td>CAP</td>
      <td>$rep_zipcode</td>
    </tr> 
    <tr>
      <td>Codice Fiscale</td>
      <td>$rep_fiscal_code</td>
    </tr>
"
};#rom01

#rom01 La regione Marche ha chiesto di togliere questa parte
#if {[string match "*iter-portal-marche*" $db_name]} {

#	puts $file_id "
#   <tr>
#      <td>Patentino da conduttore</td>
#      <td>$patentino_rapp</td>
#    </tr>
#    <tr>
#      <td>Patentino Fgas</td>
#      <td>$patentino_fgas_rapp</td>
#    </tr>
#   <tr>
#      <td colspan=2><b>Estremi del documento di identità</b></td>
#    <tr>
#      <td colspan=2>Tipo documento $tipo_doc_identita, N. $num_doc_identita, rilasciato da $ente_rilascio_doc_identita, in data $data_rilasc#io_doc_identita valido fino al $data_fine_validita_doc_identita.
#      </td>
#    </tr> 
#    <tr>
#      <td colspan=2>&nbsp;</td>
#    </tr>

#  </table>
#  <!-- PAGE BREAK --> "
	
#    } else {
	
#	puts $file_id "
#    <tr>
#      <td colspan=2>&nbsp;</td>
#    </tr>
#  </table>
#  <!-- PAGE BREAK --> "

#    }

if {![string match "*iter-portal-marche*" $db_name]} {#rom01 aggiunta if
puts $file_id "
<b>Deprimometri</b>
<font size=1>
  <table width=80% border=1> "
};#rom01
if {![db_0or1row query "select 1 from iter_tools where maintainer_id = :maintainer_id and type = '1' limit 1"]} {
    if {![string match "*iter-portal-marche*" $db_name]} {#rom01 aggiunta if
    puts $file_id "
    <tr>
      <td colspan=4>Nessun record trovato</td>
    </tr>"
    };#rom01
} else {
    set primo_de "t"
    db_foreach query "
  select brand as brand_de, model as model_de, no as no_de, to_char(last_calibration_date, 'DD/MM/YYYY') as last_calibration_date_de_pretty
    from iter_tools
   where maintainer_id = :maintainer_id
     and type = '1'
   order by brand
    " {
	if {![string match "*iter-portal-marche*" $db_name]} {#rom01 aggiunta if
	    if {$primo_de eq "t"} {
		set primo_de "f"
		puts $file_id "
      <tr>
        <td width=20%><b>Marca</b></td>
        <td width=20%><b>Modello</b></td>
        <td width=20%><b>Matricola</b></td>
        <td width=20%><b>Data ultima taratura</b></td>
      </tr>
      <tr>
        <td width=20%>$brand_de</td>
        <td width=20%>$model_de</td>
        <td width=20%>$no_de</td>
        <td width=20%>$last_calibration_date_de_pretty</td>
      </tr>"

	    } else {
		puts $file_id "
      <tr>
        <td width=20%>$brand_de</td>
        <td width=20%>$model_de</td>
        <td width=20%>$no_de</td>
        <td width=20%>$last_calibration_date_de_pretty</td>
      </tr>"
	    }
	};#rom01
    }
}

if {![string match "*iter-portal-marche*" $db_name]} {#rom01 aggiunta if
    puts $file_id "
  </table>
  </font>
  <br>
  <b>Analizzatori di Combustione</b>
  <font size=1>
  <table width=80% border=1>"
}
if {![db_0or1row query "select 1 from iter_tools where maintainer_id = :maintainer_id and type = '0' limit 1"]} {
    if {![string match "*iter-portal-marche*" $db_name]} {#rom01 aggiunta if
	puts $file_id "
    <tr>
      <td colspan=4>Nessun record trovato</td>
    </tr>"
    };#rom01
} else {
    set primo_an "t"
    db_foreach query "
    select brand as brand_an, model as model_an, no as no_an, to_char(last_calibration_date, 'DD/MM/YYYY') as last_calibration_date_an_pretty
      from iter_tools
     where maintainer_id = :maintainer_id
       and type = '0'
     order by brand
    " {
	if {![string match "*iter-portal-marche*" $db_name]} {#rom01 aggiunta if
	    if {$primo_an eq "t"} {
		set primo_an "f"
		puts $file_id "
        <tr>
          <td width=20%><b>Marca</b></td>
          <td width=20%><b>Modello</b></td>
          <td width=20%><b>Matricola</b></td>
          <td width=20%><b>Data ultima taratura</b></td>
        </tr>
        <tr>
          <td width=20%>$brand_an</td>
          <td width=20%>$model_an</td>
          <td width=20%>$no_an</td>
          <td width=20%>$last_calibration_date_an_pretty</td>
        </tr>"
	    } else {
		puts $file_id "
        <tr>
          <td width=20%>$brand_an</td>
          <td width=20%>$model_an</td>
          <td width=20%>$no_an</td>
          <td width=20%>$last_calibration_date_an_pretty</td>
        </tr>"
	    }
	};#rom01
    }
}
if {![string match "*iter-portal-marche*" $db_name]} {#rom01 aggiunta if
puts $file_id "
  </table>
  </font>
  <br>
  <b>Operatori</b>
  <table width=90%>"
};#rom01
if {![db_0or1row query "select 1 from iter_operators where maintainer_id = :maintainer_id limit 1"]} {
    if {![string match "*iter-portal-marche*" $db_name]} {#rom01 aggiunta if
    puts $file_id "
    <tr>
      <td colspan=9>Nessun record trovato</td>
    </tr>"
    };#rom01
    } else {
	set primo_op "t"
	db_foreach query "
    select name as name_op, first_name as first_name_op, iter_no, password, no, fiscal_code as fiscal_code_op
         , coalesce(phone, '&nbsp;') as phone, coalesce(mobile, '&nbsp;') as mobile
         , coalesce(address, '&nbsp;') as address_op, coalesce(notes, '&nbsp;') as notes_op
         , case when :db_name != 'iter-portal-marche' and role = '1' then 'Segreteria'
                when :db_name = 'iter-portal-marche' and role = '1' then 'Delegato del Rappresentante Legale'
                when role = '0' then 'Tecnico' 
                else '' end as op_role
    --rom03, case when :db_name = 'iter-portal-marche' and patentino = 't' then 'Si'
    --rom03       when :db_name = 'iter-portal-marche' and patentino = 'f' then 'No'
    --rom03       else '' end as patentino_op
    --rom03, case when :db_name = 'iter-portal-marche' and patentino_fgas = 't' then 'Si'
    --rom03       when :db_name = 'iter-portal-marche' and patentino_fgas = 'f' then 'No'
    --rom03       else '' end as patentino_fgas_op
          , case when   patentino = 't' then 'Si'      --rom03
                when  patentino = 'f' then 'No'        --rom03
                else '' end as patentino_op            --rom03
          , case when  patentino_fgas = 't' then 'Si'  --rom03
                when  patentino_fgas = 'f' then 'No'   --rom03
                else '' end as patentino_fgas_op       --rom03
      from iter_operators
     where maintainer_id = :maintainer_id
     order by name
    " {
	
	set img_pat_si $img_unchecked
	set img_pat_no $img_unchecked
	set img_pat_fgas_si $img_unchecked
	set img_pat_fgas_no $img_unchecked
	
	if {$patentino_op eq "Si"} {
	    set img_pat_si $img_checked
	} else {
	    set img_pat_no $img_checked
	}
	
	if {$patentino_fgas_op eq "Si"} {
	    set img_pat_fgas_si $img_checked
	} else {
	    set img_pat_fgas_no $img_checked
	}
	
	
	append dichiarazione_marche "-che l'operatore $name_op $first_name_op della ditta sopra citata è in possesso delle seguenti abilitazioni<br>
Patentino da conduttore $img_pat_si Si $img_pat_no No<br>
Patentino Fgas  $img_pat_fgas_si Si $img_pat_fgas_no No<br><br>"
	
	if {![string match "*iter-portal-marche*" $db_name]} {#rom01	
	puts $file_id "
        <tr>
          <td>Operatore</td>
          <td>$name_op $first_name_op</td>
        </tr>
        <tr>
          <td>Cod I.Ter</td>
          <td>$iter_no</td>
        </tr>
        <tr>
          <td>Matricola</td>
          <td>$no</td>
        </tr>
        <tr>
          <td>Cod.Fiscale</td>
          <td>$fiscal_code_op</td>
        </tr>
        <tr>
          <td>Telefono</td>
          <td>$phone</td>
        </tr>
        <tr>
          <td>Cellulare</td>
          <td>$mobile</td>
        </tr>
        <tr>
          <td>Recapito</td>
          <td>$address_op</td>
        </tr>
        <tr>
          <td>Ruolo</td>
          <td>$op_role</td>
        </tr>
        <tr>
          <td>Note</td>
          <td>$notes_op</td>
        </tr>
"
	};#rom01
#rom01 la regione marche non cuole più questa parte
#	if {[string match "*iter-portal-marche*" $db_name]} {
#	    puts $file_id "
#       <tr>
#          <td>Patentino da conduttore</td>
#          <td>$patentino_op</td>
#        </tr>
#        <tr>
#          <td>Patentino Fgas</td>
#          <td>$patentino_fgas_op</td>
#        </tr>
#        <tr>
#          <td>&nbsp;</td>
#          <td>&nbsp;</td>
#        </tr>
#    "
#	} else {
#	    puts $file_id "
#        <tr>
#          <td>&nbsp;</td>
#          <td>&nbsp;</td>
#        </tr>                
#    "
#rom01	}
	
    }
    }



append dichiarazione_marche $tipologie_dichiarazione_marche

append dichiarazione_marche "<br><table width=100%>
               <tr>
                 <td width=50%>DATA</td>
                 <td width=50%>FIRMA</td>
               </tr>
               <tr>
                 <td width=50%>_______________</td>
                 <td width=50%>_________________</td>
               </tr>
               </table><br><br>
Si allega documento di identità $tipo_doc_identita N. $num_doc_identita rilasciato da $ente_rilascio_doc_identita in data $data_rilascio_doc_identita valido fino al $data_fine_validita_doc_identita"


puts $file_id "</table>"
if {![string match "*iter-portal-marche*" $db_name]} {#rom01 aggiunta if
puts $file_id "<b>Privacy</b>
               <table width=100%>
               <tr>
                 <td width=50%>La vostra azienda vuole essere visibile nell'elenco ditte dell'ente?</td>
                 <td width=50%>$visualizza_company</td>
               </tr>
               <tr>
                 <td width=100%>L'azienda ha preso visione ed ha accettato l'informativa sulla privacy (INFORMATIVA EX ART.  13 D. Lgs. 196/2003)</td>
               </tr>
               <tr>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
               </tr>
               </table>
               <br><br>
               <br><br>
               <table width=100%>
               <tr>
                 <td width=50%>DATA</td>
                 <td width=50%>FIRMA</td>
               </tr>
               <tr>
                 <td width=50%>_______________</td>
                 <td width=50%>_________________</td>
               </tr>
               </table>
               "
puts $file_id "
<br><br>
<br><br>
<hr size=1>
<table width=100%>
    <tr>
      <td align=center width=100%><small>$nome_ente, $indirizzo_ente
      <br>$telefono_ente</small></td>
    </tr>
</table>"
};#rom01

puts $file_id $dichiarazione_marche

close $file_id

# lo trasformo in PDF
iter_crea_pdf [list exec htmldoc --webpage --header ... --footer ... --quiet --bodyfont arial --left 1cm --right 1cm --top 0cm --footer ... --bottom 0cm  -f $file_pdf $file_html]

ns_unlink $file_html
ad_returnredirect $file_pdf_url
ad_script_abort
