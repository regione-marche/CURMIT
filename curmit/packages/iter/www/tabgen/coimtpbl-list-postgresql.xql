<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_tpbl">
       <querytext>
                   select cod_tipo_bol
                        , descrizione
                        , iter_edit_data(data_fine_valid) as data_fine_valid
                     from coimtpbl
                    where 1 = 1
                    $where_last
                    $where_word
                    order by cod_tipo_bol
       </querytext>
    </partialquery>

</queryset>
