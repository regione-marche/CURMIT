<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <fullquery name="sel_relt">
       <querytext>
    select cod_relg
         , cod_relt
         , sezione
         , id_clsnc
         , id_stclsnc
         , obj_refer
         , id_pot
         , id_comb
         , id_per
         , iter_edit.num(n,0) as n
      from coimrelt
     where cod_relg = :cod_relg
       and not (    id_clsnc   = 5
                and id_stclsnc = 2)
    $where_last
     order by sezione desc
            , id_clsnc
            , id_stclsnc
            , id_pot
            , id_per
            , id_comb
            , obj_refer
       </querytext>
    </fullquery>

</queryset>
