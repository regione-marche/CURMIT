<?xml version="1.0"?>

<queryset>
    <rdbms><type>oracle</type><version>7.1</version></rdbms>

    <partialquery name="ins_uten">
       <querytext>
                insert
                  into coimuten 
                     ( id_utente
                     , cognome
                     , nome
                     , password
                     , id_settore
                     , id_ruolo
                     , e_mail
                     , rows_per_page
                     , livello)
                values 
                     (:cod_utente
                     ,:cognome
                     ,:nome
                     ,:password
                     ,:id_settore
                     ,:id_ruolo
                     ,:e_mail
                     ,:rows_per_page
                     ,:livello)
       </querytext>
    </partialquery>

    <partialquery name="upd_uten">
       <querytext>
                update coimuten
                   set cognome = :cognome
                     , nome = :nome
                     , password = :password
                     , id_settore = :id_settore
                     , id_ruolo = :id_ruolo
                     , e_mail = :e_mail
                     , rows_per_page = :rows_per_page
                     , livello = :livello
                 where id_utente = :cod_utente
       </querytext>
    </partialquery>

    <partialquery name="del_uten">
       <querytext>
                delete
                  from coimuten
                 where id_utente = :cod_utente
       </querytext>
    </partialquery>

    <fullquery name="sel_uten">
       <querytext>
             select id_utente
                  , cognome
                  , nome
                  , password
                  , id_settore
                  , id_ruolo
                  , e_mail
                  , iter_edit.num(rows_per_page, 0) as rows_per_page
                  , iter_edit.num(livello, 0) as livello
               from coimuten
              where id_utente = :cod_utente
       </querytext>
    </fullquery>

    <fullquery name="sel_uten_check">
       <querytext>
        select '1'
          from coimuten
         where id_utente = :cod_utente
       </querytext>
    </fullquery>

    <fullquery name="select_profilo_utente">
      <querytext>
	select id_settore
	       , id_ruolo
	from coimuten
	where id_utente = :id_utente
      </querytext>
    </fullquery>

</queryset>
