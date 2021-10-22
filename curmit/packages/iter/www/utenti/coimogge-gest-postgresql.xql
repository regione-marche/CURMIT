<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_ogge">
       <querytext>
                insert
                  into coimogge 
                     ( livello
                     , scelta_1
                     , scelta_2
                     , scelta_3
                     , scelta_4
                     , tipo
                     , descrizione
                     , nome_funz)
                values 
                     (:livello
                     ,:scelta_1
                     ,:scelta_2
                     ,:scelta_3
                     ,:scelta_4
                     ,:tipo
                     ,:descrizione
                     ,:nome_funz_d)
       </querytext>
    </partialquery>

    <partialquery name="upd_ogge">
       <querytext>
                update coimogge
                   set tipo = :tipo
                     , descrizione = :descrizione
                     , nome_funz = :nome_funz_d
                 where livello = :livello
                   and scelta_1 = :scelta_1
                   and scelta_2 = :scelta_2
                   and scelta_3 = :scelta_3
                   and scelta_4 = :scelta_4
       </querytext>
    </partialquery>

    <partialquery name="del_ogge">
       <querytext>
                delete
                  from coimogge
                 where livello = :livello
                   and scelta_1 = :scelta_1
                   and scelta_2 = :scelta_2
                   and scelta_3 = :scelta_3
                   and scelta_4 = :scelta_4
       </querytext>
    </partialquery>

    <partialquery name="del_menu">
       <querytext>
                delete
                  from coimmenu
                 where livello = :livello
                   and scelta_1 = :scelta_1
                   and scelta_2 = :scelta_2
                   and scelta_3 = :scelta_3
                   and scelta_4 = :scelta_4
       </querytext>
    </partialquery>

    <fullquery name="sel_ogge">
       <querytext>
             select livello
                  , scelta_1
                  , scelta_2
                  , scelta_3
                  , scelta_4
                  , tipo
                  , descrizione
                  , nome_funz as nome_funz_d
               from coimogge
              where livello = :livello
                and scelta_1 = :scelta_1
                and scelta_2 = :scelta_2
                and scelta_3 = :scelta_3
                and scelta_4 = :scelta_4
       </querytext>
    </fullquery>

    <fullquery name="sel_ogge_check">
       <querytext>
        select '1'
          from coimogge
         where livello = :livello
           and scelta_1 = :scelta_1
           and scelta_2 = :scelta_2
           and scelta_3 = :scelta_3
           and scelta_4 = :scelta_4
       </querytext>
    </fullquery>

    <fullquery name="sel_n_funz">
       <querytext>
       select distinct(nome_funz)
            , nome_funz
         from coimfunz
       </querytext>
    </fullquery>
</queryset>
