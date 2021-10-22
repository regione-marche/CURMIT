<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_sanz">
       <querytext>
       select cod_sanzione
            , descr_breve
         from coimsanz
     order by cod_sanzione
       </querytext>
    </partialquery>

</queryset>
