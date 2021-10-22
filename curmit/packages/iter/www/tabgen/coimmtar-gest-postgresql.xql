<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_mtar">
       <querytext>
                insert
                  into coimmtar 
                     ( cod_area
                     , cod_manutentore
                     , data_ins
                     , utente)
                values 
                     (:cod_area
                     ,:cod_manutentore
                     , current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <fullquery name="sel_mtar">
       <querytext>
             select cod_area
                  , descrizione
               from coimarea
              where 1 = 1
             $where_last
             $where_word
                and cod_area  not in 
            (select cod_area 
               from coimmtar 
              where cod_manutentore = :cod_manutentore) 
              order by upper(descrizione)
       </querytext>
    </fullquery>

</queryset>
