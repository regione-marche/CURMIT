set html "<p>Maintainers"
db_foreach query "
            select maintainer_id, name 
            from iter_maintainers 
            where approved_p = 't' 
              and validating_date is null  
              and iter_code is null 
--              and creation_date < '2009-09-09'
            order by creation_date, maintainer_id
" {
    if {[db_0or1row -dbn itercmbg query "select cod_manutentore, cognome, data_ins from coimmanu where cognome = :name order by cod_manutentore"]} {
        append html "<br>$maintainer_id $cod_manutentore $data_ins $cognome"
    }
} 

append html "<p>Trustees"
db_foreach query "
            select trustee_id, name, first_name 
            from iter_trustees 
            where approved_p = 't' 
              and validating_date is null  
--              and creation_date < '2009-09-09'
            order by creation_date, trustee_id
" {
    if {[db_0or1row -dbn itercmbg query "select cod_cittadino, cognome, data_ins from coimcitt where cognome = :name and cod_cittadino like 'AM%' and cod_cittadino > 'AM000609' and nome = :first_name order by cod_cittadino"]}  {
	append html "<br>$trustee_id $cod_cittadino $data_ins $cognome"
    }
} 


ns_return 200 text/html $html
