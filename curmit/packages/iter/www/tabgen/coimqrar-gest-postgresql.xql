<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_qrar">
       <querytext>
                insert
                  into coimqrar 
                     ( cod_area
                     , cod_comune
                     , cod_qua
                     , data_ins
                     , utente)
                values 
                     (:cod_area
                     ,:cod_comune
                     ,:cod_qua
                     , current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <fullquery name="sel_qrar">
       <querytext>
             select a.descrizione
                  , b.denominazione   as comune
                  , a.cod_qua
                  , a.cod_comune
               from coimcqua a left outer join
                    coimcomu b
                 on b.cod_comune = a.cod_comune
              where 1 = 1
                and b.cod_provincia = :prov
             $where_last
             $where_word
                and cod_qua  not in 
            (select cod_qua 
               from coimqrar 
              where cod_area = :cod_area) 
              order by upper(descrizione), cod_qua
       </querytext>
    </fullquery>

</queryset>
