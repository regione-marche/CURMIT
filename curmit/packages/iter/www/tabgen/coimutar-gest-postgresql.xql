<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

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
                     , current_date
                     ,:id_utente_ins)
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
               from coimuten a left outer join 
                    coimruol b
                 on b.id_ruolo = a.id_ruolo
                               left outer join 
                    coimsett c
                 on c.id_settore = a.id_settore
              where 1 = 1
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
