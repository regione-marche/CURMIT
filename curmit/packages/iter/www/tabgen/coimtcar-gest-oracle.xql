<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="ins_tcar">
       <querytext>
                insert
                  into coimtcar 
                     ( cod_area
                     , cod_opve
                     , data_ins
                     , utente)
                values 
                     (:cod_area
                     ,:cod_opve
                     , sysdate
                     ,:id_utente)
       </querytext>
    </partialquery>

    <fullquery name="sel_tcar">
       <querytext>
             select a.cod_area
                  , a.descrizione
               from coimarea a
              where 1=1
             $where_last
             $where_word
                and a.cod_area  not in
            (select b.cod_area
               from coimtcar b
              where b.cod_opve = :cod_opve)
              order by a.descrizione
       </querytext>
    </fullquery>


</queryset>
