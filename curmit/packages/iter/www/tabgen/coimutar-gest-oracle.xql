<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="ins_utar">
       <querytext>
                insert
                  into coimutar 
                     ( cod_area
                     , id_utente
                     , data_ins
                     , utente)
                values 
                     (:cod_area
                     ,:id_utente
                     , sysdate
                     ,:id_utente)
       </querytext>
    </partialquery>

    <fullquery name="sel_utar">
       <querytext>
             select a.id_utente
                  , a.cognome
                  , a.nome
                  , a.livello
                  , b.descrizione   as ruolo
                  , c.descrizione   as settore
               from coimuten a  
                  , coimruol b
                  , coimsett c
              where 1 = 1
                and c.id_settore (+) = a.id_settore
                and b.id_ruolo   (+) = a.id_ruolo
             $where_last
             $where_word
                and id_utente  not in 
            (select id_utente 
               from coimutar 
              where cod_area = :cod_area) 
              order by upper(cognome), upper(id_utente)
       </querytext>
    </fullquery>

</queryset>
