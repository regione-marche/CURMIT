<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_dimp_flag_tracciato">
       <querytext>
           select flag_tracciato
             from coimdimp
            where cod_dimp = :cod_dimp
       </querytext>
    </fullquery>

</queryset>
