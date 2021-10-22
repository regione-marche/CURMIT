<?xml version="1.0"?>

<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <partialquery name="ins_prof">
       <querytext>
                insert
                  into coimprof 
                     ( nome_menu
                     , settore
                     , ruolo)
                values 
                     (:nome_menu
                     ,:settore
                     ,:ruolo)
       </querytext>
    </partialquery>

    <partialquery name="upd_prof">
       <querytext>
                update coimprof
                   set settore = :settore
                     , ruolo = :ruolo
                 where nome_menu = :nome_menu
       </querytext>
    </partialquery>

    <partialquery name="del_prof">
       <querytext>
                delete
                  from coimprof
                 where nome_menu = :nome_menu
       </querytext>
    </partialquery>

    <fullquery name="sel_prof">
       <querytext>
             select nome_menu
                  , settore
                  , ruolo
               from coimprof
              where nome_menu = :nome_menu
       </querytext>
    </fullquery>

    <fullquery name="sel_prof_check">
       <querytext>
        select '1'
          from coimprof
         where upper(nome_menu) = upper(:nome_menu)
       </querytext>
    </fullquery>

    <fullquery name="check_profilo">
       <querytext>
        select '1'
          from coimprof
         where settore = :settore
           and ruolo   = :ruolo
         $where_cod
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
