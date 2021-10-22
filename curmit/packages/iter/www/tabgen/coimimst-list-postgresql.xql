<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_imst">
       <querytext>
                   select cod_imst
                        , descr_imst
                     from coimimst
                    where 1 = 1
                    $where_last
                    $where_word
                    order by cod_imst
       </querytext>
    </partialquery>

</queryset>
