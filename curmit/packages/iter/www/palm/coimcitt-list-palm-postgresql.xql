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
