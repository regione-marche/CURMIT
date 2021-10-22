<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_prog">
       <querytext>
       select cod_progettista
            , cognome
            , nome
            , indirizzo
            , provincia
            , telefono
         from coimprog
        where 1 = 1
       $where_last
       $where_word
        order by upper(cognome), cod_progettista
       </querytext>
    </partialquery>

</queryset>
