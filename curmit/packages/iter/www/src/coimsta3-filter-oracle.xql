<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_data_cinc">
       <querytext>
       select to_char(data_inizio, 'yyyymmdd') as data_inizio
            , to_char(data_fine, 'yyyymmdd') as data_fine
         from coimcinc
        where cod_cinc = :f_campagna
       </querytext>
    </fullquery>

    <fullquery name="sel_cinc_att">
       <querytext>
            select cod_cinc as cod_cinc_att
              from coimcinc
             where stato = '1'
       </querytext>
    </fullquery>


</queryset>
