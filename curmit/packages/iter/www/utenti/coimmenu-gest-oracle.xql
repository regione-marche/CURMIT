<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="ins_menu">
       <querytext>
                insert
                  into coimmenu 
                     ( nome_menu
                     , livello
                     , scelta_1
                     , scelta_2
                     , scelta_3
                     , scelta_4
                     , lvl
                     , seq)
                values 
                     (:nome_menu
                     ,:livel
                     ,:scelta1
                     ,:scelta2
                     ,:scelta3
                     ,:scelta4
                     ,:lvl
                     ,:seque)
       </querytext>
    </partialquery>

    <partialquery name="del_menu">
       <querytext>
                delete
                  from coimmenu
                 where nome_menu = :nome_menu
       </querytext>
    </partialquery>

    <fullquery name="sel_ogge">
       <querytext>
    select a.livello as livell
         , a.scelta_1 as scelt_1
         , a.scelta_2 as scelt_2
         , a.scelta_3 as scelt_3
         , a.scelta_4 as scelt_4
         , a.tipo     as tip
         , a.descrizione as descr
         , b.lvl         as liv
         , b.seq         as seque
         , b.nome_menu as nom_menu
      from coimogge a
         , coimmenu b 
     where a.tipo <> 'titolo'
       and b.livello   (+) = a.livello
       and b.scelta_1  (+) = a.scelta_1
       and b.scelta_2  (+) = a.scelta_2
       and b.scelta_3  (+) = a.scelta_3
       and b.scelta_4  (+) = a.scelta_4 
       and b.nome_menu (+) = :nome_menu
  order by a.scelta_1
         , a.scelta_2
         , a.scelta_3
         , a.scelta_4
       </querytext>
    </fullquery>

    <fullquery name="sel_menu_check">
       <querytext>
        select '1'
          from coimmenu
         where nome_menu = :nome_menu
       </querytext>
    </fullquery>

</queryset>
