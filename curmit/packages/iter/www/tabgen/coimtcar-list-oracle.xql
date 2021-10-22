<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="sel_tcar">
       <querytext>
     select a.cod_area
          , a.cod_opve
          , b.descrizione
       from coimtcar a
          , coimarea b
      where a.cod_opve = :cod_opve
        and b.cod_area = a.cod_area
      $where_last
      $where_word
      order by descrizione
       </querytext>
    </partialquery>

    <partialquery name="del_tcar">
       <querytext>
                delete
                  from coimtcar
                 where cod_area     = :cod_area
                   and cod_opve     = :cod_opve
       </querytext>
    </partialquery>

</queryset>
