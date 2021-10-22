<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_esit">
       <querytext>
           select nom
                , url
                , pat
             from coimesit
            where cod_batc = :cod_batc
              and ctr      = :ctr
       </querytext>
    </fullquery>

    <fullquery name="sel_esit_count">
       <querytext>
           select count(*) as ctr_esit
             from coimesit
            where cod_batc = :cod_batc
       </querytext>
    </fullquery>

    <fullquery name="del_esit">
       <querytext>
           delete
             from coimesit
            where cod_batc = :cod_batc
              and ctr      = :ctr
       </querytext>
    </fullquery>

    <fullquery name="del_batc">
       <querytext>
           delete
             from coimbatc
            where cod_batc = :cod_batc
       </querytext>
    </fullquery>

</queryset>
