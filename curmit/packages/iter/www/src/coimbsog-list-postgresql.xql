<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
        <querytext>
                   select cod_cittadino
                        , coalesce(cognome,'')||' '||coalesce(nome,'')
                       as nominativo
                        , cognome
                        , nome
                        , coalesce(indirizzo,'')||' '||coalesce(numero,'') as indirizzo
                        , comune
                        , cod_fiscale
                     from coimcitt
                    where 1 = 1
                   $where_word
                   $where_nome
                   $where_comune
                   and cod_cittadino not in (select cod_legale_rapp from coimmanu where cod_cittadino = cod_legale_rapp)
                 order by cognome
                        , nome
                        , cod_cittadino
                 limit 5000
       </querytext>
   </partialquery>

</queryset>
