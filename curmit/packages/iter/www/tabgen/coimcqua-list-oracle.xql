<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_cqua">
       <querytext>
                   select a.cod_qua 
                        , a.cod_comune
                        , a.descrizione 
                        , b.denominazione
                     from coimcqua a
                        , coimcomu b
                    where 1 = 1
                      and b.cod_comune = a.cod_comune
                      and b.flag_val   = 'T'
                    $where_last
                    $where_word
                    order by cod_comune, cod_qua
       </querytext>
    </partialquery>
   

</queryset>
