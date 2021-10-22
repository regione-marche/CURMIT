<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_cmar">
       <querytext>
                insert
                  into coimcmar 
                     ( cod_area
                     , cod_comune
                     , data_ins
                     , utente)
                values 
                     (:cod_area
                     ,:cod_comune
                     , current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <fullquery name="sel_cmar">
       <querytext>
             select cod_comune
                  , denominazione
               from coimcomu
              where 1 = 1
                and cod_provincia = :cod_prov
             $where_last
             $where_word
             $where_comu
                and cod_comune  not in 
            (select cod_comune 
               from coimcmar 
              where cod_area = :cod_area) 
              order by upper(denominazione), cod_comune
       </querytext>
    </fullquery>

</queryset>
