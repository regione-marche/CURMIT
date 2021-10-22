<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>


    <partialquery name="sql_query">
        <querytext>
                   select cod_manutentore
                        , nvl(cognome,'')||' '||nvl(nome,'') as nominativo
                        , cognome
                        , nome
                        , indirizzo
                        , comune
                        , cod_fiscale
                     from coimmanu
                    where 1 = 1
                   $where_word
                   $where_nome
                 order by cognome
                        , nome
                        , cod_manutentore
       </querytext>
   </partialquery>

</queryset>
