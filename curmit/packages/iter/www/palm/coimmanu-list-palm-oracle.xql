<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_manu">
       <querytext>
       select cod_manutentore
            , cognome
            , nome
            , indirizzo
            , provincia
            , telefono
         from coimmanu
        where 1 = 1
       $where_last
       $where_word
       $where_manu
        order by upper(cognome)
               , cod_manutentore
       </querytext>
    </partialquery>

</queryset>
