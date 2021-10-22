<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_ragr">
       <querytext>
       select cod_raggruppamento
            , descrizione
         from coimragr
     order by cod_raggruppamento
       </querytext>
    </partialquery>

</queryset>
