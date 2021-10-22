<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="sel_cimp_flag_tracciato">
       <querytext>
           select flag_tracciato
             from coimcimp
            where cod_cimp = :cod_cimp
       </querytext>
    </fullquery>

    <fullquery name="sel_aimp_pote">
       <querytext>
           select potenza
             from coimaimp
            where cod_impianto= :cod_impianto
       </querytext>
    </fullquery>


</queryset>
