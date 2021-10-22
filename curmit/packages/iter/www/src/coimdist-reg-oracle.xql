<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_cod_fisc">
       <querytext>
         select '1'
           from coimddds
          where codice_fisc_utente = :cod_fisc
       </querytext>
    </fullquery>

</queryset>
