<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sql_query">
        <querytext>
                   select cod_manutentore
                        , coalesce(cognome,'')||' '||coalesce(nome,'') as nominativo
                        , cognome
                        , nome
                        , indirizzo
                        , comune
                        , cod_fiscale
                     from coimmanu
                    where (flag_attivo = 'S' or flag_attivo is null)
                   $where_word
                   $where_nome
                 order by cognome
                        , nome
                        , cod_manutentore
--                 limit 200
       </querytext>
   </partialquery>

</queryset>
