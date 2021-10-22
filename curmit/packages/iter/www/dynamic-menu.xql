<?xml version="1.0"?>

<queryset>

    <fullquery name="sel_menu_join_ogge">
       <querytext>
                    select a.scelta_1
                         , a.scelta_2
                         , a.scelta_3
                         , a.scelta_4
                         , a.livello
                         , b.descrizione
                         , b.tipo
                         , b.nome_funz
                         , lpad(a.livello,2,'0')||lpad(a.scelta_1,2,'0')||lpad(a.scelta_2,2,'0')||lpad(a.scelta_3,2,'0')||lpad(a.scelta_4,2,'0') as id_riga_di_menu
                      from coimmenu a
                         , coimogge b
                     where a.nome_menu = :nome_menu
                       and a.livello   = :livello
                    $where_scelte_a
                       and b.livello   = a.livello
                       and b.scelta_1  = a.scelta_1
                       and b.scelta_2  = a.scelta_2
                       and b.scelta_3  = a.scelta_3
                       and b.scelta_4  = a.scelta_4
                  order by a.seq,
                           a.scelta_1,
                           a.scelta_2,
                           a.scelta_3,
                           a.scelta_4
       </querytext>
    </fullquery>

    <fullquery name="sel_funz">
       <querytext>
                   select '/iter/'||azione as azione
                        , dett_funz
                        , parametri
                     from coimfunz
                    where nome_funz = :nome_funz
                      and tipo_funz = 'primario'
       </querytext>
    </fullquery>

</queryset>
