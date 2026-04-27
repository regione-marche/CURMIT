<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_flag_tracciato_cimp">
       <querytext>
       select flag_tracciato
         from coimcimp
        where cod_cimp = :cod_cimp
       </querytext>
    </fullquery>

</queryset>
