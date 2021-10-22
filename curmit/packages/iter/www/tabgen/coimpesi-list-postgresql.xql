<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="sel_pesi">
       <querytext>
       select nome_campo
            , descrizione_dimp
            , peso
            , case tipo_peso
               when 'N' then 'No'
               when 'C' then 'N.C.'
               when 'A' then 'N.A.'
              else ''
              end as tipo_peso_ed
            , tipo_peso
         from coimpesi
     order by descrizione_dimp
       </querytext>
    </partialquery>

</queryset>
