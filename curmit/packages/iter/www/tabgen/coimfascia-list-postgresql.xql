<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_fascia">
       <querytext>
                   select cod_fascia
                        , ora_inizio||' - '||ora_fine as descr_fascia
                     from coimfascia
                    where 1 = 1
                    $where_last
                    $where_word
                    order by cod_fascia
       </querytext>
    </partialquery>

</queryset>
