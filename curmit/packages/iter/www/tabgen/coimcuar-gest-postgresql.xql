<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_cuar">
       <querytext>
                insert
                  into coimcuar 
                     ( cod_area
                     , cod_comune
                     , cod_urb
                     , data_ins
                     , utente)
                values 
                     (:cod_area
                     ,:cod_comune
                     ,:cod_urb
                     , current_date
                     ,:id_utente)
       </querytext>
    </partialquery>

    <fullquery name="sel_cuar">
       <querytext>
             select a.descrizione
                  , b.denominazione   as comune
                  , a.cod_urb
                  , a.cod_comune
               from coimcurb a left outer join
                    coimcomu b
                 on b.cod_comune = a.cod_comune
              where 1 = 1
                and b.cod_provincia = :prov
             $where_last
             $where_word
                and cod_urb  not in 
            (select cod_urb 
               from coimcuar 
              where cod_area = :cod_area) 
              order by upper(a.descrizione), a.cod_urb
       </querytext>
    </fullquery>

</queryset>
