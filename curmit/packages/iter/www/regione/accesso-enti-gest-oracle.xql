<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_uten">
       <querytext>
                    select password
                      from coimuten
                     where id_utente = :id_utente
       </querytext>
    </fullquery>

</queryset>
