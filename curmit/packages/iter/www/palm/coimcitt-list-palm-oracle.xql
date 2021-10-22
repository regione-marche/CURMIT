<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
        <querytext>
                   select cod_cittadino
                        , nvl(cognome,'')||' '||nvl(nome,'')
                       as nominativo
                        , cognome
                        , nome
                        , nvl(indirizzo,'')||' '||nvl(numero,'') as indirizzo
                        , comune
                        , cod_fiscale
                     from coimcitt
                    where 1 = 1
                   $where_word
                   $where_nome
                   $where_cod_cittadino
                   $where_cod_fiscale
                   $where_cod_piva
                   $where_key
                 order by cognome
                        , nome
                        , cod_cittadino
       </querytext>
   </partialquery>

</queryset>
