ad_page_contract {
    
    @author         Serena Saccani
    @creation-date  04.03.2013
    
    @cvs-id         maintainers-csv.tcl

    USER  DATA       MODIFICHE
    ===== ========== ==========================================================================
    rom02 19/10/2023 Aggiunta colonna PEC su richiesta di Della Monica di Salerno, Sandro ha detto
    rom02            che va bene per tutti tranne che per le Marche.

    rom01 30/06/2021 Aggiunta colonna Data Registrazione su richiesta delle Marche,
    rom01            Sandro ha detto che puo' essere aggiunta per tutti.

    gab01 21/08/2017 Aggiunte le colonne: Patentino, Patentino fgas, Attivo? e aggiunte opzioni
    gab01            3 e 4 al campo ruolo. 

    sim01 20/07/2016 Aggiunto nuovo filtro f_is_active_p
    
} {
    {search_name        ""}
    {search_fiscal_code ""}
    {search_iva_code    ""}
    {search_city        ""}
    {search_province    ""}
    {from_date          ""}
    {to_date            ""}
    {from_date_ansi     ""}
    {to_date_ansi       ""}
    {f_validated_p      ""}
    {f_is_active_p      ""}
}

set user_id    [auth::require_login]
set package_id [ad_conn package_id]

# imposto filtri
if {$search_name ne ""} {
    set where_name "and upper(m.name) like upper('%[db_quote $search_name]%')"
} else {
    set where_name ""
}
if {$search_fiscal_code ne ""} {
    set where_fiscal_code "and upper(m.fiscal_code) like upper('%$search_fiscal_code%')"
} else {
    set where_fiscal_code ""
}
if {$search_iva_code ne ""} {
	set where_iva "and upper(m.iva_code) like upper('%$search_iva_code%')"
    } else {
	set where_iva ""
}
if {$search_city ne ""} {
    set where_city "and upper(m.city) like upper('%[db_quote $search_city]%')"
} else {
    set where_city ""
}
if {$search_province ne ""} {
    set where_province "and m.province = :search_province"
} else {
    set where_province ""
}
if {$from_date ne ""} {
    set where_from_date "and m.creation_date >= :from_date_ansi"
} else {
    set where_from_date ""
}
if {$to_date ne ""} {
    set where_to_date "and m.creation_date <= :to_date_ansi"
} else {
    set where_to_date ""
}
if {$f_validated_p ne ""} {
    set where_validate "and m.validated_p = :f_validated_p"
} else {
    set where_validate ""
}

if {$f_is_active_p ne ""} {#sim01: aggiunta if e suo contenuto
    set where_active "and m.is_active_p = :f_is_active_p"
} else {
    set where_active ""
}

set current_datetime   [clock format [clock seconds] -f "%Y-%m-%d %H:%M:%S"]
set nome_file          "Estrazione manutentori"
set nome_file          [iter_temp_file_name -permanenti $nome_file]
set permanenti_dir     [iter_set_permanenti_dir]
set permanenti_dir_url [iter_set_permanenti_dir_url]
set file_csv           "$permanenti_dir/$nome_file.csv"
set file_csv_url       "$permanenti_dir_url/$nome_file.csv"

set file_id [open $file_csv w]
fconfigure $file_id -encoding iso8859-1

# imposto la prima riga del file csv
set     head_cols ""
lappend head_cols "Codice"
lappend head_cols "Ragione sociale"
lappend head_cols "Indirizzo"
lappend head_cols "Località"
lappend head_cols "Comune"
lappend head_cols "Provincia"
lappend head_cols "Cap"
lappend head_cols "Cod.Fiscale"
lappend head_cols "P.Iva"
lappend head_cols "E-mail"
if {![string match "*iter-portal-marche*" [db_get_database]]} {#rom02 Aggiunta if e il suo contenuto
    lappend head_cols "PEC"
}
lappend head_cols "Telefono"
lappend head_cols "Cellulare"
lappend head_cols "Fax"
lappend head_cols "Località Reg.Imprese"
lappend head_cols "Reg.Imprese"
lappend head_cols "Località Rea"
lappend head_cols "Rea"
lappend head_cols "Albo Artigiani"
lappend head_cols "Ruolo"
lappend head_cols "N.Op.impegnati"
lappend head_cols "N.Analizzatori usati"
lappend head_cols "N.Deprimometri usati"
lappend head_cols "Associaz.Riferimento"
lappend head_cols "Capitale sociale"
lappend head_cols "Cognome Rapp.Legale"
lappend head_cols "Nome Rapp.Legale"
lappend head_cols "Indirizzo Rapp.Legale"
lappend head_cols "Comune Rapp.Legale"
lappend head_cols "Localitià Rapp.Legale"
lappend head_cols "CAP Rapp.Legale"
lappend head_cols "Prov.Rapp.Legale"
lappend head_cols "Cod.Fiscale Rapp.Legale"
lappend head_cols "Patentino" ;#gab01
lappend head_cols "Patentino fgas" ;#gab01
lappend head_cols "Attivo?" ;#gab01
lappend head_cols "Data Registrazione";#rom01

