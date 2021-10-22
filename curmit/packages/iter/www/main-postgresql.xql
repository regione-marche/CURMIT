<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

     <fullquery name="sel_ogge_titolo">
       <querytext>
                    select descrizione as titolo
                      from coimogge
                     where livello   = :livello
                       and scelta_1  = :scelta_1
                       and scelta_2  = :scelta_2
                       and scelta_3  = :scelta_3
                       and tipo      = 'titolo'
       </querytext>
    </fullquery>

    <fullquery name="sel_user">
       <querytext>
                    select nome
                         , cognome
                         , id_settore
                         , id_ruolo
                         , data
                         , flag_menu_yui
                         , flag_alto_contrasto
                      from coimuten
                     where id_utente = :id_utente
       </querytext>
    </fullquery>

    <fullquery name="sel_funz">
       <querytext>
                   select azione
                        , dett_funz as det
                        , parametri
                     from coimfunz
                    where nome_funz = :nome_funz
                      and tipo_funz = 'primario'
       </querytext>
    </fullquery>

    <fullquery name="sel_menu_join_ogge">
       <querytext>
                    select a.scelta_1 as uno
                         , a.scelta_2 as due 
                         , a.scelta_3 as tre 
                         , a.scelta_4 as quattro 
                         , a.livello as liv
                         , b.descrizione
                         , b.tipo
                         , b.nome_funz     
                      from coimmenu a 
                         , coimogge b     
                     where a.livello = :livello
                     $where_scelte_a
                       and a.nome_menu = :nome_menu
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

    <fullquery name="sel_menu">
       <querytext>
                    select b.nome_menu
                      from coimuten a
                         , coimprof b
                     where a.id_settore = b.settore
                       and a.id_ruolo   = b.ruolo
                       and a.id_utente = :id_utente
       </querytext>
    </fullquery>

    <fullquery name="get_titolo">
       <querytext>
    select descrizione as titolo
      from coimogge
     where livello   = :livello
       and scelta_1  = :scelta_1
       and scelta_2  = :scelta_2
       and scelta_3  = :scelta_3
       and tipo      = 'titolo'
       </querytext>
    </fullquery>


</queryset>
