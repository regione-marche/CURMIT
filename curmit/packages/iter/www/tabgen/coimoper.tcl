ad_page_contract {

  @author Gacalin Lufi

} {
    {id ""}
    {query ""}
    {valore ""}
}

### UNICA PARTE DA MODIFICARE

#Recupero tutte le operazioni

set search_clause ""

#if {$query ne ""} {
#    set search_clause " and "
#    append search_clause [ah::search_clause_f -search_word $query -search_field "descr_operazione"]
#}

#if {$search_clause eq ""} {
#    db_multirow datas query "select null as name , null as id"
#} else {
#db_multirow datas query "
#  select descr_operazione as name, descr_operazione as id
#    from coimoper
#   where (:id is null or descr_operazione = :id)
#         $search_clause
#   order by id asc, name asc limit 30
#"
#}


if {$query ne ""} {
    set search_clause " and "
    append search_clause [ah::search_clause_f -search_word $query -search_field "descr_operazione"]
}

if {$search_clause eq ""} {

#ns_return 200 text/xml ""
    db_multirow datas query "select :valore as name , :valore as id "
} else {
    db_multirow datas query "
    select coalesce(descr_operazione, '') as name, descr_operazione as id
      from coimoper
     where 1=1
--(:id is null or descr_operazione = :id)
          $search_clause
     order by cod_operazione asc, descr_operazione asc limit 30
"
####
}
set columns [template::multirow columns datas]

set total [template::multirow size datas]

# First create our top-level document
set doc [dom createDocument xml]
set root [$doc documentElement]

# Set xml version number and encoding
$root setAttribute version "1.0"
$root setAttribute encoding "UTF-8"


# Create the commands to build up our XML document
dom createNodeCmd elementNode success
dom createNodeCmd elementNode total
dom createNodeCmd textNode t

foreach column $columns {
    dom createNodeCmd elementNode $column
}


$root appendFromScript {
    success {t "true"}
    total {t $total}
}

template::multirow foreach datas {
    set data [$doc createElement data]
    $root appendChild $data

    foreach column $columns {
        $data appendFromScript {
            $column {t [set $column]}
        }
    }
}

ns_log notice "simone root=$root"
ns_return 200 text/xml [$root asXML]