# imposto il tracciato record del file csv
set     file_cols ""
lappend file_cols "iter_code"
lappend file_cols "name"
lappend file_cols "address1"
lappend file_cols "address2"
lappend file_cols "city"
lappend file_cols "province"
lappend file_cols "zipcode"
lappend file_cols "fiscal_code_l"
lappend file_cols "iva_code_l"
lappend file_cols "email"
if {![string match "*iter-portal-marche*" [db_get_database]]} {#rom02 Aggiunta if e il suo contenuto
    lappend file_cols "pec"
}
lappend file_cols "phone_l"
lappend file_cols "mobile_l"
lappend file_cols "fax_l"
lappend file_cols "where_registered"
lappend file_cols "registration_no"
lappend file_cols "where_rea"
lappend file_cols "rea_no_l"
lappend file_cols "albo_artigiani"
lappend file_cols "role"
lappend file_cols "op_number_pretty"
lappend file_cols "an_number_pretty"
lappend file_cols "de_number_pretty"
lappend file_cols "associated_to"
lappend file_cols "capital_pretty"
lappend file_cols "rep_name"
lappend file_cols "rep_first_name"
lappend file_cols "rep_address1"
lappend file_cols "rep_address2"
lappend file_cols "rep_city"
lappend file_cols "rep_province"
lappend file_cols "rep_zipcode"
lappend file_cols "rep_fiscal_code"
lappend file_cols "patentino" ;#gab01
lappend file_cols "patentino_fgas" ;#gab01
lappend file_cols "is_active_p" ;#gab01
lappend file_cols "creation_date";#rom01

set sw_primo_rec "t"
db_foreach query "
     select maintainer_id
          , m.name
          , m.address1
          , m.address2
          , m.city
          , m.province
          , m.zipcode
          , m.iva_code
          , m.fiscal_code
          , m.phone
          , m.mobile
          , m.email
          , m.pec  --rom02
          , m.fax
          , m.associated_to
          , m.where_registered
          , m.registration_no
          , m.where_rea
          , m.rea_no
          , m.capital
          , m.albo_artigiani
          , m.representative_id
          , m.notes
          , m.lotto_no
          , m.validated_p
          , m.validating_user
          , m.validating_date
          , m.iter_code
          , m.company_type
          , m.is_active_p
          , m.op_number
          , m.an_number
          , m.de_number
          , m.approved_p
          , m.cait_id
          , m.wallet_id
          , m.iban_code
          , m.cc_name
          , case m.role
              when '1' then 'Manuntentore'
              when '2' then 'Installatore/Manutentore'
              when '0' then 'Installatore'
              when '3' then 'Manut/Inst solo Clim.Estiva'
              when '4' then 'Manut/Inst Biomassa solo Legnosa'
              else ''
            end as role
          , ah_edit_num(m.op_number, 0) as op_number_pretty
          , ah_edit_num(m.an_number, 0) as an_number_pretty
          , ah_edit_num(m.de_number, 0) as de_number_pretty
          , ah_edit_num(m.capital, 0)   as capital_pretty
          , case m.patentino
              when 't' then 'Si'
              when 'f' then 'No'
              else ''
            end as patentino --gab01
          , case m.patentino_fgas
              when 't' then 'Si'
              when 'f' then 'No'
              else ''
            end as patentino_fgas --gab01
          , case m.is_active_p
              when 't' then 'Si'
              when 'f' then 'No'
              else ''
            end as is_active_p --gab01
          , iter_edit_data(m.creation_date) as creation_date --rom01
          , c.email       as cait_mail
          , p.name        as rep_name
          , p.first_name  as rep_first_name
          , p.address1    as rep_address1
          , p.city        as rep_city
          , p.address2    as rep_address2
          , p.province    as rep_province
          , p.zipcode     as rep_zipcode
          , p.fiscal_code as rep_fiscal_code
       from iter_maintainers m left outer join iter_cait c on c.cait_id = m.cait_id
                               left outer join iter_parties p on m.representative_id = p.party_id
      where 1 = 1
      $where_name
      $where_fiscal_code
      $where_iva
      $where_city
      $where_province
      $where_from_date
      $where_to_date
      $where_validate
      $where_active -- sim01
    order by m.name
" {
    set file_col_list ""

    if {$sw_primo_rec == "t"} {
	set sw_primo_rec "f"
	iter_put_csv $file_id head_cols
    }

   
    foreach column_name $file_cols {
       set iva_code_l "\'$iva_code"
       set fiscal_code_l "'$fiscal_code"
       set rea_no_l "'$rea_no"
       set phone_l "'$phone"
       set mobile_l "'$mobile"
       set fax_l "'$fax"


	lappend file_col_list [set $column_name]
    }
    iter_put_csv $file_id file_col_list
    
} if_no_rows {
    set msg_err "Nessun manutentore selezionato con i criteri utilizzati"
    set msg_err_list [list $msg_err]
    iter_put_csv $file_id msg_err_list
}

ad_returnredirect $file_csv_url
ad_script_abort
